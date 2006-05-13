From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 03:17:53 -0400
Message-ID: <20060513071753.GA21998@spearce.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org> <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org> <7vody2v7yr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 09:18:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeoO3-0000OU-PY
	for gcvg-git@gmane.org; Sat, 13 May 2006 09:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWEMHR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 03:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWEMHR6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 03:17:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49595 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932357AbWEMHR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 03:17:57 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FeoNu-0001aM-8X; Sat, 13 May 2006 03:17:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE2F420FB12; Sat, 13 May 2006 03:17:53 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vody2v7yr.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19928>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > git-udpate-ref.  So just have it append the ref's history to a file:
> >
> > 	.git/log/refs/heads/$branch
> >
> > where the history records are stored as:
> >
> > 	40 byte commit-ish SHA1
> > 	<SP>
> > 	<committer>
> > 	<LF>
> >
> > e.g.:
> >
> > 	cbb6d91d95e523c2b6a6b52577c4be28d18ace83 Shawn O. Pearce <spearce@spearce.org> 1137039378 -0500
> > 	ae8c74e96a1e02bbfb7f1a9669b77d6f8ee6c3cf Shawn O. Pearce <spearce@spearce.org> 1136921470 -0500
> >
> 
> Because the question we often would want to ask is "two days ago
> my tip worked but today it does not", recording the timestamp
> makes sense, but I do not know what the point is for the name
> and e-mail.  If it is in your local repository (i.e. the program
> that updates the tip ref is not receive-pack which is invoked by
> your pushing into a remote repo), it will always be you.  And in
> the receive-pack case, the information is not available to begin
> with (you may have a UNIX UID but that is about it).

Agreed.  Prototype patch below.

While writing this I discovered at least two chunks of GIT which
don't use git-update-ref: fetch.c and upload-pack.c.  fetch.c uses
the APIs in refs.c but upload-pack.c doesn't.  I spent a couple of
hours trying to convert update-ref.c to use the APIs in refs.c so
I could just put the logging change there, but that turned out to
be more difficult than expected for a simple prototype so it all
went out the window.

-- >-
Log ref updates to logs/refs/<refname>

If .git/logs/refs/<refname> exists then append a line to it whenever
git-update-ref <refname> is executed.  Each log line contains the
following information:

  40 byte tree-ish SHA1
  <SP>
  date/time
  <LF>

where date/time is the current date, time and timezone in the
standard GIT date format.  If the caller is unable to append to
the log file and the log file exists then git-update-ref will fail
without updating <refname>.

---

 Documentation/git-update-ref.txt |   15 ++++++++++++++
 update-ref.c                     |   41 +++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

8f1ccd3b0eda9d54eca37af178113c91174e81ca
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 475237f..d314786 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -49,6 +49,21 @@ for reading but not for writing (so we'l
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
+Logging Updates
+---------------
+If "$GIT_DIR/logs/<ref>" (possibly dereferencing symbolic refs)
+exists then `git-update-ref` will append a line to the log file
+describing the change in ref value.  Log lines are formatted as:
+
+    . sha1 SP date LF
++
+Where "sha1" is the 40 character hexadecimal value of <newvalue>
+and "date" is the current date/time and timezone in the standard
+GIT date format.
+
+An update will fail (without changing <ref>) if the log file
+exists but the current user is unable to append to the file.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>.
diff --git a/update-ref.c b/update-ref.c
index fd48742..bffe5f9 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -20,9 +20,9 @@ int main(int argc, char **argv)
 {
 	char *hex;
 	const char *refname, *value, *oldval, *path;
-	char *lockpath;
+	char *lockpath, *logpath;
 	unsigned char sha1[20], oldsha1[20], currsha1[20];
-	int fd, written;
+	int fd, logfd, written, pfxlen;
 
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
 
@@ -50,6 +52,17 @@ int main(int argc, char **argv)
 			exit(0);
 	}
 	path = strdup(path);
+
+	/*
+	 * If logging is required make sure we can append to the log.
+	 */
+	logpath = strdup(git_path("logs/%s", path + pfxlen));
+	logfd = open(logpath, O_APPEND | O_WRONLY, 0);
+	if (logfd < 0 && errno != ENOENT)
+		die("Unable to append to log %s", logpath);
+	if (logfd >= 0)
+		setup_ident();
+
 	lockpath = mkpath("%s.lock", path);
 	if (safe_create_leading_directories(lockpath) < 0)
 		die("Unable to create all of %s", lockpath);
@@ -75,6 +88,28 @@ int main(int argc, char **argv)
 	}
 
 	/*
+	 * Write to the log, if it was opened.
+	 */
+	if (logfd >= 0) {
+		char now[50];
+		char logrec[100];
+		unsigned len;
+
+		datestamp(now, sizeof(now));
+		len = snprintf(logrec, sizeof(logrec), "%s %s\n", sha1_to_hex(sha1), now);
+		if (len >= sizeof(logrec)) {
+			unlink(lockpath);
+			die("Internal error formatting log record.");
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
