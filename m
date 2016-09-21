Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F88F20985
	for <e@80x24.org>; Wed, 21 Sep 2016 22:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934112AbcIUWaB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:30:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47292 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933101AbcIUWaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:30:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B90511F935;
        Wed, 21 Sep 2016 22:29:59 +0000 (UTC)
Date:   Wed, 21 Sep 2016 22:29:59 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] http: check curl_multi_remove_handle error code
Message-ID: <20160921222959.GA4781@whir>
References: <20160913002557.10671-1-e@80x24.org>
 <xmqqr38nv8ul.fsf@gitster.mtv.corp.google.com>
 <20160921214623.GA1919@whir>
 <20160921222208.ccgnpgx3gcvbjpfm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160921222208.ccgnpgx3gcvbjpfm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Sep 21, 2016 at 09:46:23PM +0000, Eric Wong wrote:
> 
> > -----------8<-----------
> > Subject: [PATCH] http: check curl_multi_remove_handle error code
> > 
> > This should help detect bugs in future changes.  While we're at
> > it, fix a (probably innocuous) bug in our http_cleanup function
> > for users of older curl.
> > 
> > curl_multi_remove_handle was not idempotent until curl 7.33.0
> > with commit 84f3b3dd448399f9548468676e1bd1475dba8de5
> > ("curl_multi_remove_handle: allow multiple removes"),
> > so we track the "curlm" membership of the curl easy handle
> > ourselves with a new "in_multi" flag.
> 
> Does curl provide a meaningful error here? I'm just wondering if we
> could simply let curl handle this, and just ignore the error that comes
> from older versions. We're basically just replicating curl's own state
> data here.

curl before 7.33.0 returned CURLM_BAD_EASY_HANDLE.  This error
code also happens if we pass a bad/corrupt easy handle;
so it could be hiding an error on our end.
