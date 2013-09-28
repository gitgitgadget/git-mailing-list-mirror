From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Sat, 28 Sep 2013 08:29:21 +0530
Message-ID: <1380337161-803-4-git-send-email-artagnon@gmail.com>
References: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 28 05:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPkrw-00077y-LI
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 05:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab3I1DGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 23:06:42 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:61865 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3I1DGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 23:06:23 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so3346053pdi.19
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 20:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4bBd58UBraw3dxzaAcDhrbFcFhnXTpR2b54FNRFXDDY=;
        b=c4o/gLow/D+VDnxNe2zXzgimUSwKOs+al+YgoOk7uDlo9pNyIeupZFh1tgAST2kfn6
         Gw9djoTHXPz3prJzcAezAK/wSF1K2UAb8LUYVeySVsiN9WmL3X73kkHpeZP8Qq+qjo+M
         v0zBAa31HofDrkgdaKxtuzQrzu3zNut7CIts80SC/jEcmn4QahkEieq46ZmjQ35e57PT
         bICKz3yLdKV5tjEFx1n3yJeIJWzQ9DJTPO2mSu6T/7PQ58Bxk4MlpgEugBgC2hCKzpuH
         YYDD4M8TTxCsO4Fw05EP7H0HKuBDQC90DJ6x2PmD8euMOB5dSRILP4HQrDGNg9ReIvkL
         YPmg==
X-Received: by 10.68.197.3 with SMTP id iq3mr10641557pbc.113.1380337582769;
        Fri, 27 Sep 2013 20:06:22 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id hx1sm11880794pbb.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 20:06:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.477.g4cae6f5
In-Reply-To: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235486>

Introduce %(upstream:track) to display "[ahead M, behind N]" and
%(upstream:trackshort) to display "=", ">", "<", or "<>"
appropriately (inspired by contrib/completion/git-prompt.sh).

Now you can use the following format in for-each-ref:

  %C(green)%(refname:short)%C(reset)%(upstream:trackshort)

to display refs with terse tracking information.

Note that :track and :trackshort only work with "upstream", and error
out when used with anything else.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  6 +++++-
 builtin/for-each-ref.c             | 39 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index bb9c4c1..3ef6aa8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -93,7 +93,11 @@ objectname::
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
index b841545..7d5c174 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -648,6 +648,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		struct branch *branch;
 
 		if (*name == '*') {
 			deref = 1;
@@ -659,7 +660,6 @@ static void populate_value(struct refinfo *ref)
 		else if (!prefixcmp(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
-			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
 				continue;
@@ -686,6 +686,7 @@ static void populate_value(struct refinfo *ref)
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
 			unsigned char sha1[20];
+
 			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
@@ -698,11 +699,45 @@ static void populate_value(struct refinfo *ref)
 		formatp = strchr(name, ':');
 		/* look for "short" refname format */
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
-- 
1.8.4.477.g4cae6f5
