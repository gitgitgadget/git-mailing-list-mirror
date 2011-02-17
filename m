From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] tests: skip terminal output tests on OS X
Date: Thu, 17 Feb 2011 06:38:52 -0600
Message-ID: <20110217123852.GD7740@elie>
References: <201102091538.46594.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq38c-00011I-Ql
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab1BQMjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:39:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39050 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab1BQMjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:39:03 -0500
Received: by yxt3 with SMTP id 3so1091782yxt.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 04:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=krgd0SXK3kuo4ORTxWSKB6WV9uWvY2QEXeFt60Psv1w=;
        b=rDEkixJ+6dxHUIU5neO9snJ+yWWVnlY6iLEREDX1es1PP55XwVqiZxKh4sT+nsODWZ
         OtwKdTD3/cN8LRCDs2u7LRVKkoza88rHGJWSh9TKxfSiQi2WR3wWy8SQPkQLv24/e/B/
         8HXZQ+E4UBayAuZ+2BnZtVskRSBg7EOAJwabo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DH0j1ZHuxIJc1r6MaljrQC0I3menURm+gnjwTaNaAXp/I5dYPXIVhg4FcjQt/h2XKo
         g2mRaFXyar8LLaQDw9h4uONrILC0/SuKaeE81+uSVkbR9MPXfV7V+Pn0oKZvuBRnbCAY
         BSnepHeB24s+HMLa6UFD0bCX7i6Mmr5+CtCqE=
Received: by 10.151.83.1 with SMTP id k1mr2260510ybl.131.1297946341979;
        Thu, 17 Feb 2011 04:39:01 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id q33sm598902yba.7.2011.02.17.04.38.58
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 04:38:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102091538.46594.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167078>

On Mac OS X 10.5.0, test_terminal gets stuck reading from the pty
master every once in a while.  To reproduce the problem:

 perl -MIO::Pty -MFile::Copy -e '
	for (my $i = 0;; $i++) {
		my $master = new IO::Pty;
		my $slave = $master->slave;
		if (fork == 0) {
			close $master or die "close: $!";
			open STDOUT, ">&", $slave or die "dup2: $!";
			close $slave or die "close: $!";
			exec("echo", "hi", $i) or die "exec: $!";
		}
		close $slave or die "close: $!";
		copy($master, \*STDOUT) or die "copy: $!";
		close $master or die "close: $!";
		wait;
	}
 '

It blocks after 7000 iterations or so in sysread().  The relevant
sysread() call is the second call by the parent, which presumably
executes before the child dies but after the parent has read all
output from there.

Since this is an intermitent problem, the quick check of terminal
support in lib-terminal doesn't catch it.  Skip these tests on the Mac
for now.

Noticed-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for a reminder.

I'd be interested to hear whether this happens on other BSDs, too.
It's possible that test_terminal should be using a select() loop
to wait for input to be ready or the child to die instead of
waiting on one while the other happens.

 t/lib-terminal.sh |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index c383b57..58d911d 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,8 +1,24 @@
 #!/bin/sh
 
-test_expect_success 'set up terminal for tests' '
-	if
-		test_have_prereq PERL &&
+test_expect_success PERL 'set up terminal for tests' '
+	# Reading from the pty master seems to get stuck _sometimes_
+	# on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
+	#
+	# Reproduction recipe: run
+	#
+	#	i=0
+	#	while ./test-terminal.perl echo hi $i
+	#	do
+	#		: $((i = $i + 1))
+	#	done
+	#
+	# After 2000 iterations or so it hangs.
+	# https://rt.cpan.org/Ticket/Display.html?id=65692
+	#
+	if test "$(uname -s)" = Darwin
+	then
+		:
+	elif
 		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl \
 			sh -c "test -t 1 && test -t 2"
 	then
-- 
1.7.4.1
