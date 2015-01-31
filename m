From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Sat, 31 Jan 2015 22:04:25 +0100
Organization: gmx
Message-ID: <cover.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfDg-0003gN-3A
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbbAaVEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:04:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:59863 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbbAaVEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:04:34 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MAhTr-1YOZuK1WFH-00BrqF; Sat, 31 Jan 2015 22:04:27
 +0100
In-Reply-To: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:eZib7/jJTJrLpkSsXAeyMKkrBzg+Zy6wyT9p2Sf1Pv+3FtsAhRt
 s3joWmIui/TWxxwYSjtV5umKWE+GWQNlJMA4mWCnqSn//+q07SwKaYVwxVexgj2eacHrFi4
 eDlkThZ6vHHe+FOXJRq+Qbciy/up5LGJr5fFRMYD3ERGcEYxAAIPazfOnFJmoiqznkoW+J7
 8wDe1aOfvqc4knLV9z+6g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263210>

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

Changes vs v3: address Junio's concern regarding repeated patterns,
heed Peff's advice to avoid that pesky clang warning re: unsigned enums,
use the fsck.skiplist setting in builtin/fsck.c (not
receive.fsck.skiplist), and switch to fsck.severity to address Michael's
concerns that letting fsck.(error|warn|ignore)'s comma-separated lists
possibly overriding each other partially; interdiff below the diffstat.

Johannes Schindelin (19):
  fsck: Introduce fsck options
  fsck: Introduce identifiers for fsck messages
  fsck: Provide a function to parse fsck message IDs
  fsck: Offer a function to demote fsck errors to warnings
  fsck: Allow demoting errors to warnings
  fsck: Report the ID of the error/warning
  fsck: Make fsck_ident() warn-friendly
  fsck: Make fsck_commit() warn-friendly
  fsck: Handle multiple authors in commits specially
  fsck: Make fsck_tag() warn-friendly
  fsck: Add a simple test for receive.fsck.severity
  fsck: Disallow demoting grave fsck errors to warnings
  fsck: Optionally ignore specific fsck issues completely
  fsck: Allow upgrading fsck warnings to errors
  fsck: Document the new receive.fsck.severity options.
  fsck: Support demoting errors to warnings
  fsck: Introduce `git fsck --quick`
  fsck: git receive-pack: support excluding objects from fsck'ing
  fsck: support ignoring objects in `git fsck` via fsck.skiplist

 Documentation/config.txt        |  41 ++++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  73 ++++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  21 +-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 532 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  27 +-
 t/t1450-fsck.sh                 |  37 ++-
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  49 ++++
 11 files changed, 656 insertions(+), 162 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 644411a..93c43d5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1208,17 +1208,14 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
 
-fsck.error::
-fsck.warn::
-fsck.ignore::
-	The `fsck.error`, `fsck.warn` and `fsck.ignore` settings specify
-	comma-separated lists of fsck message IDs which should trigger
-	fsck to error out, to print the message and continue, or to ignore
-	said messages, respectively.
+fsck.severity::
+	A comma-separated lists of of the form `<id>=<level>` where `<id>`
+	denotes a fsck message ID such as `missing-email` and `<level>` is
+	one of `error`, `warn` and `ignore`.
 +
-For convenience, fsck prefixes the error/warning with the name of the option,
+For convenience, fsck prefixes the error/warning with the message ID,
 e.g.  "missing-email: invalid author/committer line - missing email" means
-that setting `fsck.ignore = missing-email` will hide that issue.
+that setting `fsck.severity = missing-email=ignore` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
@@ -2152,28 +2149,15 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
-receive.fsck.error::
-receive.fsck.warn::
-receive.fsck.ignore::
+receive.fsck.severity::
 	When `receive.fsckObjects` is set to true, errors can be switched
-	to warnings and vice versa by configuring the `receive.fsck.*`
-	settings. These settings contain comma-separated lists of fsck
-	message IDs. For convenience, fsck prefixes the error/warning with
-	the message ID, e.g. "missing-email: invalid
+	to warnings and vice versa by configuring the `receive.fsck.severity`
+	setting. These settings contain comma-separated lists of the form
+	`<id>=<level>` where the `<id>` is the fsck message ID and the level
+	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
+	the error/warning with the message ID, e.g. "missing-email: invalid
 	author/committer line - missing email" means that setting
