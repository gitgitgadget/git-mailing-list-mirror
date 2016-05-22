From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/6] worktree.c: rewrite mark_current_worktree() to avoid strbuf
Date: Sun, 22 May 2016 16:33:52 +0700
Message-ID: <20160522093356.22389-3-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:34:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4PmQ-0001I2-R1
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcEVJeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:37 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34517 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcEVJeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:36 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so15029668pac.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19VSyx31l325erI1Coa5wo7Mr+IuAJOVxclZaW1lQWw=;
        b=fpsUHlIqYT4iyzGnzqGA7RyhkfOEQRxwJnZwhgxEr0rixEY94qLm3PUDwrfDVE9Az3
         yah1guujM6fkiTOCjQzhXTNW/tMn1I32Owz+lTQcc8D6AjB9jX6dapkIO4zVaR8LaWWH
         iY9tYbd08T4jPf1QCak2YSjrC0HkHEOjtOLgP5NJKQcR5ebe91QC95F/Y9Fu66Uu4iUx
         5QejSrJJXRn5s/sedJVkcPontFc6klB5HzwL4KLK7rCaKmY/LrdPuAKPB8iog11MOhuu
         ySKyVuhLbtAokiZeGtZdgySQ5JBM2WOjl/+g7kDOceuMMP3vOtAo2LnpQ6taGnHUUR1u
         PXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19VSyx31l325erI1Coa5wo7Mr+IuAJOVxclZaW1lQWw=;
        b=HTxYinCQyBHuKXZKq/Fp1RY4Oh9OwImcSnNo6rHrYi4O9q/l6mL6kezWPSo2W1AjVl
         Fvng7/Aqf4doyNCteetCTFLk+wyzu2f9o/6X9jRLICayyVTaqQm/VwzX1RrUOTd0BBMI
         NQXKlHQOk2y95TO9CKUh/XkGwvgySWPDz3PNtGwICYuNAAisrSFD1fFZUJDrbV628Wkl
         tuBpeay6dzLVPA8VjNX3SC1ZM6YRDFOqakLMrSybgUuLASGjg9ziJ3ClQxs3fQ/XZwR+
         /RygY/fyE6aSUH9X/LlQaOasna7qkkESLN/wdMFEeL7k8c64BtAOSk5N0kDtsMPbGPdt
         wA+g==
X-Gm-Message-State: AOPr4FVwXAEbzZB9WQu77UF2BvuB9Y26KC5q0GwIntNGGzQUmTCSjA2LWv251CkHcGXHnw==
X-Received: by 10.66.118.106 with SMTP id kl10mr18452187pab.78.1463909675213;
        Sun, 22 May 2016 02:34:35 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id hk7sm38781218pad.25.2016.05.22.02.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:30 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295262>

strbuf is a bit overkill for this function. What we need is to call
absolute_path() twice and make sure the second call does not destroy th=
e
result of the first. One buffer allocation is enough.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/worktree.c b/worktree.c
index 4817d60..6a11611 100644
--- a/worktree.c
+++ b/worktree.c
@@ -153,21 +153,19 @@ done:
=20
 static void mark_current_worktree(struct worktree **worktrees)
 {
-	struct strbuf git_dir =3D STRBUF_INIT;
-	struct strbuf path =3D STRBUF_INIT;
+	char *git_dir =3D xstrdup(absolute_path(get_git_dir()));
 	int i;
=20
-	strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
 	for (i =3D 0; worktrees[i]; i++) {
 		struct worktree *wt =3D worktrees[i];
-		strbuf_addstr(&path, absolute_path(get_worktree_git_dir(wt)));
-		wt->is_current =3D !fspathcmp(git_dir.buf, path.buf);
-		strbuf_reset(&path);
-		if (wt->is_current)
+		const char *wt_git_dir =3D get_worktree_git_dir(wt);
+
+		if (!fspathcmp(git_dir, absolute_path(wt_git_dir))) {
+			wt->is_current =3D 1;
 			break;
+		}
 	}
-	strbuf_release(&git_dir);
-	strbuf_release(&path);
+	free(git_dir);
 }
=20
 struct worktree **get_worktrees(void)
--=20
2.8.2.524.g6ff3d78
