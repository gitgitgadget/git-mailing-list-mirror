From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] help: fix configured help format taking over command line one
Date: Sat, 09 Jan 2010 06:10:05 +0100
Message-ID: <20100109051006.3569.45440.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerrit Pape <pape@smarden.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 06:09:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTTYl-0002OZ-12
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 06:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940Ab0AIFIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 00:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917Ab0AIFIS
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 00:08:18 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52012 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab0AIFIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 00:08:18 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A906381806A;
	Sat,  9 Jan 2010 06:08:10 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6C445818049;
	Sat,  9 Jan 2010 06:08:07 +0100 (CET)
X-git-sha1: 990e3ed17a4785c2821bd726c2e8c37f2e0d1b3f 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136514>

Since commit 7c3baa9 (help -a: do not unnecessarily look for a
repository, 2009-09-04), the help format that is passed as a
command line option is not used if an help format has been
configured. This patch fixes that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-help.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 09ad4b0..3182a2b 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -23,13 +23,14 @@ static struct man_viewer_info_list {
 } *man_viewer_info_list;
 
 enum help_format {
+	HELP_FORMAT_NONE,
 	HELP_FORMAT_MAN,
 	HELP_FORMAT_INFO,
 	HELP_FORMAT_WEB,
 };
 
 static int show_all = 0;
-static enum help_format help_format = HELP_FORMAT_MAN;
+static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
 	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
 	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
@@ -415,10 +416,12 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
 	const char *alias;
+	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
+	parsed_help_format = help_format;
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -437,6 +440,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
 
+	if (parsed_help_format != HELP_FORMAT_NONE)
+		help_format = parsed_help_format;
+
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
 		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
@@ -444,6 +450,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	switch (help_format) {
+	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
 		show_man_page(argv[0]);
 		break;
-- 
1.6.6.271.gc8799
