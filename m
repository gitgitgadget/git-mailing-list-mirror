Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E07201A7
	for <e@80x24.org>; Mon, 15 May 2017 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758666AbdEOVVk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 15 May 2017 17:21:40 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:60326 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758646AbdEOVVj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 17:21:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id D9D9E1000FE;
        Mon, 15 May 2017 21:21:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6O0SIWtastmP; Mon, 15 May 2017 21:21:37 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id C7E788002E;
        Mon, 15 May 2017 21:21:37 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 15 May 2017 21:21:37 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 15 May 2017 21:21:37 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "benpeart@microsoft.com" <benpeart@microsoft.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Thread-Topic: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Thread-Index: AQHSza9xnxP0HlkZREi6FimeFkCaFKH13b4Q
Date:   Mon, 15 May 2017 21:21:37 +0000
Message-ID: <d195af80f27e4fea85a96d6435b36139@exmbdft7.ad.twosigma.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
In-Reply-To: <20170515191347.1892-3-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> -----Original Message-----
> From: Ben Peart [mailto:peartben@gmail.com]
> Sent: Monday, May 15, 2017 3:14 PM
> To: git@vger.kernel.org
> Cc: gitster@pobox.com; benpeart@microsoft.com; pclouds@gmail.com;
> johannes.schindelin@gmx.de; David Turner <David.Turner@twosigma.com>;
> peff@peff.net
> Subject: [PATCH v1 2/5] Teach git to optionally utilize a file system monitor to
> speed up detecting new or changed files.

> @@ -342,6 +344,8 @@ struct index_state {
>  	struct hashmap dir_hash;
>  	unsigned char sha1[20];
>  	struct untracked_cache *untracked;
> +	time_t last_update;
> +	struct ewah_bitmap *bitmap;

The name 'bitmap' doesn't tell the reader much about what it used for.

> +static int update_istate(const char *name, void *is) {

Rename to mark_file_dirty?  Also why does it take a void pointer?  Or return int (rather than void)?

> +void refresh_by_fsmonitor(struct index_state *istate) {
> +	static has_run_once = FALSE;
> +	struct strbuf buffer = STRBUF_INIT;

Rename to query_result? Also I think you're leaking it.

