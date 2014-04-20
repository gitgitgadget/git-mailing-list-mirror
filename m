From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 5/8] branch: display publish branch
Date: Sun, 20 Apr 2014 14:45:03 -0500
Message-ID: <1398023106-25958-6-git-send-email-felipe.contreras@gmail.com>
References: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbxqe-0006hB-5x
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbaDTT4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:56:04 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:42014 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbaDTTzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:42 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so2930099yha.5
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iylt3ZM7uJ1YK32TOmNZjfYmqu1bD+fRswSgfPKKyDs=;
        b=NIcmOQFpW1/r6ak0G9qyAGnR9vk9V6ATpPQpksCG/Im5m4bHajSirRlI7RTmDtC+ZG
         VIMVRzUc1rkiOWvlMNuc5PX+d5HYleL2CDxyrxNYX8VO5WXNTkpiLKzjA36Lw9Sz+89c
         tVKSY+od5EfXp/E1sHzbd9yF3pFdL7zS2uRncAXjnFABJmgWjtbFRH5ULm0loeJPK6w5
         kJn3q7Y+9UpoBNpsRALfNCaFoSDzVZ15wQBkuZgUPw+bP470s2HtojtMJidbZyFusula
         affWYl08X44p1BhanEwLnphZ37xoKX7juVwqrefl7GF+96ixqBpnOL8Vlb6gDl7GDs9I
         9QZg==
X-Received: by 10.236.102.70 with SMTP id c46mr47479224yhg.40.1398023741742;
        Sun, 20 Apr 2014 12:55:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t24sm65567513yhb.39.2014.04.20.12.55.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246572>

It does it along the upstream branch, if any.

* publish ... [master, gh/publish: ahead 1] ...
  master  ... [master, gh/master] ...

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c         | 17 ++++++++++++++++-
 t/t6040-tracking-info.sh |  5 +++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 17773d7..e0a8d0a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -42,6 +42,7 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* LOCAL */
 	GIT_COLOR_GREEN,	/* CURRENT */
 	GIT_COLOR_BLUE,		/* UPSTREAM */
+	GIT_COLOR_YELLOW,	/* PUBLISH */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
@@ -49,7 +50,8 @@ enum color_branch {
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
 	BRANCH_COLOR_CURRENT = 4,
-	BRANCH_COLOR_UPSTREAM = 5
+	BRANCH_COLOR_UPSTREAM = 5,
+	BRANCH_COLOR_PUBLISH = 6
 };
 
 static enum merge_filter {
@@ -76,6 +78,8 @@ static int parse_branch_color_slot(const char *var, int ofs)
 		return BRANCH_COLOR_CURRENT;
 	if (!strcasecmp(var+ofs, "upstream"))
 		return BRANCH_COLOR_UPSTREAM;
+	if (!strcasecmp(var+ofs, "publish"))
+		return BRANCH_COLOR_PUBLISH;
 	return -1;
 }
 
@@ -448,6 +452,17 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		else
 			strbuf_addstr(&fancy, ref);
 	}
+	if (branch->push.dst) {
+		ref = shorten_unambiguous_ref(branch->push.dst, 0);
+		if (fancy.len)
+			strbuf_addstr(&fancy, ", ");
+		if (want_color(branch_use_color))
+			strbuf_addf(&fancy, "%s%s%s",
+					branch_get_color(BRANCH_COLOR_PUBLISH),
+					ref, branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strbuf_addstr(&fancy, ref);
+	}
 
 	if (upstream_is_gone) {
 		if (show_upstream_ref)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 7ac8fd0..8b9ef63 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -33,7 +33,8 @@ test_expect_success setup '
 		git checkout -b b5 --track brokenbase &&
 		advance g &&
 		git branch -d brokenbase &&
-		git checkout -b b6 origin
+		git checkout -b b6 origin &&
+		git branch --set-publish origin/master b6
 	) &&
 	git checkout -b follower --track master &&
 	advance h
@@ -64,7 +65,7 @@ b2 [origin/master: ahead 1, behind 1] d
 b3 [origin/master: behind 1] b
 b4 [origin/master: ahead 2] f
 b5 [brokenbase: gone] g
-b6 [origin/master] c
+b6 [origin/master, origin/master] c
 EOF
 
 test_expect_success 'branch -vv' '
-- 
1.9.1+fc3.9.gc73078e
