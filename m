From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/9] branch: display publish branch
Date: Thu, 10 Apr 2014 14:04:43 -0500
Message-ID: <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRe-0006Ua-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbaDJTPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:24 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:55258 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161185AbaDJTPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:20 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so5041562oah.1
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nffd1kBIz6Jk/c5scKXi8PMq5vqJFcBpBLYI11Y6Y4I=;
        b=iVU4hJvFO9lLYImBIuajQUfbka5yXy73N7aB42wJc7Wufa3Ejo0b8SdE1TxFjIlunJ
         WsEPuXSvH6fUistkakyO7wsM3EA7ngAGfggYX3HHoMJ0v7JpuL/ZXwlqyDlYG3aBQijQ
         Iy3OpH5DKYPaAdoyfSiLPk0eCQV1yoXFswCiM4BpJywR0fWI7uRWc4KdXfwhYKUsNTwl
         KFCqfx1DG3IbC/iTAJ88AEXas8ftbOS6nxPTg1Btq59MQCsald/ZPFOktydKSTi6lNKU
         61sxONtnysqsG/wcjf3wu6dr96tavI/jOcjAv+8DR3l7R02v7C4alnmVXjFI2rwPkSMw
         AaMQ==
X-Received: by 10.60.16.103 with SMTP id f7mr15477389oed.8.1397157320044;
        Thu, 10 Apr 2014 12:15:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm8369004obb.11.2014.04.10.12.15.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246044>

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
