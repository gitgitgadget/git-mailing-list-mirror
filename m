From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] worktree.c: rewrite mark_current_worktree() to avoid strbuf
Date: Tue, 10 May 2016 21:15:48 +0700
Message-ID: <20160510141553.22967-2-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:16:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08Sf-0007aT-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbcEJOQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:16:27 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36722 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcEJOQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:16:25 -0400
Received: by mail-pa0-f67.google.com with SMTP id i5so996881pag.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrcbaR7R+N53xDEDriWvIfvCmOQWMeQqh5mTLzvADEc=;
        b=oWFxnYNS8RzZ1OwR4AxHw5SJd4zg2CFoCKkE+u01EznPHe5Mwyh/JVFfb8wdKc5Onp
         PiLXnLsM6fcrl5gxlAsagOeP+exG7Sf1Eh8sS2b7dRDuEW6elA1a7K//it9zBRWZvUp9
         aQSsb6lr32ZKON1Gri9RCg2WzayrYa6Gjgc/3knsv6gIC5Qzfd7M0h7AI1NK5p6xtLhr
         sFZ9ly7U0hP5oJtOspJzgLUrFPOhIw5wSwVM3D7o2JR8aqaJIxv9zwMnef9oJNXtJ4XA
         hAuZYQ3J15pcODZn7r9IIE1rd0POXLHOYBCpGbgLVep+ZKR8/eX1/v9xjACMXqIbXTZ9
         H09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrcbaR7R+N53xDEDriWvIfvCmOQWMeQqh5mTLzvADEc=;
        b=Qv9b776wgAA1uN/l2Tfaye0HFlRUGSZ7lUngtE2tvJtpIiybeQQD7O8JDqSTcAHUuT
         twF8RMDLxLjHp6YopggP7NxuTR7yM4aLyQyGw1jSOKHS6MltuY9OFyifiZDWlDcepcXi
         Wvtk5KUwH0iSHeM5H0UGPAocCbhipnarmUDJ3WJAtNe+0Qm7Rnv3GfHtTjZ1GTNmY/fm
         hLXbAeZCev1TvYE8hWaIWcOuBlz0UUh/TxIzLoYCrxm2Sa96waY1zROC6+DksW4IEGuG
         aB6MR3gr+P3ct0O+EEBT21i4dTvIcfwN6HD7U/hcpEBmKfdq7J0T1jf8dGHtm3r54S5s
         Eeow==
X-Gm-Message-State: AOPr4FXIoiJH74wy54Twi0Fe67eJ5UYdsbG9SI/Nt+j13CJ7yIyxralb7bZWoh4S9Ohsfw==
X-Received: by 10.66.160.133 with SMTP id xk5mr59039999pab.71.1462889784596;
        Tue, 10 May 2016 07:16:24 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id i6sm4958571pfc.65.2016.05.10.07.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:16:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:26 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294137>

strbuf is a bit overkill for this function. What we need is call
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
