From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [PATCH] CVSps fixed, git-cvsimport still buggy (WAS: [OT] ancestor branch in cvsps is wrong for branch-of-branch)
Date: Wed, 9 Nov 2005 17:26:34 -0500
Message-ID: <20051109222634.GA19209@pe.Belkin>
References: <20051101035148.GA11807@pe.Belkin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Cc: cvsps@dm.cobite.com, David Mansfield <david@cobite.com>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Nov 09 23:30:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZyPI-00053H-V6
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVKIW0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVKIW0i
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:26:38 -0500
Received: from eastrmmtao01.cox.net ([68.230.240.38]:39383 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751021AbVKIW0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 17:26:36 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109222554.RVIR13165.eastrmmtao01.cox.net@localhost>;
          Wed, 9 Nov 2005 17:25:54 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1EZyOo-00050B-Ll; Wed, 09 Nov 2005 17:26:34 -0500
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051101035148.GA11807@pe.Belkin>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11424>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[This is now on-topic.]

I tried the git-cvsimport script and found that in the
resulting git tree, on a branch-off-a-branch, files were missing from
the branch if they had been added to the branch's immediate parent.  I
really wanted this to work better, so I looked into it and learned
that CVSps was incorrectly reporting that the "ancestor" branch was
HEAD for a branch-off-a-branch.

Since CVSps wasn't reporting the correct branch relationships, I
couldn't blame git-cvsimport.  Trying to improve CVSps to get better
parent-detection proved much harder than I expected.  I had to use a
completely different algorithm that loops over all files instead of
just the files in the patchsets that are on the child branch.

Now that I've done that, [David, please see attached patch] CVSps does
report more accurate branch parents.  But, testing git-cvsimport with
the corrected CVSps output shows that it *still* doesn't produce the
right tree.  In fact, it's WORSE!  In the simple test script, not only
is file 'b' not on the 'dev' branch, but the 'stable' branch and the
file 'b' is completely MISSING form the git tree!

I could cut git-cvsimport some slack for failing to infer that file
'b' is also on the 'dev' branch, since I learned how hard that is when
I taught CVSps to make that inference.  But completely missing a
branch and all files added to it is not good.  

I'd *really* like to be told I'm off the deep end here, so if anyone
can set me straight please do.

If you want to reproduce this bug, use the test-script from my
original post (actually, I'll attach it again - it's been a while).
But you must first apply the attached patch to CVSps; or you can
instead use the '-P cvsps.out' option [which is quite handy BTW] to
git-cvsimport after you correct the one "Ancestor:" line from "HEAD"
to "stable" which is the only effect the new algorithm has on this
simple test case.  Note: the script demonstrates that 'b' is missing
from 'dev'.  To notice that 'stable' and 'b' are missing altogether
you have to say 'git-branch'.

If this stuff makes your head hurt like it does mine, you may want to
refer to the notes that I had to take in order to work through
this a half-hour at a time: http://www.codesifter.com/cvsps-notes.txt

-chris

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ancestor.diff"

 cvsps.c       |  242 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 cvsps_types.h |    2 
 2 files changed, 240 insertions(+), 4 deletions(-)

Index: cvsps-2.1/cvsps.c
===================================================================
--- cvsps-2.1.orig/cvsps.c
+++ cvsps-2.1/cvsps.c
@@ -81,9 +81,12 @@ static int ignore_cache;
 static int do_write_cache;
 static int statistics;
 static const char * test_log_file;
+/* branch_heads actually store branch "roots": [char *] to [PatchSet *]
+ * It's only used by the track_branch_ancestry option. */
 static struct hash_table * branch_heads;
 static struct list_head all_patch_sets;
 static struct list_head collisions;
+static struct list_head all_branches;
 
 /* settable via options */
 static int timestamp_fuzz_factor = 300;
@@ -143,8 +146,10 @@ static void set_psm_initial(PatchSetMemb
 static int check_rev_funk(PatchSet *, CvsFileRevision *);
 static CvsFileRevision * rev_follow_branch(CvsFileRevision *, const char *);
 static int before_tag(CvsFileRevision * rev, const char * tag);
-static void determine_branch_ancestor(PatchSet * ps, PatchSet * head_ps);
+static void determine_branch_ancestor(const PatchSet * ps, PatchSet * head_ps);
 static void handle_collisions();
+static void find_branch_parent(PatchSet *ps);
+static int is_ancestor_rev(const char *rev1, const char *rev2);
 
 int main(int argc, char *argv[])
 {
@@ -181,6 +186,7 @@ int main(int argc, char *argv[])
     branch_heads = create_hash_table(1023);
     INIT_LIST_HEAD(&all_patch_sets);
     INIT_LIST_HEAD(&collisions);
+    INIT_LIST_HEAD(&all_branches);
 
     /* this parses some of the CVS/ files, and initializes
      * the repository_path and other variables 
@@ -1259,6 +1265,29 @@ static int get_branch(char * buff, const
     return get_branch_ext(buff, rev, NULL);
 }
 
+/* Doesn't have to handle magic branches because parse_sym already did. */
+static int is_ancestor_rev(const char *rev1, const char *rev2)
+{
+    char b1[REV_STR_MAX], b2[REV_STR_MAX];
+    int len1 = strlen(rev1);
+    int len2 = strlen(rev2);
+    int leaf1, leaf2;
+
+    if (len1 > len2)
+        return 0;
+
+    if (strncmp(rev1, rev2, len1) == 0 || strcmp(rev1, "INITIAL") == 0)
+        return 1;
+
+    if (!get_branch_ext(b1, rev1, &leaf1) || !get_branch_ext(b2, rev2, &leaf2))
+        return 0;
+
+    if (strcmp(b1, b2) == 0 && leaf2 >= leaf1)
+        return 1;
+
+    return 0;
+}
+
 /* 
  * the goal if this function is to determine what revision to assign to
  * the psm->pre_rev field.  usually, the log file is strictly 
@@ -1499,11 +1528,15 @@ static void assign_patchset_id(PatchSet 
 	    PatchSet * head_ps = (PatchSet*)get_hash_object(branch_heads, ps->branch);
 	    if (!head_ps) 
 	    {
+                Tag *tag;
 		head_ps = ps;
 		put_hash_object(branch_heads, ps->branch, head_ps);
+                find_branch_parent(ps);
+                tag = (Tag*)malloc(sizeof(*tag));
+                tag->tag = ps->branch;
+                /* This is our own private tag list, so we use global_link.*/
+                list_add(&tag->global_link,  &all_branches);
 	    }
-	    
-	    determine_branch_ancestor(ps, head_ps);
 	}
     }
     else
