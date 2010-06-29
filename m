From: newren@gmail.com
Subject: [PATCH 5/5] fast-import: Handle directories changing into symlinks
Date: Mon, 28 Jun 2010 19:12:16 -0600
Message-ID: <1277773936-12412-6-git-send-email-newren@gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, vmiklos@frugalware.org,
	gitster@pobox.com, spearce@spearce.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPM5-0006ry-9a
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab0F2BLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:11:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33767 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0F2BK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:10:59 -0400
Received: by pwj8 with SMTP id 8so3576372pwj.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WzfKcnqVnvfeDvK7dtFB5Y1wwEqjR3jiSQXuHEJEK54=;
        b=XYRrgL5y3N79kMc9PxG+1ARj2JuQW0Xw5cdoUeDBh1B2lCYxxeWPi7KLzJQX3Ps3dB
         knx1teejjbU//tzJ/Z4aLjplTTK2wTDmcOsi56i6WxERKIIm1IYNvv42o/at367cnLLv
         qM55oETCxkgJUqVu/AB/XUeBUpBSvk5mO1vkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P60dQ335A1LV5lvIJdp0amfIBMOk8ujh4TnqK4F3by7RcwxlvspLJUxsO/UUoHbFe7
         neD5Xs144lQRq3+YmFOy/fWsSyStYCUo7FamQwbGNt7Zxxp7vCwQHTJP7LUa1eTVAN1+
         hgYeS65mUdTI4IBbRqfTzQQ9URYoUsf0Ru1JY=
Received: by 10.142.195.14 with SMTP id s14mr7095163wff.49.1277773858874;
        Mon, 28 Jun 2010 18:10:58 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id x34sm8105171wfi.4.2010.06.28.18.10.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:10:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
In-Reply-To: <1277773936-12412-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149875>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
This is a resend of an earlier patch.  Since the previous one wasn't
reviewed and didn't make it to pu, I decided to resend it along with the
merge-recursive directory/symlink conflict fixes as part of a patch series.

 fast-import.c          |    5 +++++
 t/t9350-fast-export.sh |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1e5d66e..9a2ecc8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1528,6 +1528,11 @@ static int tree_content_remove(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (slash1 && S_ISLNK(e->versions[1].mode))
+				/* p was already removed by an earlier change
+				 * of a parent directory to a symlink.
+				 */
+				return 1;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 69179c6..1ee1461 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,7 +376,7 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-test_expect_failure 'directory becomes symlink'        '
+test_expect_success 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
 	(
-- 
1.7.2.rc0.212.g0c601
