From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 5/8] test_terminal: give priority to
 test-terminal.perl usage
Date: Sat, 16 Oct 2010 19:38:07 -0500
Message-ID: <20101017003807.GF20883@burratino>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
 <1287254223-4496-6-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 02:41:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7HJv-0004QB-73
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 02:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711Ab0JQAlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 20:41:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32860 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0JQAln (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 20:41:43 -0400
Received: by ywi6 with SMTP id 6so893148ywi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jxL//jH9yBVld3D6GKBnV+25sKnWJSdQWAj+YrAcqk8=;
        b=rb6EyP9NetBVNk9+QmxrVIZaN88Z8mpXW2xTY3vCN5aezO2dLzRt4kOvuqdL9rnm5d
         FLjpEg/yrHraGiryyqk35EphVCElhYbMI6zDiKI+rJKd/YOOKBg4psL2pFdsUdikWCcc
         vOe+/kwffq13ma1pqPFEQA5G49XDd1G23kYu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nkKfj5gMiYwOV1p9ZrBGUKkiFuoP8dlxkYoR2xct3s73tjjN3cCki/HCQimRsbluUQ
         uegIo9MXHhcLURacVKE6wz206OlwMohficfHdb72ZYgoCkokVnl8D9eSD3eohB7TLZ1n
         HPwqV7hLQV0wKlsxKO2y4RHQ7cPxBNXlDUI30=
Received: by 10.150.217.19 with SMTP id p19mr2473478ybg.229.1287276102897;
        Sat, 16 Oct 2010 17:41:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v37sm2897413yba.20.2010.10.16.17.41.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 17:41:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287254223-4496-6-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159180>

Tay Ray Chuan wrote:

>  - use the test_terminal script even when running with "-v"
>    if IO::Pty is available, to allow commands like
> 
> 	test_terminal foo >out 2>err
> 
>  - add a separate TTYREDIR prerequisite which is only set
>    when the test_terminal script is usable
> 
>  - write the "need to declare TTY prerequisite" message to fd 4,
>    where it will be printed when running tests with -v, rather
>    than being swallowed up by an unrelated redireciton.

The patches up to this one look good to me.  This one behaves
as advertised, but I think the API is lousy --- it is just
begging people to use the TTY prereq where TTYREDIR is needed.

Better to change TTY to mean TTYREDIR and drop support for
test_terminal on systems without IO::Pty:

-- 8< --
Subject: test_terminal: ensure redirections work reliably

For terminal tests that capture output/stderr, the TTY prerequisite
warning does not quite work for commands like

	test_terminal foo >out 2>err

because the warning gets "swallowed" up by the redirection that's
supposed only to be done by the subcommand.

Even worse, the outcome depends on whether stdout was already a
terminal (in which case test_terminal is a noop) or not (in which case
test_terminal introduces a pseudo-tty in the middle of the pipeline).

	$ test_terminal.perl sh -c 'test -t 1 && echo >&2 YES' >out
	YES
	$ sh -c 'test -t 1 && echo >&2 YES' >out
	$

So:

 - use the test_terminal script even when running with "-v".

 - skip tests that require a terminal when the test_terminal
   script is unusable because IO::Pty is not installed.

 - write the "need to declare TTY prerequisite" message to fd 4,
   where it will be printed when running tests with -v, rather
   than being swallowed up by an unrelated redireciton.

Noticed-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The only other sane alternative I can think of is to introduce
TTYNOREDIR, since at least people wouldn't be tempted to use
that.  Distinguishing between

	test_expect_success 'foo' '
		test_terminal bar >out 2>err
	'

and

	test_expect_success 'foo' '
		test_terminal bar
	'

from a script run as

	sh t1234-some-script.sh >log 2>err.log

does not seem to be easy without OS-specific hacks like
"readlink /dev/fd/1".

 t/lib-terminal.sh |   38 ++++++++++----------------------------
 1 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5e7ee9a..c383b57 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,37 +1,19 @@
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
-		>test_terminal_works
+		test_set_prereq TTY &&
+		test_terminal () {
+			if ! test_declared_prereq TTY
+			then
+				echo >&4 "test_terminal: need to declare TTY prerequisite"
+				return 127
+			fi
+			"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
+		}
 	fi
 '
-
-if test -e have_tty
-then
-	test_terminal_() { "$@"; }
-	test_set_prereq TTY
-elif test -e test_terminal_works
-then
-	test_terminal_() {
-		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
-	}
-	test_set_prereq TTY
-else
-	say "# no usable terminal, so skipping some tests"
-fi
-
-test_terminal () {
-	if ! test_declared_prereq TTY
-	then
-		echo >&2 'test_terminal: need to declare TTY prerequisite'
-		return 127
-	fi
-	test_terminal_ "$@"
-}
-- 
1.7.2.3
