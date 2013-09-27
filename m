From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 17:40:28 +0530
Message-ID: <1380283828-25420-4-git-send-email-artagnon@gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 14:17:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPWzT-0006ng-IN
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 14:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab3I0MRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 08:17:32 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:48527 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab3I0MRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 08:17:25 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2552027pdj.1
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPb3SCL4J1wZISVGaJPL74BowiQzGu0C8Pw/ni8D328=;
        b=ASBgzmds6BfN1DEIN7z80vJJVwLoQyek7M/je9FcDBL+Lne7cmbUpWE7QamRwH4ERf
         8HuHIUOxEkDjyqg3SIA/Vh85gMRkdh8V1y0dqcm7JB8p5/D7fvUNdAi6+I4XcxaZGbIU
         dcUh9H+Aw7Xf7Hj/Zq6DTnx0jIpGvJ/2Vder9pdpS26408SMrQU5lns5KcHOeNGju9hD
         cqGebBVLid610dEwgkFuFMR7MJc7Lpa5XHW49Bzeu5Qj6NUfk0TyRH8UZg/onSLLNxlT
         lSzAaE3dJFzMbb6YI47T/DVw9sGTzN3mTbb+pwm+KHlBi7hSwFGeM1eD6y95+TUMjMJR
         GBBw==
X-Received: by 10.68.33.100 with SMTP id q4mr6724615pbi.119.1380284245200;
        Fri, 27 Sep 2013 05:17:25 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id xe9sm12229901pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 05:17:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.478.g55109e3
In-Reply-To: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235456>

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
 builtin/for-each-ref.c             | 44 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f1d4e9e..682eaa8 100644
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
index e54b5d8..10843bb 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -631,6 +631,7 @@ static void populate_value(struct refinfo *ref)
 	int eaten, i;
 	unsigned long size;
 	const unsigned char *tagged;
+	int upstream_present = 0;
 
 	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
 
@@ -648,6 +649,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		struct branch *branch;
 
 		if (*name == '*') {
 			deref = 1;
@@ -659,7 +661,6 @@ static void populate_value(struct refinfo *ref)
 		else if (!prefixcmp(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (!prefixcmp(name, "upstream")) {
-			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
 				continue;
@@ -669,6 +670,7 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
+			upstream_present = 1;
 		}
 		else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -686,6 +688,7 @@ static void populate_value(struct refinfo *ref)
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
 			unsigned char sha1[20];
+
 			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
@@ -698,11 +701,48 @@ static void populate_value(struct refinfo *ref)
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
+				if (!upstream_present)
+					continue;
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
1.8.4.478.g55109e3
