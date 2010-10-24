From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 03/10] gitweb: separate heads and remotes lists
Date: Sun, 24 Oct 2010 12:45:29 +0200
Message-ID: <1287917136-26103-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5w-0004rf-8o
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab0JXKqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0JXKqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:00 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RcnZ80bc8IY5m2mBcgJpv4qkLBKlgUdwhJdz5M3QBxo=;
        b=nfyxOtU375ntHISg7z3uw4wzM6sZBkWhREoKIX4e5pgumnOSEw8L1tmDC8auKIDWt8
         dtdnGUiVHZTOruNP8ipoZV2t7BG7EG2xXx2AN4aJZ4rX+C/K55ZK/uElA70vQEb/UcBb
         vktUAQAM9zldMvPLzLL/6Pa301E6o5FgPX3T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UosSEDHnT/g3h+ZcPyZCAw79OxpkXHDRpKV+CsRCpX3rRca/Du9fXxUz+v4LrGEbn1
         +6a1sZuGmluAbiUe8NchvQ8i74bdG+eH6vi7SnEFmnH5tTegkrcwuzbZiMMK0rKTqRDA
         ek1E096jJt+3Dg/rg27SKHvg+u6Y+q3+FL4KU=
Received: by 10.227.133.135 with SMTP id f7mr5153714wbt.117.1287917159571;
        Sun, 24 Oct 2010 03:45:59 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id i19sm4508494wbe.5.2010.10.24.03.45.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:45:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159846>

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
index e75d3f4..667c11b 100755
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
@@ -5126,6 +5127,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my $remote_heads = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -5133,7 +5135,8 @@ sub git_summary {
 	# These get_*_list functions return one more to allow us to see if
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
-	my @headlist = git_get_heads_list(16);
+	my @headlist = git_get_heads_list(16, 'heads');
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5211,6 +5214,13 @@ sub git_summary {
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
@@ -5518,13 +5528,29 @@ sub git_heads {
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
