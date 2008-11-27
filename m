From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 5/5] Implement 'l' command to display summaries.
Date: Thu, 27 Nov 2008 21:10:34 +0000
Message-ID: <492F0CCA.20905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5o9d-0004dt-UX
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYK0VKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYK0VKk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:10:40 -0500
Received: from ik-out-1112.google.com ([66.249.90.176]:34157 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYK0VKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:10:39 -0500
Received: by ik-out-1112.google.com with SMTP id c29so981636ika.5
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=0hLgnEaD22edHfiDSqGq7stRBVMpjf3JXdLnktAXyMg=;
        b=ZyOcp5nrlPtIHu6BL//DjsKg61msFesm7pAaYJ2LrAodYQvnGnVOBrDaLH3FZZC6sO
         bxLb4EKk68BjsawgipK/u3ySAQQ7ns95AS8IuWBi7bFZMjEj6/pIyE5k3zYbXuWGRT5d
         mGbsYECquhYl3K9MyyPw0foC+0xcrp/ycuTzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=AOKdG/r++fvwI2Bv8Ao0tpPrnnIwHbN+OeTXX3pu7kdzj1gM+/cTeqIbjnGTe1JqNN
         EnpcfislveMeyu4sAczAB/IR44YPEYdFwiTPtF5/2xmcS5pEslAfcrNSxNi1G7fn4yTs
         EVnRG86F8Yx5kWPZUoM8t6NCu9iiV39oJUO+I=
Received: by 10.210.91.7 with SMTP id o7mr7959253ebb.61.1227820237621;
        Thu, 27 Nov 2008 13:10:37 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id q9sm329935gve.18.2008.11.27.13.10.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:10:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101829>



The summary information is in place to print out
the first added line (NEW), and the first removed
line (OLD), but it seems that just printing the
line number context is adequate.  Perhaps one
could add config options to print OLD and NEW,
but this seems good enough for now.
---
  git-add--interactive.perl |   25 ++++++++++++++++++++++++-
  1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ae785e2..6a3d97d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -824,6 +824,7 @@ sub help_patch_cmd {
  y - stage this hunk
  n - do not stage this hunk
  a - stage this and all the remaining hunks in the file
+l - print a brief summary of all the hunks in the file
  d - do not stage this hunk nor any of the remaining hunks in the file
  j - leave this hunk undecided, see next undecided hunk
  J - leave this hunk undecided, see next hunk
@@ -861,6 +862,24 @@ sub patch_update_cmd {
  	}
  }

+sub display_summaries {
+	my $index = shift;
+	my @hunk = @_;
+	my $i = 0;
+	print "'*' indicates current hunk.  '+' stage, '-' don't stage\n";
+	for ( ; $i < @hunk; $i++ ) {
+		my $status = " ";
+		if( defined $hunk[$i]{USE} ) {
+			$status = $hunk[$i]{USE} ? "+" : "-";
+		}
+		printf "%s%d%s: %s",
+			$i == $index ? "*" : " ",
+			$i,
+			$status,
+			$hunk[$i]{SUMMARY}{LINE};
+	}
+}
+
  sub patch_update_file {
  	my ($ix, $num);
  	my $path = shift;
@@ -904,7 +923,7 @@ sub patch_update_file {

  	while (1) {
  		my ($commands, $undecided, $i);
-		$commands = 'ynad';
+		$commands = 'ynald';

  		if ($num <= $ix) {
  			$ix = 0;
@@ -961,6 +980,10 @@ sub patch_update_file {
  				}
  				next;
  			}
+			elsif ($line =~ /^l/i) {
+				display_summaries ($ix, @hunk);
+				next;
+			}
  			elsif ($line =~ /^d/i) {
  				while ($ix < $num) {
  					if (!defined $hunk[$ix]{USE}) {
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
