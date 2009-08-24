From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 1/4] fast-import: put option parsing code in seperate functions
Date: Mon, 24 Aug 2009 13:52:33 -0700
Message-ID: <1251147156-19279-2-git-send-email-srabbelier@gmail.com>
References: <1251147156-19279-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 22:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfgXo-00068r-8V
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 22:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbZHXUwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZHXUwz
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 16:52:55 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:50648 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbZHXUwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 16:52:53 -0400
Received: by mail-pz0-f194.google.com with SMTP id 32so1142245pzk.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Kotimzv835V+CW6t1X7g6KdAJRRyYB/mv4NEK15DSPw=;
        b=NWdTdrgm2ojc5F+7+syWL6zm8QkhyVi/xipTSjiIcgRnfJFjMyJ8APnD1vUEnA0fgp
         vDsiES7fKvUaz0PorHtsFvAQczY56DbMr25WOscexQCK6wl/nkI8AJuojdRixQWYOuWU
         StBNVfJrDCsEy7fgNciZWeg22HyLTAKJVPJl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mod606MEr0BXPUGX/QbNtCcYWy/YgkrEGPGPf72iHZPIes9qfwPRCH3MCZMyOKtR+r
         Z2KY6MbqjbqmznapBo+s6Q6wLoKsO/O2FEAG0jOws3aLL9ABoGtBFgt49O64A5AwoDNP
         lJqfJU7dkhc4Ly5nazPJiq2YY+iFammGQMYug=
Received: by 10.114.44.8 with SMTP id r8mr6447865war.80.1251147175713;
        Mon, 24 Aug 2009 13:52:55 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id 20sm1023981pzk.5.2009.08.24.13.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 13:52:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251147156-19279-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126966>

Putting the options in their own functions increases readability of
the option parsing block and makes it easier to reuse the option
parsing code later on.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Unchanged from v3.

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
