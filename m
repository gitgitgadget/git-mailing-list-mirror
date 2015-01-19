From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 05/18] fsck: Allow demoting errors to warnings via  receive.fsck.warn =?UTF-8?Q?=3D=20=3Ckey=3E?=
Date: Mon, 19 Jan 2015 16:50:32 +0100
Organization: gmx
Message-ID: <3fd56573b263f2a4551c9a363d1a44728573a1c6.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjx-0006J3-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbbASP7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:43 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751744AbbASP7l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:41 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFoWfs026281;
	Mon, 19 Jan 2015 16:50:32 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFoWd2026280;
	Mon, 19 Jan 2015 16:50:32 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262625>

For example, missing emails in commit and tag objects can be demoted to
mere warnings with

	git config receive.fsck.warn = missing-email

The value is actually a comma-separated list, and there is a
corresponding receive.fsck.error setting.

In case that the same key is listed in multiple receive.fsck.* lines in
the config, the latter configuration wins.

As git receive-pack does not actually perform the checks, it hands off
the setting to index-pack or unpack-objects in the form of an optional
argument to the --strict option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/index-pack.c     |  4 ++++
 builtin/receive-pack.c   | 26 ++++++++++++++++++++++----
 builtin/unpack-objects.c |  5 +++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 925f7b5..f464ca0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1565,6 +1565,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--strict")) {
 				strict = 1;
 				do_fsck_object = 1;
+			} else if (starts_with(arg, "--strict=")) {
+				strict = 1;
+				do_fsck_object = 1;
+				fsck_set_severity(&fsck_options, arg + 9);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e0ce78e..da2e019 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -36,6 +36,7 @@ static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static struct strbuf fsck_severity = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
@@ -115,6 +116,13 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "receive.fsck.")) {
+		if (fsck_severity.len)
+			strbuf_addch(&fsck_severity, ',');
+		strbuf_addf(&fsck_severity, "%s=%s", var + 13, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -1470,8 +1478,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
 			argv_array_push(&child.args, "-q");
-		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+		if (fsck_objects) {
+			if (fsck_severity.len)
+				argv_array_pushf(&child.args, "--strict=%s",
+					fsck_severity.buf);
+			else
+				argv_array_push(&child.args, "--strict");
+		}
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1488,8 +1501,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
-		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+		if (fsck_objects) {
+			if (fsck_severity.len)
+				argv_array_pushf(&child.args, "--strict=%s",
+					fsck_severity.buf);
+			else
+				argv_array_push(&child.args, "--strict");
+		}
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6d17040..82f2d62 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -530,6 +530,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				strict = 1;
 				continue;
 			}
+			if (starts_with(arg, "--strict=")) {
+				strict = 1;
+				fsck_set_severity(&fsck_options, arg + 9);
+				continue;
+			}
 			if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
-- 
2.0.0.rc3.9669.g840d1f9
