From: David Mansfield <david@cobite.com>
Subject: [PATCH] cvsps/cvsimport: fix branch point calculation and broken
	branch imports
Date: Tue, 01 Apr 2008 21:34:51 -0400
Organization: Cobite
Message-ID: <1207100091.10532.64.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-71SU1iU+4dv2h/Rkxp27"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 03:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgsDO-00087w-QB
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 03:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbYDBBzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 21:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755506AbYDBBzz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 21:55:55 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:43249 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755379AbYDBBzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 21:55:54 -0400
X-Greylist: delayed 1254 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Apr 2008 21:55:54 EDT
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id 4BB7BE11BE
	for <git@vger.kernel.org>; Tue,  1 Apr 2008 21:34:59 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b8zpITrJduZ3 for <git@vger.kernel.org>;
	Tue,  1 Apr 2008 21:34:52 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 63312E11BC
	for <git@vger.kernel.org>; Tue,  1 Apr 2008 21:34:52 -0400 (EDT)
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78674>


--=-71SU1iU+4dv2h/Rkxp27
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Everyone,

This email addresses a long-standing bug with the cvsimport which is due
to a bugs in cvsps.  The bug is that branches can be forked off too
late.  

In case you're wondering, I'm actually the original author of cvsps,
which is behind the scenes for cvsimport.  I don't call myself
maintainer because I've hardly been that over the last few years.

Anyway, the fix to cvsps is attached (1st 2 patches) as well as the
patch to git-cvsimport.perl (2nd 2 patches) against the master branch as
of today's git repo.

The cvsps patches apply with fuzz against the 2.1 version which is out
there.

The full tarball of the latest cvsps version including this is available
on the website http://www.cobite.com/cvsps as well, the version is
2.2b1.

I plan to find time in the next week or so to merge all of the
outstanding patches from Yann Dirson's git repo, publish cvsps via a git
repo myself, and fix other bugs as time permits (including adding
support for multiple tags).

I'd mainly like feedback if anyone can test this.

Also, as I'm actually a newb. to this list, if I'm violating any rules,
such as how to post the patches, let me know.

Thanks,
David

P.S Also, as many people may have imported broken branches already, can
anyone thing of a way to fix the branch, (maybe with git-rebase or
something)?  The breakage affects, I believe, files not ever modified on
the branch until any given point in time on the branch...


--=-71SU1iU+4dv2h/Rkxp27
Content-Disposition: attachment; filename=01-cvsps-add-branch-object.patch
Content-Type: application/mbox; name=01-cvsps-add-branch-object.patch
Content-Transfer-Encoding: 7bit

>From ba9a76a3edd461f2614a0c642cc135dfb849a519 Mon Sep 17 00:00:00 2001
From: David Mansfield <david@cobite.com>
Date: Mon, 31 Mar 2008 21:27:14 -0400
Subject: [PATCH] add a global branch object which will ultimately track branch points

---
 cvsps.c       |   20 ++++++++++++++++++++
 cvsps_types.h |   14 ++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index 7559308..bcc1d44 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -79,6 +79,7 @@ static const char * test_log_file;
 static struct hash_table * branch_heads;
 static struct list_head all_patch_sets;
 static struct list_head collisions;
+static struct hash_table * branches;
 
 /* settable via options */
 static int timestamp_fuzz_factor = 300;
@@ -140,6 +141,7 @@ static CvsFileRevision * rev_follow_branch(CvsFileRevision *, const char *);
 static int before_tag(CvsFileRevision * rev, const char * tag);
 static void determine_branch_ancestor(PatchSet * ps, PatchSet * head_ps);
 static void handle_collisions();
