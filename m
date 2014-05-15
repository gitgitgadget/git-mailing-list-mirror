From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/10] contrib/examples/git-merge.sh: don't use the -a or -b option with the test command
Date: Thu, 15 May 2014 07:17:31 -0700
Message-ID: <1400163457-28285-4-git-send-email-gitter.spiros@gmail.com>
References: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:17:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwTs-0005GT-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbaEOORt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:17:49 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:58713 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbaEOORq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:17:46 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so1165787pbc.9
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4gcf/SU06gbq2QHs57k5SdUbU5yqweXqLhU0+yB/xY=;
        b=YbXgypm4O3ddEO+CTCAi/8cR8eBdudk0qtn7l+YPRGqaA7ZDzMo75Cd2GdInz5DQ5I
         4aRyrT8ORKaN+DofPwgYdSqIhIo4yY3i6kxNgCGxkODUCK1S6cCloE9bRXNbnaWmIZkO
         2kW9AthjPXyQGwKcI4DB59gCd8NRVKz/+oo+a6R3Rq9j4Qe59DdbuRhUnDokXvyPO2Il
         n/CW3Ynp4f+ttciFVhIYrdcA2UIbE8cT590B0pSg51OIUW623A4vFb/Zj2sB8jDvZfEX
         qIotkZeFGQ3ysux0+cwegJsXvY7mvA5r1/but4G9sBdzsMQD40P6p3tANWezlTsRV0Tl
         GZwg==
X-Received: by 10.66.163.2 with SMTP id ye2mr12835443pab.110.1400163466125;
        Thu, 15 May 2014 07:17:46 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id as12sm21782704pac.43.2014.05.15.07.17.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:17:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249082>

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
