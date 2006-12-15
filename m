X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Do not show difftree for merges in "commit" view
Date: Fri, 15 Dec 2006 17:53:45 +0100
Message-ID: <11662016252211-git-send-email-jnareb@gmail.com>
References: <20061215160303.GG17860@spearce.org>
NNTP-Posting-Date: Fri, 15 Dec 2006 16:51:31 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Carl Worth <cworth@cworth.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h1b60BQ/eQ7+NuwJdjPcnWssoT6t+1D5cnHo/RUHmHYCnagvAiGjFEKuOeeZBvCa8sxOQ1Ksb5RTH5u135AL41N3kzfD4/5Z7W1glJTozhX+Iw4hlNHBtMhtHsLOn9JAO8RfjG4XKjEsVnJO2JsOGOexWyntPJSaA8ES0Z1EeY8=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <20061215160303.GG17860@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34534>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvGHP-0005wd-FY for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752855AbWLOQvY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbWLOQvY
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:51:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:51388 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752855AbWLOQvX (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 11:51:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so857092uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 08:51:22 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr109971ugm.1166201481907; Fri, 15
 Dec 2006 08:51:21 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 j3sm3762089ugd.2006.12.15.08.51.21; Fri, 15 Dec 2006 08:51:21 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBFGrmBk032438; Fri, 15 Dec 2006 17:53:49 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBFGrj0R032437; Fri, 15 Dec 2006 17:53:45 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Do not show difftree against first parent for merges (commits with
more than one parent) in "commit" view, because it usually is
misleading.  git-show and git-whatchanged doesn't show diff for merges
either.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 040ee71..ebf35a1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3572,14 +3572,19 @@ sub git_commit {
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent = $co{'parent'};
+	my $parents = $co{'parents'};
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
-		@diff_opts, $parent, $hash, "--"
-		or die_error(undef, "Open git-diff-tree failed");
-	my @difftree = map { chomp; $_ } <$fd>;
-	close $fd or die_error(undef, "Reading git-diff-tree failed");
+	my @difftree;
+	if (@$parents <= 1) {
+		# difftree output is not printed for merges
+		open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
+			@diff_opts, $parent, $hash, "--"
+				or die_error(undef, "Open git-diff-tree failed");
+		@difftree = map { chomp; $_ } <$fd>;
+		close $fd or die_error(undef, "Reading git-diff-tree failed");
+	}
 
 	# non-textual hash id's can be cached
 	my $expires;
@@ -3641,7 +3646,7 @@ sub git_commit {
 	}
 	print "</td>" .
 	      "</tr>\n";
-	my $parents = $co{'parents'};
+
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
@@ -3663,7 +3668,10 @@ sub git_commit {
 	git_print_log($co{'comment'});
 	print "</div>\n";
 
-	git_difftree_body(\@difftree, $hash, $parent);
+	if (@$parents <= 1) {
+		# do not output difftree/whatchanged for merges
+		git_difftree_body(\@difftree, $hash, $parent);
+	}
 
 	git_footer_html();
 }
-- 
1.4.4.1
