Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FC01F404
	for <e@80x24.org>; Thu, 25 Jan 2018 19:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeAYTQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 14:16:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:57592 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751108AbeAYTQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 14:16:43 -0500
Received: (qmail 15577 invoked by uid 109); 25 Jan 2018 19:16:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 19:16:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6461 invoked by uid 111); 25 Jan 2018 19:17:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Jan 2018 14:17:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jan 2018 14:16:41 -0500
Date:   Thu, 25 Jan 2018 14:16:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/6] off-by-one errors in git-daemon
Message-ID: <20180125191641.GB26309@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
 <xmqqshatai90.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshatai90.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 10:46:51AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This series fixes two off-by-one errors in git-daemon noticed by Michael
> > (who then nerd-sniped me into fixing them). It also improves
> > git-daemon's verbose logging of extended attributes, and beefs up the
> > tests a bit.
> >
> > Before anyone gets excited, no, these aren't security-interesting
> > errors. The only effect you could have is for git-daemon to reject your
> > request as nonsense. ;)
> 
> Thanks.  All looked sensible.

Thanks. Do you mind replacing patch 2 with the update below while
queuing? It uses the more robust loop mentioned by Lucas, and clarifies
the commit message a bit.

There should be no changes necessary for the other patches on top.

-- >8 --
Subject: [PATCH v2] t/lib-git-daemon: record daemon log

When we start git-daemon for our tests, we send its stderr
log stream to a named pipe. We synchronously read the first
line to make sure that the daemon started, and then dump the
rest to descriptor 4. This is handy for debugging test
output with "--verbose", but the tests themselves can't
access the log data.

Let's dump the log into a file, as well, so that future
tests can check the log. There are a few subtleties worth
calling out here:

  - we'll continue to send output to descriptor 4 for
    viewing/debugging, which would imply swapping out "cat"
    for "tee". But we want to ensure that there's no
    buffering, and "tee" doesn't have a standard way to
    ask for that. So we'll use a shell loop around "read"
    and "printf" instead. That ensures that after a request
    has been served, the matching log entries will have made
    it to the file.

  - the existing first-line shell loop used read/echo. We'll
    switch to consistently using "read -r" and "printf" to
    relay data as faithfully as possible.

  - we open the logfile for append, rather than just output.
    That makes it OK for tests to truncate the logfile
    without restarting the daemon (the OS will atomically
    seek to the end of the file when outputting each line).
    That allows tests to look at the log without worrying
    about pollution from earlier tests.

Helped-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-git-daemon.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 987d40680b..9612cccefb 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -53,11 +53,19 @@ start_git_daemon() {
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		>&3 2>git_daemon_output &
 	GIT_DAEMON_PID=$!
+	>daemon.log
 	{
-		read line <&7
-		echo >&4 "$line"
-		cat <&7 >&4 &
-	} 7<git_daemon_output &&
+		read -r line <&7
+		printf "%s\n" "$line"
+		printf >&4 "%s\n" "$line"
+		(
+			while read -r line <&7
+			do
+				printf "%s\n" "$line"
+				printf >&4 "%s\n" "$line"
+			done
+		) &
+	} 7<git_daemon_output >>"$TRASH_DIRECTORY/daemon.log" &&
 
 	# Check expected output
 	if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
-- 
2.16.1.273.g775ca5227b

