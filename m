From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 02/10] cvsserver: add comments about database schema/usage
Date: Sat, 24 Jan 2009 16:43:13 -0700
Message-ID: <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBY-0006Ei-Qy
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbZAXXnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZAXXnd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:33 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:49250 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272AbZAXXn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:29 -0500
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id 7RJs1b00P1HpZEsA5bjVv1; Sat, 24 Jan 2009 23:43:29 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id 7bjT1b0061TYyYj8abjTSV; Sat, 24 Jan 2009 23:43:28 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 5558F89116;
	Sat, 24 Jan 2009 16:43:24 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107017>

No functionality changes, but these comments should make it easier to
understand how it works.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

This is the result of some initial research into what it would
take to support switching branches/tags/commithashes for the entire
sandbox using "cvs update -r TAG".  This seems like the one remaining
big missing feature that makes git-cvsserver a substantial downgrade
compared to a real CVS server.

git-cvsserver's support for cvs's "-r" arguments is kind of hit
or miss:
   - Some commands ignore it completely.  This includes "checkout",
     but checkout does have a kind of workaround: you can checkout
     any branch by specifying "cvs checkout branch".  (Normally
     it is "cvs checkout module".)  But that sandbox is then locked
     to that branch, you can't switch to another.
   - Some commands (e.g. update) allow you to specify CVS-style
     version numbers with -r, but that is generally only useful if
     you are examining a single file.
   - Some of those commands also recognize git commit hashes.  But
     due to the internal database model, the commithash form will only
     work for files that were actually modified in the requested
     commit, and for which cvsserver has previously decided that
     the commit is on the same branch that the sandbox
     is locked to (it has already assigned CVS revision numbers
     for it).  Other commands (including update) do not recognize
     the commithash form at all (ignores it if it doesn't look like
     a CVS version number, even though the underlying getmeta()
     function is more a little more general).

Even the relatively simple goal of being able to update to an
older version on the same branch involves some significant costs:
   - Perhaps store O(numCommits*totalNumFiles) entries in the
     revision table, instead of the current more reasonable
     O(numCommits*averageNumChangedFilesPerCommit).  Perhaps
     this could be combined with a significant schema change that
     involves assigning short ints to distinct commithash
     values and distinct filenames, looking up author/mode
     information directly in git on demand, and just storing the
     short ints in the revisions table to shrink each row
     as much as possible.
   - Fork off extra git commands to find the most recent
     commit (relative to the supplied commit) that modified each
     file, then look that up in the DB.  For many files, it
     is likely to have to search quite a ways, and if it the search
     is done with a separate command per file, it could
     get expensive.  Also watch out for "other"
     branches that won't be in the DB.  Sounds like a lot
     of extra CPU usage re-parsing commit history for every
     file...

Thoughts about full branch support in cvsserver:
   - One way would be to add a "branch" column to the "revisions"
     and "headers" tables.  Also add a branch table (details TBD)?
   - Alternatively, drop the DB and see if maybe we could store
     file revision number information using git's core data structures:
     "refs/cvsfileversions/{branch}", with a tree structure for storing
     file revision number to commithash/path mappings that is
     specifically designed to use the strengths of the DAG
     representation and pack files.
   - I have vague notions of other techniques as well.
   - Recognise that names of branches may change as heads advance
     and things get merged, but the CVS branch /number/ needs
     to remain consistent.
   - Recognize that in general you can not reliably regenerate
     the DB.  Depending on what sequence of git-cvsserver and
     git-merge commands, versions of files can end up with
     different CVS revision numbers.
   - Has anyone thought about implementing server emulators for
     other version control systems (git-svnserver and similar)?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 git-cvsserver.perl |   46 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1de0c1e..f7891b8 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2045,6 +2045,10 @@ sub statecleanup
     $state->{entries} = {};
 }
 
+# Return working directory revision int "X" from CVS revision "1.X" out
+# of the the working directory "entries" state, for the given filename.
+# Return negative "X" to represent the file is scheduled for removal
+# when it is committed.
 sub revparse
 {
     my $filename = shift;
@@ -2775,6 +2779,16 @@ sub new
     }
 
     # Construct the revision table if required
+    # The revision table stores an entry for each file, each time that file
+    # changes.
+    #   numberOfRecords = O( numCommits * averageNumChangedFilesPerCommit )
+    # This is not sufficient to support "-r {commithash}" for any
+    # files except files that were modified by that commit (also,
+    # some places in the code ignore/effectively strip out -r in
+    # some cases, before it gets passed to getmeta()).
+    # The "filehash" field typically has a git blob hash, but can also
+    # be set to "dead" to indicate that the given version of the file
+    # should not exist in the sandbox.
     unless ( $self->{tables}{$self->tablename("revision")} )
     {
         my $tablename = $self->tablename("revision");
@@ -2802,6 +2816,15 @@ sub new
     }
 
     # Construct the head table if required
+    # The head table (along with the "last_commit" entry in the property
+    # table) is the persisted working state of the "sub update" subroutine.
+    # All of it's data is read entirely first, and completely recreated
+    # last, every time "sub update" runs.
+    # This is also used by "sub getmeta" when it is asked for the latest
+    # version of a file (as opposed to some specific version).
+    # Another way of thinking about it is as a single slice out of
+    # "revisions", giving just the most recent revision information for
+    # each file.
     unless ( $self->{tables}{$self->tablename("head")} )
     {
         my $tablename = $self->tablename("head");
@@ -2824,6 +2847,7 @@ sub new
     }
 
     # Construct the properties table if required
+    #  - "last_commit" - Used by "sub update".
     unless ( $self->{tables}{$self->tablename("properties")} )
     {
         my $tablename = $self->tablename("properties");
@@ -2836,6 +2860,11 @@ sub new
     }
 
     # Construct the commitmsgs table if required
+    # The commitmsgs table is only used for merge commits, since
+    # "sub update" will only keep one branch of parents.  Shortlogs
+    # for ignored commits (i.e. not on the chosen branch) will be used
+    # to construct a replacement "collapsed" merge commit message,
+    # which will be stored in this table.  See also "sub commitmessage".
     unless ( $self->{tables}{$self->tablename("commitmsgs")} )
     {
         my $tablename = $self->tablename("commitmsgs");
@@ -2867,6 +2896,14 @@ sub tablename
 
 =head2 update
 
+Bring the database up to date with the latest changes from
+the git repository.
+
+Internal working state is read out of the "head" table and the
+"last_commit" property, then it updates "revisions" based on that, and
+finally it writes the new internal state back to the "head" table
+so it can be used as a starting point the next time update is called.
+
 =cut
 sub update
 {
@@ -2980,17 +3017,18 @@ sub update
                 next;
             } elsif (@{$commit->{parents}} > 1) {
                 # it is a merge commit, for each parent that is
-                # not $lastpicked, see if we can get a log
+                # not $lastpicked (not given a CVS revision number),
+                # see if we can get a log
                 # from the merge-base to that parent to put it
                 # in the message as a merge summary.
                 my @parents = @{$commit->{parents}};
                 foreach my $parent (@parents) {
-                    # git-merge-base can potentially (but rarely) throw
-                    # several candidate merge bases. let's assume
-                    # that the first one is the best one.
                     if ($parent eq $lastpicked) {
                         next;
                     }
+                    # git-merge-base can potentially (but rarely) throw
+                    # several candidate merge bases. let's assume
+                    # that the first one is the best one.
 		    my $base = eval {
 			    safe_pipe_capture('git-merge-base',
 						 $lastpicked, $parent);
-- 
1.6.1.81.g9833d.dirty
