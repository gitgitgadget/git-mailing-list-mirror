From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Always set 'from_file' and 'to_file' in parse_difftree_raw_line
Date: Thu,  1 Nov 2007 12:38:08 +0100
Message-ID: <1193917089-15920-2-git-send-email-jnareb@gmail.com>
References: <1193917089-15920-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 12:36:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYLC-0001N2-Sy
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 12:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbXKALfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 07:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbXKALfq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 07:35:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:63586 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbXKALfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 07:35:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so450344ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jGBaFwApPDy1IWB7VS6cudd5fSp7dSZXJ04B452p4+I=;
        b=Pp852rTeM47+G9VrbZwjSNiTY+e/1bpnEQduplcQXC5fNNPOixMA+cXsdylMv1O7DDHfqo3bBlWi2wweBMeVi0hebWZHlonr3bWke/icizdaeeta10EJW6tRGPtqoEK0iQ+LBbAgF/jma2+vRIyIgkSwV9dFkNjwJ6RNx6y2zrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CpWUP25bbMOCmarxoDbMh1GKOwaFlY27J6LqjH3pyoDWZQo15ER4+u5aZ/vxiZNNRiOL/0VBKWOQJxivtR97f47vqPUEYw8NVf7rk7P1G9ri51JZHBdgrerR14XCLVjD2TfkMkOUel/G668W1g5PTKnn6v64ft0VAHnGGjjkWVI=
Received: by 10.66.239.16 with SMTP id m16mr2236969ugh.1193916940749;
        Thu, 01 Nov 2007 04:35:40 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id s8sm2177307uge.2007.11.01.04.35.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 04:35:39 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1BcBwl015949;
	Thu, 1 Nov 2007 12:38:11 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1BcB5X015948;
	Thu, 1 Nov 2007 12:38:11 +0100
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1193917089-15920-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62936>

Always set 'from_file' and 'to_file' keys when parsing raw diff output
format line, even if filename didn't change (file was not renamed).
This allows for simpler code (and no problems with file named '0').

Use
  $diffinfo->{'from_file'}
instead of
  $diffinfo->{'from_file'} || $diffinfo->{'file'}
from now on.

While at it, replace (for merge commits)
  $diffinfo->{'from_file'}[$i] || $diffinfo->{'to_file'}
by
  defined $diffinfo->{'from_file'}[$i] ?
          $diffinfo->{'from_file'}[$i] :
          $diffinfo->{'to_file'};
to have no problems woth file named '0'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2e00756..79ea7ec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1995,7 +1995,7 @@ sub parse_difftree_raw_line {
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
 			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
 		} else {
-			$res{'file'} = unquote($7);
+			$res{'from_file'} = $res{'to_file'} = $res{'file'} = unquote($7);
 		}
 	}
 	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
@@ -2062,7 +2062,10 @@ sub parse_from_to_diffinfo {
 		fill_from_file_info($diffinfo, @parents)
 			unless exists $diffinfo->{'from_file'};
 		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
-			$from->{'file'}[$i] = $diffinfo->{'from_file'}[$i] || $diffinfo->{'to_file'};
+			$from->{'file'}[$i] = 
+				defined $diffinfo->{'from_file'}[$i] ?
+				        $diffinfo->{'from_file'}[$i] :
+				        $diffinfo->{'to_file'};
 			if ($diffinfo->{'status'}[$i] ne "A") { # not new (added) file
 				$from->{'href'}[$i] = href(action=>"blob",
 				                           hash_base=>$parents[$i],
@@ -2074,7 +2077,7 @@ sub parse_from_to_diffinfo {
 		}
 	} else {
 		# ordinary (not combined) diff
-		$from->{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
+		$from->{'file'} = $diffinfo->{'from_file'};
 		if ($diffinfo->{'status'} ne "A") { # not new (added) file
 			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 			                       hash=>$diffinfo->{'from_id'},
@@ -2084,7 +2087,7 @@ sub parse_from_to_diffinfo {
 		}
 	}
 
-	$to->{'file'} = $diffinfo->{'to_file'} || $diffinfo->{'file'};
+	$to->{'file'} = $diffinfo->{'to_file'};
 	if (!is_deleted($diffinfo)) { # file exists in result
 		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
 		                     hash=>$diffinfo->{'to_id'},
@@ -2829,7 +2832,7 @@ sub is_patch_split {
 	my ($diffinfo, $patchinfo) = @_;
 
 	return defined $diffinfo && defined $patchinfo
-		&& ($diffinfo->{'to_file'} || $diffinfo->{'file'}) eq $patchinfo->{'to_file'};
+		&& $diffinfo->{'to_file'} eq $patchinfo->{'to_file'};
 }
 
 
@@ -4667,8 +4670,8 @@ sub git_blobdiff {
 		}
 
 		%diffinfo = parse_difftree_raw_line($difftree[0]);
-		$file_parent ||= $diffinfo{'from_file'} || $file_name || $diffinfo{'file'};
-		$file_name   ||= $diffinfo{'to_file'}   || $diffinfo{'file'};
+		$file_parent ||= $diffinfo{'from_file'} || $file_name;
+		$file_name   ||= $diffinfo{'to_file'};
 
 		$hash_parent ||= $diffinfo{'from_id'};
 		$hash        ||= $diffinfo{'to_id'};
-- 
1.5.3.4
