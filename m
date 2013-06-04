From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/15] for-each-ref: introduce %(upstream:track[short])
Date: Tue,  4 Jun 2013 18:05:34 +0530
Message-ID: <1370349337-20938-13-git-send-email-artagnon@gmail.com>
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
	id 1UjqRh-00078F-SI
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab3FDMe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:28 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42093 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3FDMeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:25 -0400
Received: by mail-pd0-f178.google.com with SMTP id w16so171657pde.23
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bgegC0R6fmLlvNJ1AL/BLTIzeeJpwgSBAgPUhP8bRAc=;
        b=sTnYwgOVAIOF2Cn4jE97bTdz8LfQIxaAseNCqecKn0jCCPRu1mWn/jG7pkxpXYpaWE
         tUV0R2B84eDXlmR5vF4Uei6ACqeUwjjp4bO5Tk/xHOd2VpxXBegGUJFAtL8jaqmiRNOF
         Qm0Q1X4R8ZMShC1x2E34UBAjnzDHGnEAjswl8D4ZLFXoZyfcslK62+VnmawOJ9LuVq0n
         pPZs/x8qFl5sJ7iZhabFvdUVxqc/TJNwjgfdh4vLrpjazPpmfM7FUbQ8jKcZWBbmcxdn
         NpXECWUiaBAYS4a/EY5RQ/A7iJRGFR1D2b943Mm8HCMGYAkpUcB+UzVaCFzhlfA072c0
         IX2w==
X-Received: by 10.66.123.72 with SMTP id ly8mr28458860pab.159.1370349264625;
        Tue, 04 Jun 2013 05:34:24 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226355>

Introduce %(upstream:track) to display "[ahead M, behind N]" and
%(upstream:trackshort) to display "=", ">", "<", or "<>"
appropriately (inspired by the contrib/completion/git-prompt.sh).

Now you can use the following format in for-each-ref:

  %C(green)%(refname:short)%C(reset)%(upstream:trackshort)

to display refs with terse tracking information.

Note that :track and :trackshort only works with upstream, and errors
out when used with anything else.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  6 +++++-
 builtin/for-each-ref.c             | 42 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d529296..05ff7ba 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -118,7 +118,11 @@ objectname::
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
 	Useful to indicate the currently checked out branch.  Is '*'
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b0b8236..adc965e 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -628,6 +628,7 @@ static void populate_value(struct refinfo *ref)
 	int eaten, i;
 	unsigned long size;
 	const unsigned char *tagged;
+	int upstream_present = 0;
 
 	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
 
@@ -645,6 +646,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		struct branch *branch;
 
 		if (*name == '*') {
 			deref = 1;
@@ -656,7 +658,6 @@ static void populate_value(struct refinfo *ref)
 		else if (!prefixcmp(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
-			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
 				continue;
@@ -666,6 +667,7 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
+			upstream_present = 1;
 		}
 		else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -683,6 +685,7 @@ static void populate_value(struct refinfo *ref)
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
 			unsigned char sha1[20];
+
 			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
@@ -695,11 +698,46 @@ static void populate_value(struct refinfo *ref)
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
+				if (!upstream_present)
+					continue;
+				if (!stat_tracking_info(branch, &num_ours, &num_theirs))
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
+				if (!upstream_present)
+					continue;
+				if (!stat_tracking_info(branch, &num_ours, &num_theirs))
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
1.8.3.GIT
