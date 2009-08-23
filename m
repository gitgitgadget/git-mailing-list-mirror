From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 14:11:31 -0700
Message-ID: <7vzl9qtev0.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS>
 <7vljlauxmk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231515020.29625@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKLt-00014w-RP
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbZHWVLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbZHWVLk
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:11:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbZHWVLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:11:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AB0016771;
	Sun, 23 Aug 2009 17:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=aw00cm1Fpn2Rv7nFgcDtH1gBbnI=; b=rRu9xG0gM4f5+EEL7VyO7D+
	9Ds9+Mujr3QoNGz6eni3auu4kyTlRSJbYJ0cCI/aqwCCeTg+xbspUsr7zLwQYOS7
	peTYxdAsH/+gLSYyYe0DzoBP/KuQlcV3SzMuzvvuqcP31iDRZbQHGtuJv0yQRY4+
	+mVBII2VhrS6suUAduqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dHo1Nj+S0IL51HSCYi1AwIsvdrdFOaR0fenXZmtzcVwGNJ4al
	RjkVuAl+bx955ul6YUN1UI49GEctuUOw90IpRtXl6zFa9P/TOoD02dAMS3pPvYN2
	z0ZwKUARdUs0FtldZUUnebcoYViSrEr7uNvbcCiXzgZ4YJv5kvglxFmmHY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B10716770;
	Sun, 23 Aug 2009 17:11:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 057CA1676F; Sun, 23 Aug
 2009 17:11:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B23DD48-9029-11DE-ADE5-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126881>

Thell Fowler <git@tbfowler.name> writes:

>> Or we can just move the final else clause up and start the function like
>> this:
>> 
>> 	int i1, i2;
>> 
>> 	if (!(flags & XDF_WHITESPACE_FLAGS))
>>  		return s1 == s2 && !memcmp(l1, l2, s1);
>> 
>> 	i1 = i2 = 0;
>>  	if (flags & XDF_IGNORE_WHITESPACE) {
>> 		...
>> 
>> that would get rid of two unnecessary clearing of variables (i1 and i2,
>> even though I suspect that the compiler _could_ optimize them out without
>> such an change), and three flags-bit check in the most common case of not
>> ignoring any whitespaces.
>> 
>
> HA!  That's a nifty way to do that with the variables.

My tentative draft to replace the "how about this" patch further reworks
the loop structure and currently looks like this.

It adds net 15 lines but among that 12 lines are comments, which is not so
bad.

-- >8 --
Subject: [PATCH] xutils: Fix xdl_recmatch() on incomplete lines

Thell Fowler noticed that various "ignore whitespace" options to git diff
do not work well on an incomplete line.

The loop control of the function responsible for these bugs was extremely
difficult to follow.  This patch restructures the loops for three variants
of "ignore whitespace" logic.

The basic idea of the re-written logic is:

 - A loop runs while the characters from both strings we are looking at
   match.  We declare unmatch immediately when we find something that does
   not match and return false from the function.  We break out of the loop
   if we ran out of either side of the string.

   The way we skip spaces inside this loop varies depending on the style
   of ignoring whitespaces.

 - After the above loop breaks, we know that the parts of the strings we
   inspected so far match, ignoring the whitespaces.  The lines can match
   only if the remainder consists of nothing but whitespaces.  This part
   of the logic is shared across all three styles.

The new code is more obvious and should be much easier to follow.

Tested-by: Thell Fowler <git@tbfowler.name>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xutils.c |   77 +++++++++++++++++++++++++++++++++----------------------
 1 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9411fa9..eb7b597 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -190,48 +190,63 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
 
+	if (!(flags & XDF_WHITESPACE_FLAGS))
+		return s1 == s2 && !memcmp(l1, l2, s1);
+
+	i1 = 0;
+	i2 = 0;
+
+	/*
+	 * -w matches everything that matches with -b, and -b in turn
+	 * matches everything that matches with --ignore-space-at-eol.
+	 *
+	 * Each flavor of ignoring needs different logic to skip whitespaces
+	 * while we have both sides to compare.
+	 */
 	if (flags & XDF_IGNORE_WHITESPACE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (isspace(l1[i1]))
-				while (isspace(l1[i1]) && i1 < s1)
-					i1++;
-			if (isspace(l2[i2]))
-				while (isspace(l2[i2]) && i2 < s2)
-					i2++;
-			if (i1 < s1 && i2 < s2 && l1[i1++] != l2[i2++])
+		goto skip_ws;
+		while (i1 < s1 && i2 < s2) {
+			if (l1[i1++] != l2[i2++])
 				return 0;
+		skip_ws:
+			while (i1 < s1 && isspace(l1[i1]))
+				i1++;
+			while (i2 < s2 && isspace(l2[i2]))
+				i2++;
 		}
-		return (i1 >= s1 && i2 >= s2);
 	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (isspace(l1[i1])) {
-				if (!isspace(l2[i2]))
-					return 0;
-				while (isspace(l1[i1]) && i1 < s1)
-					i1++;
-				while (isspace(l2[i2]) && i2 < s2)
-					i2++;
-			} else if (l1[i1++] != l2[i2++])
-				return 0;
-		}
-		return (i1 >= s1 && i2 >= s2);
-	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (l1[i1] != l2[i2]) {
+		while (i1 < s1 && i2 < s2) {
+			if (isspace(l1[i1]) && isspace(l2[i2])) {
+				/* Skip matching spaces and try again */
 				while (i1 < s1 && isspace(l1[i1]))
 					i1++;
 				while (i2 < s2 && isspace(l2[i2]))
 					i2++;
-				if (i1 < s1 || i2 < s2)
-					return 0;
-				return 1;
+				continue;
 			}
+			if (l1[i1++] != l2[i2++])
+				return 0;
+		}
+	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
+		while (i1 < s1 && i2 < s2 && l1[i1++] == l2[i2++])
+			; /* keep going */
+	}
+
+	/*
+	 * After running out of one side, the remaining side must have
+	 * nothing but whitespace for the lines to match.
+	 */
+	if (i1 < s1) {
+		while (i1 < s1 && isspace(l1[i1]))
 			i1++;
+		return (s1 == i1);
+	}
+	if (i2 < s2) {
+		while (i2 < s2 && isspace(l2[i2]))
 			i2++;
-		}
-		return i1 >= s1 && i2 >= s2;
-	} else
-		return s1 == s2 && !memcmp(l1, l2, s1);
+		return (s2 == i2);
+	}
+	return 1;
 }
 
 static unsigned long xdl_hash_record_with_whitespace(char const **data,
-- 
1.6.4.1.255.g5556a
