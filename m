From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/7] gitweb: separate heads and remotes lists
Date: Thu, 16 Sep 2010 11:31:01 +0200
Message-ID: <1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:31:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAop-0007PY-RR
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab0IPJbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0IPJbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:40 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so130944wwe.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6c25zi/P1KhByL6qknQ5xMTBbXxwhuh8q4ielSMWuDg=;
        b=Swv3e1RaAzhIt55qNjDgipU4LyvCQ7akj07iRhLE0Ao9nxTOLoRymUJvJOiFd7Tqyv
         SIpLpZy70T8LcNAz4SR55ADChTdFzLLiVTyAgiMa1C8rui7FuSdPTQ/lj8O7DYwyaHQ7
         GIPORJPlueOaLFLPybJQUEUO2KvK/Csxn3LHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YCaw9UFUvjPEa9tm3OI2O+8le3FQACIKGrIW1R/t3WzEaCFa6sEet3D49VpYQ1dRQh
         ZRq7Bof842KGX37quRjCkdHykB5h4guNiRyFgdFdV5JMNS+019RQyznwELrtZXCsFmKE
         4oneNc1wI1ltXziWiqFWeWwciq2IbO/Ik1K4c=
Received: by 10.216.155.206 with SMTP id j56mr2440406wek.67.1284629500033;
        Thu, 16 Sep 2010 02:31:40 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id u11sm1668833weq.7.2010.09.16.02.31.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156304>

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
index 21e83bb..0118739 100755
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
@@ -5112,6 +5113,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my $remote_heads = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -5119,7 +5121,8 @@ sub git_summary {
 	# These get_*_list functions return one more to allow us to see if
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
-	my @headlist = git_get_heads_list(16);
+	my @headlist = git_get_heads_list(16, 'heads');
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5197,6 +5200,13 @@ sub git_summary {
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
@@ -5504,13 +5514,29 @@ sub git_heads {
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
1.7.3.rc1.230.g8b572
