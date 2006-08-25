From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 13/19] gitweb: Add invisible hyperlink to from-file/to-file diff header
Date: Fri, 25 Aug 2006 21:05:07 +0200
Message-ID: <200608252105.07500.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:07:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGh1M-0007jn-Vs
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWHYTHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHYTHI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:07:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:21549 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751489AbWHYTHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:07:04 -0400
Received: by nf-out-0910.google.com with SMTP id o25so872264nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:07:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SIj6+Lcox74lL4ZPhrmCisBTukAFX/2VTS9o6xhSsy1ymepoTozKU12LJ53hrz22PmXh6CSJ2aDy9hPeGWuCP0Q23BA+G4I3lTc8l5xkqMB5ZEvoS4h6izTJo6ipsq83/gbBLAs2H1Q7ETReN0dICnUG/8/3RNGN8PVQ9rv/kTE=
Received: by 10.49.8.15 with SMTP id l15mr5801432nfi;
        Fri, 25 Aug 2006 12:07:03 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p72sm7119215nfc.2006.08.25.12.07.02;
        Fri, 25 Aug 2006 12:07:02 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26007>

Change replacing hashes as from-file/to-file with filenames from
difftree to adding invisible (except underlining on hover/mouseover)
hyperlink to from-file/to-file blob.  /dev/null as from-file or
to-file is not changed (is not hyperlinked).

This makes two-file from-file/to-file unified diff header parsing in
git_patchset_body more generic, and not only for legacy blobdiffs.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |   10 ++++++++++
 gitweb/gitweb.perl |   14 ++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 0912361..afd9e8a 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -273,11 +273,21 @@ td.mode {
 	font-family: monospace;
 }
 
+div.diff a.list {
+	text-decoration: none;
+}
+
+div.diff a.list:hover {
+	text-decoration: underline;
+}
+
+div.diff.to_file a.list,
 div.diff.to_file,
 div.diff.add {
 	color: #008800;
 }
 
+div.diff.from_file a.list,
 div.diff.from_file,
 div.diff.rem {
 	color: #cc0000;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9222e30..7e68292 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1711,8 +1711,11 @@ sub git_patchset_body {
 
 			my $file = $diffinfo->{'from_file'};
 			$file  ||= $diffinfo->{'file'};
-			$patch_line =~ s|a/[0-9a-fA-F]{40}|a/$file|g;
-			print "<div class=\"diff from_file\">" . esc_html($patch_line) . "</div>\n";
+			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
+			                               hash=>$diffinfo->{'from_id'}, file_name=>$file),
+			                -class => "list"}, esc_html($file));
+			$patch_line =~ s|a/.*$|a/$file|g;
+			print "<div class=\"diff from_file\">$patch_line</div>\n";
 
 			$patch_line = <$fd>;
 			chomp $patch_line;
@@ -1720,8 +1723,11 @@ sub git_patchset_body {
 			#$patch_line =~ m/^+++/;
 			$file    = $diffinfo->{'to_file'};
 			$file  ||= $diffinfo->{'file'};
-			$patch_line =~ s|b/[0-9a-fA-F]{40}|b/$file|g;
-			print "<div class=\"diff to_file\">" . esc_html($patch_line) . "</div>\n";
+			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
+			                               hash=>$diffinfo->{'to_id'}, file_name=>$file),
+			                -class => "list"}, esc_html($file));
+			$patch_line =~ s|b/.*|b/$file|g;
+			print "<div class=\"diff to_file\">$patch_line</div>\n";
 
 			next LINE;
 		}
-- 
1.4.1.1
