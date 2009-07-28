From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 10:40:20 +0200
Message-ID: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 10:41:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MViEn-0002f8-1Z
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbZG1Ike (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbZG1Ikd
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:40:33 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20204 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbZG1Ikc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:40:32 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 10:40:31 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 10:40:31 +0200
X-Mailer: git-send-email 1.6.4.rc3.218.g43757
X-OriginalArrivalTime: 28 Jul 2009 08:40:31.0039 (UTC) FILETIME=[10B99CF0:01CA0F5F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124224>

The reflog case special-cases --date=default (internally DATE_NORMAL)
to show the entry number instead of a date.  This means it is
impossible to show the default date format for the reflog entries.

Introduce a new state DATE_DEFAULT (for the existing --date=default)
that takes over the special value 0, and have DATE_NORMAL (for the new
--date=normal) act the same except in the reflog code where we still
special-case the value 0.  This means that 'git log -g --date=normal'
shows the date, whereas 'git log -g --date=default' shows the reflog
entry number.

Thanks to Johannes Schindelin for IRC help.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-list.txt     |    2 +-
 Documentation/rev-list-options.txt |    7 +++++--
 builtin-blame.c                    |    1 +
 cache.h                            |    3 ++-
 date.c                             |    2 ++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index a765cfa..6f2013b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -36,7 +36,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date={local|relative|default|iso|rfc|short} ]
+	     [ \--date={local|relative|normal|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bf66116..2a106bd 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default,iso,rfc,short,raw}::
+--date={relative,local,normal,default,iso,rfc,short,raw}::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
@@ -33,8 +33,11 @@ format, often found in E-mail messages.
 +
 `--date=raw` shows the date in the internal raw git format `%s %z` format.
 +
-`--date=default` shows timestamps in the original timezone
+`--date=normal` shows timestamps in the original timezone
 (either committer's or author's).
++
+`--date=default` is like `normal`, except for reflog entries where the
+entry number is shown instead.
 
 ifdef::git-rev-list[]
 --header::
diff --git a/builtin-blame.c b/builtin-blame.c
index fd6ca51..9671c20 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2288,6 +2288,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		/* "normal" is used as the fallback for "relative" */
 	case DATE_LOCAL:
 	case DATE_NORMAL:
+	case DATE_DEFAULT:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	}
diff --git a/cache.h b/cache.h
index e6c7f33..a62ce78 100644
--- a/cache.h
+++ b/cache.h
@@ -712,7 +712,8 @@ static inline unsigned int hexval(unsigned char c)
 				   struct object *o, enum object_type);
 
 enum date_mode {
-	DATE_NORMAL = 0,
+	DATE_DEFAULT = 0,
+	DATE_NORMAL,
 	DATE_RELATIVE,
 	DATE_SHORT,
 	DATE_LOCAL,
diff --git a/date.c b/date.c
index 409a17d..661dd24 100644
--- a/date.c
+++ b/date.c
@@ -637,6 +637,8 @@ enum date_mode parse_date_format(const char *format)
 	else if (!strcmp(format, "local"))
 		return DATE_LOCAL;
 	else if (!strcmp(format, "default"))
+		return DATE_DEFAULT;
+	else if (!strcmp(format, "normal"))
 		return DATE_NORMAL;
 	else if (!strcmp(format, "raw"))
 		return DATE_RAW;
-- 
1.6.4.rc3.218.gb7ac
