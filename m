From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] Add '--fixed-strings' option to "git log --grep" and friends
Date: Tue, 26 Feb 2008 13:22:05 +0100
Message-ID: <1204028528-18941-2-git-send-email-jnareb@gmail.com>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 13:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTypn-0001rJ-Kt
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbYBZMWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbYBZMWY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:22:24 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:55675 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYBZMWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:22:22 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2857234fkz.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fl2Rxyj5LSsvr5FM4cuk9YYWE2MOQaZOz9eS4XYh5Ug=;
        b=SfFbcEy2sYVBcMQIfIdgZNN4Zofie7TYO0/x6x+yZrXZRekOFNEEoUwosl40qCbshaXmWeNedRBrCEnlCKCOxA3djJYMs7hpiADjcvXdkHM3fMeEqSFAYgpuDmS2W0wE0xNfT5iWiPGc9Dr1kYATO8Rqv4cgT4mZGU5vyAL9/mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f+EucWgdcEvwe8CgKBx08rdlyzevLTBFKA1X+OjGjL1IbAoDeoCCbXxk6EITFbrvV77pLYp7l8rZvVPksDvITH1vqfvSO0Z52OTjfUK/OC7OGxJvub7wlaczRv6nYuIeQB636a7uuYcJpHZcXY2qh0uCv5CqygJke25EugVSm/E=
Received: by 10.82.174.20 with SMTP id w20mr8678274bue.9.1204028540170;
        Tue, 26 Feb 2008 04:22:20 -0800 (PST)
Received: from localhost.localdomain ( [83.8.218.226])
        by mx.google.com with ESMTPS id z37sm10915314ikz.1.2008.02.26.04.22.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 04:22:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1QCMA73018964;
	Tue, 26 Feb 2008 13:22:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1QCMAnr018963;
	Tue, 26 Feb 2008 13:22:10 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75128>

Add support for -F | --fixed-strings option to "git log --grep"
and friends: "git log --author", "git log --committer=<pattern>".
Code is based on implementation of this option in "git grep".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This would simplify ignore-case searching for a fixed string from
within gitweb, as gitweb wouldn't then have to deal with differences
in quoting and unquoting (if you quote character which doesn't need
quoting, would git (grep) unquote it?) between searched phrase,
basic/extended regular expression as understood by git/by grep,
and regular expressions in Perl (when showing matched info).

[I am not sure if the above paragraph should be added to commit
message, so it is in patch comments. Feel free to add it.] 

This patch can be also seen as "consistency" patch: git-grep
implements --fixed-strings, but "git log --grep" didn't.


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
