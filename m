From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Create special from-file/to-file header for combined diff
Date: Mon, 28 May 2007 01:16:17 +0200
Message-ID: <11803077803470-git-send-email-jnareb@gmail.com>
References: <11803077771867-git-send-email-jnareb@gmail.com>
 <11803077792064-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 01:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsRtb-0001aa-Fj
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbXE0XLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760018AbXE0XLV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:11:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23399 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759547AbXE0XLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:11:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1510508ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 16:11:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TpjVuouODLMH1pk/faZpwFoJ5rkLMFNSWTThNSJUNqCOT2w717fg/81YnIaGzQ8Fbki8YPPdI69HvJLQkNRpUkQ+qr49B+XqzG2qtzq7QPGspnSsm4c1m4VC7pTvRRfy35RUI7KuilCMbx+LqBJ47Frb4x4Ic5MI5NxSxE0EgNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vt6/KqGE77SLi67Nq3T5P/MMghstA88kZ7lmUbO30xRtvqOf4m8KS6iZiG6cPvMtu2VLxyqKihxVbx5JLmJtJ7g+DUHUHpr0vNH3eT+fEml0Cecleub6v4Xh+hfmZ564rR9njIDTJ9uhNJSiLcneZMXvXEawr5OgGwOVHaYcH1k=
Received: by 10.67.32.19 with SMTP id k19mr4803380ugj.1180307476354;
        Sun, 27 May 2007 16:11:16 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id u9sm24805845muf.2007.05.27.16.11.14;
        Sun, 27 May 2007 16:11:15 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4RNGL07018983;
	Mon, 28 May 2007 01:16:21 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4RNGKdF018982;
	Mon, 28 May 2007 01:16:20 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11803077792064-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48594>

Instead of using default, diff(1) like from-file/to-file header for
combined diff (for a merge commit), which looks like:

  --- a/git-gui/git-gui.sh
  +++ b/_git-gui/git-gui.sh_

(where _link_ denotes [hidden] hyperlink), create from-file(n)/to-file
header, using n/file for each or parents, e.g.:

  --- 1/_git-gui/git-gui.sh_
  --- 2/_git-gui.sh_
  +++ b/_git-gui/git-gui.sh_

Test it on one of merge commits involving rename, e.g.
  95f97567c1887d77f3a46b42d8622c76414d964d (rename at top)
  5bac4a671907604b5fb4e24ff682d5b0e8431931 (file from one branch)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 795af92..f73f184 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1045,17 +1045,33 @@ sub format_diff_from_to_header {
 	#assert($line =~ m/^---/) if DEBUG;
 	# no extra formatting "^--- /dev/null"
 	if ($line =~ m!^--- "?a/!) {
-		if (!$diffinfo->{'nparents'} && # multiple 'from'
-		    $from->{'href'}) {
-			$line = '--- a/' .
-			        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
-			                esc_path($from->{'file'}));
+		if (!$diffinfo->{'nparents'}) {
+			if ($from->{'href'}) {
+				$line = '--- a/' .
+				        $cgi->a({-href=>$from->{'href'}, -class=>"path"},
+				                esc_path($from->{'file'}));
+			} else {
+				$line = '--- a/' .
+				        esc_path($from->{'file'});
+			}
+			$result .= qq!<div class="diff from_file">$line</div>\n!;
 		} else {
-			$line = '--- a/' .
-			        esc_path($from->{'file'});
+			for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
+				if ($from->{'href'}[$i]) {
+					$result .= qq!<div class="diff from_file">--- ! .
+					           ($i+1) . "/" .
+					           $cgi->a({-href=>$from->{'href'}[$i], -class=>"path"},
+					                   esc_path($from->{'file'}[$i])) .
+					           qq!</div>\n!;
+				} else {
+					$result .= qq!<div class="diff from_file">--- /dev/null</div>\n!;
+				}
+			}
 		}
+	} else {
+		$result .= qq!<div class="diff from_file">$line</div>\n!;
 	}
-	$result .= qq!<div class="diff from_file">$line</div>\n!;
+
 
 	$line = $to_line;
 	#assert($line =~ m/^\+\+\+/) if DEBUG;
-- 
1.5.2
