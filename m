From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] for-each-ref: introduce %(HEAD) marker
Date: Fri, 24 May 2013 19:49:36 +0530
Message-ID: <1369405177-7855-3-git-send-email-artagnon@gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 16:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfsqX-0007G2-3H
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 16:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426Ab3EXOSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 10:18:01 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:45501 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280Ab3EXOR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 10:17:59 -0400
Received: by mail-pa0-f44.google.com with SMTP id wp1so1749866pac.17
        for <git@vger.kernel.org>; Fri, 24 May 2013 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6ayD36WvFf7jKdDyEuKLsWa02Ww+Pr1VQM+gmojWmfU=;
        b=YoNQ/xQQKvrC6xiElQv3D/9L3kao5VoyYcWm0xfCPJWvqCCJ88NF++sWKm61O9wyNa
         WVBwF6hQrso1B6gPBJgPYmxN2Y3wqGb02tOLVrdu0cPMPgQYEmXbsHt1YYVLwPghrw8i
         h2xZKoVc6JYM+Jcihd+HSfasOtKfQOS6VERnLvgwaaK/x4jhHN37N3YZnKv0vRBAIHHL
         yH0+CAGV4TYk+aYyL/y8D3RhVTtEvgyQ2pMAm2r9sPPJsoU4wpp8xhOVbJAcLmSHN5hS
         8Xd54agDDxmjdVKt7KKTEIGwa1whDBWrquD+FnHUKMMdcYOKT3WTjc63RJqbTpXFCvjW
         6aIg==
X-Received: by 10.66.26.203 with SMTP id n11mr11619747pag.196.1369405078867;
        Fri, 24 May 2013 07:17:58 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id qp4sm16338288pbc.41.2013.05.24.07.17.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 07:17:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.2.g99b8f3f.dirty
In-Reply-To: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225356>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend the format with
%(HEAD) to do exactly the same thing.

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)

to display a red asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1563b25..63d3a85 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
 
 /*
@@ -683,8 +684,16 @@ static void populate_value(struct refinfo *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		}
-		else
+		} else if (!strcmp(name, "HEAD")) {
+			const char *head;
+			unsigned char sha1[20];
+			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (!strcmp(ref->refname, head))
+				v->s = "*";
+			else
+				v->s = " ";
+			continue;
+		} else
 			continue;
 
 		formatp = strchr(name, ':');
-- 
1.8.3.rc3.2.g99b8f3f.dirty
