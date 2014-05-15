From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/10] contrib/examples/git-merge.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:44 -0700
Message-ID: <1400163710-28333-4-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwYJ-0000V4-No
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbaEOOWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:22:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33240 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaEOOV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:21:58 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so1152956pab.28
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4gcf/SU06gbq2QHs57k5SdUbU5yqweXqLhU0+yB/xY=;
        b=Cs5/Fw1vDyvyJWXNDC9fepUeakuWEjeXowMbgH0QI5v0jDa3QSZbNkOkJ1WMLkR0Jj
         ax2rduB5+LOF8DZOyvOsl7LGVuJ4qsLr0DlCrci7bhseo4IQzqh+/EmsLouAcEXTHzV5
         awpPT+JtgPVcPyiYho/S3qmXjtfHCHtoTF7zZiHv3pdBF2zROc64eX/430QTpZFHVP0a
         ZgBpa/SfLvKWIimX7GrMSs9aYAq3DgW+I21RTb2ObNvBedzFx8FJ5LAdJZwZ8qa74ZLk
         KqnGIwxScAQCqZDfetRgkdEnQNwCuY2GjeYpPaa29gKdghcXqvruYq3aeVbzfpoIuLr/
         vOkg==
X-Received: by 10.66.241.66 with SMTP id wg2mr12736116pac.132.1400163717684;
        Thu, 15 May 2014 07:21:57 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.21.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:21:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249100>

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

 contrib/examples/git-merge.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 7e40f40..52f2aaf 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -161,7 +161,7 @@ merge_name () {
 			return
 		fi
 	fi
-	if test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
+	if test "$remote" = "FETCH_HEAD" && test -r "$GIT_DIR/FETCH_HEAD"
 	then
 		sed -e 's/	not-for-merge	/		/' -e 1q \
 			"$GIT_DIR/FETCH_HEAD"
@@ -527,7 +527,7 @@ do
 		git diff-files --name-only
 		git ls-files --unmerged
 	    } | wc -l`
-	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
+	    if test $best_cnt -le 0 || test $cnt -le $best_cnt
 	    then
 		best_strategy=$strategy
 		best_cnt=$cnt
-- 
1.7.10.4
