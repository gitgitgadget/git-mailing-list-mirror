From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/10] contrib/examples/git-resolve.sh: don't use the -a or -b option with the test command
Date: Thu, 15 May 2014 07:21:46 -0700
Message-ID: <1400163710-28333-6-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwY0-00084c-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbaEOOWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:22:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34338 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbaEOOV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:21:59 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so1133495pab.26
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9LNHJ2Y9puSBhMfGRJ6Ef9wOXAaV0GP6Z0i5NgUxflY=;
        b=UlSuhO7E8VvhEGKqNgPc1b+Y+Tv+iMHQBKYgWlnzCKELQNfWyxK0XVMKN9BQ/MEnqg
         ZDvuVOb9pfHhTmGt/9vV4vWVxKiN8tz5uyB0EYbK0wqS76S3buLFbgywpL7bOzHU0+Tb
         CVnjvBergnzPAavixMJ7Y5rce6cC7VQJQUXZl+LBtfwTF+NPQLvHznoa6eBcvUX7Ynfp
         CE1QU6TIhmunzkTczZUioXi+1CM9eppSl0ya3AeYlN9ZaXZLCGnrFLzUZtg244i3uT+H
         cGZgNSso42OS4Yzfrse5Ghr688TehdCc6J03JwxPK/S4K34R9RItUwA4VxBHgHKosN/3
         pedQ==
X-Received: by 10.68.211.233 with SMTP id nf9mr12897072pbc.29.1400163719412;
        Thu, 15 May 2014 07:21:59 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.21.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:21:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249094>

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

 contrib/examples/git-resolve.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resolve.sh
index 48d0fc9..70fdc27 100755
--- a/contrib/examples/git-resolve.sh
+++ b/contrib/examples/git-resolve.sh
@@ -76,7 +76,7 @@ case "$common" in
 			2>/dev/null || continue
 		# Count the paths that are unmerged.
 		cnt=$(GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l)
-		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		if test $best_cnt -le 0 || test $cnt -le $best_cnt
 		then
 			best=$c
 			best_cnt=$cnt
-- 
1.7.10.4
