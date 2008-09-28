From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Facility to have multiple kinds of drivers for diff.
Date: Sun, 28 Sep 2008 04:06:54 +0200
Message-ID: <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 04:11:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjlkO-0004Jm-EA
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 04:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYI1CJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 22:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYI1CJt
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 22:09:49 -0400
Received: from imag.imag.fr ([129.88.30.1]:60081 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbYI1CJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 22:09:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S26wxG026009
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 04:06:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjlgY-0001db-6v; Sun, 28 Sep 2008 04:06:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjlgY-00060I-4B; Sun, 28 Sep 2008 04:06:58 +0200
X-Mailer: git-send-email 1.6.0.2.312.g1ef81a
In-Reply-To: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 04:06:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96937>

We now have an array attr_cmd_specs describing the possible kinds of
drivers.
---
 diff.c |   63 +++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 099ce3f..1c8dd19 100644
--- a/diff.c
+++ b/diff.c
@@ -56,11 +56,29 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-static struct ll_cmd_driver {
+struct ll_cmd_driver {
 	const char *name;
 	struct ll_cmd_driver *next;
 	const char *cmd;
-} *user_diff, **user_diff_tail;
+};
+
+struct attr_cmd_spec {
+	char * name;
+	struct git_attr * attr_cmd;
+	struct ll_cmd_driver *head;
+	struct ll_cmd_driver **tail;
+};
+
+enum driver_indices {
+	DIFF_DRIVER=0,
+	TEXTCONV_DRIVER=1,
+	DRIVER_COUNT,
+};
+
+static struct attr_cmd_spec attr_cmd_specs[DRIVER_COUNT] = {
+	{"diff", NULL},
+	{"textconv", NULL},
+};
 
 /*
  * Currently there is only "diff.<drivername>.command" variable;
@@ -68,24 +86,24 @@ static struct ll_cmd_driver {
  * this in a bit convoluted way to allow low level diff driver
  * called "color".
  */
-static int parse_ll_command(const char *var, const char *ep, const char *value)
+static int parse_ll_command(const char *var, const char *name,
+			    const char *ep, const char *value,
+			    int driver)
 {
-	const char *name;
 	int namelen;
 	struct ll_cmd_driver *drv;
 
-	name = var + 5;
 	namelen = ep - name;
-	for (drv = user_diff; drv; drv = drv->next)
+	for (drv = attr_cmd_specs[driver].head; drv; drv = drv->next)
 		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
 			break;
 	if (!drv) {
 		drv = xcalloc(1, sizeof(struct ll_cmd_driver));
 		drv->name = xmemdupz(name, namelen);
-		if (!user_diff_tail)
-			user_diff_tail = &user_diff;
-		*user_diff_tail = drv;
-		user_diff_tail = &(drv->next);
+		if (!attr_cmd_specs[driver].tail)
+			attr_cmd_specs[driver].tail = &attr_cmd_specs[driver].head;
+		*attr_cmd_specs[driver].tail = drv;
+		attr_cmd_specs[driver].tail = &(drv->next);
 	}
 
 	return git_config_string(&(drv->cmd), var, value);
@@ -161,7 +179,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		const char *ep = strrchr(var, '.');
 
 		if (ep != var + 4 && !strcmp(ep, ".command"))
-			return parse_ll_command(var, ep, value);
+			return parse_ll_command(var, var + 5, ep, value, DIFF_DRIVER);
 	}
 
 	return git_diff_basic_config(var, value, cb);
@@ -1340,14 +1358,14 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
 	emit_binary_diff_body(file, two, one);
 }
 
-static void setup_diff_attr_check(struct git_attr_check *check)
+/* driver_index must be among the values of "enum driver_indices" */
+static void setup_cmd_attr_check(struct git_attr_check *check, int driver_index)
 {
-	static struct git_attr *attr_diff;
-
-	if (!attr_diff) {
-		attr_diff = git_attr("diff", 4);
+	struct attr_cmd_spec * spec = &attr_cmd_specs[driver_index];
+	if (!spec->attr_cmd) {
+		spec->attr_cmd = git_attr(spec->name, strlen(spec->name));
 	}
-	check[0].attr = attr_diff;
+	check[0].attr = spec->attr_cmd;
 }
 
 static void diff_filespec_check_attr(struct diff_filespec *one)
@@ -1358,7 +1376,7 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 	if (one->checked_attr)
 		return;
 
-	setup_cmd_attr_check(&attr_cmd_check);
+	setup_cmd_attr_check(&attr_cmd_check, DIFF_DRIVER);
 	one->is_binary = 0;
 	one->funcname_pattern_ident = NULL;
 
@@ -2092,14 +2110,14 @@ static void run_external_diff(const char *pgm,
 	}
 }
 
-static const char *external_cmd_attr(const char *name)
+static const char *external_cmd_attr(const char *name, int driver_index)
 {
 	struct git_attr_check attr_cmd_check;
 
 	if (!name)
 		return NULL;
 
-	setup_diff_attr_check(&attr_cmd_check);
+	setup_cmd_attr_check(&attr_cmd_check, driver_index);
 	if (!git_checkattr(name, 1, &attr_cmd_check)) {
 		const char *value = attr_cmd_check.value;
 		if (!ATTR_TRUE(value) &&
@@ -2107,7 +2125,8 @@ static const char *external_cmd_attr(const char *name)
 		    !ATTR_UNSET(value)) {
 			struct ll_cmd_driver *drv;
 
-			for (drv = user_diff; drv; drv = drv->next)
+			for (drv = attr_cmd_specs[driver_index].head;
+			     drv; drv = drv->next)
 				if (!strcmp(drv->name, value))
 					return drv->cmd;
 		}
@@ -2128,7 +2147,7 @@ static void run_diff_cmd(const char *pgm,
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
 	else {
-		const char *cmd = external_cmd_attr(attr_path);
+		const char *cmd = external_cmd_attr(attr_path, DIFF_DRIVER);
 		if (cmd)
 			pgm = cmd;
 	}
-- 
1.6.0.2.312.g1ef81a
