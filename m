From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/4] fast-import: put option parsing code in seperate functions
Date: Wed, 12 Aug 2009 22:09:43 -0700
Message-ID: <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSaK-0001rC-Co
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbZHMFKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbZHMFKX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:10:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:1751 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbZHMFKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:10:19 -0400
Received: by rv-out-0506.google.com with SMTP id f6so169015rvb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TIUiPmtHt5452RQ8nTxFk7fjNqRaNhi9q78rXpZeLqQ=;
        b=MbF7W6LFnUF3Q6U1Vy/sHwZ04N+iyR3uMcVcds+672ULGBRrug0mmXp4WY/LsjsHix
         P1uRMWd8uD51qrRhhPwDOmZLNNSJ/diIxT+OVhrxMm+iRqVu9Nd6B4+wNVcqeTd0K4jS
         W2arFDOQOgE1ETApskPJhaFqryImw0DWeSNaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CHv52kmCkrhNY4wE7oviY83V1oM15H3+KjZ4a/N6tqe/qkcQAXUDWO3mFuxKppQK/9
         Ng3tO4+gVTBUXZz6FoRuRdtJOzlnFw5SKSt0eqigwC2bQKyGUB/GCo3jZUMllMJ/OSyr
         n/Reo0h9JRX2CC8NkXKHi6KelrYFDIEjFM5d0=
Received: by 10.140.157.14 with SMTP id f14mr383179rve.102.1250140220583;
        Wed, 12 Aug 2009 22:10:20 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm6740240rvb.20.2009.08.12.22.10.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 22:10:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125778>

Putting the options in their own functions increases readability of
the option parsing block and makes it easier to reuse the option
parsing code later on.
---

    This is nearly identical to the RFC, but with parse_one_option
    also factored out for easy reuse.

 fast-import.c |  132 +++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 92 insertions(+), 40 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..17d57ab 100644
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
@@ -2372,6 +2373,93 @@ static void import_marks(const char *input_file)
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
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr(&buf, marks);
+	mark_file = strbuf_detach(&buf, NULL);
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
+static void option_force()
+{
+	force_update = 1;
+}
+
+static void option_quiet()
+{
+	show_stats = 0;
+}
+
+static void option_stats()
+{
+	show_stats = 1;
+}
+
+static void parse_one_option(const char *option)
+{
+    if (!prefixcmp(option, "date-format=")) {
+		option_date_format(option + 12);
+    } else if (!prefixcmp(option, "max-pack-size=")) {
+		option_max_pack_size(option + 14);
+    } else if (!prefixcmp(option, "depth=")) {
+		option_depth(option + 6);
+    } else if (!prefixcmp(option, "active-branches=")) {
+		option_active_branches(option + 16);
+    } else if (!prefixcmp(option, "import-marks=")) {
+		option_import_marks(option + 13);
+    } else if (!prefixcmp(option, "export-marks=")) {
+		option_export_marks(option + 13);
+    } else if (!prefixcmp(option, "export-pack-edges=")) {
+		option_export_pack_edges(option + 18);
+    } else if (!prefixcmp(option, "force")) {
+		option_force();
+    } else if (!prefixcmp(option, "quiet")) {
+		option_quiet();
+    } else if (!prefixcmp(option, "stats")) {
+		option_stats();
+    } else {
+		die("Unsupported option: %s", option);
+    }
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2398,7 +2486,7 @@ static const char fast_import_usage[] =
 
 int main(int argc, const char **argv)
 {
-	unsigned int i, show_stats = 1;
+	unsigned int i;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -2419,44 +2507,8 @@ int main(int argc, const char **argv)
 
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
