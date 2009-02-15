From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/8] config: Improve variable 'type' handling.
Date: Sun, 15 Feb 2009 11:00:56 +0200
Message-ID: <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:03:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcuF-0000wm-5B
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZBOJBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZBOJBU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:01:20 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:61847 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZBOJBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:01:14 -0500
Received: by bwz5 with SMTP id 5so2522331bwz.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gsS3/T4OhrYaiJ6x/bCWeE3/cIpdfBepn4OdpzCcN2I=;
        b=Fn4zxlt5bZOMyOx2zsn591kCLlA6z1mj+RLQ7AENBcJL270LmCZ2479s9WHkYbTLye
         m1omVuCi/YC1oCTuRpMJHx7uygljJ1zL1IJcVpBOhI0x+zZHQSOqD5mFU34XiWtcZjTu
         oIkUAE1pi0iaUhGdrB9/6gulVAkFSZMQLk+FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I2wtQU7WKEfw1FbleH5EtQmBDuA1mIA1mnRYKO1z8bIkxOD0FGikMXfu0z0wYuf08G
         8a14F77t/eBHT+HZV30ueplfTaFy5jaaPANe3WZlJTUOM4umMw+e471sdPfwuVloTCHv
         aqL0F5V70qDSRgiiYoHimKhSUiVXP+GYq/mgA=
Received: by 10.181.61.2 with SMTP id o2mr1476280bkk.49.1234688473036;
        Sun, 15 Feb 2009 01:01:13 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id f31sm5664717fkf.35.2009.02.15.01.01.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:01:12 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109975>

So now only either --bool, --int, or --bool-or-int can be used, but not
any combination of them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 084222a..83f8b74 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -23,7 +23,7 @@ static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
 static int use_global_config, use_system_config;
 static const char *given_config_file;
-static int actions;
+static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
 
@@ -39,6 +39,10 @@ static int end_null;
 #define ACTION_LIST (1<<9)
 #define ACTION_EDIT (1<<10)
 
+#define TYPE_BOOL (1<<0)
+#define TYPE_INT (1<<1)
+#define TYPE_BOOL_OR_INT (1<<2)
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
@@ -57,9 +61,9 @@ static struct option builtin_config_options[] = {
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
@@ -336,6 +340,17 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		key_delim = '\n';
 	}
 
+	if (HAS_MULTI_BITS(types)) {
+		error("only one type at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+	switch (types) {
+	case TYPE_BOOL: type = T_BOOL; break;
+	case TYPE_INT: type = T_INT; break;
+	case TYPE_BOOL_OR_INT: type = T_BOOL_OR_INT; break;
+	default: break;
+	}
+
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
-- 
1.6.1.3
