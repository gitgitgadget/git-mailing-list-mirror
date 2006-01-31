From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make apply accept the -pNUM option like patch does.
Date: Tue, 31 Jan 2006 00:36:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601310015460.25300@iabervon.org>
References: <43DE1DB7.20909@f2s.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 06:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3o9g-0004pb-R8
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 06:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWAaFeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 00:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWAaFeL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 00:34:11 -0500
Received: from iabervon.org ([66.92.72.58]:62221 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965026AbWAaFeK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 00:34:10 -0500
Received: (qmail 29079 invoked by uid 1000); 31 Jan 2006 00:36:25 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2006 00:36:25 -0500
To: Ian Molton <spyro@f2s.com>
In-Reply-To: <43DE1DB7.20909@f2s.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15302>

This only applies to traditional diffs, not to git diffs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
On Mon, 30 Jan 2006, Ian Molton wrote:

> Hi.
> 
> is there any reason why git insists diffs be -p1 format ?

Try this patch. Completely untested; if it works, tell Junio. :)

 Documentation/git-apply.txt |    6 +++++-
 apply.c                     |    8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

2490f3129103a0eae9013eb2a6f564f4a7290fbd
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 51c7d47..75076b6 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply]
-	  [--no-add] [--index-info] [--allow-binary-replacement] [-z]
+	  [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM]
 	  [<patch>...]
 
 DESCRIPTION
@@ -68,6 +68,10 @@ OPTIONS
 	backslash characters replaced with `\t`, `\n`, and `\\`,
 	respectively.
 
+-p<n>::
+	Remove <n> leading slashes from traditional diff paths. The
+	default is 1.
+
 --apply::
 	If you use any of the options marked ``Turns off
 	"apply"'' above, git-apply reads and outputs the
diff --git a/apply.c b/apply.c
index c471a82..79e23a7 100644
--- a/apply.c
+++ b/apply.c
@@ -19,6 +19,7 @@
 static const char *prefix;
 static int prefix_length = -1;
 
+static int p_value = 1;
 static int allow_binary_replacement = 0;
 static int check_index = 0;
 static int write_index = 0;
@@ -31,7 +32,7 @@ static int no_add = 0;
 static int show_index_info = 0;
 static int line_termination = '\n';
 static const char apply_usage[] =
-"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] <patch>...";
+"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -217,7 +218,6 @@ static char * find_name(const char *line
  */
 static void parse_traditional_patch(const char *first, const char *second, struct patch *patch)
 {
-	int p_value = 1;
 	char *name;
 
 	first += 4;	// skip "--- "
@@ -1799,6 +1799,10 @@ int main(int argc, char **argv)
 			excludes = x;
 			continue;
 		}
+		if (!strncmp(arg, "-p", 2)) {
+			p_value = atoi(arg + 2);
+			continue;
+		}
 		if (!strcmp(arg, "--no-add")) {
 			no_add = 1;
 			continue;
-- 
0.99.6.g3480
