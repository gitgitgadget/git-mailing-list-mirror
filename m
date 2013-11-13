From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/3] for-each-ref: introduce %(upstream:track[short])
Date: Wed, 13 Nov 2013 15:06:45 +0530
Message-ID: <1384335406-16332-3-git-send-email-artagnon@gmail.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 13 10:46:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgX1O-0000bc-GA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 10:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177Ab3KMJpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 04:45:55 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44021 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759102Ab3KMJpu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 04:45:50 -0500
Received: by mail-pd0-f173.google.com with SMTP id x10so177436pdj.4
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 01:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxQ3ArLBklXnkP63YQHMmeCTloSq/slR7knrrjQC9vo=;
        b=UevQ0GtUzNe+i/XurmFeROBis14jJgsbNKaUKac89eSV3MmrRcA4IKqk8yv6NyoH52
         vRmiSuCISVz0gd1BQ2qedn75edC3A2JCtMqWHKKV1gOKVpzBfsekyOTm/XjBkevJN1Ko
         Y+VlccdV/SG/eS+QXTIGMzuwwtb7FpfD1omEtdVGn5ZjF/LiNaqMOVbJo3Fdv0+IgSax
         YJQfK/8fz6fLsuXYslsZ31aR8lYcunpHWg5I5KzuhyUfU2ZYIoKoKtNQj9IKKhCFASM/
         Ay8i1SE0zva/hO0OKtYXYXp0zBKDMy38FWj9CCqs0iagteNeFDPudinVomOy/50GkdzA
         XSFQ==
X-Received: by 10.68.91.3 with SMTP id ca3mr40673329pbb.20.1384335949401;
        Wed, 13 Nov 2013 01:45:49 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id ed3sm43211477pbc.6.2013.11.13.01.45.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2013 01:45:48 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.3.g914176d.dirty
In-Reply-To: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237784>

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
 2 files changed, 42 insertions(+), 4 deletions(-)

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
-- 
1.8.5.rc0.3.g914176d.dirty
