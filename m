From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/10] check_bindir: don't use the -a or -b option with the test command
Date: Thu, 15 May 2014 07:17:28 -0700
Message-ID: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:17:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwTk-00051F-DX
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbaEOORo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:17:44 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:51756 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaEOORn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:17:43 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so1156432pbc.40
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=64iHjfGfCOKD7v3ImjyWjlhOOaavERHxennMRUYMw/M=;
        b=TxzLuyZag04q7JIDvnwnvuYCVrNo5uBrJMivx+TEW2wvhe2M5hVkZfCgb3cjeckPD8
         3NfDBVwtbVtAE2Ii5O+/N304/JJHnv3MryKoz+jxYFTEpiK+2rpNo+0Gb35jHu92pNLr
         mePi+ZZ/I2zKjySocx/e0jD/s53uNwecInqGjd5nkd7zgzEZwKAP1pOLcUuOBE6zrtdD
         uXrVwNmnjfeMwNgtUXLsp/qGLRK84Zyd9mjrl/szmzEWGK0EGnymaVrdnfCyn3HuN8/h
         r8LRQOePDY+7fySb9POPtefb0itCQNlY2zIpgxkliS4YVeMYZAdi29dgDJye5sV1XHo7
         lLOg==
X-Received: by 10.68.178.194 with SMTP id da2mr12644704pbc.151.1400163462770;
        Thu, 15 May 2014 07:17:42 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id as12sm21782704pac.43.2014.05.15.07.17.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:17:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249080>

Even though POSIX.1 lists -a/-o as options to "test", they are
marked "Obsolescent XSI". Scripts using these expressions
should be converted  as follow:

test "$1" -a "$2"

should be written as:

test "$1" && test "$2"

Likewise

test "$1" -o "$2"

should be written as:

test "$1"  test "$2"

But note that, in test, -a has higher precedence than -o while
"&&" and "||" have equal precedence in the shell.

The reason for this is that the precedence rules were never well
specified, and this made many sane-looking uses of "test -a/-o" problematic.

For example, if $x is "=", these work according to POSIX (it's not
portable, but in practice it's okay):

   $ test -z "$x"
   $ test -z "$x" && test a = b

but this doesn't

   $ test -z "$x" -a a = b
   bash: test: too many arguments

because it groups "test -n = -a" and is left with "a = b".

Similarly, if $x is "-f", these

   $ test "$x"
   $ test "$x" || test c = d

correctly adds an implicit "-n", but this fails:

   $ test "$x" -o c = d
   bash: test: too many arguments

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Inspired from this discussion http://permalink.gmane.org/gmane.comp.version-control.git/137056

 check_bindir |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check_bindir b/check_bindir
index a1c4c3e..623eadc 100755
--- a/check_bindir
+++ b/check_bindir
@@ -2,7 +2,7 @@
 bindir="$1"
 gitexecdir="$2"
 gitcmd="$3"
-if test "$bindir" != "$gitexecdir" -a -x "$gitcmd"
+if test "$bindir" != "$gitexecdir" && test -x "$gitcmd"
 then
 	echo
 	echo "!! You have installed git-* commands to new gitexecdir."
-- 
1.7.10.4
