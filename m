From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH] Make git-diff-tree --pretty
Date: Mon, 06 Jun 2005 23:16:31 +0200
Message-ID: <d82e8d$km9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040104090004090708040502"
X-From: git-owner@vger.kernel.org Mon Jun 06 23:17:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfOx8-0000QB-VW
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 23:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVFFVTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 17:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVFFVTn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 17:19:43 -0400
Received: from main.gmane.org ([80.91.229.2]:49597 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261685AbVFFVTT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 17:19:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DfOvK-0000CH-CE
	for git@vger.kernel.org; Mon, 06 Jun 2005 23:14:18 +0200
Received: from c80-217-52-214.cm-upc.chello.se ([80.217.52.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2005 23:14:18 +0200
Received: from holmsand by c80-217-52-214.cm-upc.chello.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2005 23:14:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c80-217-52-214.cm-upc.chello.se
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104090004090708040502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make git-diff-tree --pretty[=[short|medium|raw]] work as in
git-rev-list.

Also suppress duplicate newline in 'git-diff-tree -s' output.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---

--------------040104090004090708040502
Content-Type: text/plain;
 name="diff-tree.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-tree.patch.txt"

 diff-tree.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -323,7 +323,8 @@ static char *generate_header(const char 
 	offset = sprintf(this_header, "%s%s (from %s)\n", header_prefix, commit, parent);
 	if (verbose_header) {
 		offset += pretty_print_commit(commit_format, msg, len, this_header + offset, sizeof(this_header) - offset);
-		this_header[offset++] = '\n';
+		if (diff_output_format != DIFF_FORMAT_NO_OUTPUT)
+			this_header[offset++] = '\n';
 		this_header[offset++] = 0;
 	}
 
@@ -400,6 +401,19 @@ static int diff_tree_stdin(char *line)
 static char *diff_tree_usage =
 "git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish>";
 
+static enum cmit_fmt get_commit_format(const char *arg)
+{
+	if (!*arg)
+		return CMIT_FMT_DEFAULT;
+	if (!strcmp(arg, "=raw"))
+		return CMIT_FMT_RAW;
+	if (!strcmp(arg, "=medium"))
+		return CMIT_FMT_MEDIUM;
+	if (!strcmp(arg, "=short"))
+		return CMIT_FMT_SHORT;
+	usage(diff_tree_usage);	
+}			
+
 int main(int argc, const char **argv)
 {
 	int nr_sha1;
@@ -492,6 +506,12 @@ int main(int argc, const char **argv)
 			header_prefix = "diff-tree ";
 			continue;
 		}
+		if (!strncmp(arg, "--pretty", 8)) {
+			commit_format = get_commit_format(arg+8);
+			verbose_header = 1;
+			header_prefix = "diff-tree ";
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			read_stdin = 1;
 			continue;

--------------040104090004090708040502--

