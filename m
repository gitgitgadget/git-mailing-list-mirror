From: Junio C Hamano <junkio@cox.net>
Subject: warn non utf-8 commit log messages.
Date: Sat, 23 Dec 2006 11:53:41 -0800
Message-ID: <7vfyb6qth6.fsf_-_@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061221085907.GA2244@cepheus>
	<Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612211623.14236.litvinov2004@gmail.com>
	<7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612221030440.18171@xanadu.home>
	<7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061222221913.GA3071@cepheus>
	<Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 20:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyCwI-0006Hy-5M
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 20:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbWLWTxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 14:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbWLWTxr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 14:53:47 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46509 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbWLWTxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 14:53:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223195342.SZBM15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 14:53:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2Ksz1W0041kojtg0000000; Sat, 23 Dec 2006 14:52:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 23 Dec 2006 00:50:21 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35329>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But I had enough of UTF-8 for a day.
>
> Okay, so I lied (this are both patches revised and combined):

I am thinking of putting this in 'next', with the following
changes on top of your combined patch.

git-commit-tree warns if the commit message does not minimally
conform to the UTF-8 encoding when i18n.commitencoding is either
unset, or set to "utf-8".  It does not die as in your version.

 builtin-commit-tree.c |   13 +++++++------
 utf8.c                |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index f274721..f641787 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -78,6 +78,11 @@ static int new_parent(int idx)
 	return 1;
 }
 
+static const char commit_utf8_warn[] =
+"Warning: commit message does not conform to UTF-8.\n"
+"You may want to amend it after fixing the message, or set the config\n"
+"variable i18n.commitencoding to the encoding your project uses.\n";
+
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -133,12 +138,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	/* And check the encoding */
 	buffer[size] = '\0';
-	if (!strcmp(git_commit_encoding, "utf-8") && !is_utf8(buffer)) {
-		fprintf(stderr, "Commit message does not conform to UTF-8.\n"
-			"Please fix the message,"
-			" or set the config variable i18n.commitencoding.\n");
-		return 1;
-	}
+	if (!strcmp(git_commit_encoding, "utf-8") && !is_utf8(buffer))
+		fprintf(stderr, commit_utf8_warn);
 
 	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
diff --git a/utf8.c b/utf8.c
index aed60ad..8fa6257 100644
--- a/utf8.c
+++ b/utf8.c
@@ -244,7 +244,7 @@ void print_wrapped_text(const char *text, int indent, int indent2, int width)
 	for (;;) {
 		char c = *text;
 		if (!c || isspace(c)) {
-			if (w < width || space < 0) {
+			if (w < width || !space) {
 				const char *start = bol;
 				if (space)
 					start = space;
