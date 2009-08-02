From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH v1a 1/3] fast-import: put option parsing code in seperate functions
Date: Sun,  2 Aug 2009 00:09:03 -0700
Message-ID: <1249196943-13259-1-git-send-email-srabbelier@gmail.com>
References: <1249189570-26576-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 09:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXVDu-0000SD-Gf
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 09:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbZHBHJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 03:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbZHBHJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 03:09:16 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:60960 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbZHBHJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 03:09:15 -0400
Received: by pzk34 with SMTP id 34so1972750pzk.4
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tMjL4AAHwMlt4ChA9ulamXcbzHuoUaFUp2ZOnCKIabQ=;
        b=ZTvBiPS0rU9Qrs8K+L9vHCu7UQ3CW2lCq6E93mm80YTG78D8iHiTd2KeKawMMTm4Et
         H98qClQfcHqxa99Ia7m1OoWRCUiaLTsa2mKVEq5WWitJz9O0i9e83WMxCuCL4J7DaYHH
         1Xg3heXwS+y0Xv6foScE0fR/IF6zHD3wZkE/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xflUGbNfwGnMQlE3TKxUpd9Q8iQvGLt1/ES3QjCvf1FL6t9WOv/cNw2iklJf6PsHsM
         CU4GkrbogF8K4WiHlkoxPWBpIRO1Tjv0N45KNT18G6oFwSaspCpLpetTbsjtjGStZE7a
         tpoNmhksDKeGwgkJvRtQW5FHbKU/4oy6Ei+Ro=
Received: by 10.140.170.12 with SMTP id s12mr2864287rve.296.1249196955873;
        Sun, 02 Aug 2009 00:09:15 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id f42sm28444433rvb.35.2009.08.02.00.09.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Aug 2009 00:09:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1249189570-26576-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124668>

Putting the options in their own functions increases readability of
the option parsing block and makes it easier to reuse the option
parsing code later on.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Good thing nobody saw my patch yet, it has a bug already.
    It used to be ok to assign the contents of *a to the marks_file
    since *a came from argv, which does not change. However, since
    the function is being factored out for future use where we cannot
    be sure about the validity of the argument after we return, it
    should be copied. All other options convert the argument into
    a safe value type (integer, etc).

 fast-import.c |  100 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..f624f08 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -291,6 +291,7 @@ static unsigned long branch_count;
 static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
+static unsigned int show_stats = 1;
 
 /* Memory pools */
 static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
@@ -2337,7 +2338,7 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
-static void import_marks(const char *input_file)
+static void option_import_marks(const char *input_file)
 {
 	char line[512];
 	FILE *f = fopen(input_file, "r");
@@ -2372,6 +2373,57 @@ static void import_marks(const char *input_file)
 	fclose(f);
 }
 
+static void option_date_format(const char *fmt) {
+	if (!strcmp(fmt, "raw"))
+		whenspec = WHENSPEC_RAW;
+	else if (!strcmp(fmt, "rfc2822"))
+		whenspec = WHENSPEC_RFC2822;
+	else if (!strcmp(fmt, "now"))
+		whenspec = WHENSPEC_NOW;
+	else
+		die("unknown --date-format argument %s", fmt);
+}
+
+static void option_max_pack_size(const char *packsize) {
+	max_packsize = strtoumax(packsize, NULL, 0) * 1024 * 1024;
+}
+
+static void option_depth(const char *depth) {
+	max_depth = strtoul(depth, NULL, 0);
+	if (max_depth > MAX_DEPTH)
+		die("--depth cannot exceed %u", MAX_DEPTH);
+}
+
+static void option_active_branches(const char *branches) {
+	max_active_branches = strtoul(branches, NULL, 0);
+}
+
+static void option_export_marks(const char *marks) {
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr(&buf, marks);
+	mark_file = strbuf_detach(&buf, NULL);
+}
+
+static void option_export_pack_edges(const char *edges) {
+	if (pack_edges)
+		fclose(pack_edges);
+	pack_edges = fopen(edges, "a");
+	if (!pack_edges)
+		die_errno("Cannot open '%s'", edges);
+}
+
+static void option_force() {
+	force_update = 1;
+}
+
+static void option_quiet() {
+	show_stats = 0;
+}
+
+static void option_stats() {
+	show_stats = 1;
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2398,7 +2450,7 @@ static const char fast_import_usage[] =
 
 int main(int argc, const char **argv)
 {
-	unsigned int i, show_stats = 1;
+	unsigned int i;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -2419,42 +2471,26 @@ int main(int argc, const char **argv)
 
 		if (*a != '-' || !strcmp(a, "--"))
 			break;
-		else if (!prefixcmp(a, "--date-format=")) {
-			const char *fmt = a + 14;
-			if (!strcmp(fmt, "raw"))
-				whenspec = WHENSPEC_RAW;
-			else if (!strcmp(fmt, "rfc2822"))
-				whenspec = WHENSPEC_RFC2822;
-			else if (!strcmp(fmt, "now"))
-				whenspec = WHENSPEC_NOW;
-			else
-				die("unknown --date-format argument %s", fmt);
-		}
+		else if (!prefixcmp(a, "--date-format="))
+			option_date_format(a + 14);
 		else if (!prefixcmp(a, "--max-pack-size="))
-			max_packsize = strtoumax(a + 16, NULL, 0) * 1024 * 1024;
-		else if (!prefixcmp(a, "--depth=")) {
-			max_depth = strtoul(a + 8, NULL, 0);
-			if (max_depth > MAX_DEPTH)
-				die("--depth cannot exceed %u", MAX_DEPTH);
-		}
+			option_max_pack_size(a + 16);
+		else if (!prefixcmp(a, "--depth="))
+			option_depth(a + 8);
 		else if (!prefixcmp(a, "--active-branches="))
-			max_active_branches = strtoul(a + 18, NULL, 0);
+			option_active_branches(a + 18);
 		else if (!prefixcmp(a, "--import-marks="))
-			import_marks(a + 15);
+			option_import_marks(a + 15);
 		else if (!prefixcmp(a, "--export-marks="))
-			mark_file = a + 15;
-		else if (!prefixcmp(a, "--export-pack-edges=")) {
-			if (pack_edges)
-				fclose(pack_edges);
-			pack_edges = fopen(a + 20, "a");
-			if (!pack_edges)
-				die_errno("Cannot open '%s'", a + 20);
-		} else if (!strcmp(a, "--force"))
-			force_update = 1;
+			option_export_marks(a + 15);
+		else if (!prefixcmp(a, "--export-pack-edges="))
+			option_export_pack_edges(a + 20);
+		else if (!strcmp(a, "--force"))
+			option_force();
 		else if (!strcmp(a, "--quiet"))
-			show_stats = 0;
+			option_quiet();
 		else if (!strcmp(a, "--stats"))
-			show_stats = 1;
+			option_stats();
 		else
 			die("unknown option %s", a);
 	}
-- 
1.6.4.16.g72c66.dirty
