From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 5/8] test_terminal: give priority to test-terminal.perl usage
Date: Sun, 17 Oct 2010 02:37:00 +0800
Message-ID: <1287254223-4496-6-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bdv-0002rt-6g
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0JPShn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42381 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab0JPShm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:42 -0400
Received: by pva18 with SMTP id 18so130001pva.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wnsebs++gTR5frV0Uwt316VWDrTtXcX/UqMsp9QtkIc=;
        b=JLURm7ieTsInDmKs49XHxhSaiOjz4FNtQK8q9fUFfAbQCrlrW0idf+ChGV2n3HVApg
         JVBbhK4b1Tqw7v+uyul6bqrr6pAclBfYvnyjUvZ81Be9cozJ+2OmlFiYMr9jzcvK2G+4
         TdX8d/xDSFy+60GID5f8O1EoKwAaS13eWDrgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HRniJW/+Dfy1UiL+EoQkfaolpi2I4u/U6K0ZfcD3g03H4D6MNxv135PbBKVgykcKO9
         wml0aeO/t0lcQom++Tlz3qy1VGk9FvYUxepJyAFzo4jZXmleTnDl3mvrgmeepPWJWsFs
         mR979JbjKFVrFne23YE4UZN6d7QBuny7yMs7k=
Received: by 10.142.192.9 with SMTP id p9mr1845562wff.165.1287254261611;
        Sat, 16 Oct 2010 11:37:41 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-5-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159174>

From: Jonathan Nieder <jrnieder@gmail.com>

Tay Ray Chuan wrote:

> [snip]
> 2. For terminal tests that capture output/stderr, the TTY prerequisite
> warning does not quite work for things like
>
>   test_terminal foo >out 2>err
>
> because the warning gets "swallowed" up by the redirection that's
> supposed only to be done by the subcommand.

Good catch.  Such cases (like Jeff's patch) are not well supported
currently. :(

The outcome depends on whether stdout was already a terminal (in which
case test_terminal is a noop) or not (in which case test_terminal
introduces a pseudo-tty in the middle of the pipeline).

	$ test_terminal.perl sh -c 'test -t 1 && echo >&2 YES' >out
	YES
	$ sh -c 'test -t 1 && echo >&2 YES' >out
	$

How about this?

 - use the test_terminal script even when running with "-v"
   if IO::Pty is available, to allow commands like

	test_terminal foo >out 2>err

 - add a separate TTYREDIR prerequisite which is only set
   when the test_terminal script is usable

 - write the "need to declare TTY prerequisite" message to fd 4,
   where it will be printed when running tests with -v, rather
   than being swallowed up by an unrelated redireciton.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Picked up from a private discussion. I left the discussion in the
  patch message to give some background, and it also gives a nice
  summary of the changes.

 t/lib-terminal.sh |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5e7ee9a..71d147f 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,36 +1,38 @@
 #!/bin/sh
 
 test_expect_success 'set up terminal for tests' '
-	if test -t 1 && test -t 2
-	then
-		>have_tty
-	elif
+	if
 		test_have_prereq PERL &&
 		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl \
 			sh -c "test -t 1 && test -t 2"
 	then
 		>test_terminal_works
+	elif test -t 1 && test -t 2
+	then
+		>have_tty
 	fi
 '
 
-if test -e have_tty
-then
-	test_terminal_() { "$@"; }
-	test_set_prereq TTY
-elif test -e test_terminal_works
+if test -e test_terminal_works
 then
 	test_terminal_() {
 		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
 	}
 	test_set_prereq TTY
+	test_set_prereq TTYREDIR
+elif test -e have_tty
+then
+	test_terminal_() { "$@"; }
+	test_set_prereq TTY
+
 else
 	say "# no usable terminal, so skipping some tests"
 fi
 
 test_terminal () {
-	if ! test_declared_prereq TTY
+	if ! test_declared_prereq TTY && ! test_declared_prereq TTYREDIR
 	then
-		echo >&2 'test_terminal: need to declare TTY prerequisite'
+		echo >&4 'test_terminal: need to declare TTY prerequisite'
 		return 127
 	fi
 	test_terminal_ "$@"
-- 
1.7.2.2.513.ge1ef3