+static Branch * create_branch(const char * name) ;
 
 int main(int argc, char *argv[])
 {
@@ -174,6 +176,7 @@ int main(int argc, char *argv[])
     file_hash = create_hash_table(1023);
     global_symbols = create_hash_table(111);
     branch_heads = create_hash_table(1023);
+    branches = create_hash_table(1023);
     INIT_LIST_HEAD(&all_patch_sets);
     INIT_LIST_HEAD(&collisions);
 
@@ -2014,6 +2017,7 @@ static PatchSet * create_patch_set()
     if (ps)
     {
 	INIT_LIST_HEAD(&ps->members);
+	INIT_LIST_HEAD(&ps->branches);
 	ps->psid = -1;
 	ps->date = 0;
 	ps->min_date = 0;
@@ -2184,6 +2188,13 @@ char * cvs_file_add_branch(CvsFile * file, const char * rev, const char * tag)
     put_hash_object_ex(file->branches, new_rev, new_tag, HT_NO_KEYCOPY, NULL, NULL);
     put_hash_object_ex(file->branches_sym, new_tag, new_rev, HT_NO_KEYCOPY, NULL, NULL);
     
+    if (get_hash_object(branches, tag) == NULL) {
+	debug(DEBUG_STATUS, "adding new branch to branches hash: %s", tag);
+	Branch * branch = create_branch(tag);
+	put_hash_object_ex(branches, new_tag, branch, HT_NO_KEYCOPY, NULL, NULL);
+    }
+    
+
     return new_tag;
 }
 
@@ -2613,3 +2624,12 @@ void walk_all_patch_sets(void (*action)(PatchSet *))
 	action(ps);
     }
 }
+
+static Branch * create_branch(const char * name) 
+{
+    Branch * branch = (Branch*)calloc(1, sizeof(*branch));
+    branch->name = get_string(name);
+    branch->ps = NULL;
+    CLEAR_LIST_NODE(&branch->link);
+    return branch;
+}
diff --git a/cvsps_types.h b/cvsps_types.h
index 130dbb9..04c0c9f 100644
--- a/cvsps_types.h
+++ b/cvsps_types.h
@@ -16,6 +16,7 @@ typedef struct _PatchSetRange PatchSetRange;
 typedef struct _CvsFileRevision CvsFileRevision;
 typedef struct _GlobalSymbol GlobalSymbol;
 typedef struct _Tag Tag;
+typedef struct _Branch Branch;
 
 struct _CvsFileRevision
 {
@@ -126,6 +127,11 @@ struct _PatchSet
      */
     int funk_factor;
 
+    /* 
+     * a list of 'Branch' objects that branch from here
+     */
+    struct list_head branches;
+
     /* for putting onto a list */
     struct list_head all_link;
     struct list_head collision_link;
@@ -154,4 +160,12 @@ struct _Tag
     struct list_head rev_link;
 };
 
+struct _Branch
+{
+    char * name;
+    PatchSet * ps;
+    /* every patchset will have a list of branches that branch from there */
+    struct list_head link;
+};
+
 #endif /* CVSPS_TYPES_H */
-- 
1.5.4.1


--=-71SU1iU+4dv2h/Rkxp27
Content-Disposition: attachment; filename=02-cvsps-implement-branch-point-detection.patch
Content-Type: application/mbox; name=02-cvsps-implement-branch-point-detection.patch
Content-Transfer-Encoding: 7bit

>From 185cd958d0dbeb6c9e837dbcf4a9acfe5a52cf55 Mon Sep 17 00:00:00 2001
From: David Mansfield <david@cobite.com>
Date: Mon, 31 Mar 2008 21:49:40 -0400
Subject: [PATCH] implement branch point detection

---
 cvsps.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index bcc1d44..96b8f5d 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -142,6 +142,7 @@ static int before_tag(CvsFileRevision * rev, const char * tag);
 static void determine_branch_ancestor(PatchSet * ps, PatchSet * head_ps);
 static void handle_collisions();
 static Branch * create_branch(const char * name) ;
+static void find_branch_points(PatchSet * ps);
 
 int main(int argc, char *argv[])
 {
@@ -1439,7 +1440,6 @@ static void print_patch_set(PatchSet * ps)
     const char * funk = "";
 
     tm = localtime(&ps->date);
-    next = ps->members.next;
     
     funk = fnk_descr[ps->funk_factor];
     
@@ -1454,9 +1454,18 @@ static void print_patch_set(PatchSet * ps)
     if (ps->ancestor_branch)
 	printf("Ancestor branch: %s\n", ps->ancestor_branch);
     printf("Tag: %s %s\n", ps->tag ? ps->tag : "(none)", tag_flag_descr[ps->tag_flags]);
+    printf("Branches: ");
+    for (next = ps->branches.next; next != &ps->branches; next = next->next) {
+	Branch * branch = list_entry(next, Branch, link);
+	if (next != ps->branches.next)
+	    printf(",");
+	printf("%s", branch->name);
+    }
+    printf("\n");
     printf("Log:\n%s\n", ps->descr);
     printf("Members: \n");
 
+    next = ps->members.next;
     while (next != &ps->members)
     {
 	PatchSetMember * psm = list_entry(next, PatchSetMember, link);
@@ -1504,6 +1513,9 @@ static void assign_patchset_id(PatchSet * ps)
 	    
 	    determine_branch_ancestor(ps, head_ps);
 	}
+
+	find_branch_points(ps);
+
     }
     else
     {
@@ -2633,3 +2645,37 @@ static Branch * create_branch(const char * name)
     CLEAR_LIST_NODE(&branch->link);
     return branch;
 }
