From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Wed, 21 Jan 2015 20:23:48 +0100
Organization: gmx
Message-ID: <cover.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:23:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0se-0001Zg-WA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbbAUTXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:23:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:61752 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbbAUTXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:23:51 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LmbVT-1Xdr793QkF-00aHxT; Wed, 21 Jan 2015 20:23:48
 +0100
In-Reply-To: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:QdgWPnhcIaBiU/+OxFptxT/xuhL2iwPgJVc0srJ1JZaUcI2UDcv
 m7QSnvlTIaqAd9mvDTnEgWGcXcgpmz9T84BMlnDq7ozlzlqFg7vsNxO30r3eDTJ6sShS2FI
 ga/TYm+U2wos8wXYevaIu+iLr04o+WovkKcu5u9GRIDfjfjMcMnczStcBxm8fQDbt4f2xMS
 D+oQu6JC6ziXxxJHSRFIA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262745>

At the moment, the git-fsck's integrity checks are targeted toward the
end user, i.e. the error messages are really just messages, intended for
human consumption.

Under certain circumstances, some of those errors should be allowed to
be turned into mere warnings, though, because the cost of fixing the
issues might well be larger than the cost of carrying those flawed
objects. For example, when an already-public repository contains a
commit object with two authors for years, it does not make sense to
force the maintainer to rewrite the history, affecting all contributors
negatively by forcing them to update.

This branch introduces an internal fsck API to be able to turn some of
the errors into warnings, and to make it easier to call the fsck
machinery from elsewhere in general.

I am proud to report that this work has been sponsored by GitHub.

Interdiff vs v2 below the diffstat.

Johannes Schindelin (19):
  fsck: Introduce fsck options
  fsck: Introduce identifiers for fsck messages
  fsck: Provide a function to parse fsck message IDs
  fsck: Offer a function to demote fsck errors to warnings
  fsck: Allow demoting errors to warnings via receive.fsck.warn = <key>
  fsck: Report the ID of the error/warning
  fsck: Make fsck_ident() warn-friendly
  fsck: Make fsck_commit() warn-friendly
  fsck: Handle multiple authors in commits specially
  fsck: Make fsck_tag() warn-friendly
  fsck: Add a simple test for receive.fsck.*
  fsck: Disallow demoting grave fsck errors to warnings
  fsck: Optionally ignore specific fsck issues completely
  fsck: Allow upgrading fsck warnings to errors
  fsck: Document the new receive.fsck.* options.
  fsck: Support demoting errors to warnings
  fsck: Introduce `git fsck --quick`
  fsck: git receive-pack: support excluding objects from fsck'ing
  fsck: support ignoring objects in `git fsck` via fsck.skiplist

 Documentation/config.txt        |  57 +++++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  76 ++++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  24 +-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 525 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  27 ++-
 t/t1450-fsck.sh                 |  37 ++-
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  46 ++++
 11 files changed, 668 insertions(+), 162 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0daba8a..644411a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1208,7 +1208,9 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
 
-fsck.*::
+fsck.error::
+fsck.warn::
+fsck.ignore::
 	The `fsck.error`, `fsck.warn` and `fsck.ignore` settings specify
 	comma-separated lists of fsck message IDs which should trigger
 	fsck to error out, to print the message and continue, or to ignore
@@ -1221,6 +1223,13 @@ that setting `fsck.ignore = missing-email` will hide that issue.
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
 
+fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
@@ -2143,31 +2152,41 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
-receive.fsck.*::
+receive.fsck.error::
+receive.fsck.warn::
+receive.fsck.ignore::
 	When `receive.fsckObjects` is set to true, errors can be switched
 	to warnings and vice versa by configuring the `receive.fsck.*`
 	settings. These settings contain comma-separated lists of fsck
 	message IDs. For convenience, fsck prefixes the error/warning with
-	the message ID, e.g. "missing-email: invalid author/committer line
-	- missing email" means that setting `receive.fsck.ignore =
-	missing-email` will hide that issue.
+	the message ID, e.g. "missing-email: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.ignore = missing-email` will hide that issue.
 +
 --
