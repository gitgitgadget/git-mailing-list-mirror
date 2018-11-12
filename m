Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B307F1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeKMIkR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:40:17 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:30455 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeKMIkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1542062703; x=1573598703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6N1sjWz3y58UxqLyiIeJCAdOjW28PWLSsiJifUUPU+s=;
  b=bGpNLghWREYlKneWxF6WDC5+vTv8JQWi71dTluXktAP+V7Ev8C7bAxJV
   5pKkYjlhIIXHhqSHcBEpt5hjZRVGF6rSSUJxX05N6rjXgJLD0QhVfURzm
   bSaY7+9Ro7g+dXE1+gXPo5KYDz3+ClIs0zhq9jKzzd9pWnW9zFXc5H2zU
   o=;
X-IronPort-AV: E=Sophos;i="5.54,497,1534809600"; 
   d="scan'208";a="769879100"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Nov 2018 22:44:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wACMiksb059343
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 12 Nov 2018 22:44:47 GMT
Received: from EX13D06UEE003.ant.amazon.com (10.43.62.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 12 Nov 2018 22:44:46 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D06UEE003.ant.amazon.com (10.43.62.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 12 Nov 2018 22:44:46 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 12 Nov 2018 22:44:46 +0000
Date:   Mon, 12 Nov 2018 22:44:46 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Jeff King <peff@peff.net>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181112224445.GA32727@amazon.com>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112162150.GB7612@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 11:21:51AM -0500, Jeff King wrote:

> No, but they don't even really need to be actual objects. So I suspect
> something like:
> 
>   git init
>   for i in $(seq 256); do
>     i=$(printf %02x $i)
>     mkdir -p .git/objects/$i
>     for j in $(seq --format=%038g 1000); do
>       echo foo >.git/objects/$i/$j
>     done
>   done
>   git index-pack -v --stdin </path/to/git.git/objects/pack/XYZ.pack
> 
> might work (for various values of 1000). The shell loop would probably
> be faster as perl, too. :)
> 
> Make sure you clear the object directory between runs, though (otherwise
> the subsequent index-pack's really do find collisions and spend time
> accessing the objects).

Below are my results. They are not as comprehensive as Ævar's tests. Similary I
kept the loose objects between tests and removed the packs instead. And I also
used the "echo 3 | sudo tee /proc/sys/vm/drop_caches" trick :)

This is with git.git:

                   origin/master    jk/loose-object-cache

256*100 objects    520s             13.5s (-97%)
256*1000 objects   826s             59s (-93%)

I've started a 256*10K setup but that's still creating the 2.5M loose objects.
I'll post the results when it's done. I would expect that jk/loose-object-cache
is still marginally faster than origin/master based on a simple linear
extrapolation.
