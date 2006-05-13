From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 03:43:28 -0400
Message-ID: <20060513074328.GB21998@spearce.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org> <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org> <7vody2v7yr.fsf@assigned-by-dhcp.cox.net> <20060513071753.GA21998@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 09:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Feomt-0002j4-Vi
	for gcvg-git@gmane.org; Sat, 13 May 2006 09:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWEMHnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 03:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWEMHnd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 03:43:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45502 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750897AbWEMHnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 03:43:32 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Feome-0002HB-HQ; Sat, 13 May 2006 03:43:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B6FC320FB12; Sat, 13 May 2006 03:43:28 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060513071753.GA21998@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19929>

Shawn Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > Shawn Pearce <spearce@spearce.org> writes:
> > 
> > > git-udpate-ref.  So just have it append the ref's history to a file:
> > >
> > > 	.git/log/refs/heads/$branch
> > >
> > > where the history records are stored as:
> > >
> > > 	40 byte commit-ish SHA1
> > > 	<SP>
> > > 	<committer>
> > > 	<LF>
> > >
> > > e.g.:
> > >
> > > 	cbb6d91d95e523c2b6a6b52577c4be28d18ace83 Shawn O. Pearce <spearce@spearce.org> 1137039378 -0500
> > > 	ae8c74e96a1e02bbfb7f1a9669b77d6f8ee6c3cf Shawn O. Pearce <spearce@spearce.org> 1136921470 -0500
> > >
> > 
> > Because the question we often would want to ask is "two days ago
> > my tip worked but today it does not", recording the timestamp
> > makes sense, but I do not know what the point is for the name
> > and e-mail.  If it is in your local repository (i.e. the program
> > that updates the tip ref is not receive-pack which is invoked by
> > your pushing into a remote repo), it will always be you.  And in
> > the receive-pack case, the information is not available to begin
> > with (you may have a UNIX UID but that is about it).

Forget my last patch.  This one automatically creates the log file
by looking for a config value of 'core.logRefUpdates=true'.

--> -
Log ref updates to logs/refs/<ref>

If config parameter core.logRefUpdates is true then append a line
to .git/logs/refs/<ref> whenever git-update-ref <ref> is executed.
Each log line contains the following information:

  40 byte tree-ish SHA1
  <SP>
  date/time
  <LF>

where date/time is the current date, time and timezone in the
standard GIT date format.  If the caller is unable to append to
the log file then git-update-ref will fail without updating <ref>.

---

 Documentation/config.txt         |    7 ++++++
 Documentation/git-update-ref.txt |   17 +++++++++++++++
 cache.h                          |    1 +
 config.c                         |    5 ++++
 environment.c                    |    1 +
 update-ref.c                     |   43 +++++++++++++++++++++++++++++++++++---
 6 files changed, 71 insertions(+), 3 deletions(-)

cac86f2df9a52d94cb03038e267934c67f04122b
diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1a4bec..f06695c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -70,6 +70,13 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.logRefUpdates::
+	If true, `git-update-ref` will append a line to
+	"$GIT_DIR/logs/<ref>" listing the new SHA1 and the date/time
+	of the update.	This information can be used to determine
+	what commit was the tip of a branch "2 days ago".  This value
+	is false by default (no logging).
+
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
 	version.
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 475237f..8c46263 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -49,6 +49,23 @@ for reading but not for writing (so we'l
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
+Logging Updates
+---------------
+If config parameter "core.logRefUpdates" is true then
+`git-update-ref` will append a line to the log file
+"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before
+creating the log name) describing the change in ref value.  Log lines
+are formatted as:
+
+    . sha1 SP date LF
++
+Where "sha1" is the 40 character hexadecimal value of <newvalue>
+and "date" is the current date/time and timezone in the standard
+GIT date format.
+
+An update will fail (without changing <ref>) if the current user is
+unable to create a new log file or append to the existing log file.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>.
diff --git a/cache.h b/cache.h
index b1300cd..887ce20 100644
--- a/cache.h
+++ b/cache.h
@@ -171,6 +171,7 @@ extern void rollback_index_file(struct c
 extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
+extern int log_ref_updates;
 extern int warn_ambiguous_refs;
 extern int diff_rename_limit_default;
 extern int shared_repository;
diff --git a/config.c b/config.c
index 0f518c9..f8a814e 100644
--- a/config.c
+++ b/config.c
@@ -232,6 +232,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.logrefupdates")) {
+		log_ref_updates = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.warnambiguousrefs")) {
 		warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 444c99e..437266e 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@ char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int assume_unchanged = 0;
 int prefer_symlink_refs = 0;
+int log_ref_updates = 0;
 int warn_ambiguous_refs = 1;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
diff --git a/update-ref.c b/update-ref.c
index fd48742..c231760 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
 	const char *refname, *value, *oldval, *path;
 	char *lockpath;
 	unsigned char sha1[20], oldsha1[20], currsha1[20];
-	int fd, written;
+	int fd, written, pfxlen;
 
 	setup_git_directory();
 	git_config(git_default_config);
@@ -38,7 +38,9 @@ int main(int argc, char **argv)
 	if (oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
 
-	path = resolve_ref(git_path("%s", refname), currsha1, !!oldval);
+	path = git_path("%s", refname);
+	pfxlen = strlen(path) - strlen(refname);
+	path = resolve_ref(path, currsha1, !!oldval);
 	if (!path)
 		die("No such ref: %s", refname);
 
@@ -50,7 +52,7 @@ int main(int argc, char **argv)
 			exit(0);
 	}
 	path = strdup(path);
-	lockpath = mkpath("%s.lock", path);
+	lockpath = strdup(mkpath("%s.lock", path));
 	if (safe_create_leading_directories(lockpath) < 0)
 		die("Unable to create all of %s", lockpath);
 
@@ -75,6 +77,41 @@ int main(int argc, char **argv)
 	}
 
 	/*
+	 * Write to the log if logging of ref updates is enabled
+	 */
+	if (log_ref_updates) {
+		char *logpath;
+		char now[50];
+		char logrec[100];
+		unsigned len;
+		int logfd;
+
+		datestamp(now, sizeof(now));
+		len = snprintf(logrec, sizeof(logrec), "%s %s\n", sha1_to_hex(sha1), now);
+		if (len >= sizeof(logrec)) {
+			unlink(lockpath);
+			die("Internal error formatting log record.");
+		}
+
+		logpath = git_path("logs/%s", path + pfxlen);
+		if (safe_create_leading_directories(logpath) < 0) {
+			unlink(lockpath);
+			die("Unable to create all of %s", logpath);
+		}
+		logfd = open(logpath, O_CREAT | O_APPEND | O_WRONLY, 0666);
+		if (logfd < 0) {
+			unlink(lockpath);
+			die("Unable to append to log %s", logpath);
+		}
+		written = write(logfd, logrec, len);
+		if (written != len) {
+			unlink(lockpath);
+			die("Unable to append to %s", logpath);
+		}
+		close(logfd);
+	}
+
+	/*
 	 * Finally, replace the old ref with the new one
 	 */
 	if (rename(lockpath, path) < 0) {
-- 
1.3.2.g7278
