From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] test_terminal: catch use without TTY prerequisite
Date: Thu, 14 Oct 2010 15:41:41 -0500
Message-ID: <20101014204141.GC28958@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
 <20101014031642.GB14664@burratino>
 <20101014033448.GB28197@sigill.intra.peff.net>
 <20101014203721.GA28958@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <jrk@wrek.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:45:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Ufq-0005cm-QN
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab0JNUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 16:45:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33636 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0JNUpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 16:45:07 -0400
Received: by iwn35 with SMTP id 35so10903iwn.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=x2s3+juw0PUhtQ6fOYizsEb+ZOHeq420NacV/fM51ag=;
        b=JYb/0tpoDUBc0BsvNbvPpO+gHbmZyvqGZRd/f5xJqFhD44o7ki3OMH+fWAjmgjyYaC
         d19dtD/ihfcY6yuYzAL3Z2f2OLSklYShVYmyOOw1zRhloeYzB/4fxnanIlHOscXjmcso
         5uddngtf0UJO3DLR7keS1KnXG6CtKYOjl77wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HXWjllTrYD5FU5b0Fqk5RoqCeJ/ATAebpH9t145Dioe0aWpr9U18xDNgJ4SuHTQVu7
         BM5y85ToZMPunZOvPAi3n7tgTqHS6wgCABXwrWTh34vv7O7xOpY4hyVtdlgHylsP1aaV
         STxOPNQvMUhBACDHyDDPJgYN3woy07wKWbMII=
Received: by 10.231.14.1 with SMTP id e1mr17034iba.147.1287089105978;
        Thu, 14 Oct 2010 13:45:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm9416908ibi.8.2010.10.14.13.45.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 13:45:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101014203721.GA28958@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159074>

It is easy to forget to declare the TTY prerequisite when
writing tests on a system where it would always be satisfied
(because IO::Pty is installed; see v1.7.3-rc0~33^2, 2010-08-16
for example).  Automatically detect this problem so there is
no need to remember.

	test_terminal: need to declare TTY prerequisite
	test_must_fail: command not found: test_terminal echo hi

test_terminal returns status 127 in this case to simulate
not being available.

Also replace the SIMPLEPAGERTTY prerequisite on one test with
"SIMPLEPAGER,TTY", since (1) the latter is supported now and
(2) the prerequisite detection relies on the TTY prereq being
explicitly declared.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Penance for introducing that bug a few times.

 t/t7006-pager.sh |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fb744e3..53868f6 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -28,11 +28,11 @@ test_expect_success 'set up terminal for tests' '
 
 if test -e stdout_is_tty
 then
-	test_terminal() { "$@"; }
+	test_terminal_() { "$@"; }
 	test_set_prereq TTY
 elif test -e test_terminal_works
 then
-	test_terminal() {
+	test_terminal_() {
 		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl "$@"
 	}
 	test_set_prereq TTY
@@ -40,6 +40,15 @@ else
 	say "# no usable terminal, so skipping some tests"
 fi
 
+test_terminal () {
+	if ! test_declared_prereq TTY
+	then
+		echo >&2 'test_terminal: need to declare TTY prerequisite'
+		return 127
+	fi
+	test_terminal_ "$@"
+}
+
 test_expect_success 'setup' '
 	unset GIT_PAGER GIT_PAGER_IN_USE;
 	test_might_fail git config --unset core.pager &&
@@ -213,11 +222,6 @@ test_expect_success 'color when writing to a file intended for a pager' '
 	colorful colorful.log
 '
 
-if test_have_prereq SIMPLEPAGER && test_have_prereq TTY
-then
-	test_set_prereq SIMPLEPAGERTTY
-fi
-
 # Use this helper to make it easy for the caller of your
 # terminal-using function to specify whether it should fail.
 # If you write
@@ -253,7 +257,7 @@ parse_args() {
 test_default_pager() {
 	parse_args "$@"
 
-	$test_expectation SIMPLEPAGERTTY "$cmd - default pager is used by default" "
+	$test_expectation SIMPLEPAGER,TTY "$cmd - default pager is used by default" "
 		unset PAGER GIT_PAGER;
 		test_might_fail git config --unset core.pager &&
 		rm -f default_pager_used ||
-- 
1.7.2.3
