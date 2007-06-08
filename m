From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/6] gitweb: Create special from-file/to-file header for
	combined diff
Date: Fri, 08 Jun 2007 13:29:49 +0200
Message-ID: <20070608112747.3594.81616.stgit@roke.D-201>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:24:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwca9-0002Nd-TU
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966422AbXFHLYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967847AbXFHLYc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:24:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:54256 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966422AbXFHLYb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:24:31 -0400
Received: by ug-out-1314.google.com with SMTP id j3so930334ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:24:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=FfLm42kNkpIb6avgqEpUPwOocwN6EiivfkPFuPG25xG+2NUBhpbbHW0cFoBuMWUxH8IQ0MesbAX0bYqJ0PN6qnOr5ZkfVNR8SMLWvTlESP1LOQPAmN66cuGpnmVgQiJI/C95kK5g0e//Wt9qnPD9MFkqH0qD+oO5ZFQANcBrTRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=LZDvjUR1KvlBn+kmqUZsV64/JTuJEnO76oEbwo5CnM1bSdZ7unCHukTrewOtWuFfG6SHNbEyj+sJEpHF1S4TbaKM8hYQS/aYRcFG59UeiwzSh6mRERIdYWrDzPtnyQXEyJDcOAAZ0IyAoRCdi9Ys2lEQysvGLZ08kzA1TG+rvZA=
Received: by 10.82.178.11 with SMTP id a11mr5154291buf.1181301870040;
        Fri, 08 Jun 2007 04:24:30 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id 6sm9204921nfv.2007.06.08.04.24.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:24:29 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BTnjR003674;
	Fri, 8 Jun 2007 13:29:55 +0200
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49467>

Instead of using default, diff(1) like from-file/to-file header for
combined diff (for a merge commit), which looks like:

  --- a/git-gui/git-gui.sh
  +++ b/_git-gui/git-gui.sh_

(where _link_ denotes [hidden] hyperlink), create from-file(n)/to-file
header, using "--- <n>/_<filename>_" for each of parents, e.g.:

  --- 1/_git-gui/git-gui.sh_
  --- 2/_git-gui.sh_
  +++ b/_git-gui/git-gui.sh_

Test it on one of merge commits involving rename, e.g.
  95f97567c1887d77f3a46b42d8622c76414d964d (rename at top)
  5bac4a671907604b5fb4e24ff682d5b0e8431931 (file from one branch)

This is mainly meant to easier see renames in a merge commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio and Pasky likes this, and were source of inspiration for
the next patch.

 gitweb/gitweb.perl |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aee4f23..13114bc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1064,19 +1064,35 @@ sub format_diff_from_to_header {
 
 	$line = $from_line;
 	#assert($line =~ m/^---/) if DEBUG;
-	# no extra formatting "^--- /dev/null"
-	if ($line =~ m!^--- "?a/!) {
-		if (!$diffinfo->{'nparents'} && # multiple 'from'
-		    $from->{'href'}) {
-			$line = '--- a/' .
-			        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
-			                esc_path($from->{'file'}));
-		} else {
-			$line = '--- a/' .
-			        esc_path($from->{'file'});
+	# no extra formatting for "^--- /dev/null"
+	if (! $diffinfo->{'nparents'}) {
+		# ordinary (single parent) diff
+		if ($line =~ m!^--- "?a/!) {
+			if ($from->{'href'}) {
+				$line = '--- a/' .
+				        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
+				                esc_path($from->{'file'}));
+			} else {
+				$line = '--- a/' .
+				        esc_path($from->{'file'});
+			}
+		}
+		$result .= qq!<div class="diff from_file">$line</div>\n!;
+
+	} else {
+		# combined diff (merge commit)
+		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+			if ($from->{'href'}[$i]) {
+				$line = '--- ' .
+				        ($i+1) . "/" .
+				        $cgi->a({-href=>$from->{'href'}[$i], -class=>"path"},
+				                esc_path($from->{'file'}[$i]));
+			} else {
+				$line = '--- /dev/null';
+			}
+			$result .= qq!<div class="diff from_file">$line</div>\n!;
 		}
 	}
-	$result .= qq!<div class="diff from_file">$line</div>\n!;
 
 	$line = $to_line;
 	#assert($line =~ m/^\+\+\+/) if DEBUG;
