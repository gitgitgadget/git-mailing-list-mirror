From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 16/20] cvsserver: generalize getmeta() to recognize commit refs
Date: Sat, 13 Oct 2012 23:42:29 -0600
Message-ID: <1350193353-19210-17-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDc-00073P-Jd
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab2JNF6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:05 -0400
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:54390
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by qmta15.emeryville.ca.mail.comcast.net with comcast
	id Atxo1k0010mlR8UAFty29B; Sun, 14 Oct 2012 05:58:02 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta11.emeryville.ca.mail.comcast.net with comcast
	id Att11k00A2wKXRC8Xtt1d4; Sun, 14 Oct 2012 05:53:02 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 242C31E9601B; Sat, 13 Oct 2012 23:43:20 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207629>

This allows getmeta() to recognize any commitish (sha1,
tag/branch name, etc).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 156 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 145 insertions(+), 11 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 53d8de7..7bb6f83 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -4041,6 +4041,19 @@ sub getlog
 This function takes a filename (with path) argument and returns a hashref of
 metadata for that file.
 
+There are several ways $revision can be specified:
+
+   - A reference to hash that contains a "tag" that is the
+     actual revision (one of the below).  TODO: Also allow it to
+     specify a "date" in the hash.
+   - undef, to refer to the latest version on the main branch.
+   - Full CVS client revision number (mapped to integer in DB, without the
+     "1." prefix),
+   - Complex CVS-compatible "special" revision number for
+     non-linear history (see comment below)
+   - git commit sha1 hash
+   - branch or tag name
+
 =cut
 
 sub getmeta
@@ -4051,23 +4064,144 @@ sub getmeta
     my $tablename_rev = $self->tablename("revision");
     my $tablename_head = $self->tablename("head");
 
