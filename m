From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] gitweb: Do not esc_html $basedir argument to git_print_tree_entry
Date: Sat, 21 Oct 2006 17:53:09 +0200
Message-ID: <200610211753.09343.jnareb@gmail.com>
References: <200610211750.49188.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 17:55:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJBc-0004Tu-5E
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993114AbWJUPy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993120AbWJUPy4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:54:56 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:49061 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993114AbWJUPyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 11:54:55 -0400
Received: by hu-out-0506.google.com with SMTP id 28so571721hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DvELziBOtDZoxmfubSVbNvIA1wi9Ym6tpz/WN34Vrw/Q+S0zNhOMCs6i1acFBe1yYUsiUIrk71CyVWZtnFKH/NQosLHaxALgJf+A6kKLsXLnZ/smDuobHLe84iN7/RERkO+qMivbue4S/8+or3NYYwRw6n5h5fayQiL74tYoRUE=
Received: by 10.66.242.20 with SMTP id p20mr3948415ugh;
        Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm2762273uge.2006.10.21.08.54.53;
        Sat, 21 Oct 2006 08:54:53 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610211750.49188.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29625>

In git_tree, rename $base variable (which is passed as $basedir
argument to git_print_tree_entry) to $basedir. Do not esc_html
$basedir, as it is part of file_name ('f') argument in link and not
printed. Add '/' at the end only if $basedir is not empty (it is empty
for top directory) and doesn't end in '/' already.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
BUGFIX patch.

 gitweb/gitweb.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c457884..209b318 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2834,7 +2834,7 @@ sub git_tree {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
-	my $base = "";
+	my $basedir = '';
 	my ($have_blame) = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
@@ -2862,7 +2862,10 @@ sub git_tree {
 		print "<div class=\"title\">$hash</div>\n";
 	}
 	if (defined $file_name) {
-		$base = esc_html("$file_name/");
+		$basedir = $file_name;
+		if ($basedir ne '' && substr($basedir, -1) ne '/') {
+			$basedir .= '/';
+		}
 	}
 	git_print_page_path($file_name, 'tree', $hash_base);
 	print "<div class=\"page_body\">\n";
@@ -2878,7 +2881,7 @@ sub git_tree {
 		}
 		$alternate ^= 1;
 
-		git_print_tree_entry(\%t, $base, $hash_base, $have_blame);
+		git_print_tree_entry(\%t, $basedir, $hash_base, $have_blame);
 
 		print "</tr>\n";
 	}
-- 
1.4.2.1
