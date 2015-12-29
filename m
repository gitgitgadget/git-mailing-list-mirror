From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 08/10] dir: simplify untracked cache "ident" field
Date: Tue, 29 Dec 2015 08:09:32 +0100
Message-ID: <1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSn-0008Us-6D
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbbL2HMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:54 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36586 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbL2HMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:20 -0500
Received: by mail-wm0-f42.google.com with SMTP id l65so24575106wmf.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sOyiw1LW5CN+24mtcGtW5G3xMliizwzrrslR65BQbm0=;
        b=gVFW30GtCT+l2mZLy7tMQkroazmqDBdFyLkFFW5+cPsRgO/dWY/ng94CChjvouEst+
         NaB3drUTkUvgit22Sl6c3XE6wphviSIv714Fhlt/1inBnddL8D4M4+OYTenK4uzsh62n
         qSLoOooldFKgx18rK9iaKGPWnQSOIGpZXEhv2uZK4uu7wKRndK51karlE53VgUXGK7to
         4wGasZYok/dFTrEppaMQXD6vUmJDPmy9gFzZL7T9P/H6b4fgeoADqASZXBC++neUgW40
         l23V/MCj6AuQq7aRS2vjzq04oF6ONKHqEY6Er3nEjY77/svf2CewDa4gJwnZme3yIl+v
         EAKg==
X-Received: by 10.194.63.142 with SMTP id g14mr61834375wjs.161.1451373139724;
        Mon, 28 Dec 2015 23:12:19 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:18 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283087>

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
index dba1ad0..1a8b5a2 100644
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
+	set_untracked_ident(uc);
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
2.7.0.rc2.10.g544ad6b
