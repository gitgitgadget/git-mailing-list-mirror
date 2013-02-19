From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/4] t/t7502: compare entire commit message with what was expected
Date: Mon, 18 Feb 2013 20:17:04 -0800
Message-ID: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 05:17:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7eeD-0002Vr-TR
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 05:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab3BSERR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 23:17:17 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:57568 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3BSERQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 23:17:16 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so2801322dal.15
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 20:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=7OAqqhTGNw8LitblCGGLyCVH/MjHu2/qGTwR+23rhXU=;
        b=SDbDxfBo7dh7S7kAGmaGj+M6IwtjC0ONdoQrbPItPom3IKDl5jHIjuOSREmdT2bZfx
         zXXyO+eNgV7zIUXJ3Nryc+2nNStO/sNnxCdqteTPKxGT6Zv1t/SLSm3jxj9hcglogfKj
         zw8Z4lEAhfT6TSmp8GfsEi9qeO+v37QldqgBNmG7jrFQgfVUmp6ZZOYV5HiiD15bY15w
         yolXsIaYlrzMFegfuReRMK7Gzxp8vjSe7ol3zmAUyJ+zDkfs+obu9h3M9PjhJXEYXR5o
         4J+7IveQU6M8xVS6O06Xl4DwAJRPZDePUrkhwnMIKAfsQ0FBBdQEUmEhWyj7gMECMqAa
         jxnA==
X-Received: by 10.66.157.100 with SMTP id wl4mr41815913pab.84.1361247435761;
        Mon, 18 Feb 2013 20:17:15 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id ax3sm16558271pbd.42.2013.02.18.20.17.13
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 20:17:14 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.638.g372f416.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216556>

This test attempts to verify that a commit in "verbatim" mode, when
supplied a commit template, produces a commit in which the commit
message matches exactly the template that was supplied.  But, since the
commit operation appends additional instructions for the user as
comments in the commit buffer, which would cause the comparison to fail,
this test decided to compare only the first three lines (the length of
the template) of the resulting commit message to the original template
file.

This has two problems.

  1. It does not allow the template to be lengthened or shortened
     without also modifying the number of lines that are considered
     significant (i.e. the argument to 'head -n').
  2. It will not catch a bug in git that causes git to append additional
     lines to the commit message.

So, let's use the --no-status option to 'git commit' which will cause
git to refrain from appending the lines of instructional text to the
commit message.  This will allow the entire resulting commit message to
be compared against the expected value.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7502-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index cbd7a45..9040f8a 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -181,8 +181,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >expect &&
-	git commit --cleanup=verbatim -t expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
+	git commit --cleanup=verbatim --no-status -t expect -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
 	test_cmp expect actual
 
 '
-- 
1.8.1.3.638.g372f416.dirty
