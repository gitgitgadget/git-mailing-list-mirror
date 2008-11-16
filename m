From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 3/4] gitweb: separate heads and remotes lists
Date: Sun, 16 Nov 2008 14:28:08 +0100
Message-ID: <1226842089-1159-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 14:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1hh9-00027T-BC
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 14:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYKPN2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 08:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbYKPN2I
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 08:28:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57037 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbYKPN2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 08:28:04 -0500
Received: by ug-out-1314.google.com with SMTP id 39so219624ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LOcK5I/i7yFh9eqHz89YKMZ+JaMa18Odbe4TcRLB1zc=;
        b=EZqz76XjPuBvmQHXuPCW4eWf9w1PBDRAyeQcxTvriNeO39TaHFdqdqljH3gopG/152
         4POerai7kaqwj2KPzgZ02GyCZQtQZPrJ3ViCeVLEcGGLr1SnXD+LJqf0+iTmSxrjh5pq
         VjmdSUTE2nqI2qFKwaL1zwdzKNFItf/9hdKWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=copXXaigOhFVd0+A8425ACdE1zJMoQ5f5piOULg0l9vYSX6DBCQCqr+F4guN3dNsGM
         ZvoZTzwxTTwYAps8RQL6FhXFN4nUGm1iaRanUKWLAGve/PeUpmEuphYNBuBl2dJ0pei/
         hJ6W1vED+Hcu9+c/GJLpvcZ2ZuMwHHoqkPXCM=
Received: by 10.67.117.13 with SMTP id u13mr850905ugm.15.1226842083844;
        Sun, 16 Nov 2008 05:28:03 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id x26sm1241403ugc.9.2008.11.16.05.28.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 05:28:03 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101129>

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
index 0512020..6b09918 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -527,6 +527,7 @@ our %actions = (
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
+	"remotes" => \&git_remotes,
 	"rss" => \&git_rss,
 	"atom" => \&git_atom,
 	"search" => \&git_search,
@@ -4467,6 +4468,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my $remote_heads = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -4474,7 +4476,8 @@ sub git_summary {
 	# These get_*_list functions return one more to allow us to see if
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
-	my @headlist = git_get_heads_list(16);
+	my @headlist = git_get_heads_list(16, 'heads');
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -4553,6 +4556,13 @@ sub git_summary {
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
@@ -4729,13 +4739,29 @@ sub git_heads {
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
1.5.6.5
