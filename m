From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] log: --date and --no-date to toggle reflog dates
Date: Tue, 28 Jul 2009 10:40:21 +0200
Message-ID: <3fda7b9318674f9516f54f2c095148e79b6b3731.1248770042.git.trast@student.ethz.ch>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 10:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MViEn-0002f8-P1
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZG1Ikg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZG1Ikg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:40:36 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20204 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbZG1Ike (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:40:34 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 10:40:31 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 10:40:31 +0200
X-Mailer: git-send-email 1.6.4.rc3.218.g43757
In-Reply-To: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 28 Jul 2009 08:40:31.0195 (UTC) FILETIME=[10D16AB0:01CA0F5F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124223>

Introduce two new options that help the user, especially in the case
where log.date is set to some value other than "normal":

--date: equivalent to --date=normal if it was previously "default"
--no-date: equivalent to --date=default

This means that 'git reflog --date' will always show reflog entries by
date, and 'git reflog --no-date' won't even if log.date is set.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-list.txt     |    2 +-
 Documentation/rev-list-options.txt |   11 ++++++++++-
 revision.c                         |    5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 6f2013b..023a595 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -36,7 +36,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date={local|relative|normal|default|iso|rfc|short} ]
+	     [ \--date[={local|relative|normal|default|iso|rfc|short}] ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2a106bd..e83e8bd 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,normal,default,iso,rfc,short,raw}::
+--date[={relative,local,normal,default,iso,rfc,short,raw}]::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
@@ -38,6 +38,15 @@ format, often found in E-mail messages.
 +
 `--date=default` is like `normal`, except for reflog entries where the
 entry number is shown instead.
++
+`--date` sets the date display to `normal` if it was previously
+`default`, so it serves as a shorthand to display reflog entries with
+date instead of number.
+
+--no-date::
+
+	Synonym for `--date=default`, so named because it causes
+	reflog entries to be shown by number instead of date.
 
 ifdef::git-rev-list[]
 --header::
diff --git a/revision.c b/revision.c
index 9f5dac5..941f631 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,6 +1159,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
 		revs->date_mode = DATE_RELATIVE;
+	} else if (!strcmp(arg, "--date")) {
+		if (!revs->date_mode)
+			revs->date_mode = DATE_NORMAL;
+	} else if (!strcmp(arg, "--no-date")) {
+		revs->date_mode = DATE_DEFAULT;
 	} else if (!strncmp(arg, "--date=", 7)) {
 		revs->date_mode = parse_date_format(arg + 7);
 	} else if (!strcmp(arg, "--log-size")) {
-- 
1.6.4.rc3.218.gb7ac
