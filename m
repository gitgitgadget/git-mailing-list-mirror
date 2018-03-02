Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50151F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946160AbeCBKhm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:37:42 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58868 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946029AbeCBKhj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:37:39 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DDDE01F576;
        Fri,  2 Mar 2018 10:37:37 +0000 (UTC)
Date:   Fri, 2 Mar 2018 10:37:37 +0000
From:   Eric Wong <e@80x24.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Reduce pack-objects memory footprint?
Message-ID: <20180302103737.GA22348@80x24.org>
References: <20180228092722.GA25627@ash>
 <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
> struct revindex_entry {
>         off_t offset;
>         unsigned int nr;
> };
> 
> We need on entry per object, so 6.5M objects * 16 bytes = 104 MB. If
> we break this struct apart and store two arrays of offset and nr in
> struct packed_git, we save 4 bytes per struct, 26 MB total.

Can the offset array can be a union which stores
int32_t/uint32_t instead of off_t for projects which never
exceed 2/4GB?

Likewise, places object_entry where "unsigned long" and off_t
are 64-bit could benefit from being 32-bit.  Testing/maintenance
overhead could be bad, for those, though.
