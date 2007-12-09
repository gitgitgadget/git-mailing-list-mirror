From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/4] Move the file read logic to read_patch_file() in builtin-apply.c
Date: Sun,  9 Dec 2007 18:04:59 +0100
Message-ID: <1197219900-19334-3-git-send-email-mh@glandium.org>
References: 20071209170250.GA18955@glandium.org
 <1197219900-19334-1-git-send-email-mh@glandium.org>
 <1197219900-19334-2-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 18:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Pap-0008I0-5B
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 18:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXLIRFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 12:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbXLIRFE
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 12:05:04 -0500
Received: from smtp2f.orange.fr ([80.12.242.152]:54669 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbXLIRFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 12:05:03 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f17.orange.fr (SMTP Server) with ESMTP id DD09470000A8
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 18:05:01 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2f17.orange.fr (SMTP Server) with ESMTP id 9FF0770000A0;
	Sun,  9 Dec 2007 18:05:01 +0100 (CET)
X-ME-UUID: 20071209170501655.9FF0770000A0@mwinf2f17.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1PaP-00052E-3z; Sun, 09 Dec 2007 18:05:01 +0100
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197219900-19334-2-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67632>

This will allow to extend the read logic further. We also return a better
error message than usage() when the given filename can't be opened, and
avoid whitespace options not being set when reading from stdin with the
"-" argument as a side effect.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin-apply.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f2e9a33..8c8162a 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -182,11 +182,23 @@ static void say_patch_name(FILE *output, const char *pre,
 #define CHUNKSIZE (8192)
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, int fd)
+static void read_patch_file(struct strbuf *sb, const char *filename)
 {
+	int fd;
+
+	if (!strcmp(filename, "-")) {
+		fd = 0;
+	} else {
+		fd = open(filename, O_RDONLY);
+		if (fd < 0)
+			die("git-apply: could not open %s: %s", filename,
+			    strerror(errno));
+	}
+
 	if (strbuf_read(sb, fd, 0) < 0)
 		die("git-apply: read returned %s", strerror(errno));
 
+	close(fd);
 	/*
 	 * Make sure that we have some slop in the buffer
 	 * so that we can do speculative "memcmp" etc, and
@@ -2705,7 +2717,7 @@ static void prefix_patches(struct patch *p)
 	}
 }
 
-static int apply_patch(int fd, const char *filename, int inaccurate_eof)
+static int apply_patch(const char *filename, int inaccurate_eof)
 {
 	size_t offset;
 	struct strbuf buf;
@@ -2714,7 +2726,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 	strbuf_init(&buf, 0);
 	patch_input_file = filename;
-	read_patch_file(&buf, fd);
+	read_patch_file(&buf, filename);
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
@@ -2807,13 +2819,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		char *end;
-		int fd;
 
-		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", inaccurate_eof);
-			read_stdin = 0;
-			continue;
-		}
 		if (!prefixcmp(arg, "--exclude=")) {
 			struct excludes *x = xmalloc(sizeof(*x));
 			x->path = arg + 10;
@@ -2916,17 +2922,13 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
-		fd = open(arg, O_RDONLY);
-		if (fd < 0)
-			usage(apply_usage);
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		errs |= apply_patch(fd, arg, inaccurate_eof);
-		close(fd);
+		errs |= apply_patch(arg, inaccurate_eof);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+		errs |= apply_patch("-", inaccurate_eof);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
-- 
1.5.3.7
