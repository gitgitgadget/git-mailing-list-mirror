From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 4/5] Log ref updates to logs/refs/<ref>
Date: Wed, 17 May 2006 05:55:40 -0400
Message-ID: <20060517095540.GE28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIky-0004W3-9g
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWEQJzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWEQJzp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:55:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61904 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932513AbWEQJzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:55:44 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIkl-0000we-1p
	for git@vger.kernel.org; Wed, 17 May 2006 05:55:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 58A8D212667; Wed, 17 May 2006 05:55:40 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20183>

If config parameter core.logAllRefUpdates is true or the log
file already exists then append a line to ".git/logs/refs/<ref>"
whenever git-update-ref <ref> is executed.  Each log line contains
the following information:

  oldsha1 <SP> newsha1 <SP> committer <LF>

where committer is the current user, date, time and timezone in
the standard GIT ident format.  If the caller is unable to append
to the log file then git-update-ref will fail without updating <ref>.

An optional message may be included in the log line with the -m flag.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/config.txt         |    8 +++
 Documentation/git-update-ref.txt |   26 +++++++++
 cache.h                          |    1 
 config.c                         |    5 ++
 environment.c                    |    1 
 refs.c                           |   56 +++++++++++++++++++
 refs.h                           |    1 
 t/t1400-update-ref.sh            |  112 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 t/t1400-update-ref.sh

1b91f255386d1120bdcb434603993156c9fdde71
diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1a4bec..e178ee2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -70,6 +70,14 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.logAllRefUpdates::
+	If true, `git-update-ref` will append a line to
+	"$GIT_DIR/logs/<ref>" listing the new SHA1 and the date/time
+	of the update.	If the file does not exist it will be
+	created automatically.	This information can be used to
+	determine what commit was the tip of a branch "2 days ago".
+	This value is false by default (no logging).
+
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
 	version.
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index f0e710a..dfbd886 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -49,6 +49,32 @@ for reading but not for writing (so we'l
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
+Logging Updates
+---------------
+If config parameter "core.logAllRefUpdates" is true or the file
+"$GIT_DIR/logs/<ref>" exists then `git-update-ref` will append
+a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
+symbolic refs before creating the log name) describing the change
+in ref value.  Log lines are formatted as:
+
+    . oldsha1 SP newsha1 SP committer LF
++
+Where "oldsha1" is the 40 character hexadecimal value previously
+stored in <ref>, "newsha1" is the 40 character hexadecimal value of
+<newvalue> and "committer" is the committer's name, email address
+and date in the standard GIT committer ident format.
+
+Optionally with -m:
+
+    . oldsha1 SP newsha1 SP committer TAB message LF
++
+Where all fields are as described above and "message" is the
+value supplied to the -m option.
+
+An update will fail (without changing <ref>) if the current user is
+unable to create a new log file, append to the existing log file
+or does not have committer information available.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>.
diff --git a/cache.h b/cache.h
index b1300cd..82adbba 100644
--- a/cache.h
+++ b/cache.h
@@ -171,6 +171,7 @@ extern void rollback_index_file(struct c
 extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
+extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int diff_rename_limit_default;
 extern int shared_repository;
diff --git a/config.c b/config.c
index 0248c6d..2ae6153 100644
--- a/config.c
+++ b/config.c
@@ -269,6 +269,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.logallrefupdates")) {
+		log_all_ref_updates = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.warnambiguousrefs")) {
 		warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 444c99e..2e79eab 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@ char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int assume_unchanged = 0;
 int prefer_symlink_refs = 0;
+int log_all_ref_updates = 0;
 int warn_ambiguous_refs = 1;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
diff --git a/refs.c b/refs.c
index 91c8c44..4be75a5 100644
--- a/refs.c
+++ b/refs.c
@@ -302,6 +302,7 @@ static struct ref_lock* lock_ref_sha1_ba
 
 	lock->ref_file = strdup(path);
 	lock->lock_file = strdup(mkpath("%s.lock", lock->ref_file));
+	lock->log_file = strdup(git_path("logs/%s", lock->ref_file + plen));
 
 	if (safe_create_leading_directories(lock->lock_file))
 		die("unable to create directory for %s", lock->lock_file);
@@ -343,9 +344,60 @@ void unlock_ref (struct ref_lock *lock)
 		free(lock->ref_file);
 	if (lock->lock_file)
 		free(lock->lock_file);
+	if (lock->log_file)
+		free(lock->log_file);
 	free(lock);
 }
 
