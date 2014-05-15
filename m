From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/10] git-mergetool.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:48 -0700
Message-ID: <1400163710-28333-8-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwY7-0008Oe-3h
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbaEOOWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:22:11 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46518 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaEOOWC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:22:02 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so1163493pbc.38
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYbV5zJqnDlBECGYeMI6tMtDlyPhDDLzKL48WJRKDu0=;
        b=YRSZZ5ZO4rz2f6xtSofpmdF/iNwagAB/iXAzMzUo7tou1wIPh53ZTmsSnwpx/0/B/x
         Ixrl6jd88LP0wmRffj5e2SISm43NhzXBhfYTTa17Xsy1ojf+eHCHFzirdpoxo4dYxLZU
         rzvqBcH2+9/xoNhZsJWrEHTDqe+U6Svu671RG6YHc7cwM44QduO2DRL6PI2i0t5WFhFl
         H7DdL3RSS7uu9nFy2rchkfIeK3hPcO9QUKgRWPFaScH0RpSteXI80n9HjcxXppw15VSB
         WiiqUj9vt1sSHmoteJc59An3PO9ewQuGZSFzsfuaQA5U5rHXg1Mz8QXn/jAoLd+2smlS
         Is7g==
X-Received: by 10.66.236.163 with SMTP id uv3mr12918419pac.18.1400163721486;
        Thu, 15 May 2014 07:22:01 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.22.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:22:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249097>

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

 git-mergetool.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 332528f..88e853f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -205,7 +205,7 @@ checkout_staged_file () {
 		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
 		: '\([^	]*\)	')
 
-	if test $? -eq 0 -a -n "$tmpfile"
+	if test $? -eq 0 && test -n "$tmpfile"
 	then
 		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
 	else
@@ -256,7 +256,7 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test -z "$local_mode" -o -z "$remote_mode"
+	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
 		describe_file "$local_mode" "local" "$LOCAL"
-- 
1.7.10.4
