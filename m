From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Mon, 23 Oct 2006 00:37:56 +0200
Message-ID: <200610230037.57183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Oct 23 00:37:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gblwx-0005Rv-0X
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 00:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJVWhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWJVWhm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 18:37:42 -0400
Received: from qb-out-0506.google.com ([72.14.204.239]:44936 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWJVWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 18:37:41 -0400
Received: by qb-out-0506.google.com with SMTP id p36so375914qba
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:37:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QwVPP95SfOpLuSsqZLwqooCglMtBPpmwajlcyqyy9Jxv4nkujEhr5YrhuDNC3nnKq7m6GzPctW+QYGu5wn5gOwanp7GVLrZEk+KsgTlb7MFufOY18N3Xf/HC8e9cl2bea0LVIvaSBO17QS3hW0etevIqvJvAN1KLWFcQ+k8aGAo=
Received: by 10.67.103.7 with SMTP id f7mr6223445ugm;
        Sun, 22 Oct 2006 15:37:40 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e33sm1642608ugd.2006.10.22.15.37.39;
        Sun, 22 Oct 2006 15:37:39 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29799>

Add a kind of "next" view in the bottom part of navigation bar for
"commitdiff" view.

For commitdiff between two commits:
  (from: _commit_)
For commitdiff for one single parent commit:
  (parent: _commit_)
For commitdiff for one merge commit
  (merge: _commit_ _commit_ ...)
For commitdiff for root (parentless) commit
  (initial)
where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
display, everything is perhaps unnecessary esc_html on display.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Junio (and others), is it what you wanted? The idea was to change
"commitdiff" view only in minimal way, and preserve similarity
to "commit" format. 

SHA1 ids are printed in monospace (fixed width) font. BTW. should
we put '...' after shortened SHA1? Should those '...' be included
in link?


 gitweb/gitweb.perl |   49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c9e57f0..4241d5c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3280,6 +3280,51 @@ sub git_commitdiff {
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
+
+	# we need to prepare $formats_nav before any parameter munging
+	my $formats_nav;
+	if ($format eq 'html') {
+		$formats_nav =
+			$cgi->a({-href => href(action=>"commitdiff_plain",
+			                       hash=>$hash, hash_parent=>$hash_parent)},
+			        "raw");
+
+		if (defined $hash_parent) {
+			# commitdiff with two commits given
+			my $hash_parent_short = $hash_parent;
+			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
+				$hash_parent_short = substr($hash_parent, 0, 7);
+			}
+			$formats_nav .=
+				' (from: ' .
+				$cgi->a({-href => href(action=>"commitdiff",
+				                       hash=>$hash_parent)},
+				        esc_html($hash_parent_short)) .
+				')';
+		} elsif (!$co{'parent'}) {
+			# --root commitdiff
+			$formats_nav .= ' (initial)';
+		} elsif (scalar @{$co{'parents'}} == 1) {
+			# single parent commit
+			$formats_nav .=
+				' (parent: ' .
+				$cgi->a({-href => href(action=>"commitdiff",
+				                       hash=>$co{'parent'})},
+				        esc_html(substr($co{'parent'}, 0, 7))) .
+				')';
+		} else {
+			# merge commit
+			$formats_nav .=
+				' (merge: ' .
+				join(' ', map {
+					$cgi->a({-href => href(action=>"commitdiff",
+					                       hash=>$_)},
+					        esc_html(substr($_, 0, 7)));
+				} @{$co{'parents'}} ) .
+				')';
+		}
+	}
+
 	if (!defined $hash_parent) {
 		$hash_parent = $co{'parent'} || '--root';
 	}
@@ -3317,10 +3362,6 @@ sub git_commitdiff {
 	if ($format eq 'html') {
 		my $refs = git_get_references();
 		my $ref = format_ref_marker($refs, $co{'id'});
-		my $formats_nav =
-			$cgi->a({-href => href(action=>"commitdiff_plain",
-			                       hash=>$hash, hash_parent=>$hash_parent)},
-			        "raw");
 
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
-- 
1.4.2.1
