From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 00:57:18 -0700
Message-ID: <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Sun Aug 23 09:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf7xg-0007zR-M5
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 09:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbZHWH5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 03:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755869AbZHWH5a
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 03:57:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbZHWH53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 03:57:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFEE13430B;
	Sun, 23 Aug 2009 03:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=u9y3oi5f6l/yK7YHSbyhck98Pbs=; b=SQv1Q4gjNqPhYgB/M14mi8s
	kR+m0UeWFhiatxnPZtKkQyN19Ui7yWk32zaH08ZUPtubS0Kr/ONLkVgnBtHQTpkv
	tn5Is8s+U+SK27xOcPEYQxuE3Y7EGK7cjV7avbi/beG3DUqbj/5eiwnx9Tc7LKEW
	xeZc3e4TVD1zRfitOYXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aHc7I3EdLxo+UenD0CUmZkD0e9BTbNqQc8PVQtSrzLmajO0VS
	eTRmgIsOHUkrsz+RfpLEH77iY6n968Y4NA6hotj2arQ/KdjzVjv93dbCGwpSkneT
	zOMvEnaOgqgcZpqk9ntCUTLA8Z1djLqABH+tZEoiNryytYgY+rLYxPkBFw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6CCA3430A;
	Sun, 23 Aug 2009 03:57:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 27B7934309; Sun, 23 Aug 2009
 03:57:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99617646-8FBA-11DE-AAC5-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126847>

Thell Fowler <git@tbfowler.name> writes:

> @@ -191,12 +191,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  	int i1, i2;
>  
>  	if (flags & XDF_IGNORE_WHITESPACE) {
> -		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
> +		for (i1 = i2 = 0; i1 < s1 || i2 < s2; ) {
>  			if (isspace(l1[i1]))
> -				while (isspace(l1[i1]) && i1 < s1)
> +				while ((isspace(l1[i1]) && i1 < s1)
> +						|| (i1 + 1 == s1 && l1[s1] != '\n'))

This is wrong.  If you ran out l1/s1/i1 but you still have remaining
characters in l2/s2/i2, you do not want to even look at l1[i1].

You can fudge this by sprinkling more "(i1 < s1) &&" in many places (and
reordering how your inner while() loop checks (i1 < s1) and l1[i1]), but I
do not think that is the right direction.

The thing is, the loop control in this function is extremely hard to read
to begin with, and now it is "if we haven't run out both", the complexity
seeps into the inner logic.

How about doing it like this patch instead?  This counterproposal replaces
your 3 patches starting from [3/6].

-- >8 --
Subject: xutils: Fix xdl_recmatch() on incomplete lines

Thell Fowler noticed that various "ignore whitespace" options to
git diff does not work well with whitespace glitches on an incomplete
line.

The loop control of this function incorrectly handled incomplete lines,
and it was extremely difficult to follow.  This restructures the loops for
three variants of "ignore whitespace" logic.

The basic idea of the re-written logic is this.

 - An initial loop runs while the characters from both strings we are
   looking at match.  We declare unmatch immediately when we find
   something that does not match and return false from the loop.  And we
   break out of the loop if we ran out of either side of the string.

   The way we skip spaces inside this loop varies depending on the style
   of ignoring whitespaces.

 - After the loop, the lines can match only if the remainder consists of
   nothing but whitespaces.  This part of the logic is shared across all
   three styles.

The new code is more obvious and should be much easier to follow.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 xdiff/xutils.c |  111 +++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9411fa9..dd8b7e7 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -186,50 +186,93 @@ long xdl_guess_lines(mmfile_t *mf) {
 	return nl + 1;
 }
 
+static int remainder_all_ws(const char *l1, const char *l2,
+			    int i1, int i2, long s1, long s2)
+{
+	if (i1 < s1) {
+		while (i1 < s1 && isspace(l1[i1]))
+			i1++;
+		return (s1 == i1);
+	}
+	if (i2 < s2) {
+		while (i2 < s2 && isspace(l2[i2]))
+			i2++;
+		return (s2 == i2);
+	}
+	return 1;
+}
+
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
-	int i1, i2;
+	int i1 = 0, i2 = 0;
 
 	if (flags & XDF_IGNORE_WHITESPACE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (isspace(l1[i1]))
-				while (isspace(l1[i1]) && i1 < s1)
-					i1++;
-			if (isspace(l2[i2]))
-				while (isspace(l2[i2]) && i2 < s2)
-					i2++;
-			if (i1 < s1 && i2 < s2 && l1[i1++] != l2[i2++])
-				return 0;
+		while (1) {
+			while (i1 < s1 && isspace(l1[i1]))
+				i1++;
+			while (i2 < s2 && isspace(l2[i2]))
+				i2++;
+			if (i1 < s1 && i2 < s2) {
+				if (l1[i1++] != l2[i2++])
+					return 0;
+				continue;
+			}
+			break;
 		}
-		return (i1 >= s1 && i2 >= s2);
+
+		/*
+		 * we ran out one side; the remaining side must be all
+		 * whitespace to match.
+		 */
+		return remainder_all_ws(l1, l2, i1, i2, s1, s2);
 	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (isspace(l1[i1])) {
-				if (!isspace(l2[i2]))
+		while (1) {
+			if (i1 < s1 && i2 < s2) {
+				/* Skip matching spaces */
+				if (isspace(l1[i1]) && isspace(l2[i2])) {
+					while (i1 < s1 && isspace(l1[i1]))
+						i1++;
+					while (i2 < s2 && isspace(l2[i2]))
+						i2++;
+				}
+			}
+			if (i1 < s1 && i2 < s2) {
+				/*
+				 * We still have both sides; do they match?
+				 */
+				if (l1[i1++] != l2[i2++])
 					return 0;
-				while (isspace(l1[i1]) && i1 < s1)
-					i1++;
-				while (isspace(l2[i2]) && i2 < s2)
-					i2++;
-			} else if (l1[i1++] != l2[i2++])
-				return 0;
+				continue;
+			}
+			break;
 		}
-		return (i1 >= s1 && i2 >= s2);
+
+		/*
+		 * If we do not want -b to imply --ignore-space-at-eol
+		 * then you would need to add this:
+		 *
+		 * if (!(flags & XDF_IGNORE_WHITESPACE_AT_EOL))
+		 *	return (s1 <= i1 && s2 <= i2);
+		 *
+		 */
+
+		/*
+		 * we ran out one side; the remaining side must be all
+		 * whitespace to match.
+		 */
+		return remainder_all_ws(l1, l2, i1, i2, s1, s2);
+
 	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (l1[i1] != l2[i2]) {
-				while (i1 < s1 && isspace(l1[i1]))
-					i1++;
-				while (i2 < s2 && isspace(l2[i2]))
-					i2++;
-				if (i1 < s1 || i2 < s2)
-					return 0;
-				return 1;
-			}
-			i1++;
-			i2++;
+		while (1) {
+			if (i1 < s1 && i2 < s2 && l1[i1++] == l2[i2++])
+				continue;
+			break;
 		}
-		return i1 >= s1 && i2 >= s2;
+		/*
+		 * we ran out one side; the remaining side must be all
+		 * whitespace to match.
+		 */
+		return remainder_all_ws(l1, l2, i1, i2, s1, s2);
 	} else
 		return s1 == s2 && !memcmp(l1, l2, s1);
 }
