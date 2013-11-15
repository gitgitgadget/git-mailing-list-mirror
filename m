From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 4/6] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 15 Nov 2013 16:29:06 +0530
Message-ID: <1384513148-22633-5-git-send-email-artagnon@gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHG9-0007JT-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758334Ab3KOLIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:19 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39711 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758290Ab3KOLIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:11 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so1250609pde.35
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiciYDyxGnCyBHNFQAjUa8Yotj71WrnmqbznYZr3ulo=;
        b=Y+DSwJlfWeXtEXofKV0ujeuvegPEaotEC/T9+jYZmVOIKV7kb9MsqTy9TMTUarCiAW
         eG0E4T9LSOAZuA1XNncs8yFGL4H2yksShV2bfU5BTbdC6MAx1ePcTMmw+d8nY9MuUium
         7pzhMAqgVO4Mh0um/1wmmXp6IQGeX/jRmTriSRxK7obMJSJzGcWDtMJEXMDLSacZSKPx
         qbIvyJBhYEZ4XCsokUrymcEUrRR7TKfGobN5ihYuiNpgrUh24C5zBnY36/yQKk2AhRRw
         OYU6CaqjEwDMIvcaD1Gy/828aU74ajL+vP8Qn8q8ZZ1SbLCnzCGpT4r8ltfoR6lj2ncD
         1WDw==
X-Received: by 10.66.154.1 with SMTP id vk1mr6298083pab.85.1384513690718;
        Fri, 15 Nov 2013 03:08:10 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:09 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
In-Reply-To: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237902>

Introduce %(upstream:track) to display "[ahead M, behind N]" and
%(upstream:trackshort) to display "=", ">", "<", or "<>"
appropriately (inspired by contrib/completion/git-prompt.sh).

Now you can use the following format in for-each-ref:

  %(refname:short)%(upstream:trackshort)

to display refs with terse tracking information.

Note that :track and :trackshort only work with "upstream", and error
out when used with anything else.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  6 +++++-
 builtin/for-each-ref.c             | 40 +++++++++++++++++++++++++++++++++++---
 t/t6300-for-each-ref.sh            | 22 +++++++++++++++++++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index ab3da0e..c9b192e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -91,7 +91,11 @@ objectname::
 upstream::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short` in the same way as
-	`refname` above.
+	`refname` above.  Additionally respects `:track` to show
+	"[ahead N, behind M]" and `:trackshort` to show the terse
+	version (like the prompt) ">", "<", "<>", or "=".  Has no
+	effect if the ref does not have tracking information
+	associated with it.
 
 HEAD::
 	Used to indicate the currently checked out branch.  Is '*' if
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5f1842f..ed81407 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -641,6 +641,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		struct branch *branch;
 
 		if (*name == '*') {
 			deref = 1;
@@ -652,7 +653,6 @@ static void populate_value(struct refinfo *ref)
 		else if (!prefixcmp(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
-			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
 				continue;
@@ -679,6 +679,7 @@ static void populate_value(struct refinfo *ref)
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
 			unsigned char sha1[20];
+
 			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
@@ -689,13 +690,46 @@ static void populate_value(struct refinfo *ref)
 			continue;
 
 		formatp = strchr(name, ':');
-		/* look for "short" refname format */
 		if (formatp) {
+			int num_ours, num_theirs;
+
 			formatp++;
 			if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
-			else
+			else if (!strcmp(formatp, "track") &&
+				!prefixcmp(name, "upstream")) {
+				char buf[40];
+
+				stat_tracking_info(branch, &num_ours, &num_theirs);
+				if (!num_ours && !num_theirs)
+					v->s = "";
+				else if (!num_ours) {
+					sprintf(buf, "[behind %d]", num_theirs);
+					v->s = xstrdup(buf);
+				} else if (!num_theirs) {
+					sprintf(buf, "[ahead %d]", num_ours);
+					v->s = xstrdup(buf);
+				} else {
+					sprintf(buf, "[ahead %d, behind %d]",
+						num_ours, num_theirs);
+					v->s = xstrdup(buf);
+				}
+				continue;
+			} else if (!strcmp(formatp, "trackshort") &&
+				!prefixcmp(name, "upstream")) {
+
+				stat_tracking_info(branch, &num_ours, &num_theirs);
+				if (!num_ours && !num_theirs)
+					v->s = "=";
+				else if (!num_ours)
+					v->s = "<";
+				else if (!num_theirs)
+					v->s = ">";
+				else
+					v->s = "<>";
+				continue;
+			} else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
 		}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5e29ffc..9d874fd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -303,6 +303,28 @@ test_expect_success 'Check short upstream format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup for upstream:track[short]' '
+	test_commit two
+'
+
+cat >expected <<EOF
+[ahead 1]
+EOF
+
+test_expect_success 'Check upstream:track format' '
+	git for-each-ref --format="%(upstream:track)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+>
+EOF
+
+test_expect_success 'Check upstream:trackshort format' '
+	git for-each-ref --format="%(upstream:trackshort)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 $(git rev-parse --short HEAD)
 EOF
-- 
1.8.5.rc0.6.gfd75b41
