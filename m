Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F115D1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbcLEXhf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Dec 2016 18:37:35 -0500
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:51049 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbcLEXhe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:37:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 8A691100054;
        Mon,  5 Dec 2016 23:37:32 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P6wFUFL9TzAK; Mon,  5 Dec 2016 23:37:32 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 752D48002E;
        Mon,  5 Dec 2016 23:37:32 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 5 Dec 2016 23:37:32 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Mon, 5 Dec 2016 23:37:32 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "bmwill@google.com" <bmwill@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: RE: [RFC PATCHv2 14/17] submodule: teach unpack_trees() to update
 submodules
Thread-Topic: [RFC PATCHv2 14/17] submodule: teach unpack_trees() to update
 submodules
Thread-Index: AQHSTPyApFqmkpi+AUCxQjQGJOL28qD6AYqQ
Date:   Mon, 5 Dec 2016 23:37:32 +0000
Message-ID: <c43b64307a3e48188bc9479226058b16@exmbdft7.ad.twosigma.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-15-sbeller@google.com>
In-Reply-To: <20161203003022.29797-15-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Friday, December 02, 2016 7:30 PM
> To: bmwill@google.com; David Turner
> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; hvoigt@hvoigt.net;
> gitster@pobox.com; Stefan Beller
> Subject: [RFC PATCHv2 14/17] submodule: teach unpack_trees() to update
> submodules
[snip]
>  	if (!lstat(ce->name, &st)) {
> -		int flags =
> CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
> -		unsigned changed = ie_match_stat(o->src_index, ce, &st,
> flags);
> -		if (!changed)
> -			return 0;
> -		/*
> -		 * NEEDSWORK: the current default policy is to allow
> -		 * submodule to be out of sync wrt the superproject
> -		 * index.  This needs to be tightened later for
> -		 * submodules that are marked to be automatically
> -		 * checked out.
> -		 */
> -		if (S_ISGITLINK(ce->ce_mode))
> -			return 0;
> +		if (S_ISGITLINK(ce->ce_mode)) {
> +			if (!submodule_is_interesting(ce->name))
> +				return 0;
> +			if (ce_stage(ce) ? is_submodule_checkout_safe(ce->name,
> &ce->oid)
> +			    : !is_submodule_modified(ce->name, 1))

This logic is too convoluted.  Do a nested if or something.

> +				return 0;
> +		} else {
> +			int flags = CE_MATCH_IGNORE_VALID |
> CE_MATCH_IGNORE_SKIP_WORKTREE;
> +			if (!ie_match_stat(o->src_index, ce, &st, flags))
> +				return 0;

Nit: I liked the old temp var "changed" better -- it made it clear what
ie_match_stat is checking.

> +		}
>  		errno = 0;
>  	}
>  	if (errno == ENOENT)
> @@ -1355,6 +1359,38 @@ static int verify_uptodate_sparse(const struct
> cache_entry *ce,
>  	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);  }
> 
> +/*
> + * When a submodule gets turned into an unmerged entry, we want it to
> +be
> + * up-to-date regarding the merge changes.
> + */
> +static int verify_uptodate_submodule(const struct cache_entry *old,
> +				     const struct cache_entry *new,
> +				     struct unpack_trees_options *o) {
> +	struct stat st;
> +
> +	if (o->index_only ||
> +	    (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old)) &&
> +	      (o->reset || ce_uptodate(old))))
> +		return 0;
> +
> +	if (!submodule_is_interesting(new->name))
> +		return 0;
> +
> +	if (lstat(old->name, &st)) {

We never actually use st here.  Should we?  If not, is this really the right error message?  And should we use access() instead of lstat?

> +		if (errno == ENOENT)
> +			return 0;
> +		return o->gently ? -1 :
> +			add_rejected_path(o, ERROR_NOT_UPTODATE_SUBMODULE,
> +					  old->name);
> +	}
> +

