Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8831F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeHNWFs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:05:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727755AbeHNWFs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:05:48 -0400
Received: (qmail 1724 invoked by uid 109); 14 Aug 2018 19:17:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 19:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25375 invoked by uid 111); 14 Aug 2018 19:17:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 15:17:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 15:17:09 -0400
Date:   Tue, 14 Aug 2018 15:17:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
Message-ID: <20180814191709.GB28452@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
 <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
 <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
 <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
 <87eff2rmgt.fsf@evledraar.gmail.com>
 <20180813223701.GC16006@sigill.intra.peff.net>
 <313beb50-f5bd-ace6-8d6d-5f2a9e7cb6e7@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <313beb50-f5bd-ace6-8d6d-5f2a9e7cb6e7@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 08:29:04PM +0200, Johannes Sixt wrote:

> Am 14.08.2018 um 00:37 schrieb Jeff King:
> > And then you can do something like:
> > 
> >    for size in 4097 8193 16385 32769 65537 131073 262145 524289 1048577; do
> >      >out ;# clean up from last run
> >      echo "Trying $size..."
> >      timeout 5 ./write $size out
> >      if ! ./check $size <out; then
> >        echo "$size failed"
> >        break
> >      fi
> >    done
> > 
> > On my Linux system, each of those seems to write several gigabytes
> > without overlapping. I did manage to hit some failing cases, but they
> > were never sheared writes, but rather cases where there was an
> > incomplete write at the end-of-file.
> 
> I used your programs with necessary adjustments (as fork() is not
> available), and did similar tests with concurrent processes. With packet
> sizes 1025, 4093, 7531 (just to include some odd number), and 8193 I did not
> observe any overlapping or short writes.
> 
> I'm now very confident that we are on the safe side for our purposes.

Great, thanks for testing!

Re-reading what I wrote about end-of-file above and thinking about the
conversation with Ævar elsewhere in the thread, I suspect it _is_ easy
to get overlapping writes if the processes are receiving signals (since
clearly the TERM signal caused a partial write).

My experiment doesn't simulate that at all. I suppose the parent process
could send SIGUSR1 to the child in each loop, and the child would catch
it but keep going.

Hmm, that was easy enough to do (programs below for reference), but
surprisingly it didn't fail for me (except for the normal end-of-file
truncation). It's like the OS is willing to truncate the write of a
dying program but not one for a signal that is getting handled. Which is
great for us, since it's exactly what we want, but makes me even more
suspicious that a non-Linux kernel might behave completely differently.

I still think we're fine in practice, as I'd expect any kernel to be
atomic under the page size. So this was mostly just for my own
edification.

-Peff

-- >8 --
/* check.c, with separate short-read reporting */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, const char **argv)
{
	int size = atoi(argv[1]);
	int block = 0;
	char *buf;

	buf = malloc(size);
	while (1) {
		int i;
		/* assume atomic reads */
		int r = read(0, buf, size);
		if (!r)
			break;
		if (r < size) {
			fprintf(stderr, "short read\n");
			return 1;
		}
		for (i = 1; i < size; i++) {
			if (buf[i] != buf[0]) {
				fprintf(stderr, "overlap in block %d\n", block);
				return 1;
			}
		}
		block++;
	}
}
-- >8 --

-- >8 --
/* write.c with signals; you can also confirm via strace
   that each write is atomic */
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>

void handle_signal(int sig)
{
	/* do nothing */
}

static void doit(int size, const char *fn, char c, pid_t pid)
{
	int fd;
	char *buf;

	fd = open(fn, O_WRONLY|O_APPEND|O_CREAT, 0666);
	if (fd < 0) {
		perror("open");
		return;
	}

	buf = malloc(size);
	memset(buf, c, size);

	while (1) {
		if (pid)
			kill(pid, SIGUSR1);
		write(fd, buf, size);
	}
}

int main(int argc, const char **argv)
{
	int size = atoi(argv[1]);
	pid_t pid;

	signal(SIGUSR1, handle_signal);

	pid = fork();
	if (pid)
		doit(size, argv[2], '1', pid);
	else
		doit(size, argv[2], '2', pid);
	return 0;
}
-- >8 --
