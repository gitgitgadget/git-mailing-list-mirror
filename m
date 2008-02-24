From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Add '--fixed-strings' option to "git log --grep" and friends
Date: Sun, 24 Feb 2008 16:47:08 +0100
Message-ID: <200802241647.08871.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 16:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTJ54-0004kt-LH
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 16:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbYBXPrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 10:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYBXPrW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 10:47:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:55931 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYBXPrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 10:47:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so445680ugc.16
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=39YCBjpj7CK0xSMxDgfzCpcXombcHZMS0sarR3bqkg8=;
        b=dDnbMHg59+Qds3hNBzGbebMVR3wTPnB7vLL6iMsbZpFQ7LWZfsX/Psmnwm9CCi073jCEztuG1W/PhAbfmpe5b/Hx+Jlo2kfDFOU8wxqoYrozQaGUbv6SYOYx400otEX7VKeedv3y9n7qTIdd2I3CmZ8K+7HoLjS+CLrFrLja4H0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tYq90Ku5woVAkLwTVGw3XO7wpEhrEwTOc5Dwb9N3Jq3/iwCSEbihbaKy4UfbUxFZQ6ERSQN1aSytAiypjswkCZWVxi1Yyfj21PGGwZ64mGOyQTvA20zImMhpFVsNhw2jWpXYrXnGLEO3HoXTnu5zbu8onqi//bPDoKTsGjahjzQ=
Received: by 10.150.124.2 with SMTP id w2mr628837ybc.2.1203868038929;
        Sun, 24 Feb 2008 07:47:18 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.46])
        by mx.google.com with ESMTPS id i4sm684822nfh.26.2008.02.24.07.47.16
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 07:47:17 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74942>

Add support for -F | --fixed-strings option to "git log --grep"
and friends: "git log --author", "git log --committer=<pattern>".
Code is based on implementation of this option in "git grep".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This would simplify ignore-case searching for a fixed string from
within gitweb, as gitweb wouldn't then have to deal with differences
in quoting and unquoting (if you quote character which doesn't need
quoting, would git unquote it?) between searched phrase,
basic/extended regular expression as understood by git/by grep,
and regular expressions in Perl (when showing matched info).

[I am not sure if the above paragtaph should be added to commit
message, so it is in patch comments. Feel free to add it.] 


P.S. I see that neither git-log, nor git-grep are converted to
parseopt interface. What are plans for it, if any?

 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    5 +++++
 revision.c                         |   10 +++++++++-
 3 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 5b96eab..a8d489f 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -31,6 +31,7 @@ SYNOPSIS
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ \--regexp-ignore-case | \-i ]
 	     [ \--extended-regexp | \-E ]
+	     [ \--fixed-strings | \-F ]
 	     [ \--date={local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a8138e2..259072c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -153,6 +153,11 @@ limiting may be applied.
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
+-F, --fixed-strings::
+
+	Consider the limiting patterns to be fixed strings (don't interpret
+	pattern as a regular expression).
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index d3e8658..5df7961 100644
--- a/revision.c
+++ b/revision.c
@@ -942,6 +942,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	int left = 1;
 	int all_match = 0;
 	int regflags = 0;
+	int fixed = 0;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1238,6 +1239,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				regflags |= REG_ICASE;
 				continue;
 			}
+			if (!strcmp(arg, "--fixed-strings") ||
+			    !strcmp(arg, "-F")) {
+				fixed = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--all-match")) {
 				all_match = 1;
 				continue;
@@ -1293,8 +1299,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
-	if (revs->grep_filter)
+	if (revs->grep_filter) {
 		revs->grep_filter->regflags |= regflags;
+		revs->grep_filter->fixed = fixed;
+	}
 
 	if (show_merge)
 		prepare_show_merge(revs);
-- 
1.5.4.2
