Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9384CC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C95460FE8
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhJYRnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:43:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:45886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhJYRnl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 13:43:41 -0400
Received: (qmail 6322 invoked by uid 109); 25 Oct 2021 17:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 17:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21451 invoked by uid 111); 25 Oct 2021 17:41:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 13:41:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 13:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Is t7006-pager.sh racy?
Message-ID: <YXbsPrU6nRSboQ7r@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211024170349.GA2101@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 24, 2021 at 07:03:49PM +0200, SZEDER Gábor wrote:

> On Sat, Oct 23, 2021 at 05:04:42PM -0700, Junio C Hamano wrote:
> > It seems under --stress it is fairly easy to break the said test,
> > especially the one near the end
> 
> I couldn't reproduce a failure with --stress, but after a cursory look
> into those tests I doubt that either that test or any of the
> preceeding SIGPIPE tests added in c24b7f6736 (pager: test for exit
> code with and without SIGPIPE, 2021-02-02) actually check what they
> are supposed to.

Yeah, I am puzzled that they are using test_terminal in the first place
(as opposed to just "git -p"). And you are right that a raw git-log is
unlikely to be slow enough to get SIGPIPE in most cases.

My usual test for an intentional SIGPIPE is "yes". So something like:

  git -p \
    -c core.pager='exit 0' \
    -c alias.yes='!yes' \
    yes

will reliably trigger SIGPIPE from yes, which git.c will then translate
into an exit code of 141.

If you really want to see SIGPIPE from a builtin (which arguably is the
more interesting case here, though I think it behaves the same with
respect to the pager), it's a bit trickier. One way to do it is with a
command that doesn't generate output until after it gets EOF on stdin.

So something like "git log --stdin" works, but you have to contort
yourself a bit to make it race-free:

-- >8 --
# The I/O setup here is:
#
#         fifo:log-in          stdout
#   shell -----------> git-log ------> pager
#     ^                                 /
#      \-------------------------------/
#                 fifo:pager-closed
#
# The pager closes its stdin, which will give git-log SIGPIPE. But the
# tricky part is that after doing so, it signals via fifo to the shell,
# which then writes to git-log's stdin, triggering it to actually
# generate output (and get SIGPIPE).
#
# You can verify that it's race-free by inserting a "sleep 3" at the
# front of the pager command (before the exec) and seeing that the
# other processes wait (and we still get SIGPIPE).

mkfifo pager-closed
mkfifo log-in
git config core.pager 'exec 0<&-; echo ready >pager-closed; exit 0'
(git -p log --stdin <log-in; echo $? >exit-code) &

# we have to open a descriptor rather than just "echo HEAD >log-in", because
# that will give git-log an immediate EOF on its input when echo closes it, and
# we must wait until the signal from pager-closed. Likewise we cannot wait
# for that signal before the echo, because the subshell is blocking on opening
# log-in until somebody is hooked up to the write end of the pipe.
exec 9>log-in
read ok <pager-closed
echo HEAD >&9
exec 9>&-

# now we can wait for the subshell to finish and retrieve any output
# it produced
wait
cat exit-code
-- >8 --

-Peff
