From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/12] wt-status.c: split bisect detection out of wt_status_get_state()
Date: Wed, 20 Apr 2016 20:24:51 +0700
Message-ID: <1461158693-21289-11-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass9Y-00058K-4c
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbcDTN0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:44 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35831 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbcDTN0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id n1so18488595pfn.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SbNHqL1MPuaLFriHD+9exKIA0+Ly12zOrOW8DwDLAU=;
        b=ukfR7lAXRZh+HdpGBhfn8AheegnCCB+lpAKqNCJ/vURU+ejrCGYiWPvMb58OcImD9z
         GsL8ls+XgkA47x7x0q6oBTTIfLjOB39CHzS2jmuHXdat3Hmkn2D7Yk94nJy7A74tjcYB
         ZGmzsgbGXo2THlRIOAcjVZM0hheb4JXcJebrg2vnzSO/AXp7THKH6BhqTNYjIB44+iou
         IpCSUB/mz5HpKT/AfGhyHteMzUI2BrNdO6v5eWbkrKgA4OwIx997RaeSQwWSSj2JCB11
         Ft8FYUXkgZCsYrJhbJ+4WAFpgEsi1UvDl/gaZ5APmpgD2zuNg86vzfySzAMn+PVBh1Vi
         qmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SbNHqL1MPuaLFriHD+9exKIA0+Ly12zOrOW8DwDLAU=;
        b=elBLwhjfLcY9jBfvE8rg7c5pp2DtRwlIN+ZGAQW5UwPH7bycNIUBOVT7oc7t4MIMrQ
         mJjTEdEKwvk5QAfeSzxPlIQxo6Pm3FkSQsT6MdS6+JQ4dmr9dDKZqSwBADvSLnvu57Xp
         aN8o1K4j9Q1kg0erdyd0CqExJKFF+p2oH6gSiZInzsIqqB52eoYmRVHEbwAZnRYcUeue
         NWouF4GOyXbKVhUReYoym2G1cW8ne+in8kgZqkQemtlY4tf46S764sv9aKFitjF4QeYm
         mHp7eb8TFKRFuJRo3QugLbbdjYcZoYdB3JV6HrUTqhZ/5EHsq4EIR2YQ+7K15aFewGIa
         uWPw==
X-Gm-Message-State: AOPr4FViyw8Pa2qBgRiupAjOAXuMIxLan9UU5XOHZzWLt0aYD/yL7tR0SP5jsXTQudlWKw==
X-Received: by 10.98.82.134 with SMTP id g128mr12327418pfb.113.1461158803047;
        Wed, 20 Apr 2016 06:26:43 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id z28sm27357725pfi.32.2016.04.20.06.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:54 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292020>

And make it work with any given worktree, in preparation for (again)
find_shared_symref(). read_and_strip_branch() is deleted because it's
no longer used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 23 ++++++++++++++---------
 wt-status.h |  2 ++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 2295682..36c85f8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1296,11 +1296,6 @@ got_nothing:
 	return NULL;
 }
=20
-static char *read_and_strip_branch(const char *path)
-{
-	return get_branch(NULL, path);
-}
-
 struct grab_1st_switch_cbdata {
 	struct strbuf buf;
 	unsigned char nsha1[20];
@@ -1393,6 +1388,19 @@ int wt_status_check_rebase(const struct worktree=
 *wt,
 	return 1;
 }
=20
+int wt_status_check_bisect(const struct worktree *wt,
+			   struct wt_status_state *state)
+{
+	struct stat st;
+
+	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
+		state->bisect_in_progress =3D 1;
+		state->branch =3D get_branch(wt, "BISECT_START");
+		return 1;
+	}
+	return 0;
+}
+
 void wt_status_get_state(struct wt_status_state *state,
 			 int get_detached_from)
 {
@@ -1408,10 +1416,7 @@ void wt_status_get_state(struct wt_status_state =
*state,
 		state->cherry_pick_in_progress =3D 1;
 		hashcpy(state->cherry_pick_head_sha1, sha1);
 	}
-	if (!stat(git_path("BISECT_LOG"), &st)) {
-		state->bisect_in_progress =3D 1;
-		state->branch =3D read_and_strip_branch("BISECT_START");
-	}
+	wt_status_check_bisect(NULL, state);
 	if (!stat(git_path_revert_head(), &st) &&
 	    !get_sha1("REVERT_HEAD", sha1)) {
 		state->revert_in_progress =3D 1;
diff --git a/wt-status.h b/wt-status.h
index c4ddcad..2ca93f6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -104,6 +104,8 @@ void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detach=
ed_from);
 int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state);
+int wt_status_check_bisect(const struct worktree *wt,
+			   struct wt_status_state *state);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
2.8.0.rc0.210.gd302cd2
