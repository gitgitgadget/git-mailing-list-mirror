From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 1/2] fast-import: put option parsing code in seperate functions
Date: Sat,  1 Aug 2009 22:06:08 -0700
Message-ID: <1249189570-26576-2-git-send-email-srabbelier@gmail.com>
References: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com>
 <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 07:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXTHv-0001YW-2d
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 07:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbZHBFGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 01:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZHBFGq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 01:06:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:52835 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZHBFGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 01:06:46 -0400
Received: by rv-out-0506.google.com with SMTP id f6so836613rvb.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UTUzWrhtL9J5Kqba/DKjD8/10Dk9Xep9ZL9ZfJAH1qs=;
        b=eN5qrAJyinknOOJxdppD5NafIo1ABAsoDPfeukmlsVaChm7jFudBeqoplZ7h9q4LuM
         +CLB1HZ36lKdD3vDnQ9abZNOqGCOcxJHRMldwY95Gc2uMHjNiSecUq+2CX1+HGVL5Vrv
         5Uas5UM+PZYE94x8nEnAo8Pr6bkgZSFntUzqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FGLZYjNsvFMsI6qUJTswriUAPwflj0V6mEGFi0uHIKfIiXYIrLekl7Lz9DhEYLC/pA
         ERkE/oNukRRzZlKDfIKCUx1XJeoeakGQv2/4Q/Uf9ggFXSY12iP2e4i+Uqf9teZrslU8
         hYzE4ZmSeeHS5VgVkYSj2fP4lQLxMApSaYGO0=
Received: by 10.141.41.3 with SMTP id t3mr2924867rvj.93.1249189607059;
        Sat, 01 Aug 2009 22:06:47 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm27870127rvb.40.2009.08.01.22.06.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 22:06:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.15.g8b2be
In-Reply-To: <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124663>

Putting the options in their own functions increases readability of
the option parsing block and makes it easier to reuse the option
parsing code later on.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    I renamed import_marks to option_import_marks for consistency, since it is
    used to deal with a certain option.

 fast-import.c |   98 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..57fff3b 100644
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
@@ -2372,6 +2373,55 @@ static void import_marks(const char *input_file)
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
+	mark_file = marks;
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
@@ -2398,7 +2448,7 @@ static const char fast_import_usage[] =
 
 int main(int argc, const char **argv)
 {
-	unsigned int i, show_stats = 1;
+	unsigned int i;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -2419,42 +2469,26 @@ int main(int argc, const char **argv)
 
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
1.6.3.GIT
