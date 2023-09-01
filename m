Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A73CA0FE8
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 06:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbjIAGqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIAGqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 02:46:49 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF48CEB
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 23:46:46 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 740A024269;
        Fri,  1 Sep 2023 02:46:43 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qbxvX-RsH-00; Fri, 01 Sep 2023 08:46:43 +0200
Date:   Fri, 1 Sep 2023 08:46:43 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] treewide: fix various bugs w/ OpenSSL 3+ EVP API
Message-ID: <ZPGI02eZLmFGKCaE@ugly>
References: <ZPCL11k38PXTkFga@debian.me>
 <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
 <20230901005742.M783359@dcvr>
 <20230901020928.M610756@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230901020928.M610756@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 02:09:28AM +0000, Eric Wong wrote:
>@@ -1202,7 +1203,9 @@ static void parse_pack_objects(unsigned char *hash)
> 
> 	/* Check pack integrity */
> 	flush();
>+	the_hash_algo->init_fn(&tmp_ctx);
>
does it make sense (and doesn't it potentially even cause a leak) to 
init the target before cloning into it? at least the fallback simply 
memcpy()s over it.

>@@ -669,7 +670,9 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
> 	the_hash_algo->init_fn(&ctx);
> 	unpack_all();
> 	the_hash_algo->update_fn(&ctx, buffer, offset);
>+	the_hash_algo->init_fn(&tmp_ctx);
>
ditto

>+	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
>+	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);

regards
