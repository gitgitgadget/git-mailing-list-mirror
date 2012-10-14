From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 03/20] cvsserver: add comments about database schema/usage
Date: Sat, 13 Oct 2012 23:42:16 -0600
Message-ID: <1350193353-19210-4-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH42-0006rG-Lt
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab2JNFsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:21 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54894 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab2JNFsU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:20 -0400
Received: from omta24.emeryville.ca.mail.comcast.net ([76.96.30.92])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Ato31k0031zF43QA1toLKb; Sun, 14 Oct 2012 05:48:20 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta24.emeryville.ca.mail.comcast.net with comcast
	id AtjK1k0062wKXRC8ktjKQ9; Sun, 14 Oct 2012 05:43:20 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 033111E9601B; Sat, 13 Oct 2012 23:43:18 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207621>

No functionality changes, but these comments should make it easier to
understand how it works.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f43d287..595865c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2129,6 +2129,10 @@ sub statecleanup
     $state->{entries} = {};
 }
 
+# Return working directory revision int "X" from CVS revision "1.X" out
+# of the the working directory "entries" state, for the given filename.
+# Return negative "X" to represent the file is scheduled for removal
+# when it is committed.
 sub revparse
 {
     my $filename = shift;
@@ -2901,6 +2905,16 @@ sub new
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
@@ -2928,6 +2942,15 @@ sub new
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
@@ -2950,6 +2973,7 @@ sub new
     }
 
     # Construct the properties table if required
+    #  - "last_commit" - Used by "sub update".
     unless ( $self->{tables}{$self->tablename("properties")} )
     {
         my $tablename = $self->tablename("properties");
@@ -2962,6 +2986,11 @@ sub new
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
@@ -2993,6 +3022,14 @@ sub tablename
 
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
@@ -3106,17 +3143,18 @@ sub update
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
 			    safe_pipe_capture('git', 'merge-base',
 						 $lastpicked, $parent);
-- 
1.7.10.2.484.gcd07cc5
