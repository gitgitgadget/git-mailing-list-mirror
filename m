From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Create special from-file/to-file header for combined diff
Date: Mon, 28 May 2007 01:16:16 +0200
Message-ID: <11803077792064-git-send-email-jnareb@gmail.com>
References: <11803077771867-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 01:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsRta-0001aa-FA
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014AbXE0XLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759966AbXE0XLU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:11:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24017 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759178AbXE0XLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:11:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1510506ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 16:11:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bnX87dQuYVbQE6Lh3DUAX4bZPznCUxj4Zp3r4ccp/QavhNNy7WeixFbMnH78lycJaLbodZ8USz6J9IHZAxBxozQgvNzYePOrBdOTQsXHfhxSoj0eEgznYM8/EGn1RwWgW6wI0ru9f9XJ3Elyu92jTGRYYjfS8rYMXBLlomnLk0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EcwfS+OMvZ75x5PJfG7ChWwG45yY8DIWYgiVsjFEnTa7FLyccwkzUmc0qW6ZDZQEGpWp3LCiX+rEvZxKfZ/1n9eEmPABKYIJ+4qox5hOU8ZBjSySLZJOc8vmmX3VuzCL1lAYr1HmUGTeCnAA1gVIr+VK4RRF/k2bL7Zuai0d5vQ=
Received: by 10.67.40.12 with SMTP id s12mr4821917ugj.1180307475495;
        Sun, 27 May 2007 16:11:15 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm24803748mue.2007.05.27.16.11.14;
        Sun, 27 May 2007 16:11:14 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4RNGKhY018978;
	Mon, 28 May 2007 01:16:20 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4RNGJXk018977;
	Mon, 28 May 2007 01:16:19 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11803077771867-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48593>

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
This is just an idea, not seriously meant to be applied... unless of
course you think that this is great. What do you think about it?

This patch depends on my earlier patch
  "gitweb: Split git_patchset_body into separate subroutines"

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
