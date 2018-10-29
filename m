Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1E61F453
	for <e@80x24.org>; Mon, 29 Oct 2018 22:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJ3HME (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 03:12:04 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55736 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeJ3HMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 03:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1540851683; x=1572387683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GRjJ/NuKkXui/2BqCJ0A+/9W/c+xXV+nSbwY9GAecko=;
  b=o9yvRwMDS/W5OuBcCeMpdH9P9mxr3HbIqTEQN1Hs/WarSxCpn4Z7oOEF
   BrtU7bIge1clUq4xw2VwXch86+9UMXB3Zi8eepmCXE85FTJylZHY5GBVI
   ETEnxkHDJIvjDxttjuWCiOk4x0byZ4rI+jYXgrr8MLEps5EmSHh4SarKx
   k=;
X-IronPort-AV: E=Sophos;i="5.54,441,1534809600"; 
   d="scan'208";a="701990629"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 22:21:21 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9TMLFl7027956
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Oct 2018 22:21:20 GMT
Received: from EX13D16UEB002.ant.amazon.com (10.43.60.131) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 22:21:20 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D16UEB002.ant.amazon.com (10.43.60.131) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 22:21:19 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 29 Oct 2018 22:21:19 +0000
Date:   Mon, 29 Oct 2018 22:21:19 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Jeff King <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029222119.GB8325@amazon.com>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
 <20181029213453.GA8325@amazon.com>
 <20181029215049.GA24557@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181029215049.GA24557@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 05:50:50PM -0400, Jeff King wrote:

> > I believe the loose-object-cache approach would have a performance regression
> > when you're receiving a small pack file and there's many loose objects in the
> > repo. Basically you're trading off
> > 
> >     MIN(256, num_objects_in_pack / dentries_per_readdir) * readdir_latency
> >     
> > against
> > 
> >     num_loose_objects * stat_latency
> 
> Should num_loose_objects and num_objects_in_pack be swapped here? Just
> making sure I understand what you're saying.

Whoops, yes, thanks for spotting that!

> So the 256 in your MIN() is potentially much smaller. We still have to
> deal with the fact that if you have a large number of loose objects,
> they may be split cross multiple readdir (or getdents) calls. The "cache
> maximum" we discussed does bound that, but in some ways that's worse:
> you waste time doing the bounded amount of readdir and then don't even
> get the benefit of the cache. ;)

Yup. To get the performance benefit you'd like the cache to hold all loose
objects except in clearly degenerate cases with far too many loose objects.

> > On Amazon EFS (and I expect on other NFS server implementations too) it is more
> > efficient to do readdir() on a large directory than to stat() each of the
> > individual files in the same directory. I don't have exact numbers but based on
> > a very rough calculation the difference is roughly 10x for large directories
> > under normal circumstances.
> 
> I'd expect readdir() to be much faster than stat() in general (e.g., "ls
> -f" versus "ls -l" is faster even on a warm cache; there's more
> formatting going on in the latter, but I think a lot of it is the effort
> to stat).

In the case of NFS, the client usually requests that the READDIR response also
contains some of the stat flags (like st_mode). But even in this case it's
still more efficient to return multiple entries in one batch through READDIR
rather than as individual responses to GETATTR (which is what stat() maps to).
