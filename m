Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5AA21F453
	for <e@80x24.org>; Mon, 29 Oct 2018 21:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ3GZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 02:25:30 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:17993 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3GZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 02:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1540848899; x=1572384899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIZ+3WMMQ0VMczALgh2pDwrGMDXCX0iwA85JCpvgayA=;
  b=M50ADw/G8QBFX6ZgRkr0A4/qStJhsjcD52qZ2c3f89CNAKQm65HzsIKp
   K/LdJm/u/Wd/5ae4ygevUhtrewTLf70zGL4bPRXpMdq1GCMzf6d7i3Fj5
   xzhf+Fgz03eCshWaLtf5XyftzAoXB/Q/5cKiHCD3z21nFGvZXrfNGEH7k
   U=;
X-IronPort-AV: E=Sophos;i="5.54,441,1534809600"; 
   d="scan'208";a="761971450"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 21:34:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9TLYqgn039611
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Oct 2018 21:34:55 GMT
Received: from EX13D15UEE003.ant.amazon.com (10.43.62.19) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 21:34:54 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D15UEE003.ant.amazon.com (10.43.62.19) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 21:34:53 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 29 Oct 2018 21:34:53 +0000
Date:   Mon, 29 Oct 2018 21:34:53 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029213453.GA8325@amazon.com>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 09:48:02AM +0900, Junio C Hamano wrote:

> A real question is how much performance gain, relative to ".cloning"
> thing, this approach gives us.  If it gives us 80% or more of the
> gain compared to doing no checking, I'd say we have a clear winner.

I've tested Jeff's loose-object-cache patch and the performance is within error
bounds of my .cloning patch. A git clone of the same repo as in my initial
tests:

  .cloning -> 10m04
  loose-object-cache -> 9m59

Jeff's patch does a little more work (256 readdir() calls, which in case of an
empty repo translate into 256 LOOKUP calls that return NFS4ERR_NOENT) but that
appears to be insignificant.

I agree that the loose-object-cache approach is preferred as it applies to more
git commands and also benefits performance when there are loose objects
already in the repository.

As pointed out in the thread, maybe the default cache size should be some
integer times gc.auto.

I believe the loose-object-cache approach would have a performance regression
when you're receiving a small pack file and there's many loose objects in the
repo. Basically you're trading off

    MIN(256, num_objects_in_pack / dentries_per_readdir) * readdir_latency
    
against

    num_loose_objects * stat_latency

On Amazon EFS (and I expect on other NFS server implementations too) it is more
efficient to do readdir() on a large directory than to stat() each of the
individual files in the same directory. I don't have exact numbers but based on
a very rough calculation the difference is roughly 10x for large directories
under normal circumstances.

As an example, this means that when you're recieving a pack file with 1K
objects in a repository with 10K loose objects that the loose-object-cache
patch has roughly the same performance as the current git. I'm not sure if this
is something to worry about as I'm not sure people run repos with this many
loose files. If it is a concern, there could be a flag to turn the loose object
cache on/off.
