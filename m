From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v2 2/4] ls-tree: complete conversion to using output
	library
Date: Mon, 12 Apr 2010 00:21:15 +0100
Message-ID: <20100411232118.67460.12125.julian@quantumfyre.co.uk>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Cc: Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 01:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16We-0000OT-4Z
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab0DKXYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:24:46 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:38489 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752967Ab0DKXYp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:24:45 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 378C5819C6C7;
	Mon, 12 Apr 2010 00:24:38 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id D9E2420CF4F;
	Mon, 12 Apr 2010 00:24:43 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SHaspb4FUDBX; Mon, 12 Apr 2010 00:24:43 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id F36BC20CF51;
	Mon, 12 Apr 2010 00:24:42 +0100 (BST)
X-git-sha1: 4bdb9a9227ac9962721a4340cb8545d4609a1996 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144692>

All output from ls-tree now goes through the output library - even the
regular output.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/ls-tree.c |   51 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dc86b0d..7e19d19 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -10,8 +10,8 @@
 #include "quote.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "output.h"
 
-static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
 #define LS_SHOW_TREES 4
@@ -22,6 +22,7 @@ static int ls_options;
 static const char **pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+static struct output_context *oc;
 
 static const  char * const ls_tree_usage[] = {
 	"git ls-tree [<options>] <tree-ish> [path...]",
@@ -90,27 +91,32 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	    (baselen < chomp_prefix || memcmp(ls_tree_prefix, base, chomp_prefix)))
 		return 0;
 
+	output_start_object(oc, "entry");
 	if (!(ls_options & LS_NAME_ONLY)) {
+		output_strf(oc, "mode", "%06o", mode);
+		output_token(oc, " ");
+		output_str(oc, "type", type);
+		output_token(oc, " ");
+		output_str(oc, "hash", find_unique_abbrev(sha1, abbrev));
 		if (ls_options & LS_SHOW_SIZE) {
-			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (strcmp(type, blob_type)) {
+				output_token(oc, "       -");
+			} else {
 				unsigned long size;
+				output_token(oc, " ");
+				output_next_directive(oc, "7");
 				if (sha1_object_info(sha1, &size) == OBJ_BAD)
-					strcpy(size_text, "BAD");
+					output_str(oc, "size", "BAD");
 				else
-					snprintf(size_text, sizeof(size_text),
-						 "%lu", size);
-			} else
-				strcpy(size_text, "-");
-			printf("%06o %s %s %7s\t", mode, type,
-			       find_unique_abbrev(sha1, abbrev),
-			       size_text);
-		} else
-			printf("%06o %s %s\t", mode, type,
-			       find_unique_abbrev(sha1, abbrev));
+					output_uint(oc, "size", size);
+			}
+		}
+		output_token(oc, "\t");
 	}
-	write_name_quotedpfx(base + chomp_prefix, baselen - chomp_prefix,
-			  pathname, stdout, line_termination);
+	output_strf(oc, "path", "%.*s%s", baselen - chomp_prefix,
+		    base + chomp_prefix, pathname);
+	output_newline(oc);
+	output_end_current(oc);
 	return retval;
 }
 
@@ -119,6 +125,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct tree *tree;
 	int full_tree = 0;
+	char *structured_output_arg = NULL;
+	enum output_style output_style;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, "only show trees",
 			LS_TREE_ONLY),
@@ -126,8 +134,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_RECURSIVE),
 		OPT_BIT('t', NULL, &ls_options, "show trees when recursing",
 			LS_SHOW_TREES),
-		OPT_SET_INT('z', NULL, &line_termination,
-			    "terminate entries with NUL byte", 0),
 		OPT_BIT('l', "long", &ls_options, "include object size",
 			LS_SHOW_SIZE),
 		OPT_BIT(0, "name-only", &ls_options, "list only filenames",
@@ -140,6 +146,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    "list entire tree; not just current directory "
 			    "(implies --full-name)"),
 		OPT__ABBREV(&abbrev),
+		OPT_OUTPUT('z', "output", &structured_output_arg),
 		OPT_END()
 	};
 
@@ -159,6 +166,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
+	output_style = handle_output_arg(structured_output_arg);
+
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_sha1(argv[0], sha1))
@@ -168,7 +177,13 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
+
+	oc = output_start(output_style);
+	output_start_array(oc, "entries");
+
 	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree, NULL);
 
+	output_end(oc);
+
 	return 0;
 }
-- 
1.7.0.4
