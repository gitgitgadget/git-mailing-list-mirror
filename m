Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB4F1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeKIHdY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 02:33:24 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:49122 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeKIHdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1541714157; x=1573250157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LdPb+YgZXD5SDLnoqCS5PAZsPOGA7Ge7UkLfvDFfoHw=;
  b=RNPkYx2nCHdrkJcMRHpg/D+sWFVPtQaGAbBuqUMYrt7FSWnE1pMK2MaS
   Yfm7TwT4LLy6RgT2c7ygEaMQYQHi8i4Q0+S1ryOVm32oMCxohHp33xB8v
   /540pK7LEzSnNcHGvaTG64nBUDOIDRMX8cpSlSEu8a4Puo2zFVafIKyCD
   c=;
X-IronPort-AV: E=Sophos;i="5.54,480,1534809600"; 
   d="scan'208";a="769193302"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 21:55:55 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wA8LttIU062518
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Nov 2018 21:55:55 GMT
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Nov 2018 21:55:54 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Nov 2018 21:55:54 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 8 Nov 2018 21:55:53 +0000
Date:   Thu, 8 Nov 2018 21:55:53 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Jeff King <peff@peff.net>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181108215553.GA77596@amazon.com>
References: <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <20181108120256.GA29432@sigill.intra.peff.net>
 <20181108205819.GA93589@amazon.com>
 <20181108211823.GA20145@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181108211823.GA20145@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 04:18:24PM -0500, Jeff King wrote:

> Heh, indeed. Try this on top:
> 
> diff --git a/sha1-file.c b/sha1-file.c
> index bc35b28e17..9ff27f92ed 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -692,6 +692,7 @@ void prepare_alt_odb(struct repository *r)
>  	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
>  
>  	read_info_alternates(r, r->objects->odb->path, 0);
> +	r->objects->loaded_alternates = 1;
>  }
>  
>  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */

Thanks, this did it. Performance is now back at the level of the previous patch.
