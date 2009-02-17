From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/10] config: Disallow multiple variable types.
Date: Tue, 17 Feb 2009 15:52:55 +0200
Message-ID: <1234878776-13250-9-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-6-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-7-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-8-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPq-0001sQ-0c
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbZBQNxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbZBQNxf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:35 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51922 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbZBQNxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:34 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so4067593bwz.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2aKxm0SoPMDZWQpeM3L4zfF7MmPNBVATOF6Rfyk6d1w=;
        b=hyDSzJlnAtFq73KQDRKTFt91o0+znrG/IJgqAtb3X3y5Qx7oABMMwzGityHyKY3KsO
         Y2G40q2q28DkUdbH3hoLxlWNC+4s0JMvi0Z3rzefAF3B6XqUI9SLsROtv14EH5MinIio
         Q+NdXV8Z7C6Kt59J8emsz9QkPausTNS7BiEEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yk78uJ4SFiZauzdvraJnc1pma8DTD8GiD3zK4EXQC4ahlbZIhzQ0rMfTZgJAwTqNYO
         ryTlGT0uw9HpuSQmZTJM6EnepyiW/6b3RNnMR7RF3n4SGaAQj6wmh1/wkKUPL6rRcghu
         QmEJp91jNe3Qo8suCr2WMCLeNhH14AvSVnlv0=
Received: by 10.223.106.68 with SMTP id w4mr238941fao.19.1234878812743;
        Tue, 17 Feb 2009 05:53:32 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id p10sm3331465gvf.1.2009.02.17.05.53.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:32 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110379>

So now only either --bool, --int, or --bool-or-int can be used, but not
any combination of them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index a674246..060191c 100644
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
