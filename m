From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 05/19] fsck: Allow demoting errors to warnings via
 receive.fsck.warn =?UTF-8?Q?=3D=20=3Ckey=3E?=
Date: Wed, 21 Jan 2015 20:24:49 +0100
Organization: gmx
Message-ID: <858d4121150caa63276c392252bd4a476f89adf3.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0tf-00029f-C2
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbbAUTYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:24:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:56405 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbbAUTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:24:54 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LvUwp-1XmYG91Lu7-010bCz; Wed, 21 Jan 2015 20:24:50
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:c3CioWtGDkO2MEIf89GYqbhFHkwfLFthhEuqZPYk5zJWqwF5SM0
 AoDxxv0CE7ihOdJL4xFKpdLQwBsE7JcvDT76qfDXc+TBfDhDq87VjwnSLGhH8lJdXCYAR86
 R9UziwkguU5mCVHCWDRsF2o+2UKut/l7fY70+afS0ayXLMqmZUJorhl/cG58DuQrxHm6X6F
 cYYQa6srA9CflmaqOa/+A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262750>

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
 builtin/receive-pack.c   | 15 +++++++++++++--
 builtin/unpack-objects.c |  5 +++++
 3 files changed, 22 insertions(+), 2 deletions(-)

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
index e0ce78e..18d5012 100644
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
 
+	if (skip_prefix(var, "receive.fsck.", &var)) {
+		strbuf_addf(&fsck_severity, "%s%s=%s",
+			fsck_severity.len ? "," : "", var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -1471,7 +1478,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+			argv_array_pushf(&child.args, "--strict%s%s",
+				fsck_severity.len ? "=" : "",
+				fsck_severity.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1489,7 +1498,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			argv_array_push(&child.args, "--strict");
+			argv_array_pushf(&child.args, "--strict%s%s",
+				fsck_severity.len ? "=" : "",
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
