From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 11:56:05 -0700
Message-ID: <7vk6mpnz96.fsf@assigned-by-dhcp.cox.net>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org>
	<7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org>
	<7vsm1do0t4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261137350.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:52:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQV9g-0004Ir-Ld
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVDZS4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVDZS4l
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:56:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33773 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261726AbVDZS4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 14:56:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426185604.VMAS550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 14:56:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261137350.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 26 Apr 2005 11:38:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Tue, 26 Apr 2005, Junio C Hamano wrote:
>> 
>> Well, I somehow thought these things are in fixed column format;
>> mode, ->, sha, stage, and filename are all seperated with either
>> ' ' or '\t'.  So if I copy MN to "1 MN", presumably you would
>> see this:
>> 
>> 100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 MN
>> 100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 1 MN
>> 
>> So while I agree that // would also work, I fail to see why you
>> would even need that.

LT> Because I'd rather _not_ have the 0 in there at all for the normal case.

LT> Yes, it's there for "show-files --stages", but it's certainly _not_ there 
LT> in "diff-tree" output right now.

I know.  But first let's step back a bit.

Running diff-cache when you have unmerged entries in your
GIT_INDEX_FILE is fundamentally broken.  You first read_cache(),
and then you read-tree into stage 1 of the named tree, and at
that point, you do not know what stage 1 means.

We should just fix "remove-merge-entries" and call that
unconditionally before the read-tree is called.  Once it is
fixed, we need to think about how to show this stage
information but that should be a separate discussion.

I have attached two versions of patch.  The first one is against
the original before my stupid question; the second one is
against the one if you applied my previous patch, to revert most
of its stupidity.

################################################################
--- Patch against the original before I asked that stupid question:

cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-snap -v 0
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -76,7 +76,7 @@ static void remove_merge_entries(void)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
-			break;
+			continue;
 		printf("%s: unmerged\n", ce->name);
 		while (remove_entry_at(i)) {
 			if (!ce_stage(active_cache[i]))


################################################################
--- Patch to revert the stupidity:
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-snap -v 2
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 
-static int leave_unmerged = 0;
 static int cached_only = 0;
 static int line_termination = '\n';
 
@@ -86,8 +85,7 @@ static void remove_merge_entries(void)
 	}
 }
 
-static char *diff_cache_usage =
-"diff-cache [-r] [-z] [--cached] [--unmerged] <tree sha1>";
+static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -112,18 +110,13 @@ int main(int argc, char **argv)
 			cached_only = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--unmerged")) {
-			leave_unmerged = 1;
-			continue;
-		}
 		usage(diff_cache_usage);
 	}
 
 	if (argc != 2 || get_sha1_hex(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
-	if (!leave_unmerged)
-		remove_merge_entries();
+	remove_merge_entries();
 
 	tree = read_tree_with_tree_or_commit_sha1(tree_sha1, &size, 0);
 	if (!tree)