+
+static void find_branch_points(PatchSet * ps)
+{
+    struct list_head * next;
+    
+    /*
+     * for each member, check if the post-rev has any branch children.
+     * if so, the branch point for that branch cannot be earlier than this 
+     * PatchSet, so just assign here for new.
+     */
+    for (next = ps->members.next; next != &ps->members; next = next->next) 
+    {
+	PatchSetMember * psm = list_entry(next, PatchSetMember, link);
+	CvsFileRevision * rev = psm->post_rev;
+	struct list_head * child_iter;
+
+	for (child_iter = rev->branch_children.next; child_iter != &rev->branch_children; child_iter = child_iter->next) {
+	    CvsFileRevision * branch_child = list_entry(child_iter, CvsFileRevision, link);
+	    Branch * branch = get_hash_object(branches, branch_child->branch);
+	    if (branch == NULL) {
+		debug(DEBUG_APPERROR, "branch %s not found in global branch hash", branch_child->branch);
+		return;
+	    }
+	    
+	    if (branch->ps != NULL) {
+		list_del(&branch->link);
+	    }
+
+	    branch->ps = ps;
+	    list_add(&branch->link, ps->branches.prev);
+	}
+    }
+	
+}
-- 
1.5.4.1


--=-71SU1iU+4dv2h/Rkxp27
Content-Disposition: attachment; filename=03-cvsimport-parse-new-cvsps-output.patch
Content-Type: application/mbox; name=03-cvsimport-parse-new-cvsps-output.patch
Content-Transfer-Encoding: 7bit

>From 46e89a4c2fa6f7aaa7ecb71dfa82d3a978755197 Mon Sep 17 00:00:00 2001
From: David Mansfield <david@cobite.com>
Date: Tue, 1 Apr 2008 17:17:52 -0400
Subject: [PATCH] add parsing for the new Branches: line in cvsps output

---
 git-cvsimport.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..a7fd466 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -652,6 +652,7 @@ open(CVS, "<$cvspsfile") or die $!;
 #Author: wkoch
 #Branch: STABLE-BRANCH-1-0
 #Ancestor branch: HEAD
+#Branches: branch1,branch2,branch3
 #Tag: (none)
 #Log:
 #    See ChangeLog: Sat Sep 18 13:03:28 CEST 1999  Werner Koch
