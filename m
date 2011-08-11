From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/11] object: growing the hash-table more aggressively does
 not help much
Date: Thu, 11 Aug 2011 10:53:11 -0700
Message-ID: <1313085196-13249-7-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZSU-0000IQ-JA
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab1HKRxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab1HKRxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83ADD4192
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dgF/
	/V/KYi3jCayvsNpqZfaCFXg=; b=SPw3XAMyTwp1xQiK1E+q5lzAGmCI0BKXRgc2
	Pr33c8ZEfennyrgKnrqzh8hNKk+AV6JzNb5f72CM9vTZLj/X3v3YUKJL+0ybzAeA
	K6EY+CS3IuLoLMjTV2bUXhyRHeNkFJ8H1+iYp2GJhCMh8zXUn1/ySZTzuXkN36wb
	RSlpP/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QJbjwi
	DFBXHxTN64prg733BOjEezNJxhXsYyq2XW9/ejEVZmPj2JTC+hhnKHJE2z/e3Dfc
	tl/AHX+v6uS2921ZlBGddqzqUNOjXkDFrd6eMh2ATEaCk64ushvvUspy8DQAF1xf
	5y7jMR+32Ru6AWw13P878YIlfHTJko6nrIszg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CAE14191
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11BF84190 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D3C3BCF4-C442-11E0-9846-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179122>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
../+v/2555c0d98970098861c97b7746f2b8846c823e6f/git-pack-objects
Counting objects: 2139209, done.
32.07user 1.96system 0:34.15elapsed 99%CPU (0avgtext+0avgdata 2966176maxresident)k
0inputs+0outputs (0major+225410minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.89user 2.16system 0:34.16elapsed 99%CPU (0avgtext+0avgdata 2965264maxresident)k
0inputs+0outputs (0major+225336minor)pagefaults 0swaps
Counting objects: 2139209, done.
32.01user 2.12system 0:34.23elapsed 99%CPU (0avgtext+0avgdata 2964832maxresident)k
0inputs+0outputs (0major+225332minor)pagefaults 0swaps
---
 object.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index d95d7a6..c2c0a7d 100644
--- a/object.c
+++ b/object.c
@@ -83,7 +83,8 @@ struct object *lookup_object(const unsigned char *sha1)
 
 static int next_size(int sz)
 {
-	return sz < 32 ? 32 : 2 * sz;
+	return (sz < 32 ? 32 :
+		(sz < 1024 * 1024 ? 8 : 2) * sz);
 }
 
 static void grow_object_hash(void)
-- 
1.7.6.433.g1421f
