From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/10] contrib/examples/git-commit.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:43 -0700
Message-ID: <1400163710-28333-3-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwXv-0007sh-1p
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbaEOOV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:21:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53308 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaEOOV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:21:57 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1140089pad.37
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hnb0ZWSFm6Y+4LIBXa030zGsfCJTBJkUahD/jBXLRTk=;
        b=QAWxx+55FrfzX9AUz/N1zdvo+nrwESMxVyq0u0Xgl4EcPDAMhC8zYxfzX3xrjkpf1H
         KwwQujeF2xo3y8W0CiausDGxuf5AKHDy9HJnPAmpHm/1JFArsrBt8metKkF/maIvIzgX
         6Q24cmj54kvG5pnx/OAyolDOCshwi5DXGSVGEt+4Oqij4Dv5AsV30a321siP/TwT1Ork
         GZegOZPLJyRXuUNQDsnHsvGYRecsr34DjwRNPvNKgb4VX+bIi5Fmy5pL54UzOGJrlJEP
         8YVy8gKbZKCcS2an1D1EKWJsyzyOu9TuyxIQXcqKTPS6COMYFCRz1d/M8JnGF6k4zT6p
         vrXw==
X-Received: by 10.68.164.229 with SMTP id yt5mr12874261pbb.28.1400163716788;
        Thu, 15 May 2014 07:21:56 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.21.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:21:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249092>

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

 contrib/examples/git-commit.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 5cafe2e..934505b 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -51,7 +51,7 @@ run_status () {
 		export GIT_INDEX_FILE
 	fi
 
-	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
+	if test "$status_only" = "t" || test "$use_status_color" = "t"; then
 		color=
 	else
 		color=--nocolor
@@ -296,7 +296,7 @@ t,,,[1-9]*)
 	die "No paths with -i does not make sense." ;;
 esac
 
-if test ! -z "$templatefile" -a -z "$log_given"
+if test ! -z "$templatefile" && test -z "$log_given"
 then
 	if test ! -f "$templatefile"
 	then
-- 
1.7.10.4
