From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B v4 3/5] git config: don't allow multiple variable types
Date: Sat, 21 Feb 2009 02:49:27 +0200
Message-ID: <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag5Y-0007JC-69
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbZBUAtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbZBUAtm
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:42 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42984 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbZBUAtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:39 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3160824bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qzwC7pdvk9/p62lcIBPSyAYAT8LurtQFVrUBWBmsQHw=;
        b=lUlmoylyE76bUk8IOgtKY7SGm6zAIWHwf7zUzYJAhU+OnRod1ynSV+blbBOjyBM2iB
         c9T/lSsnZx3zKZy8oN2OmKMWoYlKdzyb8l8btbN9LdlIRpKv+FRp1Ilyaget0FZH2Spv
         N8yisukQMHEwEfBe/XjFdM1eAGQqPsubUFSeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WBWDk3mC7kwxCvt403I+LI4CB+Qd6hrg8Q+w63e2iTMLuUEpnyn4VVg8LojK7Cx9So
         ensn/lvKKr+W0/Yg4+E10yx+0SUlYsM/2y7ogSvVqk779oniIFOuDWNL1aDWmL1vkpBR
         lxaCDHZlsbXjAmkonYN5HMzSxV9Xbny1xNDEo=
Received: by 10.181.36.18 with SMTP id o18mr472534bkj.136.1235177378761;
        Fri, 20 Feb 2009 16:49:38 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id h2sm3189985fkh.9.2009.02.20.16.49.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:37 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110917>

Only --bool, --int, or --bool-or-int can be used, but not any
combination of them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 876eb0e..c2a30f2 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -19,11 +19,10 @@ static int seen;
 static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
-static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
 static int use_global_config, use_system_config;
 static const char *given_config_file;
-static int actions;
+static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
 
@@ -43,6 +42,10 @@ static int end_null;
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
 
+#define TYPE_BOOL (1<<0)
+#define TYPE_INT (1<<1)
+#define TYPE_BOOL_OR_INT (1<<2)
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
@@ -63,9 +66,9 @@ static struct option builtin_config_options[] = {
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
 	OPT_GROUP("Type"),
-	OPT_SET_INT(0, "bool", &type, "value is \"true\" or \"false\"", T_BOOL),
-	OPT_SET_INT(0, "int", &type, "value is decimal number", T_INT),
-	OPT_SET_INT(0, "bool-or-int", &type, NULL, T_BOOL_OR_INT),
+	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
+	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
+	OPT_BIT(0, "bool-or-int", &types, NULL, TYPE_BOOL_OR_INT),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
 	OPT_END(),
@@ -109,11 +112,11 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	}
 	if (seen && !do_all)
 		dup_error = 1;
-	if (type == T_INT)
+	if (types == TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
-	else if (type == T_BOOL)
+	else if (types == TYPE_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
-	else if (type == T_BOOL_OR_INT) {
+	else if (types == TYPE_BOOL_OR_INT) {
 		int is_bool, v;
 		v = git_config_bool_or_int(key_, value_, &is_bool);
 		if (is_bool)
@@ -212,18 +215,18 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (type == T_RAW)
+	if (types == 0)
 		normalized = xstrdup(value);
 	else {
 		normalized = xmalloc(64);
-		if (type == T_INT) {
+		if (types == TYPE_INT) {
 			int v = git_config_int(key, value);
 			sprintf(normalized, "%d", v);
 		}
-		else if (type == T_BOOL)
+		else if (types == TYPE_BOOL)
 			sprintf(normalized, "%s",
 				git_config_bool(key, value) ? "true" : "false");
-		else if (type == T_BOOL_OR_INT) {
+		else if (types == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key, value, &is_bool);
 			if (!is_bool)
@@ -346,6 +349,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		key_delim = '\n';
 	}
 
+	if (HAS_MULTI_BITS(types)) {
+		error("only one type at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (get_color_slot)
 	    actions |= ACTION_GET_COLOR;
 	if (get_colorbool_slot)
-- 
1.6.1.3
