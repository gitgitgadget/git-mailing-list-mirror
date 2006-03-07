From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] ls-files: add --abbrev[=<n>] option
Date: Tue, 7 Mar 2006 11:59:17 -0800
Message-ID: <20060307195917.GA29042@localdomain>
References: <20060307135202.GA17891@localdomain> <7vzmk2jfzr.fsf@assigned-by-dhcp.cox.net> <20060307195826.GA26870@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 20:59:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGiLD-00047W-MU
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 20:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWCGT7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 14:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWCGT7U
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 14:59:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61614 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932289AbWCGT7T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 14:59:19 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B42362DC033;
	Tue,  7 Mar 2006 11:59:17 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  7 Mar 2006 11:59:17 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060307195826.GA26870@localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17349>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Documentation/git-ls-files.txt |    7 ++++++-
 ls-files.c                     |   19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

1aa70bab7a4af7b79db3c86b9f88884c1dfad6ee
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e813f84..68d32a8 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>] 
 		[--error-unmatch]
-		[--full-name] [--] [<file>]\*
+		[--full-name] [--abbrev] [--] [<file>]\*
 
 DESCRIPTION
 -----------
@@ -98,6 +98,11 @@ OPTIONS
 	option forces paths to be output relative to the project
 	top directory.
 
+--abbrev[=<n>]::
+	Instead of showing the full 40-byte hexadecimal object
+	lines, show only handful hexdigits prefix.
+	Non default number of digits can be specified with --abbrev=<n>.
+
 --::
 	Do not interpret any more arguments as options.
 
diff --git a/ls-files.c b/ls-files.c
index df25c8c..585f6a7 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "quote.h"
 
+static int abbrev = 0;
 static int show_deleted = 0;
 static int show_cached = 0;
 static int show_others = 0;
@@ -488,7 +489,8 @@ static void show_ce_entry(const char *ta
 		printf("%s%06o %s %d\t",
 		       tag,
 		       ntohl(ce->ce_mode),
-		       sha1_to_hex(ce->sha1),
+		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
+				: sha1_to_hex(ce->sha1),
 		       ce_stage(ce));
 		write_name_quoted("", 0, ce->name + offset,
 				  line_terminator, stdout);
@@ -629,7 +631,8 @@ static void verify_pathspec(void)
 static const char ls_files_usage[] =
 	"git-ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
-	"[ --exclude-per-directory=<filename> ] [--full-name] [--] [<file>]*";
+	"[ --exclude-per-directory=<filename> ] [--full-name] [--abbrev] "
+	"[--] [<file>]*";
 
 int main(int argc, const char **argv)
 {
@@ -736,6 +739,18 @@ int main(int argc, const char **argv)
 			error_unmatch = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--abbrev=", 9)) {
+			abbrev = strtoul(arg+9, NULL, 10);
+			if (abbrev && abbrev < MINIMUM_ABBREV)
+				abbrev = MINIMUM_ABBREV;
+			else if (abbrev > 40)
+				abbrev = 40;
+			continue;
+		}
+		if (!strcmp(arg, "--abbrev")) {
+			abbrev = DEFAULT_ABBREV;
+			continue;
+		}
 		if (*arg == '-')
 			usage(ls_files_usage);
 		break;
-- 
1.2.4.gc279
