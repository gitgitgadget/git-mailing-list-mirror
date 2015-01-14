From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/10] read-cache.c: make fill/match_stat_data() static
Date: Wed, 14 Jan 2015 15:40:54 -0800
Message-ID: <1421278855-8126-10-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXZH-0002st-9h
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbbANXli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845AbbANXle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5B1D2DBBF;
	Wed, 14 Jan 2015 18:41:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=q5y3
	z5Bwjzt8dmSohqEULOz61V4=; b=C4+reFHmfgSZE6H/k2L9YqUIVoqD2DnU1LgS
	lRKlfI7OnvdCVVrZ/qSYg+k+M1oL7onVB8abiZoAc0A+lHRa3fBMSwd9UFVt1cwK
	JHSbmSEWvMn3gm1gUNAsjMErLJmxlDRTRzo42IymMOj6fxx0/eOCn5hqF14ux6ZD
	TWvwrRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Crx8Dp
	ipjgYnB+A2FGiJthD9Lc7o4TWz9Zq2G6nswRzngFZCdOeZ/nORNxmLt0YaNqBBrV
	OLfjW7+kn8wA1xnu7p/IWF6lDtjGmxm5LA22Ik6iYmC7e57kBcvBipG/3p9EXpRQ
	dVq+sXpWfsM6aMt7bEi8xGpGV2x7zLLaWmV84=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC8AD2DBBE;
	Wed, 14 Jan 2015 18:41:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05B4E2DB9B;
	Wed, 14 Jan 2015 18:41:13 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D3A3CB94-9C46-11E4-AE0F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262448>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      | 14 --------------
 read-cache.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index f704af5..98911c8 100644
--- a/cache.h
+++ b/cache.h
@@ -539,20 +539,6 @@ extern int ie_modified(const struct index_state *, const struct cache_entry *, s
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
 
-/*
- * Record to sd the data from st that we use to check whether a file
- * might have changed.
- */
-extern void fill_stat_data(struct stat_data *sd, struct stat *st);
-
-/*
- * Return 0 if st is consistent with a file not having been changed
- * since sd was filled.  If there are differences, return a
- * combination of MTIME_CHANGED, CTIME_CHANGED, OWNER_CHANGED,
- * INODE_CHANGED, and DATA_CHANGED.
- */
-extern int match_stat_data(const struct stat_data *sd, struct stat *st);
-
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
diff --git a/read-cache.c b/read-cache.c
index 9cff715..5a71de1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -83,7 +83,11 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
-void fill_stat_data(struct stat_data *sd, struct stat *st)
+/*
+ * Record to sd the data from st that we use to check whether a file
+ * might have changed.
+ */
+static void fill_stat_data(struct stat_data *sd, struct stat *st)
 {
 	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
 	sd->sd_mtime.sec = (unsigned int)st->st_mtime;
@@ -96,7 +100,13 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
 	sd->sd_size = st->st_size;
 }
 
-int match_stat_data(const struct stat_data *sd, struct stat *st)
+/*
+ * Return 0 if st is consistent with a file not having been changed
+ * since sd was filled.  If there are differences, return a
+ * combination of MTIME_CHANGED, CTIME_CHANGED, OWNER_CHANGED,
+ * INODE_CHANGED, and DATA_CHANGED.
+ */
+static int match_stat_data(const struct stat_data *sd, struct stat *st)
 {
 	int changed = 0;
 
-- 
2.3.0-rc0-134-g109a908
