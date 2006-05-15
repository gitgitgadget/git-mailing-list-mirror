From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Sun, 14 May 2006 23:15:11 -0400
Message-ID: <20060515031511.GA27505@spearce.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org> <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org> <7vody2v7yr.fsf@assigned-by-dhcp.cox.net> <20060513071753.GA21998@spearce.org> <20060513074328.GB21998@spearce.org> <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org> <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net> <20060513181816.GA12475@spearce.org> <7vk68o19n4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 05:15:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfTYX-0001vY-QT
	for gcvg-git@gmane.org; Mon, 15 May 2006 05:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWEODPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 23:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWEODPU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 23:15:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:7904 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750808AbWEODPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 23:15:19 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfTY0-0006ZL-Dw; Sun, 14 May 2006 23:15:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 09E2B20FB77; Sun, 14 May 2006 23:15:11 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk68o19n4.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20013>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Log ref updates to logs/refs/<ref>
> >
> > If config parameter core.logRefUpdates is true then append a line
> > to .git/logs/refs/<ref> whenever git-update-ref <ref> is executed.
> 
> I cannot decide if a parameter makes more sense, or just making
> the existence of such a file a cue is better.  For example, I do
> not much care about when I updated each of my topic branch head,
> while I do care about master, next, and pu branches.  A global
> parameter would make this black-or-white choice, while opening
> the log without O_CREAT and write things out only when the log
> file exists might make things as easy and controllable.
> 
> I could "touch" the ones I care about to prime the process.

I'm as torn as you are on this.  My `pg' would have some serious
issues with update-ref and the logRefUpdates config being true as it
uses a large number of refs to track the patch stack.  StGIT might
also be in a somewhat similiar position, but I think it uses slightly
less refs.  Opening without O_CREAT and letting the user touch the
log file into existance would fix this problem for most users.

But I can also see the case where the user has most branches logged
then infrequently creates a new branch but expects that branch
to also be logged.  What happens when they later find out its not
logging but they were counting on that log data to be there?

Perhaps a mix of the two solutions is ideal.  Use O_CREAT if
logRefUpdates is true and otherwise log only if the file already
exists.  This is now in the patch below.

I have also added an optional '-m <reason>' flag to update-ref,
for use in e.g. git-commit.  I have also moved the logging code to
refs.c where it could be used by fetch or upload-pack, but those
changes are not yet included in this patch.

--> -
Log ref updates to logs/refs/<ref>

If config parameter core.logAllRefUpdates is true or the log
file already exists then append a line to ".git/logs/refs/<ref>"
whenever git-update-ref <ref> is executed.  Each log line contains
the following information:

  oldsha1 <SP> newsha1 <SP> committer <LF>

where committer is the current user, date, time and timezone in
the standard GIT ident format.  If the caller is unable to append
to the log file then git-update-ref will fail without updating <ref>.

An optional message may be included in the log line with the -m flag.

---

 Documentation/config.txt         |    8 ++++++
 Documentation/git-update-ref.txt |   28 +++++++++++++++++++-
 cache.h                          |    1 +
 config.c                         |    5 ++++
 environment.c                    |    1 +
 refs.c                           |   50 ++++++++++++++++++++++++++++++++++++
 refs.h                           |    3 ++
 update-ref.c                     |   53 ++++++++++++++++++++++++++++++++------
 8 files changed, 139 insertions(+), 10 deletions(-)

bbac000fbc779c7434d66b10639eaa5ea218f62e
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
index 475237f..dfbd886 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,7 +7,7 @@ git-update-ref - update the object name 
 
 SYNOPSIS
 --------
