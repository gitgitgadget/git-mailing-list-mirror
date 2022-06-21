Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99410C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiFURsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiFURsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 13:48:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF081706C
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 10:48:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDD6A19A0FA;
        Tue, 21 Jun 2022 13:48:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7XMb5iYsHZGSNyADw9qN0IDIxE2QbRfEHjc2/a
        LeT9Y=; b=yKmTGAygZc2z0IQf+Nr+UQMBu7LvSHr4Z5I7Mg8zM1CVrNhBM/bcm6
        xT7BqZPQlNojZdFntSTNpgvPlB/nZ/pUepxdG5/lnAj4XgCZKJSQp8U4BeN+jiUC
        4F2DZtK98RIGbyEPn9csx8pMb2QkTL9Gx0557jYXTw2x2dA4HuDJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4CA719A0F7;
        Tue, 21 Jun 2022 13:48:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F9E919A0F6;
        Tue, 21 Jun 2022 13:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Oliver <roliver@roku.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: do not check type of remote objects
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
        <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
        <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
        <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
        <YqkpRE8nykqVv8cn@nand.local>
        <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
        <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
        <xmqqa6adzln6.fsf@gitster.g>
        <1566aed1-a38f-a9ca-241c-21b56d732328@roku.com>
        <xmqqy1xwtsds.fsf@gitster.g>
        <748f39a9-65aa-2110-cf92-7ddf81b5f507@roku.com>
Date:   Tue, 21 Jun 2022 10:48:46 -0700
In-Reply-To: <748f39a9-65aa-2110-cf92-7ddf81b5f507@roku.com> (Richard Oliver's
        message of "Tue, 21 Jun 2022 14:59:39 +0100")
Message-ID: <xmqqilothpq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66E04734-F18A-11EC-B6BE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Oliver <roliver@roku.com> writes:

> +	/* Check the type of object identified by oid without fetching objects */
> +	struct object_info oi = OBJECT_INFO_INIT;

This is -Wdecl-after-statement.

> +	oi.typep = &obj_type;
> +	if (oid_object_info_extended(the_repository, &oid, &oi,
> +				     OBJECT_INFO_LOOKUP_REPLACE |
> +				     OBJECT_INFO_QUICK |
> +				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
> +		obj_type = -1;
> +
>  	if (obj_type < 0) {
>  		if (allow_missing) {
>  			; /* no problem - missing objects are presumed to be of the right type */


I've done an obvious and trivial fix-up locally while queueing.

Thanks.


diff --git a/builtin/mktree.c b/builtin/mktree.c
index cfadb52670..06d81400f5 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -74,6 +74,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	unsigned mode;
 	enum object_type mode_type; /* object type derived from mode */
 	enum object_type obj_type; /* object type derived from sha */
+	struct object_info oi = OBJECT_INFO_INIT;
 	char *path, *to_free = NULL;
 	struct object_id oid;
 
@@ -117,7 +118,6 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	}
 
 	/* Check the type of object identified by oid without fetching objects */
-	struct object_info oi = OBJECT_INFO_INIT;
 	oi.typep = &obj_type;
 	if (oid_object_info_extended(the_repository, &oid, &oi,
 				     OBJECT_INFO_LOOKUP_REPLACE |
