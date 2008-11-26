From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Wed, 26 Nov 2008 20:51:20 +0000
Message-ID: <492DB6C8.7010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 21:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5RNM-0005DL-0s
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 21:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYKZUv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 15:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYKZUv1
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 15:51:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:48934 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYKZUv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 15:51:27 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1525723ugf.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=k6mFXUmzo5YuWQzU3cKLdoZAkkEkD7XtaCKC3gJ4wWY=;
        b=VBhEhehC1WqbohJfF1xAgblGGcbcus2OjjEjD1scW0pfYUcsEhMHYzkQUxvEHQBM3E
         lwtgmlp3sARp0eKSGWYVo2P4E5N2YEuV0kfOIHeG6WZ+ZPh/KN0WYhwZHPu9647pEF+Q
         g7dirkZVXJGGgi3iE6H7P49lgkYyC9C8S24X4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=C5BvUBxL1Y3sGzMwx2uDXXBkDz3yVEWHctiZ+w4b5E4e2c35wf6vb/7UqcGX8AXp2C
         9a8ZzGunlYrmlTEYV4Nr3BZTTiH9DKFzhdin5bdpL0i+JH2c0sbCVZUz9k+iVD2VxDTQ
         1VwG30csWomQRSHiQ5qi9nPoDNJDU0lO+/WjA=
Received: by 10.66.252.18 with SMTP id z18mr3857047ugh.30.1227732684442;
        Wed, 26 Nov 2008 12:51:24 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id k27sm583702ugd.48.2008.11.26.12.51.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 12:51:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101766>


This sequence of 2 patches adds a '/' command to
add --patch that allows the user to search for
a hunk that matches a regex, and deals with j,k slightly
more gracefully.  (Rather than printing the
help menu if k is invalid, it will print
a relevant error message.)

This is naive, and it is easy for an invalid
search string to cause a perl error.

I think it could be useful functionality to make
robust.

(Please CC me in any response)

---
  git-add--interactive.perl |   26 ++++++++++++++++++++++----
  1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..7ad4ee0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -876,12 +876,14 @@ sub patch_update_file {

  	$num = scalar @hunk;
  	$ix = 0;
+	my $search_s; # User entered string to match a hunk.

  	while (1) {
  		my ($prev, $next, $other, $undecided, $i);
  		$other = '';

  		if ($num <= $ix) {
+			$search_s = 0;
  			$ix = 0;
  		}
  		for ($i = 0; $i < $ix; $i++) {
@@ -916,11 +918,24 @@ sub patch_update_file {
  			$other .= '/s';
  		}
  		$other .= '/e';
-		for (@{$hunk[$ix]{DISPLAY}}) {
-			print;
+
+		my $line;
+		if( $search_s ) {
+			my $text = join( "", @{$hunk[$ix]{DISPLAY}} );
+			if( $text !~ $search_s ) {
+				$line = "n\n";
+			} else {
+				print $text;
+			}
+		} else {
+			for (@{$hunk[$ix]{DISPLAY}}) {
+				print;
+			}
+		}
+		if (!$line) {
+			print colored $prompt_color, "Stage this hunk [y/n/a/d///$other/?]? ";
+			$line = <STDIN>;
  		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
-		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
  				$hunk[$ix]{USE} = 1;
@@ -946,6 +961,9 @@ sub patch_update_file {
  				}
  				next;
  			}
+			elsif ($line =~ m|^/(.*)|) {
+				$search_s = $1;
+			}
  			elsif ($other =~ /K/ && $line =~ /^K/) {
  				$ix--;
  				next;
-- 
1.6.0.4.781.gf2070.dirty


-- 
William Pursell
