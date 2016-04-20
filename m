From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/12] wt-status.c: split rebase detection out of wt_status_get_state()
Date: Wed, 20 Apr 2016 20:24:47 +0700
Message-ID: <1461158693-21289-7-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass9B-0004wW-1a
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbcDTN0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:20 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36383 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDTN0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:19 -0400
Received: by mail-pf0-f176.google.com with SMTP id e128so18320184pfe.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzPjA+xeorWNLREKnMuYyV3f2Ky4CGn2WrPX54Q1l/E=;
        b=JRw/+tY+n5mPrOvLJTDbIFNRGed9VMYSO3tj+SrpTLBf/tIKedKyCZsxR5YsjS0AHK
         x2pAabqoZ6vGKIttdP4Xa2dRULkl+5MlN2pGJFm8G6Dhv+9J4XR5gGykKe3CU2DyC4Ki
         CuKyYBb64wpwlwGK3Gz06yus/6UQS8Z8M6F1VcBsB/Os+fXR5c+43ibKKlfZ4TqNcX9Q
         rANnySZczl6EZD49EsqZypL8RQveSKWouihmjjgWY7zYc2NF33ITDUGz21biRK1s7nbB
         LnheLqo+Vsf8ggwlAG+WPGsSaki6hqQeHJdn7znOO2qUlWZgh8Jj+3HwULTR7gUl9Q/g
         bHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzPjA+xeorWNLREKnMuYyV3f2Ky4CGn2WrPX54Q1l/E=;
        b=LwaM90arMKGeGLoXHVfBVAJBVdZXWgbzAWb6PAGUq3PSwkYgd4BEZYEgUUdDM9OcSf
         BkVa/q9KZ8tgva4/9awfg08wcmRy/eZMb0NL5tYOmcxqGr4PEbyndsegphXvmd9Gr44e
         wo2neyMwJ1Tcvhvlhrhx+7YKpGmS76DJfkSoazU++g9vDGnVyluib6biBT8ed7Hr0zaa
         H1mJcdNAQ5bRD837bZuUYCjbPZvGT6u89HlNPt97mvrHsv1rsrmW2tidiM3oWLkVHMTn
         dDwT0Lj13lEr1zjsOldE5aVDTqvGXH3N3tEqbyfisXcS8Uq4ubO3UUQmpngewONHyUHH
         ESTA==
X-Gm-Message-State: AOPr4FWYuJtK58/BJr4LYU6hBnztkwk/XqhFRvN2c8n6xBrWZb4rTs+oND7mZHpTcCq75Q==
X-Received: by 10.98.13.88 with SMTP id v85mr12064953pfi.150.1461158778393;
        Wed, 20 Apr 2016 06:26:18 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id w15sm6274749pfa.34.2016.04.20.06.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:30 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292015>

worktree.c:find_shared_symref() later needs to know if a branch is bein=
g
rebased, and only rebased only. Split this code so it can be used
independently from other in-progress tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 23 +++++++++++++++++------
 wt-status.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1ea2ebe..35787ec 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1360,15 +1360,11 @@ static void wt_status_get_detached_from(struct =
wt_status_state *state)
 	strbuf_release(&cb.buf);
 }
=20
-void wt_status_get_state(struct wt_status_state *state,
-			 int get_detached_from)
+int wt_status_check_rebase(struct wt_status_state *state)
 {
 	struct stat st;
-	unsigned char sha1[20];
=20
-	if (!stat(git_path_merge_head(), &st)) {
-		state->merge_in_progress =3D 1;
-	} else if (!stat(git_path("rebase-apply"), &st)) {
+	if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
 			state->am_in_progress =3D 1;
 			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
@@ -1385,6 +1381,21 @@ void wt_status_get_state(struct wt_status_state =
*state,
 			state->rebase_in_progress =3D 1;
 		state->branch =3D read_and_strip_branch("rebase-merge/head-name");
 		state->onto =3D read_and_strip_branch("rebase-merge/onto");
+	} else
+		return 0;
+	return 1;
+}
+
+void wt_status_get_state(struct wt_status_state *state,
+			 int get_detached_from)
+{
+	struct stat st;
+	unsigned char sha1[20];
+
+	if (!stat(git_path_merge_head(), &st)) {
+		state->merge_in_progress =3D 1;
+	} else if (wt_status_check_rebase(state)) {
+		/* all set */
 	} else if (!stat(git_path_cherry_pick_head(), &st) &&
 			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
 		state->cherry_pick_in_progress =3D 1;
diff --git a/wt-status.h b/wt-status.h
index c9b3b74..b398353 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -100,6 +100,7 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detach=
ed_from);
+int wt_status_check_rebase(struct wt_status_state *state);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
2.8.0.rc0.210.gd302cd2
