Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1D31F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeGFF1t (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:27:49 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42084 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbeGFF1s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:27:48 -0400
Received: by mail-yw0-f194.google.com with SMTP id y203-v6so3775115ywd.9
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpI8ePF83mIABg8ds7b+PTumqZV+uJ//ZZptoJfsOMY=;
        b=Epwk/8zehio6r6I7JanitBR0xuxnNFyPXTKUaLAq8Myh01syFbPTzKPd9FjkNEEg+k
         6jVWYOZd+mitArtgNmKt0itm0GbEjzNfumpPxVoN3Z0LgTBWVal6zSPLqAP1+ABLL5WT
         nbwuR+hFQKVtvgwTFjFXbrRC0XAujI5stkLygPgD/cCz0VNC4v8RS6FSVPCDOr3CPHCS
         zbpBSWRJ697DEBspGHgr9q/gpMw3Si82Z9AmF4CN2Y4cHIIzowXbROVnG0Mdaajnd/Ur
         fWPRld4koAuNLBsReA3qRL1SdI46IC/w9qTYDyKCpTdD4gZ8IPyfzo3lCYozj++C4lq0
         jCVQ==
X-Gm-Message-State: APt69E2J0rq9c9eENe9JXlRAxev8KZKXM1tbiTFCxBERDUc3Nr3aQ3EW
        W/ftGpyIuPEYpuWhFswrk++9vl2lUosmnz6FdmI=
X-Google-Smtp-Source: AAOMgpfiFir5p0k9/SeQ/xwOA9zYKNmJ/g/a3GLx8xGzSjWLysHUeecQwcNXYvrxNi5J3O+qPNr0CL6Y4CF5aY3ElK0=
X-Received: by 2002:a0d:f383:: with SMTP id c125-v6mr4125129ywf.98.1530854868199;
 Thu, 05 Jul 2018 22:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-16-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-16-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:27:37 -0400
Message-ID: <CAPig+cR1BaOTTjg751NO14sAr6UZ0WT_G3Hu59KyiWTASZ8D2A@mail.gmail.com>
Subject: Re: [PATCH v3 15/24] midx: write object offsets
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> The final pair of chunks for the multi-pack-index file stores the object
> offsets. We default to using 32-bit offsets as in the pack-index version
> 1 format, but if there exists an offset larger than 32-bits, we use a
> trick similar to the pack-index version 2 format by storing all offsets
> at least 2^31 in a 64-bit table; we use the 32-bit table to point into
> that 64-bit table as necessary.
>
> We only store these 64-bit offsets if necessary, so create a test that
> manipulates a version 2 pack-index to fake a large offset. This allows
> us to test that the large offset table is created, but the data does not
> match the actual packfile offsets. The multi-pack-index offset does match
> the (corrupted) pack-index offset, so a future feature will compare these
> offsets during a 'verify' step.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -6,25 +6,28 @@ test_description='multi-pack-indexes'
> +# usage: corrupt_data <file> <pos> [<data>]
> +corrupt_data() {

Style: corrupt_data () {

> +       file=$1
> +       pos=$2
> +       data="${3:-\0}"
> +       printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
> +}
> +
> +# Force 64-bit offsets by manipulating the idx file.
> +# This makes the IDX file _incorrect_ so be careful to clean up after!
> +test_expect_success 'force some 64-bit offsets with pack-objects' '
> +       mkdir objects64 &&
> +       mkdir objects64/pack &&
> +       pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
> +       idx64=objects64/pack/test-64-$pack64.idx &&
> +       chmod u+w $idx64 &&

I guess you don't have to worry about the POSIXPERM prerequisite here
because the file is already writable on Windows, right?

> +       corrupt_data $idx64 2899 "\02" &&
> +       midx64=$(git multi-pack-index write --object-dir=objects64) &&
> +       midx_read_expect 1 62 5 objects64 " large_offsets"
>  '
