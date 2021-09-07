Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A4FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACBA60EE6
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347474AbhIGWLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:11:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51464 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbhIGWLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 18:11:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A4BE1454D9;
        Tue,  7 Sep 2021 18:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=/C8zpPvovenli9PTQAuOyiUYHYYbsrrV5bPL2p9R8x4=; b=VA0DaXRV2e1t
        jVDyyn5zy5bYBvW4RHrQfvEU6oqMky6I1hzkVIDM9/KMgu1XtHXeNO1HGsUVJiN3
        IhmphtED6pIZi/MaP4F2dzejdoVnaF/GHguPNLijKbgz84hWtXyP9+8g4c6YmEmV
        pYbW0JK/IfbWuK8TifWXYwDs3r5bExQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 540F71454D8;
        Tue,  7 Sep 2021 18:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75B331454D7;
        Tue,  7 Sep 2021 18:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] hash-object: prefix_filename() returns allocated memory
 these days
cc:     peff@peff.net
Date:   Tue, 07 Sep 2021 15:10:22 -0700
Message-ID: <xmqqsfyg82b5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 666EF53C-1028-11EC-B793-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back when a1be47e4 (hash-object: fix buffer reuse with --path in a
subdirectory, 2017-03-20) was written, the prefix_filename() helper
used a static piece of memory to the caller, making the caller
responsible for copying it, if it wants to keep it across another
call to the same function.  Two callers of the prefix_filename() in
hash-object were made to xstrdup() the value obtained from it.

But in the same series, when e4da43b1 (prefix_filename: return newly
allocated string, 2017-03-20) changed the rule to gave the caller
possession of the memory, we forgot to revert one of the xstrdup()
changes, allowing the returned value to leak.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * "git show -W e4da43b1 builtin/hash-object.c" made me curious.

 builtin/hash-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/hash-object.c w/builtin/hash-object.c
index 640ef4ded5..084cba204b 100644
--- c/builtin/hash-object.c
+++ w/builtin/hash-object.c
@@ -117,7 +117,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		prefix = setup_git_directory_gently(&nongit);
 
 	if (vpath && prefix)
-		vpath = xstrdup(prefix_filename(prefix, vpath));
+		vpath = prefix_filename(prefix, vpath);
 
 	git_config(git_default_config, NULL);
 
