From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 12/19] gitweb: Parse two-line from-file/to-file diff header in git_patchset_body
Date: Fri, 25 Aug 2006 21:04:13 +0200
Message-ID: <200608252104.13607.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGh1L-0007jn-Q7
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWHYTHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWHYTHG
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:07:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:27693 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751475AbWHYTHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:07:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so872262nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:07:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U4vZa9i0u8GyJ8Mk5ydjiGrDkFnefIuEeSk7dOqk3mQRvFBRMkNBmGLxnMx6cFezPiKv6aLP48+WzL5Qixpc7H3sHo1pESN16d1aY8Ly06j0BMDWpxNR7rq890Bka2JGQTCt2FSn0KDmz6xtGTaJ/vpG5XZsMxK3d6kZ6l6q2nI=
Received: by 10.48.162.15 with SMTP id k15mr5792254nfe;
        Fri, 25 Aug 2006 12:07:02 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p72sm7119215nfc.2006.08.25.12.07.01;
        Fri, 25 Aug 2006 12:07:01 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26005>

Parse two-line from-file/to-file unified diff header in
git_patchset_body directly, instead of leaving pretty-printing to
format_diff_line function.  Hashes as from-file/to-file are replaced
by proper from-file and to-file names (from $diffinfo); in the future
we can put hyperlinks there.  This makes possible to do blobdiff with
only blobs hashes.

The lines in two-line unified diff header have now class "from_file"
and "to_file"; the style is chosen to match previous output (classes
"rem" and "add" because of '-' and '+' as first character of patch
line).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    2 ++
 gitweb/gitweb.perl |   18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5eaa24f..0912361 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -273,10 +273,12 @@ td.mode {
 	font-family: monospace;
 }
 
+div.diff.to_file,
 div.diff.add {
 	color: #008800;
 }
 
+div.diff.from_file,
 div.diff.rem {
 	color: #cc0000;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 461ebcd..9222e30 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1706,8 +1706,24 @@ sub git_patchset_body {
 
 
 		if ($in_header && $patch_line =~ m/^---/) {
-			#print "</div>\n"
+			#print "</div>\n"; # class="diff extended_header"
 			$in_header = 0;
+
+			my $file = $diffinfo->{'from_file'};
+			$file  ||= $diffinfo->{'file'};
+			$patch_line =~ s|a/[0-9a-fA-F]{40}|a/$file|g;
+			print "<div class=\"diff from_file\">" . esc_html($patch_line) . "</div>\n";
+
+			$patch_line = <$fd>;
+			chomp $patch_line;
+
+			#$patch_line =~ m/^+++/;
+			$file    = $diffinfo->{'to_file'};
+			$file  ||= $diffinfo->{'file'};
+			$patch_line =~ s|b/[0-9a-fA-F]{40}|b/$file|g;
+			print "<div class=\"diff to_file\">" . esc_html($patch_line) . "</div>\n";
+
+			next LINE;
 		}
 		next LINE if $in_header;
 
-- 
1.4.1.1
