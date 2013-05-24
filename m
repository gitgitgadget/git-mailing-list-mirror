From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 24 May 2013 19:49:37 +0530
Message-ID: <1369405177-7855-4-git-send-email-artagnon@gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 16:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfspA-0006Rk-8D
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 16:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab3EXOSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 10:18:13 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:52997 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab3EXOSC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 10:18:02 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4263601pbb.38
        for <git@vger.kernel.org>; Fri, 24 May 2013 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cXWLaWHM6PYWrorfrguWJbBUZhx3pV2gU2Zp1pSgIJk=;
        b=R3LW47cOaC/UWKnOb6TYFfcTMSMiOJWD53cMavc+rNxVlwGc/kO9nu2iJShwzXpDP/
         SlDZ1U7rJSK2WuzF1znoQiII+P2HDkIeV64qI4c1fYbQmLYgQ64gJsNMgXiv76if353i
         8AOYqQ8xjBTEYj8lDvVyrcEt7JXeae8RHAN17cgQhVYlbZymzwkmwPGkkYwkn4HppjBl
         SxASvWPzK2cQLPUS4cixZF3EhYK2VOcIH3k6iqc9zTWnHh89N9Emkil+bIIov87K4Yml
         K+M5/ClNMUtnnMKK4L/wm1yhwauxD7s4V2dl95b+8xgllSAXBZGsbZ5bVTvgcSjzGUkU
         QcYw==
X-Received: by 10.68.99.163 with SMTP id er3mr18302440pbb.36.1369405081191;
        Fri, 24 May 2013 07:18:01 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id qp4sm16338288pbc.41.2013.05.24.07.17.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 07:18:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.2.g99b8f3f.dirty
In-Reply-To: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225355>

Introduce %(upstream:track) to display "[ahead M, behind N]" and
%(upstream:trackshort) to display "=", ">", "<", or "<>"
appropriately (inspired by the contrib/completion/git-prompt.sh).

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)%(upstream:trackshort)

to display refs with terse tracking information.

Note that :track and :trackshort only works with upstream, and errors
out when used with anything else.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 63d3a85..838b125 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -632,6 +632,7 @@ static void populate_value(struct refinfo *ref)
 	int eaten, i;
 	unsigned long size;
 	const unsigned char *tagged;
+	int upstream_present = 0;
 
 	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
 
@@ -649,6 +650,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		struct branch *branch;
 
 		if (*name == '*') {
 			deref = 1;
@@ -660,7 +662,6 @@ static void populate_value(struct refinfo *ref)
 		else if (!prefixcmp(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
-			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
 				continue;
@@ -670,6 +671,7 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
+			upstream_present = 1;
 		}
 		else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -687,6 +689,7 @@ static void populate_value(struct refinfo *ref)
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
 			unsigned char sha1[20];
+
 			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
@@ -699,11 +702,46 @@ static void populate_value(struct refinfo *ref)
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
1.8.3.rc3.2.g99b8f3f.dirty
