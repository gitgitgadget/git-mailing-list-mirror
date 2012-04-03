From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] read-cache.c: report the header version we do not
 understand
Date: Tue,  3 Apr 2012 15:53:12 -0700
Message-ID: <1333493596-14202-6-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbg-0006ve-Pg
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab2DCWxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755705Ab2DCWx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FFF7F77
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Np5L
	F8qLJYzmplUfcMtfYTQUHKM=; b=CVdvXTWBg6NQ3GSZRvnRZKEeVZZhKCjBkWhX
	uo5G4AtX145inrStYwbhuW+o9xOs7s9q9TNIN6cYjKvl1Y8Hk3ahQOa0fSn0SBJN
	3cf3L8W2ttDZvWOW7ReLhSt17yndL0MxA1AF7kCED5DFZkUhaoKm2m0kwIhfiYpo
	+ufK7Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=T77IAF
	OlJOMlGw7xR+kYeae4HQCj4pujVQuxl5hMCpmFYy9IhX1HtJy/ISZGiVEowB0Ctu
	mD5LfHmsOr9/mBnE31yiIoTeWvvU2D0+A6RlaZobg1/MVLYYbUL/3J+pub0K4UXP
	9QPPFSm7UAk6S1+cV9wBAVykTheWGXfU32Xl4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3737F74
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00B207F71 for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D3115210-7DDF-11E1-A001-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194667>

Instead of just saying "bad index version", report the value we read
from the disk.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 58bfb24..2d93826 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1247,11 +1247,13 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
+	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
-	if (hdr->hdr_version != htonl(2) && hdr->hdr_version != htonl(3))
-		return error("bad index version");
+	hdr_version = ntohl(hdr->hdr_version);
+	if (hdr_version < 2 || 3 < hdr_version)
+		return error("bad index version %d", hdr_version);
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
-- 
1.7.10.rc4.54.g1d5dd3
