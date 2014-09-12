From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: [PATCH 1/2] describe: support the syntax "--abbrev=+"
Date: Fri, 12 Sep 2014 11:26:43 -0300
Message-ID: <1410532004-22769-2-git-send-email-jonh.wendell@gmail.com>
References: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonh Wendell <jonh.wendell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 16:27:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSRop-0005er-T1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 16:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbaILO1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 10:27:15 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33498 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbaILO1O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 10:27:14 -0400
Received: by mail-qc0-f181.google.com with SMTP id r5so802634qcx.26
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UxQm5ON9T3HnLsnAQgtJO6mHGRXvGQx9aTVtHxKITio=;
        b=E0/fewU2JYs5pBZ2Q8L+KeXnFZcCipqm70keiPugStE15bhQKSTS7ub2g9HC2cLs/4
         rVjTjjbX5K7U/xYMUWTsRzcwpOfgBVVPUf3pCsPnrSmirhsgwNr+SECFT+LOuevDQuCb
         ZSfYx8as3AlPzg/4duWu1ys4esiIiXcTUO9fNNLEOLWsaaDhEkDQl28x/ievSnKJLeEj
         SRcOI2CReWISZ4riHC1KbxBezfnTFKAj6zH5PZOI8b86tBFblGHxY4K0p9ZrQNn3fCaF
         ayDsuJxV1szMX/2ahEcNg4ljnH6DVpsr1Y1NyMlniN42OCHB81Vblnbv7ctKN6S5AyMl
         iZmg==
X-Received: by 10.229.122.72 with SMTP id k8mr12412901qcr.29.1410532033728;
        Fri, 12 Sep 2014 07:27:13 -0700 (PDT)
Received: from wendell-laptop.spo.virtua.com.br ([189.102.225.80])
        by mx.google.com with ESMTPSA id y10sm3088066qar.29.2014.09.12.07.27.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Sep 2014 07:27:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256924>

It will print just a "+" sign appended to the found tag, if there
are commits between the tag and the supplied commit.

It's useful when you just need a simple output to know if the
supplied commit is an exact match or not.

Signed-off-by: Jonh Wendell <jonh.wendell@gmail.com>
---
 builtin/describe.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index ee6a3b9..3a5c052 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -30,6 +30,7 @@ static int have_util;
 static const char *pattern;
 static int always;
 static const char *dirty;
+static int simple_abbrev = 0;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -378,8 +379,12 @@ static void describe(const char *arg, int last_one)
 	}
 
 	display_name(all_matches[0].name);
-	if (abbrev)
-		show_suffix(all_matches[0].depth, cmit->object.sha1);
+	if (abbrev) {
+		if (simple_abbrev)
+			printf("+");
+		else
+			show_suffix(all_matches[0].depth, cmit->object.sha1);
+	}
 	if (dirty)
 		printf("%s", dirty);
 	printf("\n");
@@ -388,6 +393,16 @@ static void describe(const char *arg, int last_one)
 		clear_commit_marks(cmit, -1);
 }
 
+static int parse_opt_abbrev_for_describe_cb(const struct option *opt, const char *arg, int unset)
+{
+	if (arg && !strncmp(arg, "+", 1)) {
+		simple_abbrev = 1;
+		return 0;
+	}
+
+	return parse_opt_abbrev_cb(opt, arg, unset);
+}
+
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains = 0;
@@ -398,7 +413,6 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "tags",       &tags, N_("use any tag, even unannotated")),
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
-		OPT__ABBREV(&abbrev),
 		OPT_SET_INT(0, "exact-match", &max_candidates,
 			    N_("only output exact matches"), 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
@@ -410,6 +424,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
+		{OPTION_CALLBACK, 0, "abbrev", &abbrev, N_("n"), N_("use <n> digits to display SHA-1s"),
+			PARSE_OPT_OPTARG, &parse_opt_abbrev_for_describe_cb, 0},
 		OPT_END(),
 	};
 
@@ -425,8 +441,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 
-	if (longformat && abbrev == 0)
-		die(_("--long is incompatible with --abbrev=0"));
+	if (longformat && (abbrev == 0 || simple_abbrev))
+		die(_("--long is incompatible with --abbrev=+ or --abbrev=0"));
 
 	if (contains) {
 		struct argv_array args;
-- 
1.9.3
