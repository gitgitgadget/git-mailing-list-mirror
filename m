From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix "apply --reverse" with regard to whitespace
Date: Sat, 7 Jul 2007 18:50:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071849430.4093@racer.site>
References: <Pine.LNX.4.64.0707062155170.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 19:57:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7EXZ-0002YK-Kz
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 19:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXGGR5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 13:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbXGGR5v
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 13:57:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:60073 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbXGGR5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 13:57:50 -0400
Received: (qmail invoked by alias); 07 Jul 2007 17:57:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 07 Jul 2007 19:57:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lqGB4q68lvJ7H6QlW2k+QBFxy8ApuZT1L1/g2fC
	Dzgv7z76PSLYD3
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707062155170.6977@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51831>


"git apply" used to take check the whitespace in the wrong
direction.

Noticed by Daniel Barkalow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 6 Jul 2007, Daniel Barkalow wrote:

	> If you apply in reverse a patch which adds junk (e.g., terminal
	> whitespace), it complains about the junk you're adding, even 
	> though (since it's in reverse) you're actually removing that 
	> junk.

	This fixes it.

 builtin-apply.c          |    6 +++++-
 t/t4116-apply-reverse.sh |    6 ++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index c6f736c..0a0b4a9 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1003,12 +1003,16 @@ static int parse_fragment(char *line, unsigned long size, struct patch *patch, s
 			trailing++;
 			break;
 		case '-':
+			if (apply_in_reverse &&
+					new_whitespace != nowarn_whitespace)
+				check_whitespace(line, len);
 			deleted++;
 			oldlines--;
 			trailing = 0;
 			break;
 		case '+':
-			if (new_whitespace != nowarn_whitespace)
+			if (!apply_in_reverse &&
+					new_whitespace != nowarn_whitespace)
 				check_whitespace(line, len);
 			added++;
 			newlines--;
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index a7f5905..9ae2b3a 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -82,4 +82,10 @@ test_expect_success 'apply in reverse without postimage' '
 	)
 '
 
+test_expect_success 'reversing a whitespace introduction' '
+	sed "s/a/a /" < file1 > file1.new &&
+	mv file1.new file1 &&
+	git diff | git apply --reverse --whitespace=error
+'
+
 test_done
-- 
1.5.3.rc0.2712.g125b7f
