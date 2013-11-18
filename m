From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 4/6] for-each-ref: introduce %(upstream:track[short])
Date: Mon, 18 Nov 2013 23:09:11 +0530
Message-ID: <1384796353-18701-5-git-send-email-artagnon@gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSwO-0004Az-7u
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab3KRRso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:44 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33721 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab3KRRsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:41 -0500
Received: by mail-pd0-f173.google.com with SMTP id x10so6830900pdj.18
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=drhRQbYJu2/4Gojy2XQyk5X0k6IsZCc/8HsmdQlixmc=;
        b=BnW8wpPoA0X6BQb4c9U87/u1IPwC4bxBT4tJP/kioyAb3LejmxnM/7VO66Q27Rz5rR
         fgEdIoV1oXt9eVFmdh1okb/nGJAD0EEq8JL7lShfu+nxvzd/Hilj9ht+2kMt6XZHn+uN
         icjVOUrY6ciF2L1hC4EJNCrUM5SsZV3vVMbnWLBvdbi535RIiPEUiOkqC0MIOyfG+crN
         Cpa6LW4+LSeIQqv10uM1zTVzg4SrgNYqyiPqEtcWF8Yt/kGPYvfXIN63iDUE2T4G48d2
         LWHf7UVoQHJuKFoebTrUo9vci/W1mzV71HqzidVt/x6JmYZyoFrBrN8Z68lrpyASb1MC
         3L4w==
X-Received: by 10.68.28.231 with SMTP id e7mr2249156pbh.180.1384796920678;
        Mon, 18 Nov 2013 09:48:40 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
In-Reply-To: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237999>

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
 t/t6300-for-each-ref.sh            | 27 +++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 8f87c9a..92e82fd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -91,7 +91,11 @@ objectname::
 upstream::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short` in the same way as
-	`refname` above.
+	`refname` above.  Additionally respects `:track` to show
+	"[ahead N, behind M]" and `:trackshort` to show the terse
+	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
+	or "=" (in sync).  Has no effect if the ref does not have
+	tracking information associated with it.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
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
index 1d998f8..d88d7ac 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -303,6 +303,33 @@ test_expect_success 'Check short upstream format' '
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
+test_expect_success 'Check that :track[short] cannot be used with other atoms' '
+	test_must_fail git for-each-ref --format="%(refname:track)" 2>/dev/null &&
+	test_must_fail git for-each-ref --format="%(refname:trackshort)" 2>/dev/null
+'
+
 cat >expected <<EOF
 $(git rev-parse --short HEAD)
 EOF
-- 
1.8.5.rc0.5.g70ebc73.dirty
