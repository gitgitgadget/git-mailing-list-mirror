From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/3] for-each-ref: introduce %(HEAD) asterisk marker
Date: Sat, 28 Sep 2013 08:29:20 +0530
Message-ID: <1380337161-803-3-git-send-email-artagnon@gmail.com>
References: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 28 05:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPkrT-0006fe-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 05:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab3I1DGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 23:06:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64971 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab3I1DGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 23:06:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so3534057pab.18
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 20:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jyyyXfwn72l1jj0YecuERBSBcItf2t1NWfjncDZ4/4E=;
        b=Gm27mHd0oi0YB24ke65yXr3CE/MYjPDKIgYQHzYTVkIl9HQN3il5j8KxuQ+sXZVv9S
         WdE8ipbFp1nLm0JfIebL03sCJzmhBnLKwxsxmU8kRrEpKyY9RJQyqJj58a7ksBUQrfn4
         Wq/Q4WQYMZbFGwGl/Ye5Bx949xuSggNheRo2Hgx1zTK4BgvYogMVbfgcx/x4bvR76N2f
         FiZ9n2lSgF/oulAYxFl52dq5UD7oqD75YrqImfr+oQdW2YFyPytQOjKCfXFMjAIEpof4
         srb3oB3YCAxp8CqYYl16bdiVg891FCN8dvg0TEo0PEk2hzwL6oKsSkPLPL6Q2QB+6xK9
         EKmA==
X-Received: by 10.68.88.161 with SMTP id bh1mr10909543pbb.49.1380337580426;
        Fri, 27 Sep 2013 20:06:20 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id hx1sm11880794pbb.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 20:06:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.477.g4cae6f5
In-Reply-To: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235484>

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
index 6fa4464..bb9c4c1 100644
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
index 6da2903..b841545 100644
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
1.8.4.477.g4cae6f5
