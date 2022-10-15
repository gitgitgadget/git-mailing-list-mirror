Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C509C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJOQ4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJOQ4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 12:56:08 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Oct 2022 09:56:03 PDT
Received: from mail.hostpark.net (mail.hostpark.net [212.243.197.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3A049B5F
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 09:56:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.hostpark.net (Postfix) with ESMTP id 1F9B616595
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 18:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bernoul.li; h=
        content-type:content-type:mime-version:message-id:date:date
        :subject:subject:from:from:received:received; s=sel2011a; t=
        1665852637; bh=1dsJouKXBHxko6oZQbvx1ka1Owfsf6wNi3VATztMkjc=; b=G
        OxmgmEMruHUcfq+pSZsslNlnPNIPLB0VqZag6CoyfAXoO2vDwkZsDuLaPKn5qwK1
        r4u5hyFMDl2W6nHRUeIj7Y5ZCj53HsKgoqsfZzYfkRMiCfgf7MsX2QZayfdIZhTL
        w/GkzSfLWfNA/jqf2RaVU5CIRy4QQoO+86QtFyji8U=
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
        by localhost (mail0.hostpark.net [127.0.0.1]) (amavisd-new, port 10224)
        with ESMTP id W7O7SIlTFrIo for <git@vger.kernel.org>;
        Sat, 15 Oct 2022 18:50:37 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.hostpark.net (Postfix) with ESMTPSA id E0C0416591
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 18:50:37 +0200 (CEST)
From:   Jonas Bernoulli <jonas@bernoul.li>
To:     git@vger.kernel.org
Subject: "submodule foreach" much slower than removed "submodule--helper
 --list"
Date:   Sat, 15 Oct 2022 18:50:36 +0200
Message-ID: <87czatrpyb.fsf@bernoul.li>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In v2.38.0 (31955475d1c283120d5d84247eb3fd55d9f5fdd9)
"submodule--helper --list" was remove because

> We're not getting anything useful from the "list | cut -f2"
> invocation that we couldn't get from "foreach 'echo $sm_path'".

But we get speed (this is with about one hundred modules):

$ time git submodule foreach -q 'echo $sm_path' > /dev/null

real    0m0.585s
user    0m0.413s
sys     0m0.182s

$ time git submodule--helper list > /dev/null

real    0m0.008s
user    0m0.004s
sys     0m0.004s

Please consider restoring this subcommand or providing something
equivalent that is just as fast.

     Thanks,
     Jonas
