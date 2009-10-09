From: "Simon Arlott" <simon@fire.lp0.eu>
Subject: [PATCH] git-svn: hide find_parent_branch output in double quiet 
 mode
Date: Fri, 9 Oct 2009 13:21:13 +0100
Message-ID: <b01cac406b93d5c67e3ae2e9a7aaa498a52dd9fc@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 09 14:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEjj-0007lo-Jx
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668AbZJIMch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 08:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759761AbZJIMch
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:32:37 -0400
Received: from proxima.lp0.eu ([81.2.80.65]:60371 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935AbZJIMcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:32:36 -0400
X-Greylist: delayed 644 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2009 08:32:36 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=exim; d=fire.lp0.eu;
	h=Received:Received:Message-ID:Date:Subject:From:To:Cc:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:Importance;
	b=iyac9tjmSkWXRVIHlbikf+KJjs0gn1YIT6a/DXL/q8WPow3h2vwhSItApR46SNu6lKGY24I+KFJ1YEUVUT4CXQd6ctbqQxOxQmwFus6uQZi+mpl22xNYUfMxPvcvuT6L;
Received: from lp0_webmail by proxima.lp0.eu with local 
	id 1MwETB-0002On-5r; Fri, 09 Oct 2009 13:21:13 +0100
Received: from simon by proxima.lp0.eu with https;
        Fri, 9 Oct 2009 13:21:13 +0100
User-Agent: SquirrelMail/1.4.19
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129795>

Hide find_parent_branch logging when -qq is specified.
This eliminates more unnecessary output when run from cron, e.g.:

Found possible branch point:
http://undernet-ircu.svn.sourceforge.net/svnroot/undernet-ircu/ircu2/trunk =>
http://undernet-ircu.svn.sourceforge.net/svnroot/undernet-ircu/ircu2/branches/authz,
1919
Found branch parent: (authz) ea061d76aea985dc0208d36fa5e0b2249b698557
Following parent with do_switch
Successfully followed parent

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 git-svn.perl |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e0ec258..fd36270 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2626,7 +2626,8 @@ sub find_parent_branch {
 	my $url = $self->ra->{url};
 	my $new_url = $url . $branch_from;
 	print STDERR  "Found possible branch point: ",
-	              "$new_url => ", $self->full_url, ", $r\n";
+	              "$new_url => ", $self->full_url, ", $r\n"
+	              unless $::_q > 1;
 	$branch_from =~ s#^/##;
 	my $gs = $self->other_gs($new_url, $url,
 		                 $branch_from, $r, $self->{ref_id});
@@ -2647,11 +2648,13 @@ sub find_parent_branch {
 		($r0, $parent) = $gs->find_rev_before($r, 1);
 	}
 	if (defined $r0 && defined $parent) {
-		print STDERR "Found branch parent: ($self->{ref_id}) $parent\n";
+		print STDERR "Found branch parent: ($self->{ref_id}) $parent\n"
+		             unless $::_q > 1;
 		my $ed;
 		if ($self->ra->can_do_switch) {
 			$self->assert_index_clean($parent);
-			print STDERR "Following parent with do_switch\n";
+			print STDERR "Following parent with do_switch\n"
+			             unless $::_q > 1;
 			# do_switch works with svn/trunk >= r22312, but that
 			# is not included with SVN 1.4.3 (the latest version
 			# at the moment), so we can't rely on it
@@ -2666,18 +2669,20 @@ sub find_parent_branch {
 			print STDERR "Trees match:\n",
 			             "  $new_url\@$r0\n",
 			             "  ${\$self->full_url}\@$rev\n",
-				     "Following parent with no changes\n";
+			             "Following parent with no changes\n"
+			             unless $::_q > 1;
 			$self->tmp_index_do(sub {
 			    command_noisy('read-tree', $parent);
 			});
 			$self->{last_commit} = $parent;
 		} else {
-			print STDERR "Following parent with do_update\n";
+			print STDERR "Following parent with do_update\n"
+			             unless $::_q > 1;
 			$ed = SVN::Git::Fetcher->new($self);
 			$self->ra->gs_do_update($rev, $rev, $self, $ed)
 			  or die "SVN connection failed somewhere...\n";
 		}
-		print STDERR "Successfully followed parent\n";
+		print STDERR "Successfully followed parent\n" unless $::_q > 1;
 		return $self->make_log_entry($rev, [$parent], $ed);
 	}
 	return undef;
@@ -2822,7 +2827,7 @@ sub other_gs {
 		$ref_id .= "\@$r";
 		# just grow a tail if we're not unique enough :x
 		$ref_id .= '-' while find_ref($ref_id);
-		print STDERR "Initializing parent: $ref_id\n";
+		print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;
 		my ($u, $p, $repo_id) = ($new_url, '', $ref_id);
 		if ($u =~ s#^\Q$url\E(/|$)##) {
 			$p = $u;
-- 
1.6.3.3

-- 
Simon Arlott
