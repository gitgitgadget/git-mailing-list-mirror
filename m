From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch
Date: Fri, 28 Nov 2008 06:42:17 +0000
Message-ID: <492F92C9.7030301@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 07:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5x4p-0000XB-3C
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 07:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbYK1GmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 01:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYK1GmY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 01:42:24 -0500
Received: from ik-out-1112.google.com ([66.249.90.177]:24942 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYK1GmX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 01:42:23 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1062017ika.5
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 22:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JxtrCZKXYs9kdoASJMdzrj94wK3YSO3lmFiqYvs6t/o=;
        b=ZbBP6EP1R6igKxB9UWijgW88T/SO54xzGon82r/C7uLhSdeNpBDeC+CjsoNkOQU1dD
         KtnMQIeRS8BlUvNJGDz2rDYjVrCYy+UFXioz0z1CSu4xpmWomaGou7kSyMbCdHG2iT5G
         2XtUYYRCsizIX/CpKKo6KifpcURqNDblc+sK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JbNtjB3xKbe8k1NQ4p2OD2aF21Pj8iy0Vc+RUD3G9ygr+lpBgy9OMS/kZNAnVkZbyI
         sBxJIQjuW3dQx/m8B3j+xSzBHLpHEkIZHii6G48w9tWNx49JfL+FJJllCcziEwQkVzzJ
         8YordpKyCYKKtKX2By1GfmS5HhmN/ijD85Ggw=
Received: by 10.210.42.20 with SMTP id p20mr8472697ebp.4.1227854541607;
        Thu, 27 Nov 2008 22:42:21 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id i6sm454636gve.26.2008.11.27.22.42.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 22:42:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7viqq8adsf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101865>


Here's a new patch.  Instead of displaying the summary and then
the current hunk, it implements a 'goto' command.  It prints the
summary and then prompts for the index of the hunk to jump to.
By not printing the current hunk, the list should typically
stay on screen.  Also, the summary is optional, so:

g  -- bring up summary and prompt for index
g3 -- jump to hunk 3


commit 510edf7c28fcc571f29106e32f2570d5f2e04fc3
Author: William Pursell <bill.pursell@gmail.com>
Date:   Fri Nov 28 06:22:36 2008 +0000

     Implement 'g' command (goto) in add --patch

     This command prints a summary of the hunks in the current
     file and prompts the user for an index of the hunk to make
     current.

     Signed-off-by: William Pursell <bill.pursell@gmail.com>

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..e6d73a0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -553,7 +553,7 @@ sub parse_diff {

  	for (my $i = 0; $i < @diff; $i++) {
  		if ($diff[$i] =~ /^@@ /) {
-			push @hunk, { TEXT => [], DISPLAY => [] };
+			push @hunk, { TEXT => [], DISPLAY => [], SUMMARY => $diff[$i] };
  		}
  		push @{$hunk[-1]{TEXT}}, $diff[$i];
  		push @{$hunk[-1]{DISPLAY}},
@@ -685,6 +685,7 @@ sub split_hunk {
  			    (($n_cnt != 1) ? ",$n_cnt" : '') .
  			    " @@\n");
  		my $display_head = $head;
+		$hunk->{SUMMARY} = $head;
  		unshift @{$hunk->{TEXT}}, $head;
  		if ($diff_use_color) {
  			$display_head = colored($fraginfo_color, $head);
@@ -783,6 +784,7 @@ sub edit_hunk_loop {
  				 $newhunk,
  				 @{$hunk}[$ix+1..$#{$hunk}])) {
  			$newhunk->{DISPLAY} = [color_diff(@{$text})];
+			$newhunk->{SUMMARY} = $$text[0];
  			return $newhunk;
  		}
  		else {
@@ -799,6 +801,7 @@ sub help_patch_cmd {
  y - stage this hunk
  n - do not stage this hunk
  a - stage this and all the remaining hunks in the file
+g - select a hunk to jump to
  d - do not stage this hunk nor any of the remaining hunks in the file
  j - leave this hunk undecided, see next undecided hunk
  J - leave this hunk undecided, see next hunk
@@ -836,6 +839,27 @@ sub patch_update_cmd {
  	}
  }

+sub select_new_hunk {
+	my $ri = shift;
+	my @hunk = @_;
+	my ($i, $response);
+	print "   '+' stage, '-' don't stage\n";
+	for ( $i = 0; $i < @hunk; $i++ ) {
+		my $status = " ";
+		if( defined $hunk[$i]{USE} ) {
+			$status = $hunk[$i]{USE} ? "+" : "-";
+		}
+		printf "%s%3d: %s",
+			$status,
+			$i + 1,
+			$hunk[$i]{SUMMARY};
+	}
+	printf "goto which hunk? ";
+	$response = <STDIN>;
+	chomp $response;
+	$$ri = $response - 1;
+}
+
  sub patch_update_file {
  	my ($ix, $num);
  	my $path = shift;
@@ -919,7 +943,7 @@ sub patch_update_file {
  		for (@{$hunk[$ix]{DISPLAY}}) {
  			print;
  		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage this hunk [y/n/a/d/g$other/?]? ";
  		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
@@ -937,6 +961,16 @@ sub patch_update_file {
  				}
  				next;
  			}
+			elsif ($line =~ /^g/) {
+				chomp ($line);
+				if ($line =~ /^g$/) {
+					select_new_hunk (\$ix, @hunk);
+				}
+				else {
+					$ix = (substr $line, 1) - 1;
+				}
+				next;
+			}
  			elsif ($line =~ /^d/i) {
  				while ($ix < $num) {
  					if (!defined $hunk[$ix]{USE}) {


-- 
William Pursell
