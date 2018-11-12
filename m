Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA5E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeKMIxU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:53:20 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:12585 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeKMIxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1542063484; x=1573599484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OpZwpM/yJB17YhVawZ7iTDwyOa3I9Mdc5PonA6uLBXQ=;
  b=ZZw2dCxJ+3EnP3R72xaMui3VPQaGQhYsWpjKz6NBtojihzQQS/MTklkW
   4iBXWTabAWqD0uejyMebk8UecusTxClzUiG/uAInFGO2mahXnsK84jmXq
   73uN3hHM1uygmOWSZog16Hcvjhrw0nJduOhGWdfuRYBJQz1635AjiZ9P5
   4=;
X-IronPort-AV: E=Sophos;i="5.54,497,1534809600"; 
   d="scan'208";a="704107592"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Nov 2018 22:58:03 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wACMw1wX023404
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 12 Nov 2018 22:58:02 GMT
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 12 Nov 2018 22:58:01 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 12 Nov 2018 22:58:01 +0000
Date:   Mon, 12 Nov 2018 22:58:01 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
CC:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181112225801.GB32727@amazon.com>
References: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com> <87d0re5pt3.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0re5pt3.fsf@evledraar.booking.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 02:43:52PM +0100, Ævar Arnfjörð Bjarmason wrote:

> As noted in
> https://public-inbox.org/git/87bm7clf4o.fsf@evledraar.gmail.com/ and
> https://public-inbox.org/git/87h8gq5zmc.fsf@evledraar.gmail.com/ I think
> it's regardless of Jeff's optimization is. O(nothing) is always faster
> than O(something), particularly (as explained in that E-Mail) on NFS.
> 
> You didn't answer my question in
> https://public-inbox.org/git/20181030024925.GC8325@amazon.com/ about
> whether for your purposes you're interested in this for something where
> it needs to work out of the box on some random Amazon's customer's
> "git", or if it's something in-house and you just don't want to turn off
> collision checking. That would be useful to know.

The reason I started this thread is to optimize performance for AWS customers
that run git on EFS. Therefore, my preference is that git would be fast out of
the box on NFS/EFS but without having to disable collision checking
unconditionally (disabling it for empty repos is fine as that's a no-op
anyway).
