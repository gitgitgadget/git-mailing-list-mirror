From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 03/12] gitweb: separate heads and remotes lists
Date: Fri, 24 Sep 2010 18:02:38 +0200
Message-ID: <1285344167-8518-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:08:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzApV-0007kq-D3
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399Ab0IXQIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:08:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45090 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab0IXQIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:08:48 -0400
Received: by wyb28 with SMTP id 28so2056550wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6aJNiWUF/iEe1oDEOZtVFXQ6R6mwgI8pxKtbmKAOe7U=;
        b=l+zsyGHNT149s4NBqcxBuKmwW9+59gf9MFdJSirU7fwHEzudu26QcDXv15Cjz6q/ko
         hokEvPNF5pcCpiL6VHnSyPcmkdfQxEAevp7C33V/wUqyfCPhoctc2h3nW5STWwTydIiP
         vneEllQpFBJn8G1PEtmS+bB0NbQLbogwUdgJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J+r5NB5YnaNnJ4JWOHsbi7q/e6z+IzspFb0FRfvzzuif2ecvfd+q8XHDf6RSLejeYB
         3rg8wlb1rTHRMfJZL2j4CFcDGHINprDyqppA56lZHz4Yh+vkpNO0NXiY/Ded4RDX4fzy
         LwfNZoDquoVls5lpXjsRMthD3ahB2/5vdiRu4=
Received: by 10.216.176.8 with SMTP id a8mr9646072wem.93.1285344194218;
        Fri, 24 Sep 2010 09:03:14 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id u11sm1431002weq.31.2010.09.24.09.03.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157015>

We specialize the 'heads' action to only display local branches, and
introduce a 'remotes' action to display the remote branches (only
available when the remotes_head feature is enabled).

Mirroring this, we also split the heads list in summary view into
local and remote lists, each linking to the appropriate action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27c455e..fe9f73e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -712,6 +712,7 @@ our %actions = (
 	"log" => \&git_log,
 	"patch" => \&git_patch,
 	"patches" => \&git_patches,
+	"remotes" => \&git_remotes,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -5111,6 +5112,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my $remote_heads = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -5118,7 +5120,8 @@ sub git_summary {
 	# These get_*_list functions return one more to allow us to see if
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
-	my @headlist = git_get_heads_list(16);
+	my @headlist = git_get_heads_list(16, 'heads');
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5196,6 +5199,13 @@ sub git_summary {
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
@@ -5503,13 +5513,29 @@ sub git_heads {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my @headslist = git_get_heads_list();
+	my @headslist = git_get_heads_list(undef, 'heads');
 	if (@headslist) {
 		git_heads_body(\@headslist, $head);
 	}
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
