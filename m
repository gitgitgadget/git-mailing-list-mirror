X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] gitweb: Show '...' links in "summary" view only if there are more items
Date: Tue, 19 Dec 2006 12:08:54 +0000
Message-ID: <20061219120854.GA16429@localhost>
References: <20061218224327.GG16029@localhost> <7vbqm0vkd6.fsf@assigned-by-dhcp.cox.net> <200612190159.24173.jnareb@gmail.com> <200612191214.58474.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 12:09:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Robert Fitzsimons <robfitz@273k.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612191214.58474.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34825>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwdmK-0004Zw-Ho for gcvg-git@gmane.org; Tue, 19 Dec
 2006 13:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932795AbWLSMIz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 07:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWLSMIy
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 07:08:54 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:39619 "EHLO
 igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932795AbWLSMIy (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 07:08:54 -0500
Received: from [212.2.165.238] (helo=localhost) by igraine.blacknight.ie with
 esmtp (Exim 4.60) (envelope-from <robfitz@273k.net>) id 1Gwdls-0002oD-Iw;
 Tue, 19 Dec 2006 12:08:36 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Show "..." links in "summary" view to shortlog, heads (if there are
any), and tags (if there are any) only if there are more items to show
than shown already.

This means that "..." link is shown below shortened shortlog if there
are more than 16 commits, "..." link below shortened heads list if
there are more than 16 heads refs (16 branches), "..." link below
shortened tags list if there are more than 16 tags.

Modified patch from Jakub to to apply cleanly to master, also preform
the same "..." link logic to the forks list.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---

> By the way, I have _NOT_ applied Robert Fitzsimons patch, but they
> (this patch and Robert patch) should be not in conflict if we remove
> last chunk of Robert's patch (this changing --count=17 to --count=15
> in git_summary).

Just removing the last chunk isn't correct, there are two slightly
different changes in that chuck.  The reduction in the max-count value
and a removal of a call to git_get_head_hash.

Here is an updated version of the patch which should apply against
master.

Robert



 gitweb/gitweb.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3bee34c..8d409c7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2918,8 +2918,9 @@ sub git_summary {
 	my $owner = git_get_project_owner($project);
 
 	my $refs = git_get_references();
-	my @taglist  = git_get_tags_list(15);
-	my @headlist = git_get_heads_list(15);
+	# we need to request one more than 16 (0..15) to check if those 16 are all
+	my @taglist  = git_get_tags_list(16);
+	my @headlist = git_get_heads_list(16);
 	my @forklist;
 	my ($check_forks) = gitweb_check_feature('forks');
 
@@ -2955,30 +2956,35 @@ sub git_summary {
 		}
 	}
 
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=16",
+	# we need to request one more than 16 (0..15) to check if those 16 are all
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
 		$head, "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 	git_print_header_div('shortlog');
 	git_shortlog_body(\@revlist, 0, 15, $refs,
+	                  $#revlist <=  15 ? undef :
 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
 	if (@taglist) {
 		git_print_header_div('tags');
 		git_tags_body(\@taglist, 0, 15,
+		              $#taglist <=  15 ? undef :
 		              $cgi->a({-href => href(action=>"tags")}, "..."));
 	}
 
 	if (@headlist) {
 		git_print_header_div('heads');
 		git_heads_body(\@headlist, $head, 0, 15,
+		               $#headlist <= 15 ? undef :
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
 	if (@forklist) {
 		git_print_header_div('forks');
 		git_project_list_body(\@forklist, undef, 0, 15,
+		                      $#forklist <= 15 ? undef :
 		                      $cgi->a({-href => href(action=>"forks")}, "..."),
 				      'noheader');
 	}
-- 
