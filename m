From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Fri, 25 May 2007 11:50:08 +0100
Message-ID: <200705251150.09439.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 12:50:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrXNJ-0002oy-3w
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbXEYKuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbXEYKuS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:50:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:42033 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbXEYKuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:50:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1091047ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 03:50:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=J6Dnpdwz/BiPzPC6OdZwTsITtPwosjAVG2rRYHIGeU7rc8XPMZq4OvuvcmbrCEUdVoGUPfKYlkkUxSvO0L5e9miNNa31nFrQLCxDeEWtZUfTg53qfQcOBwz62EZlUnkChO85ya8ai/VGdRpF45prRgSAOOsUk81+hqzP7PVZvsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=NAJp1OZNIuJPJLJNDq5DcKAJJkDq+8bi6t1Oo7Duh22WZyEgpBMtlW8KwZtPk3TcwtVjjenQCvFInuKdNNwxgAG5mhV2ftTWWR90n5/FKGBoEiTs0Ok4Cr1YLeqBD43lBU37iAR3tyXVAaXYHD/kUzMyTcK0gQEDXCqp3LeUV4U=
Received: by 10.67.90.1 with SMTP id s1mr2842591ugl.1180090214848;
        Fri, 25 May 2007 03:50:14 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm5457307iky.2007.05.25.03.50.13;
        Fri, 25 May 2007 03:50:14 -0700 (PDT)
X-TUID: 9897c276e78a3d9b
X-UID: 311
X-Length: 4241
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48355>

If the repository contained an expanded ident keyword (i.e. $Id:XXXX$),
then the wrong bytes were discarded, and the Id keyword was not
expanded.  The fault was in convert.c:ident_to_worktree().

Previously, when a "$Id:" was found in the repository version,
ident_to_worktree() would search for the next "$" after this, and
discarded everything it found until then.  That was done with the loop:

    do {
        ch = *cp++;
        if (ch == '$')
            break;
        rem--;
    } while (rem);

The above loop left cp pointing one character _after_ the final "$"
(because of ch = *cp++).  This was different from the non-expanded case,
were cp is left pointing at the "$", and was different from the comment
which stated "discard up to but not including the closing $".  This
patch fixes that by making the loop:

    do {
        ch = *cp;
        if (ch == '$')
            break;
        cp++;
        rem--;
    } while (rem);

That is, cp is tested _then_ incremented.

This loop exits if it finds a "$" or if it runs out of bytes in the
source.  After this loop, if there was no closing "$" the expansion is
skipped, and the outer loop is allowed to continue leaving this
non-keyword as it was.  However, when the "$" is found, size is
corrected, before running the expansion:

    size -= (cp - src);

This is wrong; size is going to be corrected anyway after the expansion,
so there is no need to do it here.  This patch removes that redundant
correction.

To help find this bug, I heavily commented the routine; those comments
are included here as a bonus.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
You wouldn't believe that I managed to get a file into the repository
with $Id$ stored expanded would you?  :-)

Anyway, it's fortunate that I did, because it revealed the above bugs
in the ident_to_worktree() code.

I've included the comments I wrote while debugging in this patch, which
I'm sure will annoy you, because you'd rather the fix and the comments
separately.  I'll supply that if you wish - just holler.

 convert.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 4b26b1a..3c44e3d 100644
--- a/convert.c
+++ b/convert.c
@@ -509,36 +509,71 @@ static char *ident_to_worktree(const char *path, const char *src, unsigned long
 
 	for (dst = buf; size; size--) {
 		const char *cp;
+		/* Fetch next source character, move the pointer on */
 		char ch = *src++;
+		/* Copy the current character to the destination */
 		*dst++ = ch;
+		/* If the current character is "$" or there are less than three
+		 * remaining bytes or the two bytes following this one are not
+		 * "Id", then simply read the next character */
 		if ((ch != '$') || (size < 3) || memcmp("Id", src, 2))
 			continue;
+		/*
+		 * Here when
+		 *  - There are more than 2 bytes remaining
+		 *  - The current three bytes are "$Id$"
+		 * with
+		 *  - ch == "$"
+		 *  - src[0] == "I"
+		 */
 
+		/*
+		 * It's possible that an expanded Id has crept its way into the
+		 * repository, we cope with that by stripping the expansion out
+		 */
 		if (src[2] == ':') {
+			/* Expanded keywords have "$Id:" at the front */
+
 			/* discard up to but not including the closing $ */
 			unsigned long rem = size - 3;
+			/* Point at first byte after the ":" */
 			cp = src + 3;
+			/*
+			 * Throw away characters until either
+			 *  - we reach a "$"
+			 *  - we run out of bytes (rem == 0)
+			 */
 			do {
-				ch = *cp++;
+				ch = *cp;
 				if (ch == '$')
 					break;
+				cp++;
 				rem--;
 			} while (rem);
+			/* If the above finished because it ran out of characters, then
+			 * this is an incomplete keyword, so don't run the expansion */
 			if (!rem)
 				continue;
-			size -= (cp - src);
 		} else if (src[2] == '$')
 			cp = src + 2;
 		else
+			/* Anything other than "$Id:XXX$" or $Id$ and we skip the
+			 * expansion */
 			continue;
 
+		/* cp is now pointing at the last $ of the keyword */
+
 		memcpy(dst, "Id: ", 4);
 		dst += 4;
 		memcpy(dst, sha1_to_hex(sha1), 40);
 		dst += 40;
 		*dst++ = ' ';
+
+		/* Adjust for the characters we've discarded */
 		size -= (cp - src);
 		src = cp;
+
+		/* Copy the final "$" */
 		*dst++ = *src++;
 		size--;
 	}
-- 
1.5.2.763.g8c5e-dirty
