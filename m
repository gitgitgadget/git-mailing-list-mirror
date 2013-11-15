From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 3/6] for-each-ref: introduce %(HEAD) asterisk marker
Date: Fri, 15 Nov 2013 16:29:05 +0530
Message-ID: <1384513148-22633-4-git-send-email-artagnon@gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHG9-0007JT-6u
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758333Ab3KOLIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:16 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54602 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758147Ab3KOLIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:09 -0500
Received: by mail-pd0-f178.google.com with SMTP id p10so3344335pdj.37
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WjudfPMclAUlgh7hzBr7fzhY7iYRx9aTnhItyAZJnCw=;
        b=CNYsJBHbJV5IA69bHWNRgrlScj/UCGm4ZP0a0w9p81LGOaeqr9ghsPjxDSDUaTq0ca
         Ga/83WzsxqQxxj3IHFOQaN1cwvzYmOUF1q0jKunmzGZSk7WfRbP0ZLQ/Nbtsp/2rvepz
         XPd5pX5qEt/mWaMp7Eo8fIXTxWHDtQ+I705c1KGSBkJhWdQPHhiWy1y5+lV+W4KKrmdj
         dbyKOClkv+JuEURx2AiEJngScyESMFwobc/nwcTHcAfts0gulqM9zO8qeEr8uZCMlLnA
         FVcNPPGxod7JxBkLhUXS0/9Vz9N86AaSFj00LunukQRoXsWkxTZAYP/HSaJKrFFRLI7y
         ftjA==
X-Received: by 10.66.146.170 with SMTP id td10mr6073645pab.161.1384513687795;
        Fri, 15 Nov 2013 03:08:07 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:07 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
In-Reply-To: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237903>

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
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

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
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e1f71ff..5e29ffc 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -77,6 +77,7 @@ test_atom head contents:body ''
 test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
+test_atom head HEAD '*'
 
 test_atom tag refname refs/tags/testtag
 test_atom tag upstream ''
@@ -110,6 +111,7 @@ test_atom tag contents:body ''
 test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151939927
 '
+test_atom tag HEAD ' '
 
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
-- 
1.8.5.rc0.6.gfd75b41