-	`receive.fsck.ignore = missing-email` will hide that issue.
-+
---
-error;;
-	a comma-separated list of fsck message IDs that should be
-	trigger fsck to error out.
-warn;;
-	a comma-separated list of fsck message IDs that should be
-	displayed, but fsck should continue to error out.
-ignore;;
-	a comma-separated list of fsck message IDs that should be
-	ignored completely.
---
+	`receive.fsck.severity = missing-email=ignore` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which would not pass pushing when `receive.fsckObjects = true`, allowing
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7eb4ff8..81570d8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -49,7 +49,12 @@ static int show_dangling = 1;
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
-	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+	if (strcmp(var, "fsck.severity") == 0) {
+		fsck_set_severity(&fsck_obj_options, value);
+		return 0;
+	}
+
+	if (strcmp(var, "fsck.skiplist") == 0) {
 		const char *path = is_absolute_path(value) ?
 			value : git_path("%s", value);
 		struct strbuf sb = STRBUF_INIT;
@@ -59,14 +64,6 @@ static int fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (skip_prefix(var, "fsck.", &var)) {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addf(&sb, "%s=%s", var, value);
-		fsck_set_severity(&fsck_obj_options, sb.buf);
-		strbuf_release(&sb);
-		return 0;
-	}
-
 	return git_default_config(var, value, cb);
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8e6d1a1..f454e65 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -116,18 +116,17 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsck.severity") == 0) {
+		strbuf_addf(&fsck_severity, "%c%s",
+			fsck_severity.len ? ',' : '=', value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
 		const char *path = is_absolute_path(value) ?
 			value : git_path("%s", value);
-		if (fsck_severity.len)
-			strbuf_addch(&fsck_severity, ',');
-		strbuf_addf(&fsck_severity, "skiplist=%s", path);
-		return 0;
-	}
-
-	if (skip_prefix(var, "receive.fsck.", &var)) {
-		strbuf_addf(&fsck_severity, "%s%s=%s",
-			fsck_severity.len ? "," : "", var, value);
+		strbuf_addf(&fsck_severity, "%cskiplist=%s",
+			fsck_severity.len ? ',' : '=', path);
 		return 0;
 	}
 
@@ -1487,8 +1486,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_pushf(&child.args, "--strict%s%s",
-				fsck_severity.len ? "=" : "",
+			argv_array_pushf(&child.args, "--strict%s",
 				fsck_severity.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
@@ -1507,8 +1505,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			argv_array_pushf(&child.args, "--strict%s%s",
-				fsck_severity.len ? "=" : "",
+			argv_array_pushf(&child.args, "--strict%s",
 				fsck_severity.buf);
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
diff --git a/fsck.c b/fsck.c
index 15cb8bd..046af02 100644
--- a/fsck.c
+++ b/fsck.c
@@ -107,7 +107,9 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
 {
 	int severity;
 
-	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
+
+	if (options->msg_severity)
 		severity = options->msg_severity[msg_id];
 	else {
 		severity = msg_id_info[msg_id].severity;
@@ -184,35 +186,40 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 		}
 
 		for (equal = 0; equal < len; equal++)
-			if (mode[equal] == '=')
+			if (mode[equal] == '=' || mode[equal] == ':')
 				break;
 
-		if (equal < len) {
-			if (!substrcmp(mode, equal, "error"))
+		if (!substrcmp(mode, equal, "skiplist")) {
+			char *path = xstrndup(mode + equal + 1,
+				len - equal - 1);
+
+			if (equal == len)
+				die("skiplist requires a path");
+			init_skiplist(options, path);
+			free(path);
+			mode += len;
+			continue;
+		}
+
+		msg_id = parse_msg_id(mode, equal);
+
+		if (equal == len)
+			severity = FSCK_ERROR;
+		else {
+			const char *p = mode + equal + 1;
+			int len2 = len - equal - 1;
+
+			if (!substrcmp(p, len2, "error"))
 				severity = FSCK_ERROR;
-			else if (!substrcmp(mode, equal, "warn"))
+			else if (!substrcmp(p, len2, "warn"))
 				severity = FSCK_WARN;
-			else if (!substrcmp(mode, equal, "ignore"))
+			else if (!substrcmp(p, len2, "ignore"))
 				severity = FSCK_IGNORE;
-			else if (!substrcmp(mode, equal, "skiplist")) {
-				char *path = xstrndup(mode + equal + 1,
-					len - equal - 1);
-
-				if (equal == len)
-					die("skiplist requires a path");
-				init_skiplist(options, path);
-				free(path);
-				mode += len;
-				continue;
-			}
 			else
 				die("Unknown fsck message severity: '%.*s'",
-					equal, mode);
-			mode += equal + 1;
-			len -= equal + 1;
+					len2, p);
 		}
 
-		msg_id = parse_msg_id(mode, len);
 		if (severity != FSCK_ERROR &&
 				msg_id_info[msg_id].severity == FSCK_FATAL)
 			die("Cannot demote %.*s", len, mode);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1c624a3..b32afaf 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -295,7 +295,7 @@ test_expect_success 'force fsck to ignore double author' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck &&
-	git -c fsck.ignore=multiple-authors fsck
+	git -c fsck.severity=multiple-authors=ignore fsck
 '
 
 _bz='\0'
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index d367bb2..7881e17 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -135,28 +135,31 @@ test_expect_success 'push with receive.fsck.skiplist' '
 	git push --porcelain dst bogus
 '
 
-test_expect_success 'push with receive.fsck.warn = missing-email' '
+test_expect_success 'push with receive.fsck.severity = missing-email=warn' '
 	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
-	git --git-dir=dst/.git config receive.fsck.warn missing-email &&
+	git --git-dir=dst/.git config \
+		receive.fsck.severity missing-email=warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	grep "missing-email" act &&
 	git --git-dir=dst/.git branch -D bogus &&
-	git  --git-dir=dst/.git config receive.fsck.ignore missing-email &&
-	git  --git-dir=dst/.git config receive.fsck.warn bad-date &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.severity missing-email=ignore,bad-date=warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	test_must_fail grep "missing-email" act
 '
 
-test_expect_success 'receive.fsck.warn = unterminated-header triggers error' '
+test_expect_success \
+	'receive.fsck.severity = unterminated-header=warn triggers error' '
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
-	git --git-dir=dst/.git config receive.fsck.warn unterminated-header &&
+	git --git-dir=dst/.git config \
+		receive.fsck.severity unterminated-header=warn &&
 	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
 	grep "Cannot demote unterminated-header" act
 '
-- 
2.2.0.33.gc18b867
