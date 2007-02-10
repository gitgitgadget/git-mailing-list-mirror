From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] diff.c: More logical file name quoting for renames in diffstat.
Date: Sat, 10 Feb 2007 15:39:00 +0100
Message-ID: <87ejoydqm3.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 15:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtNc-00050y-Pb
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbXBJOjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXBJOjG
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:39:06 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:40375 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbXBJOjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:39:04 -0500
Received: from adsl-62-167-54-243.adslplus.ch ([62.167.54.243] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HFtNW-0000Hc-7i
	for git@vger.kernel.org; Sat, 10 Feb 2007 08:39:02 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 50C794FB65; Sat, 10 Feb 2007 15:39:00 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39222>

Quote both file names separately when printing a rename, yielding
something like

  "foo" => "bar"

instead of the current

  "foo => bar"

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 diff.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index e036aae..c6a9692 100644
--- a/diff.c
+++ b/diff.c
@@ -545,6 +545,24 @@ static char *pprint_rename(const char *a, const char *b)
 	int pfx_length, sfx_length;
 	int len_a = strlen(a);
 	int len_b = strlen(b);
+	int qlen_a = quote_c_style(a, NULL, NULL, 0);
+	int qlen_b = quote_c_style(b, NULL, NULL, 0);
+
+	if (qlen_a || qlen_b) {
+		if (qlen_a) len_a = qlen_a;
+		if (qlen_b) len_b = qlen_b;
+		name = xmalloc( len_a + len_b + 5 );
+		if (qlen_a)
+			quote_c_style(a, name, NULL, 0);
+		else
+			memcpy(name, a, len_a);
+		memcpy(name + len_a, " => ", 4);
+		if (qlen_b)
+			quote_c_style(b, name + len_a + 4, NULL, 0);
+		else
+			memcpy(name + len_a + 4, b, len_b + 1);
+		return name;
+	}
 
 	/* Find common prefix */
 	pfx_length = 0;
@@ -701,12 +719,14 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		struct diffstat_file *file = data->files[i];
 		int change = file->added + file->deleted;
 
-		len = quote_c_style(file->name, NULL, NULL, 0);
-		if (len) {
-			char *qname = xmalloc(len + 1);
-			quote_c_style(file->name, qname, NULL, 0);
-			free(file->name);
-			file->name = qname;
+		if (!file->is_renamed) {  /* renames are already quoted by pprint_rename */
+			len = quote_c_style(file->name, NULL, NULL, 0);
+			if (len) {
+				char *qname = xmalloc(len + 1);
+				quote_c_style(file->name, qname, NULL, 0);
+				free(file->name);
+				file->name = qname;
+			}
 		}
 
 		len = strlen(file->name);
@@ -838,7 +858,7 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", file->added, file->deleted);
-		if (options->line_termination &&
+		if (options->line_termination && !file->is_renamed &&
 		    quote_c_style(file->name, NULL, NULL, 0))
 			quote_c_style(file->name, NULL, stdout, 0);
 		else
-- 
1.5.0.rc4.31.g6289

-- 
Alexandre Julliard
julliard@winehq.org
