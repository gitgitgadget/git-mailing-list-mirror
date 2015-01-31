From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 05/19] fsck: Allow demoting errors to warnings
Date: Sat, 31 Jan 2015 22:05:07 +0100
Organization: gmx
Message-ID: <4d054c3aee1e0743828170841c0169b33b7485df.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:05:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfEF-00043Q-7I
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbbAaVFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:05:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:52368 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777AbbAaVFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:05:13 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Maa3B-1XxWsZ1cuf-00K8CR; Sat, 31 Jan 2015 22:05:10
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:0IHGJ9NhbPvbr9vsejp/KSwDt9DbytJ83/oHgJX7BAZf0cN3nIO
 pjZpd7AhdU62KuMQ+r62nR7tiR83XrPll+zUfq3d5cvQQehUHuRVyJxF4cC0XG58tYnvDok
 XfhcoDdUsf1A3aGqQ11MdS6XIZyrlsQhpDUTs6zqLyM3DtWHzufFuUTZjv2GQ3jNDzboGVf
 rxG9Zlxxkkqu79/kMeI9g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263214>

For example, missing emails in commit and tag objects can be demoted to
mere warnings with

	git config receive.fsck.severity missing-email=warn

The value is actually a comma-separated list.

In case that the same key is listed in multiple receive.fsck.severity
lines in the config, the latter configuration wins (this can happen for
example when both $HOME/.gitconfig and .git/config contain severity
settings).

As git receive-pack does not actually perform the checks, it hands off
the setting to index-pack or unpack-objects in the form of an optional
argument to the --strict option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/index-pack.c     |  4 ++++
 builtin/receive-pack.c   | 13 +++++++++++--
 builtin/unpack-objects.c |  5 +++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 925f7b5..b82b4dd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1565,6 +1565,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--strict")) {
 				strict = 1;
 				do_fsck_object = 1;
+			} else if (skip_prefix(arg, "--strict=", &arg)) {
+				strict = 1;
+				do_fsck_object = 1;
+				fsck_set_severity(&fsck_options, arg);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e0ce78e..9b7f1a8 100644
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
@@ -115,6 +116,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsck.severity") == 0) {
+		strbuf_addf(&fsck_severity, "%c%s",
+			fsck_severity.len ? ',' : '=', value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -1471,7 +1478,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+			argv_array_pushf(&child.args, "--strict%s",
+				fsck_severity.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1489,7 +1497,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+			argv_array_pushf(&child.args, "--strict%s",
+				fsck_severity.buf);
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6d17040..fe9117c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -530,6 +530,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				strict = 1;
 				continue;
 			}
+			if (skip_prefix(arg, "--strict=", &arg)) {
+				strict = 1;
+				fsck_set_severity(&fsck_options, arg);
+				continue;
+			}
 			if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
-- 
2.2.0.33.gc18b867
