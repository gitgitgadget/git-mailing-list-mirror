From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/4] t7502: demonstrate breakage with a commit message with trailing newlines
Date: Mon, 18 Feb 2013 20:17:05 -0800
Message-ID: <1361247427-438-2-git-send-email-drafnel@gmail.com>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 05:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7eeN-0002Zh-U2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 05:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab3BSERV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 23:17:21 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:56890 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3BSERT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 23:17:19 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so2790808dad.10
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 20:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4pEFxnxE3qi5NvcBMsvg1wy4mxmnMP4RMr8UHCt8ImM=;
        b=G/1Qqk1BhXi+HicX3gPeNusg2pT4ybTyKCPqFYoo+69QG9/zODAIUhscQYQzHEG+1t
         dV9S217YthFXInJQRIc3xSBSDiPG1bSx/VYYlwl9RrgBoZYnGSPyAszilBnHTIm+yigq
         0RXUwIlSvmAtMLO4cxrn01IemZ6CYcAC/zF0A02bukE5yQfwlHtFnYLWQpYuMEn/r6p+
         a6y6qql42nrhHDcqwNNWtCH8ObtnKEn5GQTGvCXnD24+KEaMPebjHoiR6oZJTznr6fzM
         Dgfx2zp/8FdIx+U9mAQb7gqAXKC/Np52TzaT0CdhYoLrz+4HYoQJuXtANRgTRpRQwkqT
         iQ0A==
X-Received: by 10.66.79.135 with SMTP id j7mr42321955pax.0.1361247438656;
        Mon, 18 Feb 2013 20:17:18 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id ax3sm16558271pbd.42.2013.02.18.20.17.16
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 20:17:17 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.638.g372f416.dirty
In-Reply-To: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216557>

This test attempts to verify that a commit message supplied to 'git
commit' via the -m switch was used in full as the commit message for a
commit when --cleanup=verbatim was used.

But, this test has been broken since it was introduced.  Since the
commit message containing trailing newlines was supplied to 'git commit'
using a command substitution, the trailing newlines were removed by the
shell.  This means that a string without any trailing newlines was
actually supplied to 'git commit'.

The test was able to complete successfully since internally, git appends
two newlines to each string supplied via the -m switch.  So, the two
newlines removed by the shell were then re-added by git, and the
resulting commit matched what was expected.

So, let's move the initial creation of the commit message string out
from within a previous test so that it stands alone.  Assign the desired
commit message to a variable using literal newlines.  Then populate the
expect file from the contents of the commit message variable.  This way
the shell variable becomes the authoritative source of the commit
message and can be supplied via the -m switch with the trailing newlines
intact.

Mark this test as failing, since it is not handled correctly by git.
As described above, git appends two extra newlines to every string
supplied via -m.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7502-commit.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 9040f8a..39e55f8 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -177,10 +177,18 @@ test_expect_success 'verbose respects diff config' '
 	git config --unset color.diff
 '
 
+mesg_with_comment_and_newlines='
+# text
+
+'
+
+test_expect_success 'prepare file with comment line and trailing newlines'  '
+	printf "%s" "$mesg_with_comment_and_newlines" >expect
+'
+
 test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo; } >expect &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
 	test_cmp expect actual
@@ -196,10 +204,10 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (verbatim option,-m)' '
+test_expect_failure 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
-	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
+	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
 	test_cmp expect actual
 
-- 
1.8.1.3.638.g372f416.dirty
