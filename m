Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C6E2021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbcHBWzc (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:55:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752316AbcHBWza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:55:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5622336DA;
	Tue,  2 Aug 2016 18:52:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	a5e/Ny0gmV4ldTrwmiXO5ubPQI=; b=Tc02tMkxzgxeh9lCnPO410L3GeMODzH1h
	MT9Ik0+QQ9dyBFCyMEKd5qbiAkyYQx9w6MP6+0L2OBCRnyM1UWFydKj9orb9w0iK
	KAkSp2CxglSlzXF0e51ke2L/d9WLIz0on2f59FZDDBQmoh7Bi1c6vCDR46IihCr1
	Kuuo8ea+U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=QYz5A8gx+aJCop8ObqEzRG3svpbsfYm1zxwKi/awfc+CcrooF5xZ6Kb2
	lTWuzpQe4lhnbi4NgHbqloIJoSqDayVAwmtU4OTaPh2ougHZmaSfS08FLeasPIoI
	roKBEr10x2eWrFypaOoDsismWJFshOmVMUm8Mvt9LZ9rFbTEdEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDFFF336D9;
	Tue,  2 Aug 2016 18:52:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 522A6336D8;
	Tue,  2 Aug 2016 18:52:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] hashmap: clarify that hashmap_entry can safely be discarded
Date:	Tue, 02 Aug 2016 15:52:33 -0700
Message-ID: <xmqq8twebx72.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDC643F2-5903-11E6-AE90-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The API documentation said that the hashmap_entry structure to be
embedded in the caller's structure is to be treated as opaque, which
left the reader wondering if it can safely be discarded when it no
longer is necessary.  If the hashmap_entry structure had references
to external resources such as allocated memory or an open file
descriptor, merely free(3)ing the containing structure (when the
caller's structure is on the heap) or letting it go out of scope
(when it is on the stack) would end up leaking the external
resource.

Document that there is no need for hashmap_entry_clear() that
corresponds to hashmap_entry_init() to give the API users a little
bit of peace of mind.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As I wrote the text already, I thought I'd follow-up with a log
   message, too.

 Documentation/technical/api-hashmap.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index ad7a5bd..28f5a8b 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -104,6 +104,11 @@ If `free_entries` is true, each hashmap_entry in the map is freed as well
 `entry` points to the entry to initialize.
 +
 `hash` is the hash code of the entry.
++
+The hashmap_entry structure does not hold references to external resources,
+and it is safe to just discard it once you are done with it (i.e. if
+your structure was allocated with xmalloc(), you can just free(3) it,
+and if it is on stack, you can just let it go out of scope).
 
 `void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)`::
 
-- 
2.9.2-708-gdb68231

