From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-config: respect other options after -l, most notably --file
Date: Tue, 9 Oct 2007 12:50:24 +0000
Message-ID: <20071009125024.1259.qmail@d8e601127fe8d0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 14:50:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEXP-0003kF-PU
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXJIMuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbXJIMuF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:50:05 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56384 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752568AbXJIMuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:50:04 -0400
Received: (qmail 1260 invoked by uid 1000); 9 Oct 2007 12:50:24 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60397>

When git-commit is seeing the -l|--list option, it stops reading the
following command line options.  So although they should be the same,
the following commands act differently:

 git config --file ../repo2/.git/config -l
 git config -l --file ../repo2/.git/config

This patch delays the 'list all variables' to after the command line
options have been processed.

The problem was noticed by Joey Hess, reported through
 http://bugs.debian.org/445208

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-config.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index c2708ba..1bb0ebb 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -8,6 +8,7 @@ static char *key;
 static regex_t *key_regexp;
 static regex_t *regexp;
 static int show_keys;
+static int show_all;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
@@ -173,7 +174,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
-			return git_config(show_all_config);
+			show_all = 1;
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
@@ -234,6 +235,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		argv++;
 	}
 
+	if (show_all)
+		return git_config(show_all_config);
 	switch (argc) {
 	case 2:
 		return get_value(argv[1], NULL);
-- 
1.5.3.4