-'git-update-ref' <ref> <newvalue> [<oldvalue>]
+'git-update-ref' <ref> <newvalue> [<oldvalue>] [-m <reason>]
 
 DESCRIPTION
 -----------
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
index 0f518c9..fa6db4b 100644
--- a/config.c
+++ b/config.c
@@ -232,6 +232,11 @@ int git_default_config(const char *var, 
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
index 275b914..691a8ba 100644
--- a/refs.c
+++ b/refs.c
@@ -375,3 +375,53 @@ int write_ref_sha1_unlocked(const char *
 	free(lock_filename);
 	return retval;
 }
+
+int log_ref_update(const char *ref, const unsigned char *currsha1, const unsigned char *newsha1, const char *msg)
+{
+	char *logpath, *logrec;
+	const char *comitter;
+	unsigned maxlen, len;
+	int oflags, logfd, written;
+
+	oflags = O_APPEND | O_WRONLY;
+	logpath = git_path("logs/%s", ref);
+	if (log_all_ref_updates) {
+		if (safe_create_leading_directories(logpath) < 0)
+			return error("Unable to create all of %s", logpath);
+		oflags |= O_CREAT;
+	}
+
+	logfd = open(logpath, oflags, 0666);
+	if (logfd < 0) {
+		if (!log_all_ref_updates && errno == ENOENT)
+			return 0;
+		return error("Unable to append to %s: %s", logpath, strerror(errno));
+	}
+
+	setup_ident();
+	comitter = git_committer_info(1);
+	if (msg) {
+		maxlen = strlen(comitter) + strlen(msg) + 2*40 + 5;
+		logrec = xmalloc(maxlen);
+		len = snprintf(logrec, maxlen, "%s %s %s\t%s\n",
+			sha1_to_hex(currsha1),
+			sha1_to_hex(newsha1),
+			comitter,
+			msg);
+	} else {
+		maxlen = strlen(comitter) + 2*40 + 4;
+		logrec = xmalloc(maxlen);
+		len = snprintf(logrec, maxlen, "%s %s %s\n",
+			sha1_to_hex(currsha1),
+			sha1_to_hex(newsha1),
+			comitter);
+	}
+	if (len >= maxlen)
+		return error("Internal error formatting log record.");
+	written = write(logfd, logrec, len);
+	if (written != len)
+		return error("Unable to append to %s", logpath);
+	free(logrec);
+	close(logfd);
+	return 0;
+}
diff --git a/refs.h b/refs.h
index 2625596..9345942 100644
--- a/refs.h
+++ b/refs.h
@@ -25,4 +25,7 @@ extern int write_ref_sha1_unlocked(const
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
+/** If logging is enabled logs the change made to the ref. **/
+extern int log_ref_update(const char *ref, const unsigned char *currsha1, const unsigned char *newsha1, const char *msg);
+
 #endif /* REFS_H */
diff --git a/update-ref.c b/update-ref.c
index fd48742..95940dd 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -1,7 +1,8 @@
 #include "cache.h"
 #include "refs.h"
 
-static const char git_update_ref_usage[] = "git-update-ref <refname> <value> [<oldval>]";
+static const char git_update_ref_usage[] =
+"git-update-ref <refname> <value> [<oldval>] [-m <reason>]";
 
 static int re_verify(const char *path, unsigned char *oldsha1, unsigned char *currsha1)
 {
@@ -19,26 +20,50 @@ static int re_verify(const char *path, u
 int main(int argc, char **argv)
 {
 	char *hex;
-	const char *refname, *value, *oldval, *path;
+	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL, *path;
 	char *lockpath;
 	unsigned char sha1[20], oldsha1[20], currsha1[20];
-	int fd, written;
+	int i, fd, written, pfxlen;
 
 	setup_git_directory();
 	git_config(git_default_config);
-	if (argc < 3 || argc > 4)
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp("-m", argv[i])) {
+			if (i+1 >= argc)
+				usage(git_update_ref_usage);
+			msg = argv[++i];
+			if (!*msg)
+				die("Refusing to perform update with empty message.");
+			if (strchr(msg, '\n'))
+				die("Refusing to perform update with \\n in message.");
+			continue;
+		}
+		if (!refname) {
+			refname = argv[i];
+			continue;
+		}
+		if (!value) {
+			value = argv[i];
+			continue;
+		}
+		if (!oldval) {
+			oldval = argv[i];
+			continue;
+		}
+	}
+	if (!refname || !value)
 		usage(git_update_ref_usage);
 
-	refname = argv[1];
-	value = argv[2];
-	oldval = argv[3];
 	if (get_sha1(value, sha1))
 		die("%s: not a valid SHA1", value);
 	memset(oldsha1, 0, 20);
 	if (oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
 
-	path = resolve_ref(git_path("%s", refname), currsha1, !!oldval);
+	path = git_path("%s", refname);
+	pfxlen = strlen(path) - strlen(refname);
+	path = resolve_ref(path, currsha1, !!oldval);
 	if (!path)
 		die("No such ref: %s", refname);
 
@@ -49,8 +74,13 @@ int main(int argc, char **argv)
 		if (!memcmp(oldsha1, sha1, 20))
 			exit(0);
 	}
+
+	/* No change in ref.  Don't do anything. */
+	if (!memcmp(currsha1, sha1, 20))
+		exit(0);
+
 	path = strdup(path);
-	lockpath = mkpath("%s.lock", path);
+	lockpath = strdup(mkpath("%s.lock", path));
 	if (safe_create_leading_directories(lockpath) < 0)
 		die("Unable to create all of %s", lockpath);
 
@@ -74,6 +104,11 @@ int main(int argc, char **argv)
 		die("Ref lock failed");
 	}
 
+	if (log_ref_update(path + pfxlen, currsha1, sha1, msg) < 0) {
+		unlink(lockpath);
+		die("Logging ref update failed, update aborted.");
+	}
+
 	/*
 	 * Finally, replace the old ref with the new one
 	 */
-- 
1.3.2.g7278
