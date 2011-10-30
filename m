From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 4/8] gitweb: Give side-by-side diff extra CSS styling
Date: Mon, 31 Oct 2011 00:36:23 +0100
Message-ID: <1320017787-18048-5-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf1t-0006ij-6l
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1J3XnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:43:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1J3Xm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:42:59 -0400
Received: by faan17 with SMTP id n17so5069535faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VA/k9et4/RUkL6yDwP/64XoOwCk8T1UwQ0ChPFGCrj4=;
        b=h3anLGC4d3GyE/I26oE5Kyw8raUVAOiMx3OV7xkbJc3hSmOh6MCmCAf6hZwFnCUQqp
         igESagAJWJU2Heflr2cOAo01qNBiC3byAOhxjMAFBs9TnQfhFceMeg7fcpUOFWMGnVRS
         9QvzKZ1aZC/2IoXViz/dzzGIGLxJ1NWUZVbqE=
Received: by 10.223.58.146 with SMTP id g18mr25074643fah.13.1320018178157;
        Sun, 30 Oct 2011 16:42:58 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.42.56
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:42:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184483>

Use separate background colors for pure removal, pure addition and
change for side-by-side diff.  This makes reading such diff easier,
allowing to easily distinguish empty lines in diff from vertical
whitespace used to align chunk blocks.

Note that if lines in diff were numbered, the absence of line numbers
[for one side] would help in distinguishing empty lines from vertical
align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in this version of series.

Note that the code could probably be written with less duplication, at
the cost of being more complicated.  I think it is worth tradeoff as
written here.

For how output looks like, compare for example:

  http://confluence.atlassian.com/display/FISHEYE/Using+Side+by+Side+Diff+View

 gitweb/gitweb.perl       |   39 +++++++++++++++++++++++++++++----------
 gitweb/static/gitweb.css |   13 +++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68629f6..f69ed08 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4890,7 +4890,7 @@ sub print_sidebyside_diff_chunk {
 		# empty contents block on start rem/add block, or end of chunk
 		if (@ctx && (!$class || $class eq 'rem' || $class eq 'add')) {
 			print join '',
-				'<div class="chunk_block">',
+				'<div class="chunk_block ctx">',
 					'<div class="old">',
 					@ctx,
 					'</div>',
@@ -4902,15 +4902,34 @@ sub print_sidebyside_diff_chunk {
 		}
 		# empty add/rem block on start context block, or end of chunk
 		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
-			print join '',
-				'<div class="chunk_block">',
-					'<div class="old">',
-					@rem,
-					'</div>',
-					'<div class="new">',
-					@add,
-					'</div>',
-				'</div>';
+			if (!@add) {
+				# pure removal
+				print join '',
+					'<div class="chunk_block rem">',
+						'<div class="old">',
+						@rem,
+						'</div>',
+					'</div>';
+			} elsif (!@rem) {
+				# pure addition
+				print join '',
+					'<div class="chunk_block add">',
+						'<div class="new">',
+						@add,
+						'</div>',
+					'</div>';
+			} else {
+				# assume that it is change
+				print join '',
+					'<div class="chunk_block chg">',
+						'<div class="old">',
+						@rem,
+						'</div>',
+						'<div class="new">',
+						@add,
+						'</div>',
+					'</div>';
+			}
 			@rem = @add = ();
 		}
 
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 21842a6..c7827e8 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -491,6 +491,19 @@ div.chunk_block div.new {
 	width: 50%;
 }
 
+div.chunk_block.rem div.old div.diff.rem {
+	background-color: #fff5f5;
+}
+div.chunk_block.add div.new div.diff.add {
+	background-color: #f8fff8;
+}
+div.chunk_block.chg div     div.diff {
+	background-color: #fffff0;
+}
+div.chunk_block.ctx div     div.diff.ctx {
+	color: #404040;
+}
+
 
 div.index_include {
 	border: solid #d9d8d1;
-- 
1.7.6
