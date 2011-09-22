From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/2] fast-import: don't allow to tag empty branch
Date: Fri, 23 Sep 2011 01:47:04 +0600
Message-ID: <1316720825-32552-2-git-send-email-divanorama@gmail.com>
References: <1316720825-32552-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 21:40:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6p8B-0004Tz-0H
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 21:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab1IVTkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 15:40:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44362 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1IVTkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 15:40:17 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2807782bkb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v2LAQ7ts3csmqnyU+e/TUnjhJcxUnBQNxus5RyLsB7Q=;
        b=Rvt7ZSyi/qYm0GyJ3RdEG6+YFrnqGWBnDl0NzGJ7GSglx1NJ+I6BiWh8x6Pno0JQSe
         B459nBeEju8DWVBhbIwinzcgCRA/1MdaN4I0DkhV393bO0eR8o14fJT5TMwhnbKMuSke
         WiNfZ/6JpdABlR1g9qdicfAH+dnjaRI6GiWvA=
Received: by 10.204.153.27 with SMTP id i27mr1867237bkw.278.1316720416940;
        Thu, 22 Sep 2011 12:40:16 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id j16sm3857428bks.3.2011.09.22.12.40.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 12:40:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316720825-32552-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181914>

'reset' command makes fast-import start a branch from scratch. It's name
is kept in lookup table but it's sha1 is null_sha1 (special value).
'tag' command can be used to tag a branch by it's name. lookup_branch()
is used it that case and it doesn't check for null_sha1. So fast-import
writes a tag for null_sha1 object instead of giving a error.

Add a check to deny tagging an empty branch and add a corresponding test.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |    2 ++
 t/t9300-fast-import.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 742e7da..c44cc11 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2717,6 +2717,8 @@ static void parse_new_tag(void)
 	from = strchr(command_buf.buf, ' ') + 1;
 	s = lookup_branch(from);
 	if (s) {
+		if (is_null_sha1(s->sha1))
+			die("Can't tag an empty branch.");
 		hashcpy(sha1, s->sha1);
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1a6c066..0b97d7a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -820,6 +820,18 @@ test_expect_success \
 	'test 1 = `git rev-list J | wc -l` &&
 	 test 0 = `git ls-tree J | wc -l`'
 
+cat >input <<INPUT_END
+reset refs/heads/J2
+
+tag wrong_tag
+from refs/heads/J2
+data <<EOF
+Tag branch that was reset.
+EOF
+INPUT_END
+test_expect_success \
+	'J: tag must fail on empty branch' \
+	'test_must_fail git fast-import <input'
 ###
 ### series K
 ###
-- 
1.7.3.4
