Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89943C433E3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E250022B45
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJuRzWoy";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="oOXNvx2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHCTYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:24:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58414 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCTYv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:24:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2723784977;
        Mon,  3 Aug 2020 15:24:49 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=S
        HPQi98HLyTSJpJdlpw6ZRknF2I=; b=GJuRzWoy43i5BC1br0MzKMGHUUkarRveL
        IW1N9Gf5Mm3jS/dxfv1BnW8+0lR2F/wLZu1SR6tUi0DjRMaK650/Ziz7wUcn5jWs
        9HZtX7ooesfIuVjR7fOMcqDU9KmR5LARwPaDEszzJrIQ425FDQFcGnby5d3J0oxH
        T36O1118Mw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D38584976;
        Mon,  3 Aug 2020 15:24:49 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-type; s=mesmtp;
 bh=vmdqWm07CCT/pJ+BjhoeQuuia9B3miw6koN8JjhzhCY=;
 b=oOXNvx2HpInoArTtumy7krrL+MIyP9w0Rztud01eTD61vXCGDs7JdbO0kaUL61dIlotIY9T9OR9p1bshAmGoDXBXjBYzf917SOAab80xLXRid+UZ/dVmA/2Rv8pazKC2a6e8aniiZh+h2UuBVHhb6BtXih26+tem1isUxvYGOHk=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8947884974;
        Mon,  3 Aug 2020 15:24:48 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Confused about git-config's description of escaping
Date:   Mon, 03 Aug 2020 15:24:47 -0400
Message-ID: <878sevwn0g.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEEEEB8C-D5BE-11EA-A211-01D9BED8090B-24757444!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When describing the configuration syntax, the git-config manpage says
this about the value:

    Inside double quotes, double quote " and backslash \ characters must
    be escaped: use \" for " and \\ for \.

I find the "Inside double quotes" part confusing because escaping these
characters appears to also be needed when there are no enclosing double
quotes:

    $ nl .git/config | tail -n2
         6	[a]
         7		b = c"d

    $ git config a.b
    fatal: bad config line 7 in file .git/config

    $ git version
    git version 2.28.0.236.gb10cc79966

I was going to suggest dropping the "Inside double quotes" qualifier.
Perhaps

    Double quote " and backslash \ characters in the value must
    be escaped: use \" for " and \\ for \.

But it looks like that's pretty close to how this sentence was written
before ff5507ed2a (Documentation/config.txt: describe the structure
first and then meaning, 2015-03-04), which makes me think that I'm
misreading the description or otherwise missing something.

What's gained by specifying "Inside double quotes"?  Are there any cases
where a value, whether enclosed in double quotes or not, doesn't need "
or \ characters escaped?
