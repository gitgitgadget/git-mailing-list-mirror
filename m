From: Gisle Aas <gisle.aas@it.uib.no>
Subject: [PATCH] Add --path-prefix option to git-fast-import
Date: Tue, 29 Dec 2009 13:51:23 +0100
Message-ID: <1262091083-25401-1-git-send-email-gisle.aas@it.uib.no>
Cc: gitster@pobox.com, Gisle Aas <gisle@aas.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 14:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPbyM-0002WQ-9b
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 14:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbZL2NSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 08:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbZL2NSo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 08:18:44 -0500
Received: from alfons.uib.no ([129.177.30.72]:41777 "EHLO alfons.uib.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbZL2NSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 08:18:43 -0500
X-Greylist: delayed 1606 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2009 08:18:43 EST
Received: from thoralf.uib.no (smtp.uib.no) [129.177.13.16] 
	by alfons.uib.no  with esmtp  (Exim 4.69)
	id 1NPbYI-0006O6-UP; Tue, 29 Dec 2009 13:51:55 +0100
Received: from void.uib.no [129.177.5.125]:45679 
	by smtp.uib.no  with esmtps (Exim 4.69)
	id 1NPbYI-0000ni-To; Tue, 29 Dec 2009 13:51:54 +0100
Received: from gaa041 by void.uib.no  with local (Exim 4.63)
	id 1NPbYI-0006cE-RJ; Tue, 29 Dec 2009 13:51:54 +0100
X-Mailer: git-send-email 1.6.6.rc4.12.g269e7
X-checked-clean: by exiscan on alfons
X-Scanner: 159c6f94f43b0a61927463fb17c179ec http://tjinfo.uib.no/virus.html
X-UiB-SpamFlag: NO UIB: -23.9 hits, 8.0 required
X-UiB-SpamReport: spamassassin found;
  -15 From is listed in 'whitelist_SA'
 -9.0 Message received from UIB
  0.1 BODY: UIB_MAILWON
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135796>

From: Gisle Aas <gisle@aas.no>

I found this useful when import multiple external repositories to be merged
into a single git repo.  Not having the files be renamed during the merge
made it easier to follow the history of the individual files.

Signed-off-by: Gisle Aas <gisle@aas.no>
---
 Documentation/git-fast-import.txt |    6 ++++++
 fast-import.c                     |   24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 288032c..b8f9593 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -58,6 +58,12 @@ OPTIONS
 	Maximum number of branches to maintain active at once.
 	See ``Memory Utilization'' below for details.  Default is 5.
 
+--path-prefix=<str>:
+	Prepend the given prefix to all the paths imported.
+	This can be used to import stuff into a subdirectory
+	of where the original files where located.  Most likely
+	you want <str> to end with a slash.
+
 --export-marks=<file>::
 	Dumps the internal marks table to <file> when complete.
 	Marks are written one per line as `:markid SHA-1`.
diff --git a/fast-import.c b/fast-import.c
index dd3c99d..32b0d70 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -351,6 +351,8 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static const char *path_prefix;
+static size_t path_prefix_len;
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1860,6 +1862,16 @@ static void load_branch(struct branch *b)
 	}
 }
 
+static const char *path_prefix_prepend(struct strbuf *sb, const char *p)
+{
+	if (p != sb->buf) {
+	    strbuf_reset(sb);
+	    strbuf_addstr(sb, p);
+	}
+	strbuf_insert(sb, 0, path_prefix, path_prefix_len);
+	return sb->buf;
+}
+
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
@@ -1909,6 +1921,8 @@ static void file_change_m(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
+	if (path_prefix)
+	    p = path_prefix_prepend(&uq, p);
 
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
@@ -1961,6 +1975,8 @@ static void file_change_d(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
+	if (path_prefix)
+	    p = path_prefix_prepend(&uq, p);
 	tree_content_remove(&b->branch_tree, p, NULL);
 }
 
@@ -1984,6 +2000,8 @@ static void file_change_cr(struct branch *b, int rename)
 		strbuf_add(&s_uq, s, endp - s);
 	}
 	s = s_uq.buf;
+	if (path_prefix)
+	    s = path_prefix_prepend(&s_uq, s);
 
 	endp++;
 	if (!*endp)
@@ -1996,6 +2014,8 @@ static void file_change_cr(struct branch *b, int rename)
 			die("Garbage after dest in: %s", command_buf.buf);
 		d = d_uq.buf;
 	}
+	if (path_prefix)
+	    d = path_prefix_prepend(&d_uq, d);
 
 	memset(&leaf, 0, sizeof(leaf));
 	if (rename)
@@ -2523,6 +2543,10 @@ int main(int argc, const char **argv)
 			if (max_depth > MAX_DEPTH)
 				die("--depth cannot exceed %u", MAX_DEPTH);
 		}
+		else if (!prefixcmp(a, "--path-prefix=")) {
+			path_prefix = a + 14;
+			path_prefix_len = strlen(path_prefix);
+		}
 		else if (!prefixcmp(a, "--active-branches="))
 			max_active_branches = strtoul(a + 18, NULL, 0);
 		else if (!prefixcmp(a, "--import-marks="))
-- 
1.6.6.rc4.12.g269e7
