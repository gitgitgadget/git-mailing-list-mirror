From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v7 1/6] fast-import: put option parsing code in separate functions
Date: Sun,  6 Sep 2009 16:35:43 +0200
Message-ID: <1252247748-14507-2-git-send-email-srabbelier@gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Sun Sep 06 16:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkIrA-00078l-P1
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 16:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757978AbZIFOgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 10:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757975AbZIFOgQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 10:36:16 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:36677 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZIFOgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 10:36:10 -0400
Received: by ewy2 with SMTP id 2so1511768ewy.17
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CuDHhlupKZt+hK9JvDyQ4ApDSz5b4XT+BHlJoIzcRe0=;
        b=ByrdDoWLz8iLNgvVhMR2naaISJ0oknRoQiW6TozHmXQV5j/S3qHZxDWqGlHI4P7p6B
         l2sMV61+RWD9FK4IZ+4ur3dIEOd0OxF4l1nWeArJ1mAyh76/yc4s6PtxSYZTZ0trVCn5
         0KvPNlO56IFoT24DLV4bDTZcs3JfJHLMiNBe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gb/xiY3dlL7nddfpph/+OIviv5L2bNKnP3vif6GrncLB3PShj3KA3TiEzr++428aGO
         vHvPLWhmyCt8ZkYys8+mRC7o5h2Opwc5xG0zktBM1lhjQbQgkbm1Z2DNtnsS5CGGU7xL
         gonTMVpQjlUbirxLcK4+xn4JV223r23VPH3h8=
Received: by 10.216.47.204 with SMTP id t54mr2760760web.75.1252247772041;
        Sun, 06 Sep 2009 07:36:12 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id q9sm8759493gve.6.2009.09.06.07.36.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 07:36:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127857>

Putting the options in their own functions increases readability of
the option parsing block and makes it easier to reuse the option
parsing code later on.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged again.

 fast-import.c |  115 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..b904f20 100644
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
@@ -2372,6 +2373,76 @@ static void import_marks(const char *input_file)
 	fclose(f);
 }
 
+static void option_date_format(const char *fmt)
+{
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
+static void option_max_pack_size(const char *packsize)
+{
+	max_packsize = strtoumax(packsize, NULL, 0) * 1024 * 1024;
+}
+
+static void option_depth(const char *depth)
+{
+	max_depth = strtoul(depth, NULL, 0);
+	if (max_depth > MAX_DEPTH)
+		die("--depth cannot exceed %u", MAX_DEPTH);
+}
+
+static void option_active_branches(const char *branches)
+{
+	max_active_branches = strtoul(branches, NULL, 0);
+}
+
+static void option_export_marks(const char *marks)
+{
+	mark_file = xstrdup(marks);
+}
+
+static void option_export_pack_edges(const char *edges)
+{
+	if (pack_edges)
+		fclose(pack_edges);
+	pack_edges = fopen(edges, "a");
+	if (!pack_edges)
+		die_errno("Cannot open '%s'", edges);
+}
+
+static void parse_one_option(const char *option)
+{
+	if (!prefixcmp(option, "date-format=")) {
+		option_date_format(option + 12);
+	} else if (!prefixcmp(option, "max-pack-size=")) {
+		option_max_pack_size(option + 14);
+	} else if (!prefixcmp(option, "depth=")) {
+		option_depth(option + 6);
+	} else if (!prefixcmp(option, "active-branches=")) {
+		option_active_branches(option + 16);
+	} else if (!prefixcmp(option, "import-marks=")) {
+		option_import_marks(option + 13);
+	} else if (!prefixcmp(option, "export-marks=")) {
+		option_export_marks(option + 13);
+	} else if (!prefixcmp(option, "export-pack-edges=")) {
+		option_export_pack_edges(option + 18);
+	} else if (!prefixcmp(option, "force")) {
+		force_update = 1;
+	} else if (!prefixcmp(option, "quiet")) {
+		show_stats = 0;
+	} else if (!prefixcmp(option, "stats")) {
+		show_stats = 1;
+	} else {
+		die("Unsupported option: %s", option);
+	}
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2398,7 +2469,7 @@ static const char fast_import_usage[] =
 
 int main(int argc, const char **argv)
 {
-	unsigned int i, show_stats = 1;
+	unsigned int i;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -2419,44 +2490,8 @@ int main(int argc, const char **argv)
 
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
-		else if (!prefixcmp(a, "--max-pack-size="))
-			max_packsize = strtoumax(a + 16, NULL, 0) * 1024 * 1024;
-		else if (!prefixcmp(a, "--depth=")) {
-			max_depth = strtoul(a + 8, NULL, 0);
-			if (max_depth > MAX_DEPTH)
-				die("--depth cannot exceed %u", MAX_DEPTH);
-		}
-		else if (!prefixcmp(a, "--active-branches="))
-			max_active_branches = strtoul(a + 18, NULL, 0);
-		else if (!prefixcmp(a, "--import-marks="))
-			import_marks(a + 15);
-		else if (!prefixcmp(a, "--export-marks="))
-			mark_file = a + 15;
-		else if (!prefixcmp(a, "--export-pack-edges=")) {
-			if (pack_edges)
-				fclose(pack_edges);
-			pack_edges = fopen(a + 20, "a");
-			if (!pack_edges)
-				die_errno("Cannot open '%s'", a + 20);
-		} else if (!strcmp(a, "--force"))
-			force_update = 1;
-		else if (!strcmp(a, "--quiet"))
-			show_stats = 0;
-		else if (!strcmp(a, "--stats"))
-			show_stats = 1;
-		else
-			die("unknown option %s", a);
+
+		parse_one_option(a + 2);
 	}
 	if (i != argc)
 		usage(fast_import_usage);
-- 
1.6.4.16.g72c66.dirty
