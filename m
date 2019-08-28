Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035FF1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 14:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1OyO (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 10:54:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726315AbfH1OyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 10:54:13 -0400
Received: (qmail 13418 invoked by uid 109); 28 Aug 2019 14:54:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Aug 2019 14:54:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11462 invoked by uid 111); 28 Aug 2019 14:55:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2019 10:55:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Aug 2019 10:54:12 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190828145412.GB14432@sigill.intra.peff.net>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828093408.GD8571@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 11:34:08AM +0200, SZEDER Gábor wrote:

> On Tue, Aug 27, 2019 at 06:43:29PM -0700, Derrick Stolee via GitGitGadget wrote:
> > Test t5516-fetch-push.sh has a test 'deny fetch unreachable SHA1,
> > allowtipsha1inwant=true' that checks stderr for a specific error
> > string from the remote. In some build environments the error sent
> > over the remote connection gets mingled with the error from the
> > die() statement. Since both signals are being output to the same
> > file descriptor (but from parent and child processes), the output
> > we are matching with grep gets split.
> 
> In the spirit of "An error message is worth a thousand words", I think
> it's worth to include the error message causing the failure:
> 
>   error: 'grep not our ref.*64ea4c133d59fa98e86a771eda009872d6ab2886 err' didn't find a match in:
>   fatal: git upload-pack: not our ref 64ea4c13fatal: remote error: upload-pack: not our ref 63d59fa98e86a771eda009872d6ab2886
>   4ea4c133d59fa98e86a771eda009872d6ab2886
>   error: last command exited with $?=1
> 
> I tried to reproduce this specific error on Linux and macOS, but
> couldn't yet.

I suspect it depends on write() to a file not being atomic, since we
should be able to get the full message out to a single write in both
cases. It's _possible_ that stderr is fully buffered on Windows, but it
generally shouldn't be. If it is, then this might help:

diff --git a/usage.c b/usage.c
index 2fdb20086b..d6df31bc5b 100644
--- a/usage.c
+++ b/usage.c
@@ -10,13 +10,19 @@ void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p;
-
-	vsnprintf(msg, sizeof(msg), err, params);
+	size_t len;
+
+	/* truncation is OK here, but make sure we have a newline */
+	len = xsnprintf(msg, sizeof(msg), "%s", prefix);
+	len += vsnprintf(msg + len, sizeof(msg) - len, err, params);
+	if (len >= sizeof(msg) - 1)
+		len--;
+	len += xsnprintf(msg + len, sizeof(msg) - len, "\n");
 	for (p = msg; *p; p++) {
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')
 			*p = '?';
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	write(2, msg, len);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)

But again, I'm doubtful.

> Here you talk about reducing the risk ...
> 
> > 1. Write an error message to stderr.
> > 2. Write an error message across the connection.
> > 3. exit(1).
> > 
> > This reorders the events so the error is written entirely before
> > the client receives a message from the remote, removing the race
> > condition.
> 
> ... but here you talk about removing the race condition.
> 
> I don't understand how this change would remove the race condition.
> After all, the occasional failure is caused by two messages racing
> through different file descriptors, and merely sending them in reverse
> order doesn't change that they would still be racing.

I had the same puzzlement. I think the answer might be that in the
original, we can have two write()s happening simultaneously:

  1. upload-pack sends the packet to the client

  2. client receives packet

  3a. upload-pack then writes to stderr

  3b. simultaneously, the client writes to stderr

But by reordering, step 3a is completed before step 1.

> > +			warning("git upload-pack: not our ref %s",
> > +				oid_to_hex(&o->oid));
> >  			packet_writer_error(writer,
> >  					    "upload-pack: not our ref %s",
> >  					    oid_to_hex(&o->oid));
> > -			die("git upload-pack: not our ref %s",
> > -			    oid_to_hex(&o->oid));
> > +			exit(1);
> 
> 
> So, the error coming from the 'git fetch' command in question
> currently looks like this:
> 
>   fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
>   fatal: remote error: upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
> 
> Changing die() to a warning() changes the prefix of the message from
> "fatal:" to "warning:", i.e. with this patch I got this:
> 
>   warning: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
>   fatal: remote error: upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
> 
> I don't think that "demoting" that message from fatal to warning
> matters much to users, because they would see the (arguably redundant)
> second line starting with "fatal:".

An interesting thing about this message is that many users won't see it
at all! It requires that they be connected to the stderr of upload-pack,
which happens only for local-filesystem clones, and for git-over-ssh to
a vanilla ssh session.

It won't be seen for git:// nor for https://, which go to the stderr of
git-daemon and the webserver respectively. Nor would it be seen on any
hosting site which uses something other than vanilla sshd to terminate
the connection (at GitHub for example, ssh terminates in a proxy layer
which then uses a different protocol to run upload-pack on the backend).

That's why we've been adding this sideband-level errors: so everybody
can see them. So unless the client is a 2005-era version of Git that
lacks sideband, the die message is either invisible to the user, or
redundant.

I'd almost suggest it is worth dropping the die() message altogether
here, but it does carry some value to people collecting them on the
server side[1].

Another solution is for Git to redirect the stderr of the child
upload-pack it runs, which puts all invocations on the same footing,
regardless of protocol. But that risks losing useful messages from
before the sideband starts up (e.g., ssh failures).

[1] At GitHub, we record the exit status of every Git process, and we've
    hooked die() to record the message, which is often helpful for
    post-facto debugging. I'd hate to lose it, but we could certainly
    work around it for this case, perhaps by hooking
    packet_writer_error() in a similar way.

> Unfortunately, however, while running './t5516-fetch-push.sh -r 1,79
> --stress' to try to reproduce a failure caused by those mingled
> messages, the same check only failed for a different reason so far
> (both on Linux and macOS (on Travis CI)):

There's some hand-waving argument that this should be race-free in
014ade7484 (upload-pack: send ERR packet for non-tip objects,
2019-04-13), but I am not too surprised if there is a flaw in that
logic.

This kind of race is a problem anytime upload-pack dies. And it's not
just a test issue, but a real problem for users: they might see EPIPE
instead of the error message from the server (it used to be SIGPIPE but
we recently relaxed that).

There's details and a possible path forward discussed in:

  https://public-inbox.org/git/20190305041139.GA19800@sigill.intra.peff.net/

-Peff
