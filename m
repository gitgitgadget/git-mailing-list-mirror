From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/15] for-each-ref: introduce %(HEAD) marker
Date: Tue,  4 Jun 2013 18:05:33 +0530
Message-ID: <1370349337-20938-12-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRh-00078F-BW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab3FDMeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:23 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:48536 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3FDMeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:22 -0400
Received: by mail-pd0-f178.google.com with SMTP id w16so171601pde.23
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gN5FIx9Ih4AsYkxEc427KFUx1xQ/7Rt21zxYmNz77n8=;
        b=YDg7wby7D0AU4pNG5l8DFpRA6szklBZf16QKMBNHoVJ3HgJCL1/++a0Wnl/5GJbx8l
         MSX7RbbHx0Gh9YBvRyPrA6qJYnqtZ4B5auQtXHCqVw+2PVZQ5xoDjSM6Dwr/IfWrmJK0
         1r561ta43FiBspgcwB//Sl9ZB4edvU7wUWBIol02rs4woCTy4Vvv2MzeiwBzZkV6pNQm
         CwJWfJZQGBW5UwKxgSljOvnct3g/3SVf9pp80GVedBHwHM84hf04+dMozAEcX+RQDado
         pnzYYYbUulxzGe3qKjSxtcxk6BGxo+xVXm6ocQzvVoP3DGsvEoF449I9amu50SujVgZM
         Titw==
X-Received: by 10.66.158.36 with SMTP id wr4mr28621186pab.28.1370349261822;
        Tue, 04 Jun 2013 05:34:21 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226353>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend the format with
%(HEAD) to do exactly the same thing.

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)

to display a red asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7d6db7f..d529296 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -120,6 +120,10 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
 
+HEAD::
+	Useful to indicate the currently checked out branch.  Is '*'
+	if HEAD points to the current ref, and ' ' otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 053a622..b0b8236 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
 
 /*
@@ -679,8 +680,16 @@ static void populate_value(struct refinfo *ref)
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
1.8.3.GIT
