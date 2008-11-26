From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 2/2] In add --patch, Handle K,k,J,j slightly more gracefully.
Date: Wed, 26 Nov 2008 20:51:26 +0000
Message-ID: <492DB6CE.3010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 21:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5RNX-0005HU-J8
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 21:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbYKZUvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 15:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYKZUvc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 15:51:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:48934 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYKZUvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 15:51:31 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1525723ugf.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=tbrmiTE1R7SVpAf5Ofv/HRHgaarXaILuwnLeGyqs8iY=;
        b=AGyOCYhgjzKOGevHOZ1u7uJ/F27y2fskRSBjIAJygVv1pnrjgbDQDUXRaptuObz7EV
         UAILNpgZxX0zU8U3JW4HywWUszcHIMLGs5p/GXKKgWkDTErYFO4TPhl7ccsa7sNiiqXe
         D/j4vdCFnZDVt81RAwQ+KlvtHAYfn+UhOsdmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=oFzfFbWLyl86rkO9a9UN8VkcJejvZjILdEFVeqRMv0sxcW++tkSZuPJkci9flds8Jl
         8gos6pPxGkIWaTVZP750QQtPEyzBzuCce0/r+GiGPynNWNBn7UKgzCLi6QzSoNXsFgIC
         BCipGPVM+PPKpxKocTCsttwv5QA8AGacqswhM=
Received: by 10.67.40.6 with SMTP id s6mr3893350ugj.10.1227732690391;
        Wed, 26 Nov 2008 12:51:30 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id r38sm593736ugc.54.2008.11.26.12.51.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 12:51:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101767>




Instead of printing the help menu, this will print
"No next hunk" and then process the given hunk again.
---
  git-add--interactive.perl |   35 +++++++++++++++++++----------------
  1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 7ad4ee0..6321bd9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -964,29 +964,32 @@ sub patch_update_file {
  			elsif ($line =~ m|^/(.*)|) {
  				$search_s = $1;
  			}
-			elsif ($other =~ /K/ && $line =~ /^K/) {
-				$ix--;
+			elsif ( $line =~ /^K/) {
+				$other =~ /K/ ?  $ix-- : print STDERR "No previous hunk\n";
  				next;
  			}
-			elsif ($other =~ /J/ && $line =~ /^J/) {
-				$ix++;
+			elsif ($line =~ /^J/) {
+				$other =~ /J/ ?  $ix++ : print STDERR "No next hunk\n";
  				next;
  			}
-			elsif ($other =~ /k/ && $line =~ /^k/) {
-				while (1) {
-					$ix--;
-					last if (!$ix ||
-						 !defined $hunk[$ix]{USE});
+			elsif ($line =~ /^k/) {
+				if ($other =~ /k/) {
+					while (1) {
+						$ix--;
+						last if (!$ix ||
+							 !defined $hunk[$ix]{USE});
+					}
+					next;
+				}
+				else {
+					print STDERR "No previous hunk\n";
  				}
-				next;
  			}
-			elsif ($other =~ /j/ && $line =~ /^j/) {
-				while (1) {
-					$ix++;
-					last if ($ix >= $num ||
-						 !defined $hunk[$ix]{USE});
+			elsif ($line =~ /^j/) {
+				if ($other !~ /j/) {
+					print STDERR "No next hunk\n";
+					next;
  				}
-				next;
  			}
  			elsif ($other =~ /s/ && $line =~ /^s/) {
  				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
-- 
1.6.0.4.781.gf2070.dirty


-- 
William Pursell
