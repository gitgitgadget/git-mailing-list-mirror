From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/3] for-each-ref: introduce %(HEAD) asterisk marker
Date: Wed, 13 Nov 2013 15:06:44 +0530
Message-ID: <1384335406-16332-2-git-send-email-artagnon@gmail.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 13 10:46:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgX1N-0000bc-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 10:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759123Ab3KMJpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 04:45:52 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39469 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101Ab3KMJpr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 04:45:47 -0500
Received: by mail-pd0-f170.google.com with SMTP id q10so172975pdj.29
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 01:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vc+TqFOsza+nHjbeQkw6XDcofvKr+9rOPFHVW6iQqT0=;
        b=exkdoBhhAIbllbFy2evVwu+3hwxjiHcOkLut+Klq8ROo2SpyPmrFXKiJi6GHKSgk8K
         /dYbKECXJoMAPXkXBmf/4IfM8vsmvhyA0cD/EwwQW5RmpXk0Rrr6o2l25gtqzsyliqkL
         BItN8srVtahuEO9DPfDmiSpTXErPnJYISxZe3xjEwZaBTf+N2QxqzWwEXufpGX70pu0M
         pPKx1PSyQypkmb4C3CXEDoOf2stNDGBuB+m6n/BNMKE3zOXufrKTvBZ18GzlD48LJQ0e
         OmVRrl/9Gi9LzDf9xly0U/L+awc8RyWN1L756arl83IhmCkEjqH4y8BSUD5hUqDSAxf+
         2lCw==
X-Received: by 10.68.225.138 with SMTP id rk10mr446784pbc.203.1384335947005;
        Wed, 13 Nov 2013 01:45:47 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id ed3sm43211477pbc.6.2013.11.13.01.45.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2013 01:45:46 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.3.g914176d.dirty
In-Reply-To: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237783>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend its format with
%(HEAD) for the same effect.

Now you can use the following format in for-each-ref:

  %(HEAD) %(refname:short)

to display an asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f2e08d1..ab3da0e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -93,6 +93,10 @@ upstream::
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
index 1d4083c..5f1842f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -75,6 +75,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
 
 /*
@@ -675,8 +676,16 @@ static void populate_value(struct refinfo *ref)
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
1.8.5.rc0.3.g914176d.dirty
