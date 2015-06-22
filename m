From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 05/19] fsck (receive-pack): Allow demoting errors to
 warnings
Date: Mon, 22 Jun 2015 17:25:31 +0200
Organization: gmx
Message-ID: <639965f17eef7a0fc05af7ee4e2b064a8d1737ce.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73bR-0006WR-Jb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbbFVPZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:25:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:57092 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbbFVPZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:25:33 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MMTEM-1ZAvDe1sHm-008NaF; Mon, 22 Jun 2015 17:25:32
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:zAqP1o1H5tNYp3Jq4RMj2lbIq98AaoyiZp1nrO9S/svhuTbFyAL
 Y/kskyFZCGj83BFE8vZSclx8CbubPkQdBiLpo7SGsoKkPKoMjD5MRUInnfjF16oxuF5fMsh
 /m2PuGmJmPy6wtprf7XaK1VZchED7hdyfyqucA7B8GCzNLoxdDj8W5b+gjSK44Z6nwcgjBk
 Ym11CQzO03MS/E6dOe3TQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272376>

For example, missing emails in commit and tag objects can be demoted to
mere warnings with

	git config receive.fsck.missingemail=warn

The value is actually a comma-separated list.

In case that the same key is listed in multiple receive.fsck.<msg-id>
lines in the config, the latter configuration wins (this can happen for
example when both $HOME/.gitconfig and .git/config contain message type
settings).

As git receive-pack does not actually perform the checks, it hands off
the setting to index-pack or unpack-objects in the form of an optional
argument to the --strict option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/index-pack.c     |  4 ++++
 builtin/receive-pack.c   | 17 +++++++++++++++--
 builtin/unpack-objects.c |  5 +++++
 fsck.c                   |  8 ++++++++
 fsck.h                   |  1 +
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f8b0c64..f0d283b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1633,6 +1633,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--strict")) {
 				strict = 1;
 				do_fsck_object = 1;
+			} else if (skip_prefix(arg, "--strict=", &arg)) {
+				strict = 1;
+				do_fsck_object = 1;
+				fsck_set_msg_types(&fsck_options, arg);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d0571..3afe8f8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -19,6 +19,7 @@
 #include "tag.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
+#include "fsck.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -36,6 +37,7 @@ static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
@@ -115,6 +117,15 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (skip_prefix(var, "receive.fsck.", &var)) {
+		if (is_valid_msg_type(var, value))
+			strbuf_addf(&fsck_msg_types, "%c%s=%s",
+				fsck_msg_types.len ? ',' : '=', var, value);
+		else
+			warning("Skipping unknown msg id '%s'", var);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -1490,7 +1501,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+			argv_array_pushf(&child.args, "--strict%s",
+				fsck_msg_types.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1508,7 +1520,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+			argv_array_pushf(&child.args, "--strict%s",
+				fsck_msg_types.buf);
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6d17040..7cc086f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -530,6 +530,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				strict = 1;
 				continue;
 			}
+			if (skip_prefix(arg, "--strict=", &arg)) {
+				strict = 1;
+				fsck_set_msg_types(&fsck_options, arg);
+				continue;
+			}
 			if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
diff --git a/fsck.c b/fsck.c
index e81a342..02af3ed 100644
--- a/fsck.c
+++ b/fsck.c
@@ -131,6 +131,14 @@ static int parse_msg_type(const char *str)
 		die("Unknown fsck message type: '%s'", str);
 }
 
+int is_valid_msg_type(const char *msg_id, const char *msg_type)
+{
+	if (parse_msg_id(msg_id) < 0)
+		return 0;
+	parse_msg_type(msg_type);
+	return 1;
+}
+
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id, const char *msg_type)
 {
diff --git a/fsck.h b/fsck.h
index af3c84e..3ef92a3 100644
--- a/fsck.h
+++ b/fsck.h
@@ -9,6 +9,7 @@ struct fsck_options;
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
+int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
 /*
  * callback function for fsck_walk
-- 
2.3.1.windows.1.9.g8c01ab4
