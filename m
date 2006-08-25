From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11/19] gitweb: Allow for pre-parsed difftree info in git_patchset_body
Date: Fri, 25 Aug 2006 20:59:39 +0200
Message-ID: <200608252059.39971.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:07:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGh1M-0007jn-Cp
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWHYTHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWHYTHF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:07:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:19500 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWHYTHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:07:02 -0400
Received: by nf-out-0910.google.com with SMTP id o25so872260nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:07:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Zx4DXTg4qsfJxPU20wRX5aqOfgtBD+ct5V2Kc9L6npcoNRz2lZ6GgJc9sb6nYGYw7k30A03VS8rQuwXyalgh/0T5npBecZ6UEIViOzA4z0vXSlSrHPpF3nmk+NxGaZ2cD77Qt85yH+xlNVKdVd8zWeQaW6YEa2fyXBZOmf9TiR4=
Received: by 10.48.163.19 with SMTP id l19mr5477182nfe;
        Fri, 25 Aug 2006 12:07:01 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p72sm7119215nfc.2006.08.25.12.07.00;
        Fri, 25 Aug 2006 12:07:00 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26006>

Preparation for converting git_blobdiff and git_blobdiff_plain
to use git-diff-tree patch format to generate patches.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   55 ++++++++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a3553ad..461ebcd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1624,7 +1624,7 @@ sub git_patchset_body {
 	my $patch_idx = 0;
 	my $in_header = 0;
 	my $patch_found = 0;
-	my %diffinfo;
+	my $diffinfo;
 
 	print "<div class=\"patchset\">\n";
 
@@ -1643,54 +1643,59 @@ sub git_patchset_body {
 			}
 			print "<div class=\"patch\">\n";
 
-			%diffinfo = parse_difftree_raw_line($difftree->[$patch_idx++]);
+			if (ref($difftree->[$patch_idx]) eq "HASH") {
+				$diffinfo = $difftree->[$patch_idx];
+			} else {
+				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
+			}
+			$patch_idx++;
 
 			# for now, no extended header, hence we skip empty patches
 			# companion to	next LINE if $in_header;
-			if ($diffinfo{'from_id'} eq $diffinfo{'to_id'}) { # no change
+			if ($diffinfo->{'from_id'} eq $diffinfo->{'to_id'}) { # no change
 				$in_header = 1;
 				next LINE;
 			}
 
-			if ($diffinfo{'status'} eq "A") { # added
-				print "<div class=\"diff_info\">" . file_type($diffinfo{'to_mode'}) . ":" .
+			if ($diffinfo->{'status'} eq "A") { # added
+				print "<div class=\"diff_info\">" . file_type($diffinfo->{'to_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo{'to_id'}, file_name=>$diffinfo{'file'})},
-				              $diffinfo{'to_id'}) . "(new)" .
+				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
+				              $diffinfo->{'to_id'}) . "(new)" .
 				      "</div>\n"; # class="diff_info"
 
-			} elsif ($diffinfo{'status'} eq "D") { # deleted
-				print "<div class=\"diff_info\">" . file_type($diffinfo{'from_mode'}) . ":" .
+			} elsif ($diffinfo->{'status'} eq "D") { # deleted
+				print "<div class=\"diff_info\">" . file_type($diffinfo->{'from_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo{'from_id'}, file_name=>$diffinfo{'file'})},
-				              $diffinfo{'from_id'}) . "(deleted)" .
+				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
+				              $diffinfo->{'from_id'}) . "(deleted)" .
 				      "</div>\n"; # class="diff_info"
 
-			} elsif ($diffinfo{'status'} eq "R" || # renamed
-			         $diffinfo{'status'} eq "C") { # copied
+			} elsif ($diffinfo->{'status'} eq "R" || # renamed
+			         $diffinfo->{'status'} eq "C") { # copied
 				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo{'from_mode'}) . ":" .
+				      file_type($diffinfo->{'from_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo{'from_id'}, file_name=>$diffinfo{'from_file'})},
-				              $diffinfo{'from_id'}) .
+				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'from_file'})},
+				              $diffinfo->{'from_id'}) .
 				      " -> " .
-				      file_type($diffinfo{'to_mode'}) . ":" .
+				      file_type($diffinfo->{'to_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo{'to_id'}, file_name=>$diffinfo{'to_file'})},
-				              $diffinfo{'to_id'});
+				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'to_file'})},
+				              $diffinfo->{'to_id'});
 				print "</div>\n"; # class="diff_info"
 
 			} else { # modified, mode changed, ...
 				print "<div class=\"diff_info\">" .
-				      file_type($diffinfo{'from_mode'}) . ":" .
+				      file_type($diffinfo->{'from_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
-				                             hash=>$diffinfo{'from_id'}, file_name=>$diffinfo{'file'})},
-				              $diffinfo{'from_id'}) .
+				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
+				              $diffinfo->{'from_id'}) .
 				      " -> " .
-				      file_type($diffinfo{'to_mode'}) . ":" .
+				      file_type($diffinfo->{'to_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-				                             hash=>$diffinfo{'to_id'}, file_name=>$diffinfo{'file'})},
-				              $diffinfo{'to_id'});
+				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
+				              $diffinfo->{'to_id'});
 				print "</div>\n"; # class="diff_info"
 			}
 
-- 
1.4.1.1
