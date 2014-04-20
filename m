From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try3] branch: reorganize verbose options
Date: Sun, 20 Apr 2014 15:58:34 -0500
Message-ID: <1398027514-19399-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 23:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbyyy-0003Tp-3S
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaDTVI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:08:56 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:37663 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaDTVIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:08:55 -0400
Received: by mail-yh0-f42.google.com with SMTP id v1so1150637yhn.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jAo5KxT4JWXVSCbpEFyKUYF4B3M3aoRzSbyf5ii10xU=;
        b=Q4JQOXttrjt3eItTwdWckaBIBykHY6oNuk/5buuWrvJP630pB7hQnWQN3+5lMZF7gl
         osQOhL6s+sgi+pQYToGcOgifzj+PKNn6cNSh67iaWcqrGlGYDzzPYHGnNJTj8oyVth9F
         J19l3naj8gdokWtkv9uYHtK8Nz2uTqy8vxyZbNPUxqPC0nPcNZFHtU7yZa8knF4V5/QK
         0KxcIMGpPGa19n1IuhMBi1Wm7fioIRwjq2boN5hW5I8+S0CWSJKcYD2EXMYia0hhlYRE
         eiVrDJXWa07HnTW5ZvmGRSyWs7GTC1RX9hJvj0un1RdbVqmVhswjx/rT/qRPWNl0PCfJ
         ItJA==
X-Received: by 10.236.177.100 with SMTP id c64mr48239935yhm.30.1398028134550;
        Sun, 20 Apr 2014 14:08:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c66sm65856104yhk.23.2014.04.20.14.08.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 14:08:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246583>

`git branch -v` before:

  fc/branch/nice-verbose 4761939 [master] branch: reorganize verbose options

`git branch -v` after:

  fc/branch/nice-verbose 4761939 [ahead 1] branch: reorganize verbose options

Showing the upstream tracking branch is more important than how many commits
are ahead/behind, after all you need to know ahead/behind compared to _what_.
So now `git branch -v` shows the upstream, but not the tracking info, and
`git branch -vv` shows all information (unchanged).

An additional benefit is that `git branch -v` is now much faster:

Before:

 git branch -v  0.01s user 0.01s system 90% cpu 0.014 total

After:

 git branch -v  1.67s user 0.03s system 99% cpu 1.698 total

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c         | 76 +++++++++++++++++++++---------------------------
 t/t6040-tracking-info.sh | 12 ++++----
 2 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..8013540 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -417,29 +417,35 @@ static int ref_cmp(const void *r1, const void *r2)
 }
 
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
-		int show_upstream_ref)
+		int show_tracking)
 {
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 	int upstream_is_gone = 0;
-	int added_decoration = 1;
 
-	switch (stat_tracking_info(branch, &ours, &theirs)) {
-	case 0:
-		/* no base */
+	if (!branch)
 		return;
-	case -1:
-		/* with "gone" base */
-		upstream_is_gone = 1;
-		break;
-	default:
-		/* with base */
-		break;
+
+	if (show_tracking) {
+		switch (stat_tracking_info(branch, &ours, &theirs)) {
+		case 0:
+			/* no base */
+			return;
+		case -1:
+			/* with "gone" base */
+			upstream_is_gone = 1;
+			break;
+		default:
+			/* with base */
+			break;
+		}
+	} else {
+		ours = theirs = 0;
 	}
 
-	if (show_upstream_ref) {
+	if (branch->merge && branch->merge[0] && branch->merge[0]->dst) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 		if (want_color(branch_use_color))
 			strbuf_addf(&fancy, "%s%s%s",
@@ -448,39 +454,23 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		else
 			strbuf_addstr(&fancy, ref);
 	}
+	if (!fancy.len)
+		return;
 
-	if (upstream_is_gone) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
-		else
-			added_decoration = 0;
-	} else if (!ours && !theirs) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s]"), fancy.buf);
-		else
-			added_decoration = 0;
-	} else if (!ours) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
-		else
-			strbuf_addf(stat, _("[behind %d]"), theirs);
+	if (upstream_is_gone)
+		strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
+	else if (!ours && !theirs)
+		strbuf_addf(stat, _("[%s]"), fancy.buf);
+	else if (!ours)
+		strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
+	else if (!theirs)
+		strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
+	else
+		strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
+			    fancy.buf, ours, theirs);
 
-	} else if (!theirs) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
-		else
-			strbuf_addf(stat, _("[ahead %d]"), ours);
-	} else {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
-				    fancy.buf, ours, theirs);
-		else
-			strbuf_addf(stat, _("[ahead %d, behind %d]"),
-				    ours, theirs);
-	}
 	strbuf_release(&fancy);
-	if (added_decoration)
-		strbuf_addch(stat, ' ');
+	strbuf_addch(stat, ' ');
 	free(ref);
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 7ac8fd0..af26db5 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -41,12 +41,12 @@ test_expect_success setup '
 
 script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
 cat >expect <<\EOF
-b1 [ahead 1, behind 1] d
-b2 [ahead 1, behind 1] d
-b3 [behind 1] b
-b4 [ahead 2] f
-b5 g
-b6 c
+b1 [origin/master] d
+b2 [origin/master] d
+b3 [origin/master] b
+b4 [origin/master] f
+b5 [brokenbase] g
+b6 [origin/master] c
 EOF
 
 test_expect_success 'branch -v' '
-- 
1.9.1+fc3.9.gc73078e
