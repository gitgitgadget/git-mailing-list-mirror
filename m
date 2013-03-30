From: Michael Contreras <michael@inetric.com>
Subject: [PATCH] git-svn: avoid self-referencing mergeinfo
Date: Sat, 30 Mar 2013 18:06:42 -0400
Message-ID: <20130330220642.GA14641@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Jacobs <bjacobs@woti.com>, Eric Wong <normalperson@yhbt.net>,
	Avishay Lavie <avishay.lavie@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 23:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM3vj-0006o3-UM
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 23:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab3C3WGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 18:06:47 -0400
Received: from mail-gh0-f181.google.com ([209.85.160.181]:48095 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3C3WGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 18:06:46 -0400
Received: by mail-gh0-f181.google.com with SMTP id 3so189319ghz.12
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inetric.com; s=google;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=i+3CykCXOKE5a/wVDTjyF7dCpvWEK1egoNRLHnKhBOY=;
        b=p8uFgFY6s7hoZoBSBG2mnQnn2QRHNpNvBsrMS9GZ7+x7PS6LwzoI//gDOEhGnYEjpg
         tShu92k7KYBwgFDleTXzDvlPSLj0c76Ll+xgXMW5LwHNjk7P7sRGd/SWsS3BQNCzI5JD
         gf7CWCv0vcMvST9nuoqJ6XVfYl/dyZV3cKxcM=
X-Received: by 10.236.158.194 with SMTP id q42mr4586734yhk.62.1364681205695;
        Sat, 30 Mar 2013 15:06:45 -0700 (PDT)
Received: from gmail.com (70-88-178-169-Atlanta.hfc.comcastbusiness.net. [70.88.178.169])
        by mx.google.com with ESMTPS id v48sm12972294yhi.26.2013.03.30.15.06.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 15:06:44 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219597>

When svn.pushmergeinfo is set, the target branch is included in the
mergeinfo if it was previously merged into one of the source branches.
SVN does not do this.

Remove merge target branch path from resulting mergeinfo when
svn.pushmergeinfo is set to better match the behavior of SVN. Update the
svn-mergeinfo-push test.

Signed-off-by: Michael Contreras <michael@inetric.com>
Reported-by: Avishay Lavie <avishay.lavie@gmail.com>
---

Avishay's original patch was never applied.
http://thread.gmane.org/gmane.comp.version-control.git/193123

 git-svn.perl                      | 9 ++++++---
 t/t9161-git-svn-mergeinfo-push.sh | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b46795f..bd4388d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -669,12 +669,14 @@ sub merge_revs_into_hash {
 }
 
 sub merge_merge_info {
-	my ($mergeinfo_one, $mergeinfo_two) = @_;
+	my ($mergeinfo_one, $mergeinfo_two, $ignore_branch) = @_;
 	my %result_hash = ();
 
 	merge_revs_into_hash(\%result_hash, $mergeinfo_one);
 	merge_revs_into_hash(\%result_hash, $mergeinfo_two);
 
+	delete $result_hash{$ignore_branch} if $ignore_branch;
+
 	my $result = '';
 	# Sort below is for consistency's sake
 	for my $branchname (sort keys(%result_hash)) {
@@ -695,6 +697,7 @@ sub populate_merge_info {
 		my $all_parents_ok = 1;
 		my $aggregate_mergeinfo = '';
 		my $rooturl = $gs->repos_root;
+		my ($target_branch) = $gs->full_pushurl =~ /^\Q$rooturl\E(.*)/;
 
 		if (defined($rewritten_parent)) {
 			# Replace first parent with newly-rewritten version
@@ -726,7 +729,7 @@ sub populate_merge_info {
 			# Merge previous mergeinfo values
 			$aggregate_mergeinfo =
 				merge_merge_info($aggregate_mergeinfo,
-								 $par_mergeinfo, 0);
+								 $par_mergeinfo, $target_branch);
 
 			next if $parent eq $parents[0]; # Skip first parent
 			# Add new changes being placed in tree by merge
@@ -769,7 +772,7 @@ sub populate_merge_info {
 			my $newmergeinfo = "$branchpath:" . join(',', @revsin);
 			$aggregate_mergeinfo =
 				merge_merge_info($aggregate_mergeinfo,
-								 $newmergeinfo, 1);
+								 $newmergeinfo, $target_branch);
 		}
 		if ($all_parents_ok and $aggregate_mergeinfo) {
 			return $aggregate_mergeinfo;
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index 6ef0c0b..1eab701 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -88,7 +88,6 @@ test_expect_success 'check reintegration mergeinfo' '
 	test "$mergeinfo" = "/branches/svnb1:2-4,7-9,13-18
 /branches/svnb2:3,8,16-17
 /branches/svnb3:4,9
-/branches/svnb4:5-6,10-12
 /branches/svnb5:6,11"
 	'
 
-- 
1.8.2
