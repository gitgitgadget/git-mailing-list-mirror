From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 04/11] gitweb: separate heads and remotes lists
Date: Thu, 11 Nov 2010 13:26:11 +0100
Message-ID: <1289478378-15604-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWEi-0000Gr-6S
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab0KKM0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0KKM0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:36 -0500
Received: by mail-ww0-f44.google.com with SMTP id 29so64691wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WixOmPGycSRR4hR6nA3dvLifyBMWN5fQL95vyVjmS6g=;
        b=M/Bx/0xbP1xcyRop7UflPK+OQEWAyc0oq5XuJgB9hNJSRdx8XBGLLiFCwl+hU5JkgW
         HLejUkupnScnUKUM3j6TgjSpKGF4SB9waG3YxRxCXsghylwx6ROWpVh6GiPD/2qVDpAR
         YI3dbL6i6OBk5/zLC3hJ3VG4lGZKIbCIIxniQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gh6OPv7EXANiHnzv+8HhleFdrpGEbkjXbMhbEnHhMzb+STDl7KrvYILo60dn7oDKNW
         v1LU91JXv14sU0NYgpqdX+ym8CZaTI1/gbbwQsHawn+C9G2bkGbg86b1bJCdmuEUfmSp
         x/xgWR0g3RG02OkhXWDUcq9ycP3GUyj+UU+yM=
Received: by 10.227.145.68 with SMTP id c4mr763167wbv.42.1289478395285;
        Thu, 11 Nov 2010 04:26:35 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id c16sm1241097wef.17.2010.11.11.04.26.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:34 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161233>

We specialize the 'heads' action to only display local branches, and
introduce a 'remotes' action to display the remote branches (only
available when the remotes_head feature is enabled).

Mirroring this, we also split the heads list in summary view into
local and remote lists, each linking to the appropriate action.

The git_get_heads_list now defaults to 'heads' only, regardless of
whether the remote heads feature is active or not.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 951bb0d..9fcbbb2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -719,6 +719,7 @@ our %actions = (
 	"log" => \&git_log,
 	"patch" => \&git_patch,
 	"patches" => \&git_patches,
+	"remotes" => \&git_remotes,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -3170,10 +3171,7 @@ sub parse_from_to_diffinfo {
 
 sub git_get_heads_list {
 	my ($limit, @classes) = @_;
-	unless (@classes) {
-		my $remote_heads = gitweb_check_feature('remote_heads');
-		@classes = ('heads', $remote_heads ? 'remotes' : ());
-	}
+	@classes = ('heads') unless @classes;
 	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
@@ -5126,6 +5124,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my $remote_heads = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -5134,6 +5133,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5211,6 +5211,13 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
+	if (@remotelist) {
+		git_print_header_div('remotes');
+		git_heads_body(\@remotelist, $head, 0, 15,
+		               $#remotelist <= 15 ? undef :
+		               $cgi->a({-href => href(action=>"remotes")}, "..."));
+	}
+
 	if (@forklist) {
 		git_print_header_div('forks');
 		git_project_list_body(\@forklist, 'age', 0, 15,
@@ -5525,6 +5532,22 @@ sub git_heads {
 	git_footer_html();
 }
 
+sub git_remotes {
+	gitweb_check_feature('remote_heads')
+		or die_error(403, "Remote heads view is disabled");
+
+	my $head = git_get_head_hash($project);
+	git_header_html();
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project);
+
+	my @remotelist = git_get_heads_list(undef, 'remotes');
+	if (@remotelist) {
+		git_heads_body(\@remotelist, $head);
+	}
+	git_footer_html();
+}
+
 sub git_blob_plain {
 	my $type = shift;
 	my $expires;
-- 
1.7.3.68.g6ec8
