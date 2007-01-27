From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 09:22:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArGW-0002b4-LD
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbXA0RW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbXA0RW5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:22:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57682 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXA0RW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:22:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RHMp1m014350
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 09:22:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RHMo2T012964;
	Sat, 27 Jan 2007 09:22:50 -0800
In-Reply-To: <20070127080126.GC9966@spearce.org>
X-Spam-Status: No, hits=-0.514 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37967>



On Sat, 27 Jan 2007, Shawn O. Pearce wrote:
> 
> _THIS_ is worth doing.  I've been having a lot of discussion on
> #git with Simon 'corecode' Schubert and Chris Lee about how poorly
> git-blame performs compared to its counterpart in Subversion.

I think we're *much* better off trying to get people off the "git-blame" 
mentality entirely.

Don't screw up git in trying to make "git blame" performance better.

Because you *will* screw it up. No ifs, buts, maybes or anything else 
about it. The only way to make "git blame" perform better is to do a 
really really crappy job.

You really have to fundamnetally realize that the reason SVN and CVS can 
do "annotate" really cheaply is BECAUSE THEY ARE BROKEN. Trying to emulate 
them is only going to break git too.

Really. Let that thought sink in, and let it fester in your brain until 
you really really get it.

There simply is no way to get "git blame" to be faster, without screwing 
things up royally in any number of ways:

 - extra (redundant) on-the-fly-generated metadata

   Yes, you can generate caches etc. Now you need to have a way to check 
   the caches, and to make sure that they are in sync. You also need to 
   update them constantly - you can make them look great in *benchmarks*, 
   but I bet that once you actually start developing, and really want to 
   _use_ them, you'll just curse the whole thing, because the caches won't 
   be there for the things you want. People normally don't do a million 
   "blame" operations on the same tree - they do *one*. Caches don't work.

 - extra (redundant) metadata generated at commit time

   Instead of doing caches, you can do it statically at commit time, and 
   now you will screw up all the *other* things, like finding content 
   movement between files, and a dense and efficient repository encoding. 
   You'll need to add tons of crap to the commits (that most ops won't 
   find *any* use for), and you'll also make the operation a lot less 
   useful because it's now static rather than dynamic.

> Thoughts?

Here's a really fundamental suggestion:

Instead of trying to do "git blame" faster, which is a totally broken 
notion, just face the fact that emulating a broken environment will be 
slower. CPU's will get faster and help you in the long run, but more 
importantly, if you just "accept git".

So instead, aim for:

 - "yes, we can do blame, but yes, it will take five seconds for a biggish 
    archive on a reasonable CPU".

   Which implies that with a slow CPU, and a really humongous archive, it 
   will take much more. Is five seconds slow enough that people think it 
   is slow? Yes. Is 30 seconds approaching painful? Yes. But you should 
   try to aim for really just telling people that it's not a common 
   operation.

   For example, I think it is a mistake to expose blame in "gitweb". It's 
   simply not a natural operation for git to do. Don't do it.

   (Side note: for the kernel - which is certainly not a "small" project, 
   even if it's not a humongous one either, and the kinds of machines I 
   work with, git blame usually takes about 1-2 seconds for most files. 
   That is *not* excessive for a developer. It's excessive if you try to 
   do it on a web-server where you've made everybody and his dog press 
   "history" by putting a big red blinking button there..

   In other words, aim for "git blame" being something that you run once a 
   week (which is about as often as I do it) or maybe a couple of times a 
   day if you're really obsessed. At which point a few seconds isn't that 
   horrid.

 - teach people about alternatives. For example, "git log -p filename" is 
   actually a hell of a lot more useful for most things. Yes, it's 
   *different*, but git makes it really easy, and it has the added 
   advantage that you see things in time order, and can very naturally 
   search back through time.

   In a very similar vein, the real problem with "git blame" is not that 
   git cannot do it, but the fact that it's a "whole history in one go" 
   operation. Again, you can actually do a "git blame" that people would 
   probably find much less annoying, if you just did things 
   *incrementally*.

   The reason "git log -p filename" doesn't perform badly is exactly that 
   it is incremental. Try it some time. The cost of

	time git log -p mm/memory.c > /dev/null
	time git blame mm/memory.c > /dev/null

   is almost 100% identical when you run them that way. So why is it that 
   just about everybody would always consider "git log -p" to be 
   instantaneous with git, but "git blame" is slow?

I'd really like people to think about that difference between "git log -p 
filename" and "git blame filename". Because it tells you a lot about the 
*psychology* of the thing. They both take the same amount of time, but one 
is slow as hell, and the other one is so fast that anybody coming from the 
CVS world will just go "Whoah! Magic!".

Really. Think about it.

Now, think about what would happen if you had a graphical "git blame" that 
was a tcl/tk thing (and slowed things down even more), but basically 
filled in the "git blame" information incrementally - the exact same way 
that "git blame" actually calculates it internally?

You know what? I bet that people would LIKE it. They could open up the 
file in that nice graphical interface, and scroll down/search to the part 
they care about, and see how git populates the blame. They'd think it's 
*cool*. And it would feel fast, because there wouldn't be any need to wait 
for *all* the information before it's done.

Here's a patch. Use "git blame --incremental filename" to get the blame 
output in a nicely parseable format that you can now write a simple 
graphical viewer for. 

Please.

		Linus
---
diff --git a/builtin-blame.c b/builtin-blame.c
index 4a1accf..7d97ae9 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -27,6 +27,7 @@ static char blame_usage[] =
 "  -p, --porcelain     Show in a format designed for machine consumption\n"
 "  -L n,m              Process only line range n,m, counting from 1\n"
 "  -M, -C              Find line movements within and across files\n"
+"  --incremental       Show blame entries as we find them, incrementally\n"
 "  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
 
 static int longest_file;
@@ -36,6 +37,7 @@ static int max_digits;
 static int max_score_digits;
 static int show_root;
 static int blank_boundary;
+static int incremental;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -1069,6 +1071,21 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		origin_decref(parent_origin[i]);
 }
 
+static void found_guilty_entry(struct blame_entry *ent)
+{
+	if (ent->guilty)
+		return;
+	ent->guilty = 1;
+	if (incremental) {
+		struct origin *origin = ent->suspect;
+		printf("%d %d %s:%s:%d\n",
+			ent->lno, ent->num_lines,
+			sha1_to_hex(origin->commit->object.sha1),
+			origin->path,
+			ent->s_lno);
+	}
+}
+
 static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 {
 	while (1) {
@@ -1102,7 +1119,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
 			if (!cmp_suspect(ent->suspect, suspect))
-				ent->guilty = 1;
+				found_guilty_entry(ent);
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -1717,6 +1734,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				die("More than one '-L n,m' option given");
 			bottomtop = arg;
 		}
+		else if (!strcmp("--incremental", arg))
+			incremental = 1;
 		else if (!strcmp("--score-debug", arg))
 			output_option |= OUTPUT_SHOW_SCORE;
 		else if (!strcmp("-f", arg) ||
@@ -1907,6 +1926,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	assign_blame(&sb, &revs, opt);
 
+	if (incremental)
+		return 0;
+
 	coalesce(&sb);
 
 	if (!(output_option & OUTPUT_PORCELAIN))
