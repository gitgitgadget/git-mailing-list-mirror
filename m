Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BFE728CF
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjI2StK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2StJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 14:49:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C394E193
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 11:49:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A16330C84;
        Fri, 29 Sep 2023 14:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ciCZExRBeWoaWn6N559/eGYP0R2tzNthNWL0P9
        qDRxA=; b=mmCqa9dP2klK375JW+AvAX4kJ5T3CBYQyL52AVC43tB309x+JAbzXP
        H7SSaLCVybONLunPhRMLBf5S3QvbjSPE13iadUaVqf0/gzjiS6Libh6noT3Yx190
        uZ0fpJ2zV1PpPhgGAC1/pMvZptD1Qqc7QLGZ8IpozFjt8RYPPpsqM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 614AF30C83;
        Fri, 29 Sep 2023 14:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBE2230C80;
        Fri, 29 Sep 2023 14:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
In-Reply-To: <87bkdkhq4s.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 29 Sep 2023 11:59:31 -0500")
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-21-ebiederm@gmail.com>
        <xmqqfs2zl2iy.fsf@gitster.g> <xmqqbkdmjbkp.fsf@gitster.g>
        <87bkdkhq4s.fsf@gmail.froward.int.ebiederm.org>
Date:   Fri, 29 Sep 2023 11:48:59 -0700
Message-ID: <xmqqedigizms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAB378F2-5EF8-11EE-BE68-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> Did you have any manual merge conflicts you had to resolve?
> If so it is possible to see the merge result you had?

The only merge-fix I had to apply to make everything compile was
this:

diff --git a/bloom.c b/bloom.c
index ff131893cd..59eb0a0481 100644
--- a/bloom.c
+++ b/bloom.c
@@ -278,7 +278,7 @@ static int has_entries_with_high_bit(struct repository *r, struct tree *t)
 		struct tree_desc desc;
 		struct name_entry entry;
 
-		init_tree_desc(&desc, t->buffer, t->size);
+		init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
 		while (tree_entry(&desc, &entry)) {
 			size_t i;
 			for (i = 0; i < entry.pathlen; i++) {

as one topic changed the function signature while the other topic
added a new callsite.

Everything else was pretty-much auto resolved, I think.

Output from "git show --cc seen" matches my recollection.  The above
does appear as an evil merge.