@@ -2394,6 +2427,8 @@ void patch_set_add_member(PatchSet * ps,
 
 static void set_psm_initial(PatchSetMember * psm)
 {
+    char *p;
+
     psm->pre_rev = NULL;
     if (psm->post_rev->dead)
     {
@@ -2405,6 +2440,27 @@ static void set_psm_initial(PatchSetMemb
 	    debug(DEBUG_APPMSG1, "WARNING: branch_add already set!");
 	psm->ps->branch_add = 1;
     }
+
+    /* Maybe this is the best place to record which branch a file was
+       initially added on.  It seems the most accurate way is
+       also painful - read the commit message. */
+    if (psm->file->initial_branch)
+        debug(DEBUG_APPMSG1, "WARNING: initial_branch already set!");
+
+    psm->file->initial_ps = psm->ps;
+
+    p = strstr(psm->ps->descr, " was initially added on branch ");
+    if (p) {
+        char * end;
+        p += strlen(" was initially added on branch ");
+        end = strchr(p, '.');
+        if (end) {
+            *end = 0;
+            psm->file->initial_branch = get_string(p);
+            return;
+        }
+    }
+    psm->file->initial_branch = psm->ps->branch;
 }
 
 /* 
@@ -2532,7 +2588,13 @@ static void check_norc(int argc, char * 
     }
 }
 
-static void determine_branch_ancestor(PatchSet * ps, PatchSet * head_ps)
+/* When we track ancestor branches, we run determine_branch_ancestor()
+ * for every ps not on HEAD.  But, we only record the ancestor in
+ * head_ps.  head_ps is the first (i.e. "root") ps on the same branch as
+ * ps (which may be the same as ps).  In other words, we record the
+ * ancestor branch in the first patch that "branched-off".
+ */
+static void determine_branch_ancestor(const PatchSet * ps, PatchSet * head_ps)
 {
     struct list_head * next;
     CvsFileRevision * rev;
@@ -2599,6 +2661,178 @@ static void determine_branch_ancestor(Pa
     }
 }
 
+/* only needs to be called once for each new branch we start */
+static void find_branch_parent(PatchSet *ps)
+{
+    const char* child = ps->branch;
+    char* parent;
+    struct list_head *next;
+    struct hash_entry * he_file;
+    Tag *tag;
+
+    /* We use the 'rev' struct member unconventionally: as a flag to mark
+       which branches have not yet been eliminated from consideration. */
+
+    /* Mark every branch for consideration. */
+    for (next = all_branches.next; next != &all_branches; next = next->next)
+    {
+        tag = list_entry(next, Tag, global_link);
+        tag->rev = (CvsFileRevision *) 1; /* cast just to silence compiler */
+    }
+
+    reset_hash_iterator(file_hash);
+    while ((he_file = next_hash_entry(file_hash)))
+    {
+	CvsFile *file = (CvsFile*)he_file->he_obj;
+
+        if (!file->initial_branch) {
+            debug(DEBUG_APPERROR, "invalid initial_branch for file %s, probably from old cache, run with -x.", file->filename);
+            exit(1);
+        }
+
+        /* If the file was introduced later than the branch point, we
+           don't consider it.  NOTE: this won't catch the case where a
+           file is added to branch A, then later branch C branches off
+           of branch B, then branch A is merged into branch C.  In
+           that case, the initial date for the file is earlier than
+           the root-branch patchset, so the absence of the file from
+           branch B *DOES* eliminate B from being the parent of C. */
+        if (file->initial_ps->date > ps->date)
+            continue;
+
+        /* If the file was added on this branch, we can't use it to
+           eliminate other potential parents just because they don't
+           have this file. */
+        if (strcmp(file->initial_branch, child) == 0)
+            continue;
+
+        /* If we haven't yet seen the branch that file was initially
+           added to, then *that* branch may be a child of *this*
+           child.  In that case, we shouldn't expect that this file is
+           necessarily also on the parent branch - for the same reason
+           we ignore files added on the child branch immediately. */
+        if (strcmp(file->initial_branch, "HEAD") != 0 &&
+            NULL == get_hash_object(branch_heads, file->initial_branch))
+            continue;
+
+        /* Pick a branch to consider */
+        for (next = all_branches.next; next != &all_branches; next = next->next)
+        {
+            char *child_rev, *parent_rev;
+            tag = list_entry(next, Tag, global_link);
+            if (!tag->rev)
+                continue;  /* skip branches already eliminated */
+
+            parent = tag->tag;
+            child_rev = get_hash_object(file->branches_sym, child);
+            parent_rev = get_hash_object(file->branches_sym, parent);
+            if (child_rev) {
+                if (parent_rev) {
+                    if (!is_ancestor_rev(parent_rev, child_rev)) {
+                        tag->rev = NULL;
+                        debug(DEBUG_STATUS,
+                              "%s not parent of %s: %s REV %s vs. %s",
+                              parent, child, file->filename, parent_rev,
+                              child_rev);
+                    }
+                } else {
+                    /* If this file is on the child branch but not on
+                       the parent branch, then it's not the true
+                       parent.  WARNING: as commented above, this may
+                       falsely eliminate a parent if a file added to
+                       some other branch before this child's branch
+                       point is later merged onto the child.  That
+                       file may not be on the true parent, but we
+                       eliminate that parent anyway. Bah!
+                       Corner-cases?!  How often do people merge with
+                       children branches?  Anyway, this is too
+                       effective at eliminating incorrect parents to
+                       ignore. */
+                    tag->rev = NULL;
+                    debug(DEBUG_STATUS, "%s not parent of %s: parent missing %s",
+                          parent, child, file->filename);
+                }
+            } else {
+                /* What about the file on the parent but not the child?
+                   The file could have been added to the parent later than
+                   the branch point. But we catch that above.  More
+                   importantly, it could have been added to some other
+                   branch time-wise earlier than the branch point, and
+                   then merged onto this parent after the branch point.
+                   That's too hard to detect.  Also, there's the evil of
+                   partial-tree tagging.  The most common way this arises
+                   is that a child branches off just a portion (usually a
+                   sub-directory) of the tree.  In that case, lots of
+                   files are on the parent but not on the child.  So we'll
+                   be lenient and let this potential parent live another
+                   day. */
+#if 0
+                /* TODO?: maybe an optional "strict" mode could enable
+                   this, if the user is willing to assume there haven't
+                   been any partial-tree taggings. */
+                if (parent_rev) {
+                    tag->rev = NULL;
+                    debug(DEBUG_STATUS, "%s not parent of %s: child missing %s",
+                          parent, child, file->filename);
+                }
+#endif
+
+            }
+        } /* end of loop over potential parents */
+    }
+
+    /* Any remaining branches are possible parents. But, if any of
+       these branches are parents of other possible parents, we'll
+       say they're "grandparents" and not consider them for
+       parenthood. */
+    for (next = all_branches.next; next != &all_branches; next = next->next)
+    {
+        struct list_head *j;
+        tag = list_entry(next, Tag, global_link);
+        if (!tag->rev) continue;
+        for (j = all_branches.next; j != &all_branches; j = j->next)
+        {
+            Tag *tag2 = list_entry(j, Tag, global_link);
+            PatchSet *root_ps;
+            if (!tag2->rev) continue;
+            if (j == next) continue;
+            root_ps = (PatchSet*)get_hash_object(branch_heads, tag2->tag);
+            if (root_ps && strcmp(root_ps->ancestor_branch, tag->tag) == 0) {
+                tag->rev = NULL;
+                debug(DEBUG_STATUS, "eliminate %s: it's GRANDparent of %s via %s",
+                      tag->tag, child, tag2->tag);
+                break;
+            }
+        }
+    }
+
+    parent = NULL;
+    debug(DEBUG_STATUS, "Remaining parents for %s:", child);
+    for (next = all_branches.next; next != &all_branches; next = next->next)
+    {
+        tag = list_entry(next, Tag, global_link);
+        if (tag->rev) {
+            debug(DEBUG_STATUS, "    %s", tag->tag);
+            if (parent)
+                debug(DEBUG_STATUS, "Alternative ambiguous parent of %s: %s",
+                      child, tag->tag);
+            else
+                parent = tag->tag;
+        }
+    }
+
+    if (parent) {
+        debug(DEBUG_STATUS, "Assigning %s as parent of %s", parent, child);
+        ps->ancestor_branch = parent;
+    } else {
+        debug(DEBUG_STATUS, "HEAD parent of %s by default", child);
+        ps->ancestor_branch = "HEAD";
+        /* Strictly speaking, we didn't actually verify that HEAD
+           is a possible parent, but what else can we do if there
+           are no other branches left? */
+    }
+}
+
 static void handle_collisions()
 {
     struct list_head *next;
Index: cvsps-2.1/cvsps_types.h
===================================================================
--- cvsps-2.1.orig/cvsps_types.h
+++ cvsps-2.1/cvsps_types.h
@@ -71,6 +71,8 @@ struct _CvsFile
      * with the branch attribute NULL.  Later we need to resolve these.
      */
     int have_branches;
+    char *initial_branch;
+    PatchSet *initial_ps;
 };
 
 struct _PatchSetMember

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test5

#!/bin/sh
dirname=`date +"%Y%m%d%H%M%S"`
mkdir $dirname && cd $dirname

# create the repository
mkdir cvsroot && cd cvsroot
export CVSROOT=`pwd`
cd ..
cvs init

# import an empty project
mkdir project && cd project
cvs import -m "Create initial repo" project yoyo start
cd ..
rmdir project

# checkout the project
cvs co project && cd project

# create a new file on HEAD
echo 1 >a
cvs add a
cvs ci -m "added file a to HEAD" a

# create and switch to "stable" branch
cvs tag -b stable
cvs update -r stable 

# add a new file to stable branch
echo 2 > b
cvs add b
cvs ci -m "added file b to 'stable' branch" b

# create and switch to "dev" branch from "stable"
cvs tag -b dev
cvs update -r dev

# modify file 'a' on "dev" branch
echo "change" >> a
cvs ci -m "changed file a on dev branch" a

# see what CVS thinks the "dev" branch looks like
cd ..
rm -rf project
cvs checkout -r dev project
ls project && echo "Note how b is PRESENT"

# check output of cvsps
cd project
cvs log > ../cvslog
cd ..
cvsps -A -x --test-log cvslog project > cvsps.out

# check behavior of git-cvsimport
git-cvsimport -i -d $CVSROOT -C project.git project
cd project.git
git-checkout -f dev
ls && echo "Note how b is ABSENT!"


--pWyiEgJYm5f9v55/--
