From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach for-each-ref about a little language called Tcl.
Date: Sat, 27 Jan 2007 02:22:58 -0500
Message-ID: <20070127072258.GA10512@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 08:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAhu5-0004xr-0Y
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 08:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbXA0HXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 02:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbXA0HXF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 02:23:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49999 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbXA0HXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 02:23:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAhts-0000yS-0f; Sat, 27 Jan 2007 02:23:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 779A720FBAE; Sat, 27 Jan 2007 02:22:58 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37928>

Love it or hate it, some people actually still program in Tcl.  Some
of those programs are meant for interfacing with Git.  Programs such as
gitk and git-gui.  It may be useful to have Tcl-safe output available
from for-each-ref, just like shell, Perl and Python already enjoy.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-for-each-ref.txt |    4 ++--
 builtin-for-each-ref.c             |   10 ++++++++++
 quote.c                            |   16 ++++++++++++++++
 quote.h                            |    1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 06e7ab1..da52eba 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -7,7 +7,7 @@ git-for-each-ref - Output information on each ref
 
 SYNOPSIS
 --------
-'git-for-each-ref' [--count=<count>]\* [--shell|--perl|--python] [--sort=<key>]\* [--format=<format>] [<pattern>]
+'git-for-each-ref' [--count=<count>]\* [--shell|--perl|--python|--tcl] [--sort=<key>]\* [--format=<format>] [<pattern>]
 
 DESCRIPTION
 -----------
@@ -49,7 +49,7 @@ OPTIONS
 	using fnmatch(3).  Refs that do not match the pattern
 	are not shown.
 
---shell, --perl, --python::
+--shell, --perl, --python, --tcl::
 	If given, strings that substitute `%(fieldname)`
 	placeholders are quoted as string literals suitable for
 	the specified host language.  This is meant to produce
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index af72a12..9d5f266 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -12,6 +12,7 @@
 #define QUOTE_SHELL 1
 #define QUOTE_PERL 2
 #define QUOTE_PYTHON 3
+#define QUOTE_TCL 4
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -723,6 +724,9 @@ static void print_value(struct refinfo *ref, int atom, int quote_style)
 	case QUOTE_PYTHON:
 		python_quote_print(stdout, v->s);
 		break;
+	case QUOTE_TCL:
+		tcl_quote_print(stdout, v->s);
+		break;
 	}
 }
 
@@ -834,6 +838,12 @@ int cmd_for_each_ref(int ac, const char **av, char *prefix)
 			quote_style = QUOTE_PYTHON;
 			continue;
 		}
+		if (!strcmp(arg, "--tcl") ) {
+			if (0 <= quote_style)
+				die("more than one quoting style?");
+			quote_style = QUOTE_TCL;
+			continue;
+		}
 		if (!strncmp(arg, "--count=", 8)) {
 			if (maxcount)
 				die("more than one --count?");
diff --git a/quote.c b/quote.c
index a418a0f..ab0e971 100644
--- a/quote.c
+++ b/quote.c
@@ -387,3 +387,19 @@ void python_quote_print(FILE *stream, const char *src)
 	}
 	fputc(sq, stream);
 }
+
+void tcl_quote_print(FILE *stream, const char *src)
+{
+	const char lb = '{';
+	const char rb = '}';
+	const char bq = '\\';
+	char c;
+
+	fputc(lb, stream);
+	while ((c = *src++)) {
+		if (c == lb || c == rb || c == bq)
+			fputc(bq, stream);
+		fputc(c, stream);
+	}
+	fputc(rb, stream);
+}
diff --git a/quote.h b/quote.h
index b55e699..bdc3610 100644
--- a/quote.h
+++ b/quote.h
@@ -55,5 +55,6 @@ extern void write_name_quoted(const char *prefix, int prefix_len,
 /* quoting as a string literal for other languages */
 extern void perl_quote_print(FILE *stream, const char *src);
 extern void python_quote_print(FILE *stream, const char *src);
+extern void tcl_quote_print(FILE *stream, const char *src);
 
 #endif
-- 
1.5.0.rc2.g8a816
