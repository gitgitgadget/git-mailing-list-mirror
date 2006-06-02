From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] format-patch: resurrect extra headers from config
Date: Fri, 2 Jun 2006 15:21:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606021520240.4608@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jun 02 15:23:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm9ai-0001ik-Bu
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 15:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWFBNVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 09:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFBNVT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 09:21:19 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13971 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751417AbWFBNVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 09:21:19 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A17DAD85;
	Fri,  2 Jun 2006 15:21:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 955C1D7F;
	Fri,  2 Jun 2006 15:21:17 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7419AD76;
	Fri,  2 Jun 2006 15:21:17 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21157>


Once again, if you have

	[format]
		headers = "Origamization: EvilEmpire\n"

format-patch will add these headers just after the "Subject:" line.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-log.c |   20 ++++++++++++++++++++
 log-tree.c    |    8 +++++---
 revision.h    |    1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index ac4822d..6612f4c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -85,6 +85,23 @@ static int istitlechar(char c)
 		(c >= '0' && c <= '9') || c == '.' || c == '_';
 }
 
+static char *extra_headers = NULL;
+static int extra_headers_size = 0;
+
+static int git_format_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "format.headers")) {
+		int len = strlen(value);
+		extra_headers_size += len + 1;
+		extra_headers = realloc(extra_headers, extra_headers_size);
+		extra_headers[extra_headers_size - len - 1] = 0;
+		strcat(extra_headers, value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
+
 static FILE *realstdout = NULL;
 static char *output_directory = NULL;
 
@@ -162,6 +179,9 @@ int cmd_format_patch(int argc, const cha
 	rev.ignore_merges = 1;
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 
+	git_config(git_format_config);
+	rev.extra_headers = extra_headers;
+
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
diff --git a/log-tree.c b/log-tree.c
index e86e16b..ebb49f2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -51,7 +51,7 @@ void show_log(struct rev_info *opt, stru
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra;
 	int len;
-	char *subject = NULL, *after_subject = NULL;
+	const char *subject = NULL, *extra_headers = opt->extra_headers;
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
@@ -100,6 +100,7 @@ void show_log(struct rev_info *opt, stru
 			static char subject_buffer[1024];
 			static char buffer[1024];
 			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
+				 "%s"
 				 "MIME-Version: 1.0\n"
 				 "Content-Type: multipart/mixed;\n"
 				 " boundary=\"%s%s\"\n"
@@ -110,9 +111,10 @@ void show_log(struct rev_info *opt, stru
 				 "Content-Type: text/plain; "
 				 "charset=UTF-8; format=fixed\n"
 				 "Content-Transfer-Encoding: 8bit\n\n",
+				 extra_headers ? extra_headers : "",
 				 mime_boundary_leader, opt->mime_boundary,
 				 mime_boundary_leader, opt->mime_boundary);
-			after_subject = subject_buffer;
+			extra_headers = subject_buffer;
 
 			snprintf(buffer, sizeof(buffer) - 1,
 				 "--%s%s\n"
@@ -141,7 +143,7 @@ void show_log(struct rev_info *opt, stru
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject, after_subject);
+	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject, extra_headers);
 
 	if (opt->add_signoff)
 		len = append_signoff(this_header, sizeof(this_header), len,
diff --git a/revision.h b/revision.h
index 75796bc..7d85b0f 100644
--- a/revision.h
+++ b/revision.h
@@ -61,6 +61,7 @@ struct rev_info {
 	int		nr, total;
 	const char	*mime_boundary;
 	const char	*add_signoff;
+	const char	*extra_headers;
 
 	/* special limits */
 	int max_count;
-- 
1.3.3.g83f2b-dirty
