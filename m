From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] update-index --{set,get}-base
Date: Thu, 29 Mar 2007 01:23:11 -0700
Message-ID: <7vhcs44fww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 10:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpuk-000473-Me
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXC2IXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbXC2IXV
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:23:21 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36712 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXC2IXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:23:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329082312.DGJZ1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 04:23:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gYPB1W00A1kojtg0000000; Thu, 29 Mar 2007 04:23:12 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43413>

These new options allow scripts to interact with BASE index
extension.  The scripts would store HEAD information when
checking a revision out, and extract and check it when making a
new commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 71cef63..5ed7c63 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -617,6 +617,23 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				verbose = 1;
 				continue;
 			}
+			if (!strcmp(path, "--set-base")) {
+				unsigned char sha1[20];
+				if (argc <= ++i)
+					die("git-update-index: --set-base <sha1>");
+				if (get_sha1_hex(argv[i], sha1))
+					die("git-update-index: --set-base: malformed object name '%s'", argv[i]);
+				active_cache_changed = 1;
+				active_cache_base_valid = 1;
+				hashcpy(active_cache_base, sha1);
+				continue;
+			}
+			if (!strcmp(path, "--get-base")) {
+				if (active_cache_base_valid)
+					printf("%s\n",
+					       sha1_to_hex(active_cache_base));
+				continue;
+			}
 			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
 				usage(update_index_usage);
 			die("unknown option %s", path);
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index cd5e014..79c4e6e 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
+	     [--get-base] [--set-base <base>]
 	     [-z] [--stdin]
 	     [--verbose]
 	     [--] [<file>]\*
@@ -110,6 +111,17 @@ OPTIONS
 	read list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
+--get-base::
+	The index can record which commit object its state was
+	initialized from (hence expected to have as the first
+	parent commit for the next commit).  This option reads
+	the commit object name and writes it to the standard
+	output.
+
+--set-base <base>::
+	This option records the commit object name in the index,
+	later to be retrieved with the `--get-base` option.
+
 --verbose::
         Report what is being added and removed from index.
 
