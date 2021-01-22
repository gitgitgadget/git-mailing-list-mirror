Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D3BC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687E523B04
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbhAVUlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:41:35 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:60088 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730338AbhAVUlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:41:12 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10MKePNm018767
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 15:40:26 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10MKePNm018767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611348026; bh=WukE+Lvzr7KToQQV4t7nX7+FeYBIWXdesJZK8V2SWPg=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=KPfETkgSScQS1HBvgIP6yDbvby0SMdfw8KEXqcFSBXRQcC+amVL4WPEkNE714OD/c
         J5/1R7aavTvaeEuuO39EalCRDpDtMkm0wGTPg60rfGhrWFViTGbJstaidenNI91R/o
         zi56X6U+v9+OfMGnxi+renbh5P/WKVlON6gtwcbiNNhRsrwLyWNKKQxIdUFIQCGkbq
         lxNXMSLDqpzu5ZPEZgmfO1rOaGQ0npJQG5GIUezSvBOmrP3udg34yWcQX6FkhpJOFO
         QBcYvg6BPV+Z3NiOp2TYDAyZ9ndgTc6biyz/sar5+dx7sZON5O3ZWbeuMomEreR8Xk
         bRjZA0u9dpUiw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: git archive setting user and group
Date:   Fri, 22 Jan 2021 15:40:36 -0500
Organization: PD Inc
Message-ID: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLXWEf+Gh/QU1qo8KQR9BTs8ih/4KgzTKuQ
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Jason Pyeron <jpyeron@pdinc.us>
> Sent: Friday, January 22, 2021 3:09 PM
> 
> I am about to make a release for logwatch tonight. Historically the files are owned by logwatch in the
> tgz file. When I use git archive it is owned by uid 0, is there an option to set the uid/uname,
> gid/gname owner of the files?

Answer: not at this time, as it is hard coded in the source.

archive-tar.c:
static void prepare_header(struct archiver_args *args,
                           struct ustar_header *header,
                           unsigned int mode, unsigned long size)
{
        xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
        xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_ISREG(mode) ? (uintmax_t)size : (uintmax_t)0);
        xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);

        xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
        xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
        strlcpy(header->uname, "root", sizeof(header->uname));
        strlcpy(header->gname, "root", sizeof(header->gname));


meh.

