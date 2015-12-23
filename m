From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 09/11] dir: simplify untracked cache "ident" field
Date: Wed, 23 Dec 2015 22:03:57 +0100
Message-ID: <1450904639-25592-10-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:05:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqan-0000a2-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965486AbbLWVE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:58 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33754 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965476AbbLWVEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:46 -0500
Received: by mail-wm0-f50.google.com with SMTP id p187so158639143wmp.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GOy5rkbNUsHg52mezqpBcp7xg9rjiCp7OE36eovuM78=;
        b=sefl1mZN5pV5EsLz35IKyi5yFzDHV4tItxMI15mDYPhjiUl4qM3yad0pRf+LY4kGts
         cmvq1YRSpQchCtDJPciD6SmtCgPZ8XLtWcCadnByWfAzum5TlRCbr7O8ibNt8KfMf5kI
         cOLAUxmC4AyVBdQlz6pK+tzoRkDKOAoXjmsVymZJkdPmFT8Wn2OFX1rwqI7axHLMnnu7
         xkTasFZAA+k9CyDxSHtVVtZpU6yShV4d8raDw1tYonP+MzS5/WazpU7xorM9A3tOpMiN
         J6IW5huoc1CWDFIDrwPpJNW+AA8ABZ8Guu3o4TPR2hu8ev3EYf2O2fGFO3mrLTFL1gyp
         aZzw==
X-Received: by 10.28.178.138 with SMTP id b132mr33833031wmf.25.1450904684386;
        Wed, 23 Dec 2015 13:04:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:43 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282964>

It is not a good idea to compare kernel versions and disable
the untracked cache if it changes as people may upgrade and
still want the untracked cache to work. So let's just
compare work tree locations to decide if we should disable
it.

Also it's not useful to store many locations in the ident
field and compare to any of them. It can even be dangerous
if GIT_WORK_TREE is used with different values. So let's
just store one location, the location of the current work
tree.

If this location changed and we still want an untracked
cache, let's delete the cache and recreate it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 dir.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index dba1ad0..7596a3f 100644
--- a/dir.c
+++ b/dir.c
@@ -1918,23 +1918,36 @@ static const char *get_ident_string(void)
 	return sb.buf;
 }
 
-static int ident_in_untracked(const struct untracked_cache *uc)
+static int ident_current_location_in_untracked(const struct untracked_cache *uc)
 {
-	const char *end = uc->ident.buf + uc->ident.len;
-	const char *p   = uc->ident.buf;
+	struct strbuf cur_loc = STRBUF_INIT;
+	int res = 0;
 
-	for (p = uc->ident.buf; p < end; p += strlen(p) + 1)
-		if (!strcmp(p, get_ident_string()))
-			return 1;
-	return 0;
+	/*
+	 * Previous git versions may have saved many strings in the
+	 * "ident" field, but it is insane to manage many locations,
+	 * so just take care of the first one.
+	 */
+
+	strbuf_addf(&cur_loc, "Location %s, system ", get_git_work_tree());
+
+	if (starts_with(uc->ident.buf, cur_loc.buf))
+		res = 1;
+
+	strbuf_release(&cur_loc);
+
+	return res;
 }
 
-void add_untracked_ident(struct untracked_cache *uc)
+static void set_untracked_ident(struct untracked_cache *uc)
 {
-	if (ident_in_untracked(uc))
-		return;
+	strbuf_reset(&uc->ident);
 	strbuf_addstr(&uc->ident, get_ident_string());
-	/* this strbuf contains a list of strings, save NUL too */
+
+	/*
+	 * This strbuf used to contain a list of NUL separated
+	 * strings, so save NUL too for backward compatibility.
+	 */
 	strbuf_addch(&uc->ident, 0);
 }
 
@@ -1945,15 +1958,21 @@ static void new_untracked_cache(void)
 	uc->exclude_per_dir = ".gitignore";
 	/* should be the same flags used by git-status */
 	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	set_untracked_ident(the_index.untracked);
 	the_index.untracked = uc;
+	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
 
 void add_untracked_cache(void)
 {
-	if (!the_index.untracked)
+	if (!the_index.untracked) {
 		new_untracked_cache();
-	add_untracked_ident(the_index.untracked);
-	the_index.cache_changed |= UNTRACKED_CHANGED;
+	} else {
+		if (!ident_current_location_in_untracked(the_index.untracked)) {
+			free_untracked_cache(the_index.untracked);
+			new_untracked_cache();
+		}
+	}
 }
 
 void remove_untracked_cache(void)
@@ -2021,7 +2040,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
-	if (!ident_in_untracked(dir->untracked)) {
+	if (!ident_current_location_in_untracked(dir->untracked)) {
 		warning(_("Untracked cache is disabled on this system."));
 		return NULL;
 	}
-- 
2.7.0.rc2.11.g68ccdd4
