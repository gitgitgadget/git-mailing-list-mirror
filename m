X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add "next" link to commit view
Date: Fri, 15 Dec 2006 21:57:16 +0100
Message-ID: <11662162364166-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Fri, 15 Dec 2006 20:54:58 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=cQutwjt2sNmBrLlM1HsbLEWThOYdgJh98c6k0GTTbC+zhaI3J+n7oaBfZ4T6USgazkEKRJYrhPS3hDcWB9LxplewTWVYwnii+V205VXc1Xm3pZXrBkBL8ItOy8rEIZ33u+ko4Zj+gB7cIc/e/FUPVyZqjvZjFiQARx+rOCceQAw=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34548>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvK4z-0006pc-KG for gcvg-git@gmane.org; Fri, 15 Dec
 2006 21:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964842AbWLOUyv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 15:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWLOUyu
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 15:54:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:6872 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964842AbWLOUyt (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 15:54:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so914911uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 12:54:48 -0800 (PST)
Received: by 10.67.19.13 with SMTP id w13mr598054ugi.1166216088155; Fri, 15
 Dec 2006 12:54:48 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 q1sm4894076uge.2006.12.15.12.54.47; Fri, 15 Dec 2006 12:54:47 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBFKvH8p004374; Fri, 15 Dec 2006 21:57:18 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBFKvGt3004373; Fri, 15 Dec 2006 21:57:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add a kind of "next" view in the bottom part of navigation bar for
"commit" view, similar to what was added for "commitdiff" view in
commit 151602df00b8e5c5b4a8193f59a94b85f9b5aebc
  'gitweb: Add "next" link to commitdiff view'

For "commit" view for single parent commit:
  (parent: _commit_)
For "commit" view for merge (multi-parent) commit:
  (merge: _commit_ _commit_ ...)
For "commit" view for root (parentless) commit
  (initial)
where _link_ denotes hyperlink.  SHA1 of commit is shortened
to 7 characters on display.

While at it, remove leftovers from commit cae1862a by Petr Baudis:
  'gitweb: More per-view navigation bar links'
namely the "blame" link if there exist $file_name and commit has a
parent; it was added in git_commit probably by mistake.  The rest
of what mentioned commit added for git_commit was removed in
commit 6e0e92fda893311ff5af91836e5007bf6bbd4a21 by Luben Tuikov:
  'gitweb: Do not print "log" and "shortlog" redundantly in commit view'
(which should have probably removed also this "blame" link removed now).


Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
By the way, the history shown above was found using git 'pickaxe',
namely
  $ git log -p -S'my @views_nav = ();' -- gitweb/
which found the first commit. I have noticed that some parts of
what this patch added to git_commit were removed later:
  $ git log -p -S'push @views_nav,' -- gitweb/
found the second commit mentioned.

The first part could be found also by git-blame command (or
any other annotate/blame command in any other SCM), but to
notice the second...


 gitweb/gitweb.perl |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ebf35a1..902c514 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3571,8 +3571,34 @@ sub git_commit {
 	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
-	my $parent = $co{'parent'};
-	my $parents = $co{'parents'};
+	my $parent  = $co{'parent'};
+	my $parents = $co{'parents'}; # listref
+
+	# we need to prepare $formats_nav before any parameter munging
+	my $formats_nav;
+	if (!defined $parent) {
+		# --root commitdiff
+		$formats_nav .= '(initial)';
+	} elsif (@$parents == 1) {
+		# single parent commit
+		$formats_nav .=
+			'(parent: ' .
+			$cgi->a({-href => href(action=>"commit",
+			                       hash=>$parent)},
+			        esc_html(substr($parent, 0, 7))) .
+			')';
+	} else {
+		# merge commit
+		$formats_nav .=
+			'(merge: ' .
+			join(' ', map {
+				$cgi->a({-href => href(action=>"commitdiff",
+				                       hash=>$_)},
+				        esc_html(substr($_, 0, 7)));
+			} @$parents ) .
+			')';
+	}
+
 	if (!defined $parent) {
 		$parent = "--root";
 	}
@@ -3596,16 +3622,10 @@ sub git_commit {
 
 	my $have_snapshot = gitweb_have_snapshot();
 
-	my @views_nav = ();
-	if (defined $file_name && defined $co{'parent'}) {
-		push @views_nav,
-			$cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)},
-			        "blame");
-	}
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
-	                   join (' | ', @views_nav));
+	                   $formats_nav);
 
 	if (defined $co{'parent'}) {
 		git_print_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
-- 
1.4.4.1