@@ -692,7 +693,7 @@ sub write_tree () {
 }
 
 my ($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my (@old,@new,@skipped,%ignorebranch);
+my (@old,@new,@skipped,%ignorebranch,@branches);
 
 # commits that cvsps cannot place anywhere...
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
@@ -840,6 +841,10 @@ while (<CVS>) {
 		} else {
 			$tag = $_;
 		}
+		$state = 12;
+	} elsif ($state == 12 and s/^Branches:\s+//) {
+		s/\s+$//;
+		@branches = split /,/;
 		$state = 7;
 	} elsif ($state == 7 and /^Log:/) {
 		$logmsg = "";
-- 
1.5.4.1


--=-71SU1iU+4dv2h/Rkxp27
Content-Disposition: attachment; filename=04-cvsimport-redo-branch-creation-process.patch
Content-Type: application/mbox; name=04-cvsimport-redo-branch-creation-process.patch
Content-Transfer-Encoding: 7bit

>From f26f976b83e29be567af9b056c5031203f83a094 Mon Sep 17 00:00:00 2001
From: David Mansfield <david@cobite.com>
Date: Tue, 1 Apr 2008 20:56:08 -0400
Subject: [PATCH] redo the branch creation process based on new metadata provided by cvsps

cvsps used to only provide the 'Ancestor Branch:' information in the branch
for creating new branches.  Actually, this was both insufficient and broken.
In fact, to correctly create a branch, you need to know the point at which
the branch comes from, not information about the first commit on the branch.

cvsps has been modified to provide just that.  So this change incorporates
that data and changes the way we create branches.

Now we create all branches immediately after commiting the changeset that
precedes the branching.
---
 git-cvsimport.perl |   66 ++++++++++++++++++++-------------------------------
 1 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index a7fd466..0444af8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -692,8 +692,8 @@ sub write_tree () {
 	return $tree;
 }
 
-my ($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my (@old,@new,@skipped,%ignorebranch,@branches);
+my ($patchset,$date,$author_name,$author_email,$branch,$tag,$logmsg);
+my (@old,@new,@skipped,%ignorebranch,@child_branches);
 
 # commits that cvsps cannot place anywhere...
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
@@ -711,11 +711,7 @@ sub commit {
 	    unless ($index{$branch}) {
 		$index{$branch} = tmpnam();
 		$ENV{GIT_INDEX_FILE} = $index{$branch};
-		if ($ancestor) {
-		    system("git-read-tree", "$remote/$ancestor");
-		} else {
-		    system("git-read-tree", "$remote/$branch");
-		}
+		system("git-read-tree", "$remote/$branch");
 		die "read-tree failed: $?\n" if $?;
 	    }
 	}
@@ -787,7 +783,9 @@ sub commit {
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
 	}
-};
+
+	return $cid;
+}
 
 my $commitcount = 1;
 while (<CVS>) {
@@ -826,12 +824,9 @@ while (<CVS>) {
 		$branch = $_;
 		$state = 5;
 	} elsif ($state == 5 and s/^Ancestor branch:\s+//) {
-		s/\s+$//;
-		$ancestor = $_;
-		$ancestor = $opt_o if $ancestor eq "HEAD";
+		# now ignored.  see 'Branches' below
 		$state = 6;
 	} elsif ($state == 5) {
-		$ancestor = undef;
 		$state = 6;
 		redo;
 	} elsif ($state == 6 and s/^Tag:\s+//) {
@@ -844,7 +839,7 @@ while (<CVS>) {
 		$state = 12;
 	} elsif ($state == 12 and s/^Branches:\s+//) {
 		s/\s+$//;
-		@branches = split /,/;
+		@child_branches = split /,/;
 		$state = 7;
 	} elsif ($state == 7 and /^Log:/) {
 		$logmsg = "";
@@ -871,33 +866,7 @@ while (<CVS>) {
 			$state = 11;
 			next;
 		}
-		if ($ancestor) {
-			if ($ancestor eq $branch) {
-				print STDERR "Branch $branch erroneously stems from itself -- changed ancestor to $opt_o\n";
-				$ancestor = $opt_o;
-			}
-			if (defined get_headref("$remote/$branch")) {
-				print STDERR "Branch $branch already exists!\n";
-				$state=11;
-				next;
-			}
-			my $id = get_headref("$remote/$ancestor");
-			if (!$id) {
-				print STDERR "Branch $ancestor does not exist!\n";
-				$ignorebranch{$branch} = 1;
-				$state=11;
-				next;
-			}
 
-			system(qw(git update-ref -m cvsimport),
-				"$remote/$branch", $id);
-			if($? != 0) {
-				print STDERR "Could not create branch $branch\n";
-				$ignorebranch{$branch} = 1;
-				$state=11;
-				next;
-			}
-		}
 		$last_branch = $branch if $branch ne $last_branch;
 		$state = 9;
 	} elsif ($state == 8) {
@@ -945,7 +914,24 @@ while (<CVS>) {
 		if ($opt_L && $commitcount > $opt_L) {
 			last;
 		}
-		commit();
+		my $cid = commit();
+		# the just made commit is the ancestor of all its branches
+		for my $child_branch (@child_branches) {
+			print "Creating child branch $child_branch\n" if $opt_v;
+			if (defined get_headref("$remote/$child_branch")) {
+				print STDERR "Branch $child_branch already exists!\n";
+				$state=11;
+				next;
+			}
+			system(qw(git update-ref -m cvsimport),
+				"$remote/$child_branch", $cid);
+			if($? != 0) {
+				print STDERR "Could not create branch $child_branch\n";
+				$ignorebranch{$child_branch} = 1;
+				$state=11;
+				next;
+			}
+		}
 		if (($commitcount & 1023) == 0) {
 			system("git repack -a -d");
 		}
-- 
1.5.4.1


--=-71SU1iU+4dv2h/Rkxp27--
