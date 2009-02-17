From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/8] config: Disallow multiple variable types.
Date: Tue, 17 Feb 2009 02:54:50 +0200
Message-ID: <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGf-0008Gx-75
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbZBQAzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbZBQAzH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:07 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51434 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbZBQAzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:05 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3545414bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m1lSlZwbJFdmm+NXxciYfYPYS7QvBPpzOIDUA25yQqQ=;
        b=ZuJFZSKqQkoHwTY+vZ7S24JNjmLq+3G625VQNeapbO+CZk9h26BUur0GR7cXQX5P4m
         dbRM40pdP5GxsK2vB1TK7b4n90416YEcatC3BQQYiCLySFQzr94leKhf3Wyiit+dgpDO
         mwuK1LZs/gi/VneMWqxIOlfR+LusN+K+3vcW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W29TogNIFkLbR514PIKQTL0qb3qsDfzJ22ph9UWpKz23HcGW6naALmb1HfOK5Y3qvu
         zH/wR3e6c9KRY9uQf7IeO07lkRBrjJ2Zk+VhksZ2zCKexKgbbE7tAWWDZK2OHVAr6t3d
         DmX+igUY7EJBNPEqckoTVJBNrDfI/4Vub96Yg=
Received: by 10.103.228.19 with SMTP id f19mr3064988mur.18.1234832103958;
        Mon, 16 Feb 2009 16:55:03 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm740000muq.5.2009.02.16.16.55.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:55:03 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110279>

So now only either --bool, --int, or --bool-or-int can be used, but not
any combination of them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 084222a..30de93e 100644
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
 
@@ -39,6 +38,10 @@ static int end_null;
 #define ACTION_LIST (1<<9)
 #define ACTION_EDIT (1<<10)
 
+#define TYPE_BOOL (1<<0)
+#define TYPE_INT (1<<1)
+#define TYPE_BOOL_OR_INT (1<<2)
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
@@ -57,9 +60,9 @@ static struct option builtin_config_options[] = {
 	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
 	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
 	OPT_GROUP("Type"),
-	OPT_SET_INT(0, "bool", &type, "value is \"true\" or \"false\"", T_BOOL),
-	OPT_SET_INT(0, "int", &type, "value is decimal number", T_INT),
-	OPT_SET_INT(0, "bool-or-int", &type, NULL, T_BOOL_OR_INT),
+	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
+	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
+	OPT_BIT(0, "bool-or-int", &types, NULL, TYPE_BOOL_OR_INT),
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
 	OPT_GROUP("Other"),
@@ -105,11 +108,11 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	}
 	if (seen && !do_all)
 		dup_error = 1;
-	if (type == T_INT)
+	if (types & TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
-	else if (type == T_BOOL)
+	else if (types & TYPE_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
-	else if (type == T_BOOL_OR_INT) {
+	else if (types & TYPE_BOOL_OR_INT) {
 		int is_bool, v;
 		v = git_config_bool_or_int(key_, value_, &is_bool);
 		if (is_bool)
@@ -208,18 +211,18 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (type == T_RAW)
+	if (types == 0)
 		normalized = xstrdup(value);
 	else {
 		normalized = xmalloc(64);
-		if (type == T_INT) {
+		if (types & TYPE_INT) {
 			int v = git_config_int(key, value);
 			sprintf(normalized, "%d", v);
 		}
-		else if (type == T_BOOL)
+		else if (types & TYPE_BOOL)
 			sprintf(normalized, "%s",
 				git_config_bool(key, value) ? "true" : "false");
-		else if (type == T_BOOL_OR_INT) {
+		else if (types & TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key, value, &is_bool);
 			if (!is_bool)
@@ -336,6 +339,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		key_delim = '\n';
 	}
 
+	if (HAS_MULTI_BITS(types)) {
+		error("only one type at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
-- 
1.6.1.3
