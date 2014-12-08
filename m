From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 05/18] Allow demoting errors to warnings via receive.fsck.<key>
 = warn
Date: Mon, 8 Dec 2014 17:14:36 +0100 (CET)
Message-ID: <d81653ce9ef73a54a71613c3e9828ad21f2391d7.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:14:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0xX-0005vl-34
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbaLHQOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:14:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:51761 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbaLHQOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:14:41 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Ma1pn-1YGuBP3cFj-00LmJ7;
 Mon, 08 Dec 2014 17:14:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:424RCTxgHqHvVuRQQ9EB45Ppj14o9TaEY3u9OsxjOxtgAZzzggn
 k7YM689VKqOxe/NuJNTDeUFqN2l9D2/JhCtTu1/lRnRqW3rDLsHINiUviu0ph/SA/55guUo
 OivGJ/8MXA9Mw6HFyOXbZQ27+Oxu9un4Mr3TQJSHfeMLCtsAnMJhHNUmFmLj8f9zNNDUFll
 oCOgC9cz7tAkdpgme0doQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261057>

For example, missing emails in commit and tag objects can be demoted to
mere warnings with

	git config receive.fsck.missing-email warn

As git receive-pack does not actually perform the checks, it hands off
the setting to index-pack or unpack-objects in the form of an optional
argument to the --strict option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/index-pack.c     |  4 ++++
 builtin/receive-pack.c   | 27 +++++++++++++++++++++++----
 builtin/unpack-objects.c |  5 +++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1c17c3f..34a11b3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1565,6 +1565,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--strict")) {
 				strict = 1;
 				do_fsck_object = 1;
+			} else if (starts_with(arg, "--strict=")) {
+				strict = 1;
+				do_fsck_object = 1;
+				fsck_strict_mode(&fsck_options, arg + 9);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e908d07..111e514 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -35,6 +35,7 @@ static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static struct strbuf fsck_strict_mode = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
@@ -109,6 +110,14 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "receive.fsck.")) {
+		if (fsck_strict_mode.len)
+			strbuf_addch(&fsck_strict_mode, ',');
+		strbuf_addf(&fsck_strict_mode,
+			"%s=%s", var + 13, value ? value : "error");
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -1266,8 +1275,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
 			argv_array_push(&child.args, "-q");
-		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+		if (fsck_objects) {
+			if (fsck_strict_mode.len)
+				argv_array_pushf(&child.args, "--strict=%s",
+					fsck_strict_mode.buf);
+			else
+				argv_array_push(&child.args, "--strict");
+		}
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1284,8 +1298,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
-		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+		if (fsck_objects) {
+			if (fsck_strict_mode.len)
+				argv_array_pushf(&child.args, "--strict=%s",
+					fsck_strict_mode.buf);
+			else
+				argv_array_push(&child.args, "--strict");
+		}
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e9e8bec..916616f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -530,6 +530,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				strict = 1;
 				continue;
 			}
+			if (starts_with(arg, "--strict=")) {
+				strict = 1;
+				fsck_strict_mode(&fsck_options, arg + 9);
+				continue;
+			}
 			if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
-- 
2.0.0.rc3.9669.g840d1f9
