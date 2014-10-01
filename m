From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] sha1-lookup: fix handling of duplicates in sha1_pos()
Date: Wed, 1 Oct 2014 06:50:07 -0400
Message-ID: <20141001105006.GB10332@peff.net>
References: <542BCBFC.5000509@web.de>
 <542BCCB9.4050908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:50:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHUB-00032f-Np
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbaJAKuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 06:50:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:53600 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751148AbaJAKuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 06:50:08 -0400
Received: (qmail 17113 invoked by uid 102); 1 Oct 2014 10:50:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 05:50:08 -0500
Received: (qmail 25475 invoked by uid 107); 1 Oct 2014 10:50:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 06:50:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2014 06:50:07 -0400
Content-Disposition: inline
In-Reply-To: <542BCCB9.4050908@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257738>

On Wed, Oct 01, 2014 at 11:43:21AM +0200, Ren=C3=A9 Scharfe wrote:

> If the first 18 bytes of the SHA1's of all entries are the same then
> sha1_pos() dies and reports that the lower and upper limits of the
> binary search were the same that this wasn't supposed to happen.  Thi=
s
> is wrong because the remaining two bytes could still differ.
>=20
> Furthermore: It wouldn't be a problem if they actually were the same,
> i.e. if all entries have the same SHA1.  The code already handles
> duplicates just fine otherwise.  Simply remove the erroneous check.

Yeah, I agree that assertion is just wrong.

Regarding duplicates: in sha1_entry_pos, we had to handle the "not
found" case specially, because we may have found the left-hand or
right-hand side of a run of duplicates, and we want to return the
correct slot where the new item would go (see the comment added by
171bdac). I think we don't have to deal with that here, because we are
just dealing with the initial "mi" selection. The actual binary search
is plain-vanilla, which handles that case just fine.

I wonder if it is worth adding a test (you test only that "not found"
produces a negative index, but not which index). Like:

diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 3fcb8d8..7781129 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -42,12 +42,12 @@ test_expect_success 'lookup' '
 '
=20
 test_expect_success 'lookup non-existing entry' '
+	echo -1 >expect &&
 	{
 		echo20 "append " 88 44 aa 55 &&
 		echo20 "lookup " 33
 	} | test-sha1-array >actual &&
-	n=3D$(cat actual) &&
-	test "$n" -lt 0
+	test_cmp expect actual
 '
=20
 test_expect_success 'lookup with duplicates' '
@@ -61,6 +61,17 @@ test_expect_success 'lookup with duplicates' '
 	test "$n" -le 3
 '
=20
+test_expect_success 'lookup non-existing entry with duplicates' '
+	echo -5 >expect &&
+	{
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "lookup " 66
+	} | test-sha1-array >actual &&
+	test_cmp expect actual
+'
+
+
 test_expect_success 'lookup with almost duplicate values' '
 	{
 		echo "append 5555555555555555555555555555555555555555" &&