-    my $db_query;
-    if ( defined($revision) and $revision =~ /^1\.(\d+)$/ )
+    if ( ref($revision) eq "HASH" )
     {
-        my ($intRev) = $1;
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_rev WHERE name=? AND revision=?",{},1);
-        $db_query->execute($filename, $intRev);
+        $revision = $revision->{tag};
+    }
+
+    # Overview of CVS revision numbers:
+    #
+    # General CVS numbering scheme:
+    #   - Basic mainline branch numbers: "1.1", "1.2", "1.3", etc.
+    #   - Result of "cvs checkin -r" (possible, but not really
+    #     recommended): "2.1", "2.2", etc
+    #   - Branch tag: "1.2.0.n", where "1.2" is revision it was branched
+    #     from, "0" is a magic placeholder that identifies it as a
+    #     branch tag instead of a version tag, and n is 2 times the
+    #     branch number off of "1.2", starting with "2".
+    #   - Version on a branch: "1.2.n.x", where "1.2" is branch-from, "n"
+    #     is branch number off of "1.2" (like n above), and "x" is
+    #     the version number on the branch.
+    #   - Branches can branch off of branches: "1.3.2.7.4.1" (even number
+    #     of components).
+    #   - Odd "n"s are used by "vendor branches" that result
+    #     from "cvs import".  Vendor branches have additional
+    #     strangeness in the sense that the main rcs "head" of the main
+    #     branch will (temporarily until first normal commit) point
+    #     to the version on the vendor branch, rather than the actual
+    #     main branch.  (FUTURE: This may provide an opportunity
+    #     to use "strange" revision numbers for fast-forward-merged
+    #     branch tip when CVS client is asking for the main branch.)
+    #
+    # git-cvsserver CVS-compatible special numbering schemes:
+    #   - Currently git-cvsserver only tries to be identical to CVS for
+    #     simple "1.x" numbers on the "main" branch (as identified
+    #     by the module name that was originally cvs checkout'ed).
+    #   - The database only stores the "x" part, for historical reasons.
+    #     But most of the rest of the cvsserver preserves
+    #     and thinks using the full revision number.
+    #   - To handle non-linear history, it uses a version of the form
+    #     "2.1.1.2000.b.b.b."..., where the 2.1.1.2000 is to help uniquely
+    #     identify this as a special revision number, and there are
+    #     20 b's that together encode the sha1 git commit from which
+    #     this version of this file originated.  Each b is
+    #     the numerical value of the corresponding byte plus
+    #     100.
+    #      - "plus 100" avoids "0"s, and also reduces the
+    #        likelyhood of a collision in the case that someone someday
+    #        writes an import tool that tries to preserve original
+    #        CVS revision numbers, and the original CVS data had done
+    #        lots of branches off of branches and other strangeness to
+    #        end up with a real version number that just happens to look
+    #        like this special revision number form.  Also, if needed
+    #        there are several ways to extend/identify alternative encodings
+    #        within the "2.1.1.2000" part if necessary.
+    #      - Unlike real CVS revisions, you can't really reconstruct what
+    #        relation a revision of this form has to other revisions.
+    #   - FUTURE: TODO: Rework database somehow to make up and remember
+    #     fully-CVS-compatible branches and branch version numbers.
+
+    my $meta;
+    if ( defined($revision) )
+    {
+        if ( $revision =~ /^1\.(\d+)$/ )
+        {
+            my ($intRev) = $1;
+            my $db_query;
+            $db_query = $self->{dbh}->prepare_cached(
+                "SELECT * FROM $tablename_rev WHERE name=? AND revision=?",
+                {},1);
+            $db_query->execute($filename, $intRev);
+            $meta = $db_query->fetchrow_hashref;
+        }
+        elsif ( $revision =~ /^2\.1\.1\.2000(\.[1-3][0-9][0-9]){20}$/ )
+        {
+            my ($commitHash)=($revision=~/^2\.1\.1\.2000(.*)$/);
+            $commitHash=~s/\.([0-9]+)/sprintf("%02x",$1-100)/eg;
+            if($commitHash=~/^[0-9a-f]{40}$/)
+            {
+                return $self->getMetaFromCommithash($filename,$commitHash);
+            }
+
+            # error recovery: fall back on head version below
+            print "E Failed to find $filename version=$revision or commit=$commitHash\n";
+            $log->warning("failed get $revision with commithash=$commitHash");
+            undef $revision;
+        }
+        elsif ( $revision =~ /^[0-9a-f]{40}$/ )
+        {
+            # Try DB first.  This is mostly only useful for req_annotate(),
+            # which only calls this for stuff that should already be in
+            # the DB.  It is fairly likely to be a waste of time
+            # in most other cases [unless the file happened to be
+            # modified in $revision specifically], but
+            # it is probably in the noise compared to how long
+            # getMetaFromCommithash() will take.
+            my $db_query;
+            $db_query = $self->{dbh}->prepare_cached(
+                "SELECT * FROM $tablename_rev WHERE name=? AND commithash=?",
+                {},1);
+            $db_query->execute($filename, $revision);
+            $meta = $db_query->fetchrow_hashref;
+
+            if(! $meta)
+            {
+                my($revCommit)=$self->lookupCommitRef($revision);
+                if($revCommit=~/^[0-9a-f]{40}$/)
+                {
+                    return $self->getMetaFromCommithash($filename,$revCommit);
+                }
+
+                # error recovery: nothing found:
+                print "E Failed to find $filename version=$revision\n";
+                $log->warning("failed get $revision");
+                return $meta;
+            }
+        }
+        else
+        {
+            my($revCommit)=$self->lookupCommitRef($revision);
+            if($revCommit=~/^[0-9a-f]{40}$/)
+            {
+                return $self->getMetaFromCommithash($filename,$revCommit);
+            }
+
+            # error recovery: fall back on head version below
+            print "E Failed to find $filename version=$revision\n";
+            $log->warning("failed get $revision");
+            undef $revision;  # Allow fallback
+        }
     }
-    elsif ( defined($revision) and $revision =~ /^[a-zA-Z0-9]{40}$/ )
+
+    if(!defined($revision))
     {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_rev WHERE name=? AND commithash=?",{},1);
-        $db_query->execute($filename, $revision);
-    } else {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_head WHERE name=?",{},1);
+        my $db_query;
+        $db_query = $self->{dbh}->prepare_cached(
+                "SELECT * FROM $tablename_head WHERE name=?",{},1);
         $db_query->execute($filename);
+        $meta = $db_query->fetchrow_hashref;
     }
 
-    my $meta = $db_query->fetchrow_hashref;
     if($meta)
     {
         $meta->{revision} = "1.$meta->{revision}";
-- 
1.7.10.2.484.gcd07cc5
