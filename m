Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D821F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 18:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeGES6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 14:58:34 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40761 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeGES6e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 14:58:34 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so3611751ybm.7
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 11:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBSShUxrBtohm05+GpuEcHQcMj1sSwgxBbcye5+dZRk=;
        b=ZS7Pm4dERCpxvAfepGBS8KJ6Iq/EHNCseLLmDicuRpUNPEaqQyzs1zIEwoYBuRjQcF
         4zWKKLvXN7S1hekog+PM4H5pHg78pk6grKedJq0HhKJ0sPcGVEkGbb59l9tl62Y0LNhy
         ZT5Ss8NNQ+kKtSD+phPzHixLyL1c1rChi2DwZICkbLQQj+cr5v8T8cSWuz1DfzZxfRRY
         eEXNqd3Np3gwsW6pGAzZilDBz1dwLHTMaZvSZNRH7+Xhy4RRGLX6boRz+6IG4QsYXHbl
         M4HMQ4nemMVJMSeuewSlS0opdV2AHNb+LXdo+f7DrYCi+ftOR49lsqACkjSUKOlUfdTW
         IKtA==
X-Gm-Message-State: APt69E0pG3PBY+QL/ASHwh1gJTFxmpERSkU3QXgOtrCU3wTJ1PKy5HEU
        3Z74iaoGh760bn9WndyDIXtngW6vl/Yph3KU7DQ=
X-Google-Smtp-Source: AAOMgpfFWgQH3CKw9/oATHhNxBhCR90QYJXsCNnWMEiKN3sKYJSB49V06VgYbfP4NjlCGOzPcrp4PNJuKM+cl6SwHnk=
X-Received: by 2002:a25:bb4e:: with SMTP id b14-v6mr3816872ybk.263.1530817113481;
 Thu, 05 Jul 2018 11:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180625143434.89044-1-dstolee@microsoft.com>
 <20180625143434.89044-7-dstolee@microsoft.com> <xmqqfu1aodw3.fsf@gitster-ct.c.googlers.com>
 <2bb2a12f-f22d-990b-636c-73b2b805d12d@gmail.com>
In-Reply-To: <2bb2a12f-f22d-990b-636c-73b2b805d12d@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Jul 2018 14:58:22 -0400
Message-ID: <CAPig+cTVD5OpVnxAqQnO_CkzFRRkZ3YWsRC4ZwUmAELSZzcDKw@mail.gmail.com>
Subject: Re: [PATCH v2 06/24] multi-pack-index: load into memory
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
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

On Thu, Jul 5, 2018 at 10:20 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 6/25/2018 3:38 PM, Junio C Hamano wrote:
> While I don't use substitutions in this patch, I do use them in later
> patches. Here is the final version of this method:
>
> midx_read_expect () {
>          NUM_PACKS=$1
>          NUM_OBJECTS=$2
>          NUM_CHUNKS=$3
>          EXTRA_CHUNKS="$5"
>          cat >expect <<-\EOF
>          header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
>          chunks: pack_names oid_fanout oid_lookup
> object_offsets$EXTRA_CHUNKS
>          num_objects: $NUM_OBJECTS
>          packs:
>          EOF
>
> Using <<-\EOF causes these substitutions to fail. Is there a different
> way I should construct this method?

When you need to interpolate variables into the here-doc, use <<-EOF;
when you don't, use <<-\EOF.