-	error::
-		a comma-separated list of fsck message IDs that should be
-		trigger fsck to error out.
-	warn::
-		a comma-separated list of fsck message IDs that should be
-		displayed, but fsck should continue to error out.
-	ignore::
-		a comma-separated list of fsck message IDs that should be
-		ignored completely.
+error;;
+	a comma-separated list of fsck message IDs that should be
+	trigger fsck to error out.
+warn;;
+	a comma-separated list of fsck message IDs that should be
+	displayed, but fsck should continue to error out.
+ignore;;
+	a comma-separated list of fsck message IDs that should be
+	ignored completely.
+--
 +
 This feature is intended to support working with legacy repositories
 which would not pass pushing when `receive.fsckObjects = true`, allowing
-the host to accept repositories certain known issues but still catch
+the host to accept repositories with certain known issues but still catch
 other issues.
 
+receive.fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c767909..760b4bd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -49,9 +49,19 @@ static int show_dangling = 1;
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
-	if (starts_with(var, "fsck.")) {
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
 		struct strbuf sb = STRBUF_INIT;
-		strbuf_addf(&sb, "%s=%s", var + 5, value);
+		strbuf_addf(&sb, "skiplist=%s", path);
+		fsck_set_severity(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	if (skip_prefix(var, "fsck.", &var)) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "%s=%s", var, value);
 		fsck_set_severity(&fsck_obj_options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f464ca0..b82b4dd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1565,10 +1565,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--strict")) {
 				strict = 1;
 				do_fsck_object = 1;
-			} else if (starts_with(arg, "--strict=")) {
+			} else if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
-				fsck_set_severity(&fsck_options, arg + 9);
+				fsck_set_severity(&fsck_options, arg);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 40514c2..8e6d1a1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -116,7 +116,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (starts_with(var, "receive.fsck.skiplist")) {
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
 		const char *path = is_absolute_path(value) ?
 			value : git_path("%s", value);
 		if (fsck_severity.len)
@@ -125,10 +125,9 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (starts_with(var, "receive.fsck.")) {
-		if (fsck_severity.len)
-			strbuf_addch(&fsck_severity, ',');
-		strbuf_addf(&fsck_severity, "%s=%s", var + 13, value);
+	if (skip_prefix(var, "receive.fsck.", &var)) {
+		strbuf_addf(&fsck_severity, "%s%s=%s",
+			fsck_severity.len ? "," : "", var, value);
 		return 0;
 	}
 
@@ -1487,13 +1486,10 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
 			argv_array_push(&child.args, "-q");
-		if (fsck_objects) {
-			if (fsck_severity.len)
-				argv_array_pushf(&child.args, "--strict=%s",
-					fsck_severity.buf);
-			else
-				argv_array_push(&child.args, "--strict");
-		}
+		if (fsck_objects)
+			argv_array_pushf(&child.args, "--strict%s%s",
+				fsck_severity.len ? "=" : "",
+				fsck_severity.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1510,13 +1506,10 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
-		if (fsck_objects) {
-			if (fsck_severity.len)
-				argv_array_pushf(&child.args, "--strict=%s",
-					fsck_severity.buf);
-			else
-				argv_array_push(&child.args, "--strict");
-		}
+		if (fsck_objects)
+			argv_array_pushf(&child.args, "--strict%s%s",
+				fsck_severity.len ? "=" : "",
+				fsck_severity.buf);
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 82f2d62..fe9117c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -530,9 +530,9 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				strict = 1;
 				continue;
 			}
-			if (starts_with(arg, "--strict=")) {
+			if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
-				fsck_set_severity(&fsck_options, arg + 9);
+				fsck_set_severity(&fsck_options, arg);
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
diff --git a/fsck.c b/fsck.c
index dbf9fa1..15cb8bd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -169,7 +169,7 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 
 	if (!options->msg_severity) {
 		int i;
-		int *msg_severity = malloc(sizeof(int) * FSCK_MSG_MAX);
+		int *msg_severity = xmalloc(sizeof(int) * FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
 			msg_severity[i] = fsck_msg_severity(i, options);
 		options->msg_severity = msg_severity;
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 21fa9c8..d367bb2 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,7 +115,7 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >bogus-commit << EOF
+cat >bogus-commit <<\EOF
 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
 author Bugs Bunny 1234567890 +0000
 committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
-- 
2.2.0.33.gc18b867
