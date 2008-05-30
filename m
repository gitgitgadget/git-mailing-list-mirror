From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash
Date: Sat, 31 May 2008 01:00:12 +0200
Message-ID: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 01:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Dab-00054d-M4
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 01:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbYE3W75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYE3W74
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:59:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:40335 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYE3W7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:59:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so209742fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=6RTnM4nVdylasgmW014l2oHTM5isIJx3c92KhDjHr4c=;
        b=hNTPhxk3ZHMKeNi1/dfOiJ2oUqDpyb1+alHuJ7JY+Pm1kFYMghEaYom5bXbS2ts/j8vkuqm7bko19uC/iYgL9QVe093iPUDyJBWgbxwS6Yx/Lwe1JoBIHD1lMPHcxcCGuO7l3f6f3Zoe5L8bV1B4su6U4a8qYvDzitz4QJlekfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=M1ZQRomjemPsIUyc3v33g3PEvwnmybkg1pQF+xZpAHQgyxC1aIS2d/VC4NoEx8Lofyl7s03XpMPTgpsODZRjlWwM/DEa16wGOUYPcHKUEi5uhgS4PkRbeOXa6f8tvZ1L71sYxrElAul1Iv0+Nkb5rVyA2gwRJHWjS/obhPmu5w8=
Received: by 10.86.71.1 with SMTP id t1mr1310114fga.36.1212188393787;
        Fri, 30 May 2008 15:59:53 -0700 (PDT)
Received: from fly ( [91.33.213.54])
        by mx.google.com with ESMTPS id 12sm1327191fgg.0.2008.05.30.15.59.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 15:59:53 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2Da1-0005Kf-0q; Sat, 31 May 2008 01:00:13 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83353>

This simplifies git_get_head_hash a lot; the method might eventually
even go away.

I haven't checked whether this causes an IO performance regression by
instantiating a new Git repository instance, but in the end
Git->repository will be as fast as possible and do no eager disk
accesses.  No benchmarking yet at this stage.

Minor change: Moved the parameter shift in git_blob_plain to the top
for readability.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---

I have tested this by running the smoke-test.pl script on my small
test repository -- this covers calls to git_get_head_hash -- and then
recursively diffing the two resulting wget output directories before
and after the change.  The trees were essentially identical (save a
few timestamps inside the snapshot files).

For brevity, I'll refer to this test procedure as something like
"smoke-test.pl showed no differences" in future patches. ;-)

 gitweb/gitweb.perl |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a1905..0efd2f7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -16,6 +16,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+use Git;
 binmode STDOUT, ':utf8';
 
 BEGIN {
@@ -1508,20 +1509,11 @@ sub git_cmd_str {
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
 	my $project = shift;
-	my $o_git_dir = $git_dir;
-	my $retval = undef;
-	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
-		my $head = <$fd>;
-		close $fd;
-		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
-			$retval = $1;
-		}
-	}
-	if (defined $o_git_dir) {
-		$git_dir = $o_git_dir;
-	}
-	return $retval;
+	my $directory = "$projectroot/$project";
+	# Legacy side effect on $git_dir.  This will eventually go
+	# away as the global $git_dir is eliminated.
+	$git_dir = $directory if (!defined $git_dir);
+	Git->repository(Directory => $directory)->parse_rev("HEAD");
 }
 
 # get type of given object
@@ -4377,8 +4369,9 @@ sub git_heads {
 }
 
 sub git_blob_plain {
-	my $expires;
+	my $type = shift;
 
+	my $expires;
 	if (!defined $hash) {
 		if (defined $file_name) {
 			my $base = $hash_base || git_get_head_hash($project);
@@ -4392,7 +4385,6 @@ sub git_blob_plain {
 		$expires = "+1d";
 	}
 
-	my $type = shift;
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 
-- 
1.5.5.GIT
