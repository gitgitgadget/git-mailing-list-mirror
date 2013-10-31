From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Thu, 31 Oct 2013 15:16:14 +0530
Message-ID: <1383212774-5232-4-git-send-email-artagnon@gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 10:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboxd-0007tT-W1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab3JaJyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:54:32 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56713 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab3JaJya (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:54:30 -0400
Received: by mail-pa0-f42.google.com with SMTP id kp14so2281809pab.15
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sudEYaSkTn9Qo+/JRR4FijKgYv8/ivjG4g9F0IVRKNw=;
        b=aEIIJBh5DlCsWKeSIvbKEwTY1bD/1WmUemMUD/0Ke/5WSmh9dav3vz3WCHJlBtny1h
         rtTSQ/OL6DfFaCa8OkQvbVw67FIUN6qYUQaiQZ0eLFw4Sscmhn46ypF9PiYh873NkBNP
         xK2iDv6KVOJy6LYf3XtCN4pjG+2kcmcqCgvestSfBYf30xP4zEuSB2o1vDSNQoGUNbiu
         4zozmDJPvl5+qcJ4B4pkPuJgUrs1Ha5nQZ1eajVZ0it1d4ZZtYF5QMMU+narwMG84+eG
         uqJLHlb/TnhpuulEN6/bD84d/TM33JrO3fKMGt+8NvxiQSP1Jivs6nN1Dkhejqf0Os41
         vvqA==
X-Received: by 10.66.146.199 with SMTP id te7mr974119pab.106.1383213270529;
        Thu, 31 Oct 2013 02:54:30 -0700 (PDT)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id i10sm4106533pat.11.2013.10.31.02.54.28
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:54:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.rc0.3.gb488857
In-Reply-To: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237115>

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
1.8.5.rc0.3.gb488857
