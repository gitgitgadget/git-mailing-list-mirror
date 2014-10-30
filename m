From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] bisect: clean flags after checking merge bases
Date: Thu, 30 Oct 2014 12:01:11 -0700
Message-ID: <xmqq4mulwfew.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 20:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjuyE-0004rQ-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 20:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbaJ3TBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 15:01:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758728AbaJ3TBO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 15:01:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7627C1877F;
	Thu, 30 Oct 2014 15:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=EERoCZzIycK1PBrfDekR342MFUc=; b=QfgooS+xNPBCGr2O9KvJFIJwBwMW
	66wL4KXJKfbkk8Nk9XGgZXsq67NJnryiZWkE11slS5B6ciMu5SuCLQsBqIJQdGWy
	k4HSeElMkWpxL0iuAdmlde5TVHbPAxDTZAfhxc0zkmf2FE3Fr8L+kjw+EEd8Pi8b
	Ohjc5imptKl/dks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	lue6G+EGKPv6LTt0b4d46Vhh1DXt1JWuBWVRd2RBy6gQLIkuZHmkuPYW2YsDAd97
	leUwbN6o9qFdJXPOB54GV2DmXMdv2Iw2n6CGjHaVTt3xEuvr/JjVl4QSC3wLuuQk
	sIOzQLDSAMXXAoUCqcGNoKmId8+sjzQ/35KQr11/iy4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F5731877E;
	Thu, 30 Oct 2014 15:01:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDB711877D;
	Thu, 30 Oct 2014 15:01:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DF5E66C-6067-11E4-A118-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless there is a good reason to belieave that a particular
invocation of a get_merge_bases*() is the last one that cares about
the object flags the computation of merge bases leaves on the
objects, the "cleanup" parameter should always be true, and I do not
think there is one in this codepath.

Found by code inspection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I am planning to eventually change the function signature for
   this function to drop "cleanup" and change rare selected
   codepaths that know what they are doing to call a separate
   function that allows the flags not to be cleaned up.  Two calls
   in builtin/merge-base.c are both the last ones that can leave the
   flags on the objects, but I do not think this one, which happens
   before the main traversal even starts, should pass 0 here.

 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index df09cbc..ccca3b5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -777,7 +777,7 @@ static void check_merge_bases(int no_checkout)
 	int rev_nr;
 	struct commit **rev = get_bad_and_good_commits(&rev_nr);
 
-	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 0);
+	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 1);
 
 	for (; result; result = result->next) {
 		const unsigned char *mb = result->item->object.sha1;