+static int log_ref_write(struct ref_lock *lock,
+	const unsigned char *sha1, const char *msg)
+{
+	int logfd, written, oflags = O_APPEND | O_WRONLY;
+	unsigned maxlen, len;
+	char *logrec;
+	const char *comitter;
+
+	if (log_all_ref_updates) {
+		if (safe_create_leading_directories(lock->log_file) < 0)
+			return error("unable to create directory for %s",
+				lock->log_file);
+		oflags |= O_CREAT;
+	}
+
+	logfd = open(lock->log_file, oflags, 0666);
+	if (logfd < 0) {
+		if (!log_all_ref_updates && errno == ENOENT)
+			return 0;
+		return error("Unable to append to %s: %s",
+			lock->log_file, strerror(errno));
+	}
+
+	setup_ident();
+	comitter = git_committer_info(1);
+	if (msg) {
+		maxlen = strlen(comitter) + strlen(msg) + 2*40 + 5;
+		logrec = xmalloc(maxlen);
+		len = snprintf(logrec, maxlen, "%s %s %s\t%s\n",
+			sha1_to_hex(lock->old_sha1),
+			sha1_to_hex(sha1),
+			comitter,
+			msg);
+	} else {
+		maxlen = strlen(comitter) + 2*40 + 4;
+		logrec = xmalloc(maxlen);
+		len = snprintf(logrec, maxlen, "%s %s %s\n",
+			sha1_to_hex(lock->old_sha1),
+			sha1_to_hex(sha1),
+			comitter);
+	}
+	written = len <= maxlen ? write(logfd, logrec, len) : -1;
+	free(logrec);
+	close(logfd);
+	if (written != len)
+		return error("Unable to append to %s", lock->log_file);
+	return 0;
+}
+
 int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
@@ -364,6 +416,10 @@ int write_ref_sha1(struct ref_lock *lock
 		unlock_ref(lock);
 		return -1;
 	}
+	if (log_ref_write(lock, sha1, logmsg) < 0) {
+		unlock_ref(lock);
+		return -1;
+	}
 	if (rename(lock->lock_file, lock->ref_file) < 0) {
 		error("Couldn't set %s", lock->ref_file);
 		unlock_ref(lock);
diff --git a/refs.h b/refs.h
index b7e9df2..43831e9 100644
--- a/refs.h
+++ b/refs.h
@@ -4,6 +4,7 @@ #define REFS_H
 struct ref_lock {
 	char *ref_file;
 	char *lock_file;
+	char *log_file;
 	unsigned char old_sha1[20];
 	int lock_fd;
 };
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
new file mode 100644
index 0000000..f338c53
--- /dev/null
+++ b/t/t1400-update-ref.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Shawn Pearce
+#
+
+test_description='Test git-update-ref and basic ref logging'
+. ./test-lib.sh
+
+Z=0000000000000000000000000000000000000000
+A=1111111111111111111111111111111111111111
+B=2222222222222222222222222222222222222222
+m=refs/heads/master
+
+test_expect_success \
+	"create $m" \
+	'git-update-ref $m $A &&
+	 test $A = $(cat .git/$m)'
+test_expect_success \
+	"create $m" \
+	'git-update-ref $m $B $A &&
+	 test $B = $(cat .git/$m)'
+rm -f .git/$m
+
+test_expect_success \
+	"create $m (by HEAD)" \
+	'git-update-ref HEAD $A &&
+	 test $A = $(cat .git/$m)'
+test_expect_success \
+	"create $m (by HEAD)" \
+	'git-update-ref HEAD $B $A &&
+	 test $B = $(cat .git/$m)'
+rm -f .git/$m
+
+test_expect_failure \
+	'(not) create HEAD with old sha1' \
+	'git-update-ref HEAD $A $B'
+test_expect_failure \
+	"(not) prior created .git/$m" \
+	'test -f .git/$m'
+rm -f .git/$m
+
+test_expect_success \
+	"create HEAD" \
+	'git-update-ref HEAD $A'
+test_expect_failure \
+	'(not) change HEAD with wrong SHA1' \
+	'git-update-ref HEAD $B $Z'
+test_expect_failure \
+	"(not) changed .git/$m" \
+	'test $B = $(cat .git/$m)'
+rm -f .git/$m
+
+mkdir -p .git/logs/refs/heads
+touch .git/logs/refs/heads/master
+test_expect_success \
+	"create $m (logged by touch)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	 git-update-ref HEAD $A -m "Initial Creation" &&
+	 test $A = $(cat .git/$m)'
+test_expect_success \
+	"update $m (logged by touch)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:31" \
+	 git-update-ref HEAD $B $A -m "Switch" &&
+	 test $B = $(cat .git/$m)'
+test_expect_success \
+	"set $m (logged by touch)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:41" \
+	 git-update-ref HEAD $A &&
+	 test $A = $(cat .git/$m)'
+
+cat >expect <<EOF
+$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
+EOF
+test_expect_success \
+	"verifying $m's log" \
+	'diff expect .git/logs/$m'
+rm -rf .git/$m .git/logs expect
+
+test_expect_success \
+	'enable core.logAllRefUpdates' \
+	'git-repo-config core.logAllRefUpdates true &&
+	 test true = $(git-repo-config --bool --get core.logAllRefUpdates)'
+
+test_expect_success \
+	"create $m (logged by config)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:32" \
+	 git-update-ref HEAD $A -m "Initial Creation" &&
+	 test $A = $(cat .git/$m)'
+test_expect_success \
+	"update $m (logged by config)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:33" \
+	 git-update-ref HEAD $B $A -m "Switch" &&
+	 test $B = $(cat .git/$m)'
+test_expect_success \
+	"set $m (logged by config)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:43" \
+	 git-update-ref HEAD $A &&
+	 test $A = $(cat .git/$m)'
+
+cat >expect <<EOF
+$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
+EOF
+test_expect_success \
+	"verifying $m's log" \
+	'diff expect .git/logs/$m'
+rm -f .git/$m .git/logs/$m expect
+
+test_done
-- 
1.3.2.g7278
