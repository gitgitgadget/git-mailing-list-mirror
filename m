From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] grep --no-index: don't use git standard exclusions
Date: Thu, 15 Sep 2011 20:26:03 +0200
Message-ID: <7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 20:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Gdc-00067S-Bo
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 20:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934366Ab1IOS0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 14:26:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48741 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934275Ab1IOS0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 14:26:11 -0400
Received: by bkbzt4 with SMTP id zt4so2742136bkb.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=tJfGu05GUUzhhbMT85X4skWQiK4bkMxzAvA6GXGLEn8=;
        b=AzP074P0zsNlmmuSnwXGDX2ALFrgX/rIBZ2KorJdsJhMXem1k7WHlcamd9LSU8i2Bf
         AfVt/RGvogHIp0qEGdHoZPEA7lwXDX4y4HNr/62XV2UJSYeTeg8Vw3Ba4eUayOWun8l5
         df0kNfKJA/ZI84a/krUVcJLbmUV0BU2xNA5Y0=
Received: by 10.204.150.134 with SMTP id y6mr201647bkv.272.1316111170352;
        Thu, 15 Sep 2011 11:26:10 -0700 (PDT)
Received: from localhost (p5B2AB10E.dip.t-dialin.net. [91.42.177.14])
        by mx.google.com with ESMTPS id p8sm4168851bkk.3.2011.09.15.11.26.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 11:26:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com>
In-Reply-To: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181485>

The --no-index mode is intended to be used outside of a git repository, but
enabling the git standard exclusions outside a git repositories does not make
any sense. Especially if it is not possible to disable them.

Thus do not use the standard exclusions in --no-index mode.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

On Wed, Jul 20, 2011 at 22:57, Junio C Hamano <gitster@pobox.com> wrote:
>  - Since 3081623 (grep --no-index: allow use of "git grep" outside a git
>   repository, 2010-01-15) and 59332d1 (Resurrect "git grep --no-index",
>   2010-02-06), "grep --no-index" incorrectly paid attention to the
>   exclude patterns. We shouldn't have, and we'd fix that bug.

Fix this bug.

 builtin/grep.c  |    1 -
 t/t7810-grep.sh |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e0562b0..127584e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -643,7 +643,6 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec)
 	int i, hit = 0;
 
 	memset(&dir, 0, sizeof(dir));
-	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, pathspec->raw);
 	for (i = 0; i < dir.nr; i++) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 0d60016..4a05e79 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -554,7 +554,6 @@ test_expect_success 'outside of git repository' '
 	mkdir -p non/git/sub &&
 	echo hello >non/git/file1 &&
 	echo world >non/git/sub/file2 &&
-	echo ".*o*" >non/git/.gitignore &&
 	{
 		echo file1:hello &&
 		echo sub/file2:world
@@ -581,6 +580,7 @@ test_expect_success 'inside git repository but with --no-index' '
 	echo world >is/git/sub/file2 &&
 	echo ".*o*" >is/git/.gitignore &&
 	{
+		echo ".gitignore:.*o*" &&
 		echo file1:hello &&
 		echo sub/file2:world
 	} >is/expect.full &&
-- 
1.7.6.789.gb4599
