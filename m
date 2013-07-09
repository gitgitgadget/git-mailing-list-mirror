From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/15] for-each-ref: introduce %(HEAD) marker
Date: Tue,  9 Jul 2013 16:02:22 +0530
Message-ID: <1373365946-9230-12-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHu-0007Ep-68
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab3GIKgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:45 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42320 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab3GIKgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:41 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so5341920pbc.25
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uC6bRhYOjz9OYjOXJW6533wVq71AtjEDZsrw1I5+aH4=;
        b=R0xeaBb24UiqzUjQZrNGySPtL/bZ5OOdE+lbrRS7TACwn+h6AKaogMsoW53bsK0hYe
         EJksUuFkHgTNkf1Oljz2KBglcX26iFc1Xq9TROvhm6ywA0lcz3rUmv8OdDHSb5ICcaXS
         Vmnsf5oCbbSoO8ggtrxKnvOUm7we/dtS5JBMr4sXhvXaUpoGEynJ1KnticudpAB28QRs
         fZlnjWy85KYhEYr+33C4cv8Qca8qcw+53LYIFnRC20ACoEpkTreDm6d3K3zltavdtF3F
         /5kDbpUqHfQu5VGIrjAcgt2kL89jE69sKEY6iailMJUyd5/JtUQiya+ZB+SQrsvhcWQy
         lwOg==
X-Received: by 10.66.118.227 with SMTP id kp3mr26703880pab.190.1373366201048;
        Tue, 09 Jul 2013 03:36:41 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229940>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend the format with
%(HEAD) to do exactly the same thing.

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)

to display a red asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 8cbc08c..8d982e3 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -121,6 +121,10 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
=20
+HEAD::
+	Useful to indicate the currently checked out branch.  Is '*'
+	if HEAD points to the current ref, and ' ' otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index da479d1..3d357a9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
=20
 /*
@@ -679,8 +680,16 @@ static void populate_value(struct refinfo *ref)
 				v->s =3D xstrdup(buf + 1);
 			}
 			continue;
-		}
-		else
+		} else if (!strcmp(name, "HEAD")) {
+			const char *head;
+			unsigned char sha1[20];
+			head =3D resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (!strcmp(ref->refname, head))
+				v->s =3D "*";
+			else
+				v->s =3D " ";
+			continue;
+		} else
 			continue;
=20
 		formatp =3D strchr(name, ':');
--=20
1.8.3.2.736.g869de25
