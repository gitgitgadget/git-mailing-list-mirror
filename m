From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2] t5540-http-test: shorten grep pattern
Date: Mon, 29 Aug 2011 02:42:21 -0400
Message-ID: <FA05560D-EE6C-43F4-BD67-EF9E77FA969A@gernhardtsoftware.com>
References: <1314506520-17430-1-git-send-email-brian@gernhardtsoftware.com> <7vhb5094pm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxvYF-0006qx-9q
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab1H2Gm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 02:42:27 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56217 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1H2Gm0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 02:42:26 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6484D1FFC165; Mon, 29 Aug 2011 06:42:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 7AA561FFC02F;
	Mon, 29 Aug 2011 06:42:10 +0000 (UTC)
In-Reply-To: <7vhb5094pm.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180303>

On OS X, the grep pattern

    "\"OP .*/objects/$x2/X38_X40 HTTP/[.0-9]*\" 20[0-9] "

is too long ($x38 and $x40 represent 38 and 40 copies of [0-9a-f]) for
grep to handle.  In order to still be able to match this, use the sed
invocation to replace what we're looking for with a token.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t5540-http-push.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

On Aug 29, 2011, at 1:17 AM, Junio C Hamano wrote:

> Is it sensible to replace $x40 with X40 and $x38 with X38 on any line
> anywhere for the purpose of this test? As the downstream test is only
> interested in a line with HTTP request line that asks for a specific path
> under objects/??/?{38}_?{40}, wouldn't it make more sense to replace
> occurrences of only such line?

Yes, of course.  The reason it ended up the way it did was that I first
tried replacing $x40 with SHA-1, but that was still too long.  Your way
makes more sense in the end, although the $x38_$x40 bit needs to be
${x38}_$x40 so the shell looks for the right variable.

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index a266ca5..64767d8 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -132,8 +132,12 @@ x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
 x40="$x38$x2"
 
 test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
-	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
-	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
+	sed \
+		-e "s/PUT /OP /" \
+		-e "s/MOVE /OP /" \
+	    -e "s|/objects/$x2/${x38}_$x40|WANTED_PATH_REQUEST|" \
+		"$HTTPD_ROOT_PATH"/access.log |
+	grep -e "\"OP .*WANTED_PATH_REQUEST HTTP/[.0-9]*\" 20[0-9] "
 
 '
 
-- 
1.7.7.rc0.308.g517a2
