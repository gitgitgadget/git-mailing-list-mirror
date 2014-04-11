From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/8] branch: display publish branch
Date: Fri, 11 Apr 2014 12:59:08 -0500
Message-ID: <1397239151-2391-6-git-send-email-felipe.contreras@gmail.com>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYfta-0007BA-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbaDKSJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:09:32 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43712 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbaDKSJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:09:26 -0400
Received: by mail-ob0-f178.google.com with SMTP id wp18so6414063obc.37
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=csD/nWUFH44Lt2sm86WT2IC+VUTNUuP49iZ07bMkJVA=;
        b=EX1gAojmwSPc4kiFEjYR1Ft/uDvQIZan6Dl1nVXo87hSgnDWFgg6sUtrWP6//dRQ2M
         IkC+i7Z6GAVtE4wiKZkT1G2A2Q9aEBRc69XefGUdZlwGH/LJsALrvfHYKvsxVno4ATui
         NJCRD93ehiacw4J23wP5ZYML8yA8FiA4TxdIlyne1Wp1lkJntj7IFWesdmlsDjgB86GY
         exjPCis4m7ZsSP0MaBxJzZLG8lR5kJBHQ/Ulk0LA6Qqh/MbpCxU6xZ5M63G9ezhyRgMj
         Eyv0HUiZCcziQXigex7gh29g6NmSCuNygmDUvjPntKddUa8zRnqDEHnhg8X4G74z/464
         0Mgw==
X-Received: by 10.182.85.193 with SMTP id j1mr8752204obz.52.1397239765867;
        Fri, 11 Apr 2014 11:09:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm34242361oen.3.2014.04.11.11.09.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 11:09:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246120>

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
1.9.1+fc1
