From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 2/3] Add / command in add --patch
Date: Thu, 27 Nov 2008 04:07:57 +0000
Message-ID: <492E1D1D.5090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 05:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5YC5-0005Gi-0B
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 05:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYK0EIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 23:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYK0EIF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 23:08:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:36840 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYK0EIC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 23:08:02 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1599998ugf.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 20:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=zsnNEc2KJake9qf9aeKtBjI4/xDasIjd4ii7jaJa01Q=;
        b=idl7wQCqVymi2GkHhBaaZ3javr9yRqZTysJ87b5A/9LWMhH5MxFHtzTmtgwCoO/gyp
         ZSYnSo6TXpMefMMIlrHtRVyErM7my4eyJ7dAqo8/3m7LbwmD8sNLAW68JpbxqtAjjBvk
         4Xn97UYVlavqwlS82ANeoduqavQzpTmJ8T3SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=egDYmc8FR232fakhwvuhWTqJ2KfZ1uWq1iXPKylRQcHOL1kYsNFZ2IuLcLrV5Wf4iL
         +eVC46yEcjQJF2OrQEti1IIcuHn4tR9IQkZmXc5RKsQ/wMC5pBMWeWSrdy2yDBT4voPB
         f7XmFBWNQgkt/qWvxjid+dVE2zizm+X9JpXk8=
Received: by 10.210.120.7 with SMTP id s7mr6900327ebc.78.1227758880821;
        Wed, 26 Nov 2008 20:08:00 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id 6sm4318930nfv.8.2008.11.26.20.07.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 20:07:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101789>



This command allows the user to skip hunks that don't
match the specified regex.

BUG:  if the user enters an invalid regex, perl will abort.
For example: /+\s*foo will abort with:
Quantifier follows nothing in regex
I am not a Perl hacker and would welcome suggestions
on the easiest way to deal with this.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   27 +++++++++++++++++++++++----
  1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f20b880..547b5c8 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -800,6 +800,7 @@ y - stage this hunk
  n - do not stage this hunk
  a - stage this and all the remaining hunks in the file
  d - do not stage this hunk nor any of the remaining hunks in the file
+/ - search for a hunk matching the given regex
  j - leave this hunk undecided, see next undecided hunk
  J - leave this hunk undecided, see next hunk
  k - leave this hunk undecided, see previous undecided hunk
@@ -876,12 +877,14 @@ sub patch_update_file {

  	$num = scalar @hunk;
  	$ix = 0;
+	my $search_s; # User entered string to match a hunk.

  	while (1) {
  		my ($prev, $next, $other, $undecided, $i);
  		$other = '';

  		if ($num <= $ix) {
+			undef $search_s;
  			$ix = 0;
  		}
  		for ($i = 0; $i < $ix; $i++) {
@@ -916,11 +919,24 @@ sub patch_update_file {
  			$other .= ',s';
  		}
  		$other .= ',e';
-		for (@{$hunk[$ix]{DISPLAY}}) {
-			print;
+
+		my $line;
+		if (defined $search_s) {
+			my $text = join ("", @{$hunk[$ix]{DISPLAY}});
+			if ($text !~ $search_s) {
+				$line = "j\n";
+			} else {
+				print $text;
+			}
+		} else {
+			for (@{$hunk[$ix]{DISPLAY}}) {
+				print;
+			}
+		}
+		if (!$line) {
+			print colored $prompt_color, "Stage this hunk [y,n,a,d,/$other,?]? ";
+			$line = <STDIN>;
  		}
-		print colored $prompt_color, "Stage this hunk [y,n,a,d$other,?]? ";
-		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
  				$hunk[$ix]{USE} = 1;
@@ -946,6 +962,9 @@ sub patch_update_file {
  				}
  				next;
  			}
+			elsif ($line =~ m|^/(.*)|) {
+				$search_s = qr{$1}m;
+			}
  			elsif ($other =~ /K/ && $line =~ /^K/) {
  				$ix--;
  				next;
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
