From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 03/10] cvsserver: remove unused functions _headrev and gethistory
Date: Sat, 24 Jan 2009 16:43:14 -0700
Message-ID: <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBa-0006Ei-TE
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbZAXXnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbZAXXnl
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:41 -0500
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:36407 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752996AbZAXXnc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:32 -0500
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id 7R291b0091GXsucA3bjYG9; Sat, 24 Jan 2009 23:43:32 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA07.emeryville.ca.mail.comcast.net with comcast
	id 7bjW1b00F1TYyYj8TbjXDg; Sat, 24 Jan 2009 23:43:32 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 7EB1289117;
	Sat, 24 Jan 2009 16:43:24 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107024>

Remove:
   - _headrev() - cvsserver already uses similar functionality
     from getmeta() and gethead().
   - gethistory() - cvsserver already uses similar functions
     gethistorydense() and getlog().
   - #'annotate' comment  - Uncommented annotate line is 2 lines earlier.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl |   37 ++++---------------------------------
 1 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f7891b8..fe23b49 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -78,7 +78,6 @@ my $methods = {
     'editors'         => \&req_EMPTY,
     'annotate'        => \&req_annotate,
     'Global_option'   => \&req_Globaloption,
-    #'annotate'        => \&req_CATCHALL,
 };
 
 ##############################################
@@ -3310,19 +3309,6 @@ sub insert_head
     $insert_head->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
 }
 
-sub _headrev
-{
-    my $self = shift;
-    my $filename = shift;
-    my $tablename = $self->tablename("head");
-
-    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM $tablename WHERE name=?",{},1);
-    $db_query->execute($filename);
-    my ( $hash, $revision, $mode ) = $db_query->fetchrow_array;
-
-    return ( $hash, $revision, $mode );
-}
-
 sub _get_prop
 {
     my $self = shift;
@@ -3382,6 +3368,8 @@ sub gethead
 
 =head2 getlog
 
+See also gethistorydense().
+
 =cut
 
 sub getlog
@@ -3467,25 +3455,6 @@ sub commitmessage
     return $message;
 }
 
-=head2 gethistory
-
-This function takes a filename (with path) argument and returns an arrayofarrays
-containing revision,filehash,commithash ordered by revision descending
-
-=cut
-sub gethistory
-{
-    my $self = shift;
-    my $filename = shift;
-    my $tablename = $self->tablename("revision");
-
-    my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $tablename WHERE name=? ORDER BY revision DESC",{},1);
-    $db_query->execute($filename);
-
-    return $db_query->fetchall_arrayref;
-}
-
 =head2 gethistorydense
 
 This function takes a filename (with path) argument and returns an arrayofarrays
@@ -3495,6 +3464,8 @@ This version of gethistory skips deleted entries -- so it is useful for annotate
 The 'dense' part is a reference to a '--dense' option available for git-rev-list
 and other git tools that depend on it.
 
+See also getlog().
+
 =cut
 sub gethistorydense
 {
-- 
1.6.1.81.g9833d.dirty
