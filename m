From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/10] contrib/examples/git-clone.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:42 -0700
Message-ID: <1400163710-28333-2-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwYD-00007i-G9
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbaEOOV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:21:57 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:43341 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaEOOV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:21:56 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so1158292pbc.14
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RvuP7BAnf/3SCVeMcEtmQNIzWzUpApJtD1SUKcNi088=;
        b=S8bTfy5mcrRcjum+iEXzCmjf6HuVupfNyNzQFqni/5sGZDQbUlV1jEROH9EKcp5JUb
         9E0sTr74y4fwwI5415DRhZRB1WWTvZzbKM3zgLw9jvyomD/WGdkAqKaH+DsC7qXr1qHF
         JzHZJ2AFjD/uFxTmxtqjkTU1qHAZV0QRmVIWNO41vkmhOGrzhqTPiLegL0/+0qq94/Hc
         Op6F5xd1wXApZmqyHRAa7M6ZOgCR4dCZqrvfcMv09/o6zhQmX2B5apvoFQ4CYjHr5YqP
         08d7X+vLiqkTDPlKguAo6EHPZsLPv/PrpQNn0ndbXbdlDWc2xarBHMU3fxCVQ6bqiVaC
         /pew==
X-Received: by 10.68.196.202 with SMTP id io10mr12696625pbc.149.1400163715927;
        Thu, 15 May 2014 07:21:55 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.21.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:21:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249099>

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

 contrib/examples/git-clone.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index b4c9376..08cf246 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -516,7 +516,7 @@ then
 
 	case "$no_checkout" in
 	'')
-		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
+		test "z$quiet" = z && test "z$no_progress" = z && v=-v || v=
 		git read-tree -m -u $v HEAD HEAD
 	esac
 fi
-- 
1.7.10.4
