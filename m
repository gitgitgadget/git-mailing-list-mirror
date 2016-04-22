From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/13] wt-status.c: split rebase detection out of wt_status_get_state()
Date: Fri, 22 Apr 2016 20:01:30 +0700
Message-ID: <1461330096-21783-8-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ataj5-0007N4-7A
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbcDVNCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:23 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33485 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcDVNCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:22 -0400
Received: by mail-pa0-f65.google.com with SMTP id vv3so9969409pab.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QF6+jLYJQrcjHKaVKlsIgbziBiBmWwTa6jUisOwQHas=;
        b=08M73TsYejo59oeigmR0UaWZ2BPgxFyLOthgsq0XAI+gEXlIFl03pITZ/lyeH8PMTO
         PVKi2kJ8yJW745Q5SrQCrxynkGSBZ2mMVGbt/yP2ZJG9pbC3DXBZX4wllMv2rlCvJyUW
         nrBTs3ayqrArvaQ9ZIG3V3aprXz6mMVikGgiWFY7lt2Z79jWZ4FsJQlDsmNV/tv0ORhG
         8aGXJdxguzx4DCDvYRFJAcqHyGXHSgEuIAm+pft0Kq+IsgTHjR4UPdCX+s6Ps31DPJ4M
         tnU7XhypDF0xw6Rq3Ci+ItdKx98VIv4t5t3PuRbh24nywVUEDtpSfmpiOtvIho9KFeUB
         FicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QF6+jLYJQrcjHKaVKlsIgbziBiBmWwTa6jUisOwQHas=;
        b=KI+bcWEz3UtbLfAAw9Zb7yCQW+Xq2zMRlxTtKLz5UedOP5+Z7REzRqIQ7qpKUic2Ja
         pyRpeYujuKDIMqHGgeGq7AbsGGOpJtON+aaRElmGqt+FFvTJknTCzuTGpKIuQ0ArPI+X
         SsYrRUKurLWaEkimMGg/n9GUzxsjYhsouNiev/UCHH6B9jS08rDFrczE2M7uOLZCEnjU
         4tBgW1KGuFsa24Xp+PMg5FOcv+7Yj6onufw6IVA9go8WXbcMQLowSgmfGRagaJp3Qbcx
         r2IJ/vJe+uD8Dp/vfwmBcr1u23Pjb/Rl9x2ErRcUGX7C4EOFvT3kiaHNsPZJ0ujXvCdR
         tnOQ==
X-Gm-Message-State: AOPr4FWwPzBfJcVXwiA/BLklIvzbpfHMSdbv8kEjDyHGbhNbZ7OLfKAlfser+IZHVfYcLA==
X-Received: by 10.66.142.73 with SMTP id ru9mr28163642pab.51.1461330141490;
        Fri, 22 Apr 2016 06:02:21 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id t85sm8440429pfi.55.2016.04.22.06.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:02:34 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292196>

worktree.c:find_shared_symref() later needs to know if a branch is bein=
g
rebased, and only rebase, no cherry-pick, do detached branch... Split
this code so it can be used independently from other in-progress tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 23 +++++++++++++++++------
 wt-status.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1ea2ebe..ec9240d 100644
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
+		;		/* all set */
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
