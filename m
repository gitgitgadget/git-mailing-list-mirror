From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] for-each-ref: introduce %(HEAD) asterisk marker
Date: Fri, 27 Sep 2013 17:40:27 +0530
Message-ID: <1380283828-25420-3-git-send-email-artagnon@gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 14:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPWzB-0006Ti-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 14:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab3I0MR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 08:17:26 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54571 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab3I0MRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 08:17:23 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so2491815pbc.31
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1f1WX8JloRqvJ/XoUgQw47zq4Ywa9sp291cDYpg2Gc=;
        b=sYp0y5Oo3rKNaIowVmTVtbUsMKokQVJko8OvvDoK+IionfGp6pzDtxCvTA9FEH+wxn
         0epsN+1YsXsJRTRaAwL+YSAAM2Fidf8w1k8ymWNo0QS/Zx+FQxu+sq9wtQZ4sZh2eyKa
         wE6aGaptP1PVAJwOQrcTKFAQeygav7U1FK6b+WM9PRRxWE67puFbHta/tp70Jnol5deZ
         JdO9PegCiInWmWmNLtylmd3dhH0GOQqpEvoR6CaV22DuulsUCkx5SuEKf+B4mJ1nc8yt
         U9QY7Ei/t703YE007QcmIgdRApbU9dFTvWUkFHTyrasWditwFEfIe2Foz6byjCfzIfRo
         y/Jg==
X-Received: by 10.68.216.35 with SMTP id on3mr7128071pbc.86.1380284243122;
        Fri, 27 Sep 2013 05:17:23 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id xe9sm12229901pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 05:17:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.478.g55109e3
In-Reply-To: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235455>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend its format with
%(HEAD) for the same effect.

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %(refname:short)

to display a red asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 078a116..f1d4e9e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,6 +95,10 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
 
+HEAD::
+	Used to indicate the currently checked out branch.  Is '*' if
+	HEAD points to the current ref, and ' ' otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index a1ca186..e54b5d8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
 
 /*
@@ -682,8 +683,16 @@ static void populate_value(struct refinfo *ref)
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
1.8.4.478.g55109e3
