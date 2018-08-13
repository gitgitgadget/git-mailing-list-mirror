Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E8A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHNBVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:21:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:53968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730131AbeHNBVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:21:17 -0400
Received: (qmail 19610 invoked by uid 109); 13 Aug 2018 22:37:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 22:37:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14542 invoked by uid 111); 13 Aug 2018 22:37:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 18:37:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 18:37:02 -0400
Date:   Mon, 13 Aug 2018 18:37:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
Message-ID: <20180813223701.GC16006@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
 <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
 <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
 <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
 <87eff2rmgt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eff2rmgt.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:22:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > O_APPEND is POSIX and means race-free append. If you mark some call
> > sites with O_APPEND, then that must be the ones that need race-free
> > append. Hence, you would have to go the other route: Mark those call
> > sites that do _not_ need race-free append with some custom
> > function/macro. (Or mark both with different helpers and avoid writing
> > down O_APPEND.)
> 
> O_APPEND in POSIX is race-free only up to PIPE_MAX bytes written at a
> time, which is e.g. 2^12 by default on linux, after that all bets are
> off and the kernel is free to interleave different write calls.

This is a claim I've run across often, but I've never seen a good
citation for it.

Certainly atomic writes to _pipes_ are determined by PIPE_BUF (which
IIRC is not even a constant on Linux, but can be changed at run-time).
But is it relevant for regular-file writes?

Another gem I found while digging on this O_APPEND/FILE_APPEND_DATA
stuff the other day: somebody claimed that the max atomic-append size on
Linux is 4096 and 1024 on Windows. But their experimental script was
done in bash! So I suspect they were really just measuring the size of
stdio buffers.

Here's my attempt at a test setup. This C program forces two processes
to write simultaneously to the same file with O_APPEND:

-- >8 --
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>

static void doit(int size, const char *fn, char c)
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

	while (1)
		write(fd, buf, size);
}

int main(int argc, const char **argv)
{
	int size = atoi(argv[1]);

	if (fork())
		doit(size, argv[2], '1');
	else
		doit(size, argv[2], '2');
	return 0;
}
-- 8< --

and then this program checks that we saw atomic units of the correct
size:

-- >8 --
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, const char **argv)
{
	int size = atoi(argv[1]);
	char *buf;

	buf = malloc(size);
	while (1) {
		int i;
		/* assume atomic reads, i.e., no signals */
		int r = read(0, buf, size);
		if (!r)
			break;
		for (i = 1; i < size; i++) {
			if (buf[i] != buf[0]) {
				fprintf(stderr, "overlap\n");
				return 1;
			}
		}
	}
	return 0;
}
-- 8< --

And then you can do something like:

  for size in 4097 8193 16385 32769 65537 131073 262145 524289 1048577; do
    >out ;# clean up from last run
    echo "Trying $size..."
    timeout 5 ./write $size out
    if ! ./check $size <out; then
      echo "$size failed"
      break
    fi
  done

On my Linux system, each of those seems to write several gigabytes
without overlapping. I did manage to hit some failing cases, but they
were never sheared writes, but rather cases where there was an
incomplete write at the end-of-file.

So obviously this is all a bit of a tangent. I'd be fine declaring that
trace output is generally small enough not to worry about this in the
first place. But those results show that it shouldn't matter even if
we're writing 1MB trace lines on Linux. I wouldn't be at all surprised
to see different results on other operating systems, though.

-Peff
