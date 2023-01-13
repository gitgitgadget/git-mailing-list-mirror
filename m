Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E3C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 13:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbjAMNdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjAMNch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 08:32:37 -0500
X-Greylist: delayed 1453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 05:24:00 PST
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0517E0F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 05:24:00 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 4A4BE262DD5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:23:59 +0100 (CET)
Message-ID: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
Date:   Fri, 13 Jan 2023 14:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Hans Petter Selasky <hps@selasky.org>
Subject: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Currently GIT only supports cryptographic hashes for its commit tags.

That means:

1) It's very difficult to edit the history without also recomputing the 
hash tags for all commits after the needed change-point, which then 
means references to a repository is broken.

2) Only a single bit error in the main repository can break everything!

3) Illicit contents may be present in binary blobs, which in the future 
may be need to be removed without warrant and the only way to do that is 
by rebasing and force pushing, which will break "everything". It can be 
everything from child-porn to expired distribution licenses.

Many people think that bit errors cannot happen because the memory uses 
ECC and the file system uses cryptographic hashes to verify the 
integrity of the data. But what many people forget about is that when 
copying data from memory to disk, typically using a DMA channel data is 
copied w/o any kind of integrity protection, because the integrity 
protection is not end-to-end. The integrity protection is only per-link.

Therefore I propose the following changes to GIT.

1) Use a CRC128 / 256 or 512 non-cryptographic based hashing algorithm 
as default.

2) Add support for a CRC fixup field, which usually is zero, but when 
merges are needed, it can be non-zero, to allow the hash-tag-value to 
remain the same! This also allows for easy conversion of existing GIT 
repositories to the new scheme.

3) All git objects should be uncompressed.

CRC-XXX can easily be used to correct multiple bit errors without any 
performance overhead.

--HPS
