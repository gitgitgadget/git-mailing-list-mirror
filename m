From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log --full-history renamed-file
Date: Fri, 9 Mar 2007 14:20:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
References: <87lki6umts.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPnSY-0006Na-Uh
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 23:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767563AbXCIWVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 17:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767564AbXCIWVF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 17:21:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51271 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767563AbXCIWVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 17:21:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l29MKuo4018466
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 14:20:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l29MKt7o004371;
	Fri, 9 Mar 2007 14:20:55 -0800
In-Reply-To: <87lki6umts.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-0.493 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41815>


[ See toy patch at the end as an example of how you could do somethign 
  like this better. I started out just explaining what git does, but ended 
  up writing a simple patch that kind of shows an example of how it could 
  be implemented ]

On Fri, 9 Mar 2007, Jim Meyering wrote:
> 
> Is there some git-log-like command (or some git-log option)
> to print a log of deltas affecting a file across renames?

There were patches floating around for an option called "--follow" to "git 
log", that would actually follow the renames. 

I don't remember what happened to them - I suspect the implementation 
wasn't up to snuff. But the *concept* is definitely right.

> I know that git-annotate can detect renames (and gitk),
> but that's not quite the interface I was looking for.
> 
> I've tried with git-log --full-history, with and without --parents,
> to no avail.  Adding --parents does make it produce a couple more
> log entries, but they are not relevant.

Yeah, those don't really do what you want. They are entirely about the 
"time view" of the commits, they don't move in "space"

[ That's just my personal terminology: git tracks data in two different 
  dimensions: the contents ("space") and the history ("time"). So with 
  "git log" you can limit both the content dimension (by path limiters) 
  and the history dimension (with revision limiters).

  So --full-history and --parents are about showing more detail or 
  changing the limiting in that history dimension, but they do not affect 
  the content dimension. What you want to do is to let the content 
  limiters change over time, and yes, "git annotate" obviously does 
  exactly that, but no, we don't do it in "git log", and the space 
  limiters are entirely static over time right now ]

> The "Why does git not track renames?" section in the wiki,
> http://git.or.cz/gitwiki/Godfry says that "git-log -M"
> will do what I want, but that appears to have no effect.

Actually, it will have effect, but it will have an effect only *within* 
the space limiter (and only when you actually *watch* what happens by 
showing the patches).

So for an example of the effect, do

	git log -p 76cead39 Documentation

(or "git show" with, and without an "-M").

So no, the -M flag does *not* do what you want. Yes, it detects renames, 
but it does so within individual diffs, not over time. So to go back to my 
space/time analogy, "-M" works 100% in space, it's a one-time temporal 
event for showing single commit, it doesn't actually start following 
history down under any other name.

> To be precise, I'd like to run a command like this
> 
>   git-log <options> current-name
> 
> to summarize the commits affecting current-name as well as
> those affecting old-name (which I git-mv'd to current-name).

Yes. Rigth now you *can* emulate this (in a very cumbersome manner!) by 
letting "git show -M" help you see what happened. Eg, in git, many files 
have gotten renamed over time, and you can do something like

	git log builtin-rev-list.c

and when you go to the end of that result, you'll see the first commit 
where it showed up under that name:

	5fb61b8d: Make "git rev-list" be a builtin

and *now* you can use the "-M" flag to let git figure out what happened:

	git show -M 5fb61b8d

which will have

	diff --git a/rev-list.c b/builtin-rev-list.c
	similarity index 99%
	rename from rev-list.c
	rename to builtin-rev-list.c

(there are lots of other options, ie you could have used

	git show -M --name-status --pretty=oneline 5fb61b8d

and it would show the changes in a much condensed manner, but still 
showing the fact that "rev-list.c" got renamed to "builtin-rev-list.c" in 
that commit.

And after that, you could re-start the log from that point on (or rather, 
the parent), and with that older name:

	git log 5fb61b8d^ -- rev-list.c

In other words:

 - git can do it, but doesn't really have the interfaces to do it sanely 
   right now.

 - you can do it by hand

 - it's almost silly, but "git blame" internally really already has all 
   the logic for this, it's just not exposed any sane way to a user.

I'm appending a REALLY UGLY patch that makes

	git blame --log filename.c

work kind of like you'd want. IT IS NOT MEANT TO BE REALLY USED, because 
in particular, it doesn't take the nice log options (so you cannot make it 
show diffs etc, even though we have all the machinery in place for that). 
But it's an example of the fact that yes, git can do this, but we're so 
stupid that we don't really accept it.

(NOTE! It's also almost totally untested. It might not work. I'm sending 
it out as a very rough example, not as a serious contender)

		Linus

---
diff --git a/builtin-blame.c b/builtin-blame.c
index b51cdc7..470f3ae 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -41,8 +41,11 @@ static int max_score_digits;
 static int show_root;
 static int blank_boundary;
 static int incremental;
+static int log;
 static int cmd_is_annotate;
 
+static struct rev_info log_rev;
+
 #ifndef DEBUG
 #define DEBUG 0
 #endif
@@ -1376,6 +1379,16 @@ static void found_guilty_entry(struct blame_entry *ent)
 	if (ent->guilty)
 		return;
 	ent->guilty = 1;
+	if (log) {
+		struct origin *suspect = ent->suspect;
+		struct commit *commit = suspect->commit;
+
+		if (commit->object.flags & SHOWN)
+			return;
+		commit->object.flags |= SHOWN;
+		log_tree_commit(&log_rev, commit);
+		return;
+	}
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
 
@@ -2073,7 +2086,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
 	git_config(git_blame_config);
-	save_commit_buffer = 0;
+//	save_commit_buffer = 0;
 
 	opt = 0;
 	seen_dashdash = 0;
@@ -2139,6 +2152,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			seen_dashdash = 1;
 			i++;
 			break;
+		} if (!strcmp("--log", arg)) {
+			log = 1;
+			init_revisions(&log_rev, NULL);
+			log_rev.diff = 1;
+			log_rev.diffopt.recursive = 1;
+			log_rev.commit_format = CMIT_FMT_DEFAULT;
+			log_rev.verbose_header = 1;
+			log_rev.abbrev = DEFAULT_ABBREV;
 		}
 		else
 			argv[unk++] = arg;
@@ -2336,7 +2357,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	assign_blame(&sb, &revs, opt);
 
-	if (incremental)
+	if (incremental || log)
 		return 0;
 
 	coalesce(&sb);
