From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Mon, 14 May 2007 19:03:02 -0700
Message-ID: <7vmz06lu7d.fsf@assigned-by-dhcp.cox.net>
References: <200705141429.58412.andyparkins@gmail.com>
	<46486FE6.16A82D9A@eudaptics.com>
	<7v646vo3pn.fsf@assigned-by-dhcp.cox.net>
	<200705142324.02929.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 04:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnmNd-0002Rz-Vv
	for gcvg-git@gmane.org; Tue, 15 May 2007 04:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418AbXEOCDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 22:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758906AbXEOCDK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 22:03:10 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43814 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758418AbXEOCDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 22:03:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515020307.BHBM24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 22:03:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zE321W00V1kojtg0000000; Mon, 14 May 2007 22:03:07 -0400
In-Reply-To: <200705142324.02929.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 14 May 2007 23:24:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47307>

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2007, May 14, Junio C Hamano wrote:
>
>> Obviously I do not care much about this feature and I have not
>> look at Andy's patch too deeply yet, but in any case I think the
>> inverse conversion needs to be modified to match it, if it
>> hasn't been done so.
>
> I believe I did the inverse conversion as well.

I think this on top of your patch would be the minimum necessary
for v1.5.2.

 Documentation/RelNotes-1.5.2.txt |    2 +-
 Documentation/gitattributes.txt  |    6 +++---
 convert.c                        |   14 +++++++-------
 t/t0021-conversion.sh            |    4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/RelNotes-1.5.2.txt b/Documentation/RelNotes-1.5.2.txt
index d1c2cac..7dbdb26 100644
--- a/Documentation/RelNotes-1.5.2.txt
+++ b/Documentation/RelNotes-1.5.2.txt
@@ -26,7 +26,7 @@ Updates since v1.5.1
   considered a binary or text (the former would be treated by
   'git diff' not to produce textual output; the latter can go
   through the line endings conversion process in repositories
-  with core.autocrlf set), expand and unexpand '$ident$' keyword
+  with core.autocrlf set), expand and unexpand '$Id$' keyword
   with blob object name, specify a custom 3-way merge driver,
   and specify a custom diff driver.  You can also apply
   arbitrary filter to contents on check-in/check-out codepath
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8772310..d3ac9c7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -138,11 +138,11 @@ upon checkout.
 ^^^^^^^
 
 When the attribute `ident` is set to a path, git replaces
-`$ident$` in the blob object with `$ident:`, followed by
+`$Id$` in the blob object with `$Id:`, followed by
 40-character hexadecimal blob object name, followed by a dollar
 sign `$` upon checkout.  Any byte sequence that begins with
-`$ident:` and ends with `$` in the worktree file is replaced
-with `$ident$` upon check-in.
+`$Id:` and ends with `$` in the worktree file is replaced
+with `$Id$` upon check-in.
 
 
 Interaction between checkin/checkout attributes
diff --git a/convert.c b/convert.c
index c46ab1b..12abdaf 100644
--- a/convert.c
+++ b/convert.c
@@ -422,20 +422,20 @@ static int count_ident(const char *cp, unsigned long size)
 		size--;
 		if (ch != '$')
 			continue;
-		if (size < 6)
+		if (size < 3)
 			break;
-		if (memcmp("ident", cp, 5))
+		if (memcmp("Id", cp, 2))
 			continue;
-		ch = cp[5];
-		cp += 6;
-		size -= 6;
+		ch = cp[2];
+		cp += 3;
+		size -= 3;
 		if (ch == '$')
-			cnt++; /* $ident$ */
+			cnt++; /* $Id$ */
 		if (ch != ':')
 			continue;
 
 		/*
-		 * "$ident: ... "; scan up to the closing dollar sign and discard.
+		 * "$Id: ... "; scan up to the closing dollar sign and discard.
 		 */
 		while (size) {
 			ch = *cp++;
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bab9ecc..6c26fd8 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -21,7 +21,7 @@ test_expect_success setup '
 	{
 	    echo a b c d e f g h i j k l m
 	    echo n o p q r s t u v w x y z
-	    echo '\''$ident$'\''
+	    echo '\''$Id$'\''
 	} >test &&
 	cat test >test.t &&
 	cat test >test.o &&
@@ -31,7 +31,7 @@ test_expect_success setup '
 	git checkout -- test test.t test.i
 '
 
-script='s/^\$ident: \([0-9a-f]*\) \$/\1/p'
+script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
 
 test_expect_success check '
 
