From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 14:18:16 -0400
Message-ID: <20060513181816.GA12475@spearce.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org> <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org> <7vody2v7yr.fsf@assigned-by-dhcp.cox.net> <20060513071753.GA21998@spearce.org> <20060513074328.GB21998@spearce.org> <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org> <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 20:18:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeyhE-0004gc-7f
	for gcvg-git@gmane.org; Sat, 13 May 2006 20:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWEMSSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWEMSSY
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 14:18:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:436 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932469AbWEMSSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 14:18:24 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Feygt-0000p5-13; Sat, 13 May 2006 14:18:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6AB8520FB12; Sat, 13 May 2006 14:18:16 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19942>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I actually disagree with Junio - I think the logging the name made sense. 
> > If you have a shared repo with multiple people pushing to the same branch, 
> > it's interesting to see who does the pushing.
> 
> Yes, I agree recording that information is interesting.  
> 
> My comment was about how it is recorded.  In the local case
> GIT_COMMITTER_IDENT is what you want as Shawn did in his
> original proposal, but remote "pushing into shared repository"
> case I do not think it is available in general.
> 
> Well, at least that was what I was thinking when I made that
> comment.  However,
> 
> If the pushers arrange to have appropriate environment variables
> while receive-pack does its work (.git/config in the target
> repository is not an appropriate place to get user.* settings
> from in a shared setting), what you say makes perfect sense.
> 
> Having the usual enviornment available would be handy to make
> the hooks on the receiving end to do useful things anyway, so I
> retract that suggestion.
> 
> > I also think it might be good to save the oldsha1 value. Yes, it _should_ 
> > always be the previous sha1 logged, but it's interesting to see in case it 
> > isn't (ie the ref was updated some other way), and it's also interesting 
> > for the first entry after logging has been enabled.
> >
> > 		Linue
> 
> Yes, and also what user-level command was used to cause update
> the ref; was it a merge from remote, own commit, rewind/rebase?
> 
> 	Junia
> 
> ;-)
> 

New version of the patch below; this patch superceeds the prior two.
The format now includes the old sha1 and committer ident, and does
not write a log record if the update-ref is pointless.

Hmm, why does update-ref do a pointless update?

Now the problem with this patch is it doesn't append to the log
in the case of upload-pack or fetch; nor does it record what user
level command caused the update.

  [spearce@pb15 git]$ grep update-ref *.sh *.perl *.py | wc -l
      20

Hmm.  That's easy enough to fix.  Anyone up for a '-m foo' comment
switch to update-ref from the higher-level tools such that foo
appears as part of the log line?

I'll be offline for a few hours but can work on this some more
later tonight.

--> -
Log ref updates to logs/refs/<ref>

If config parameter core.logRefUpdates is true then append a line
to .git/logs/refs/<ref> whenever git-update-ref <ref> is executed.
Each log line contains the following information:

  oldsha1 <SP> newsha1 <SP> committer <LF>

where committer is the current user, date, time and timezone in
the standard GIT ident format.  If the caller is unable to append
to the log file then git-update-ref will fail without updating <ref>.

---

 Documentation/config.txt         |    7 ++++++
 Documentation/git-update-ref.txt |   19 +++++++++++++++
 cache.h                          |    1 +
 config.c                         |    5 ++++
 environment.c                    |    1 +
 update-ref.c                     |   48 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 78 insertions(+), 3 deletions(-)

898e33d9c2def73296697d65dff0676d96adb5d8
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
index 475237f..edd39d3 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -49,6 +49,25 @@ for reading but not for writing (so we'l
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
+    . oldsha1 SP newsha1 SP committer LF
++
+Where "oldsha1" is the 40 character hexadecimal value previously
+stored in <ref>, "newsha1" is the 40 character hexadecimal value of
+<newvalue> and "committer" is the committer's name, email address
+and date in the standard GIT committer ident format.
+
+An update will fail (without changing <ref>) if the current user is
+unable to create a new log file, append to the existing log file
+or does not have committer information available.
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
index fd48742..64fc3db 100644
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
 
@@ -75,6 +77,46 @@ int main(int argc, char **argv)
 	}
 
 	/*
+	 * Write to the log if logging of ref updates is enabled
+	 */
+	if (log_ref_updates && memcmp(currsha1, sha1, 20)) {
+		char *logrec, *logpath;
+		const char *comitter;
+		unsigned maxlen, len;
+		int logfd;
+
+		setup_ident();
+		comitter = git_committer_info(1);
+		maxlen = strlen(comitter) + 2*40 + 4;
+		logrec = xmalloc(maxlen);
+		len = snprintf(logrec, maxlen, "%s %s %s\n",
+			sha1_to_hex(currsha1),
+			sha1_to_hex(sha1),
+			comitter);
+		if (len >= maxlen) {
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
+			die("Unable to append to %s", logpath);
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
