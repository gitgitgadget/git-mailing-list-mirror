Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF172021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbcKPAWf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 15 Nov 2016 19:22:35 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:38448 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754033AbcKPAWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:22:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 8867A10007A;
        Wed, 16 Nov 2016 00:22:21 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZtoC3ZhyOQ3w; Wed, 16 Nov 2016 00:22:21 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 7528E80035;
        Wed, 16 Nov 2016 00:22:21 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Wed, 16 Nov 2016 00:22:21 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Wed, 16 Nov 2016 00:22:21 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Subject: RE: [PATCH 13/16] submodule: teach unpack_trees() to update
 submodules
Thread-Topic: [PATCH 13/16] submodule: teach unpack_trees() to update
 submodules
Thread-Index: AQHSP5T/yfE5zbVgwU2DRjwgjfcv5aDauJXg
Date:   Wed, 16 Nov 2016 00:22:21 +0000
Message-ID: <f54d446aa7734cb4aec4b51c7b81a2b6@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-14-sbeller@google.com>
In-Reply-To: <20161115230651.23953-14-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I've reviewed up-to and including 13; I'll look at 14-16 tomorrow-ish]

> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Tuesday, November 15, 2016 6:07 PM
> Cc: git@vger.kernel.org; bmwill@google.com; gitster@pobox.com;
> jrnieder@gmail.com; mogulguy10@gmail.com; David Turner; Stefan Beller
> Subject: [PATCH 13/16] submodule: teach unpack_trees() to update
> submodules
...
>  	msgs[ERROR_NOT_UPTODATE_DIR] =
>  		_("Updating the following directories would lose untracked
> files in it:\n%s");
> +	msgs[ERROR_NOT_UPTODATE_SUBMODULE] =
> +		_("Updating the following submodules would lose modifications
> in
> +it:\n%s");

s/it/them/

>  	if (!strcmp(cmd, "checkout"))
>  		msg = advice_commit_before_merge
> @@ -1315,19 +1320,18 @@ static int verify_uptodate_1(const struct
> cache_entry *ce,
>  		return 0;
> 
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
> +		if (!S_ISGITLINK(ce->ce_mode)) {

I generally prefer to avoid if (!x) { A } else { B } -- I would rather just see if (x) { B } else { A }.

> +		if (!changed) {
> +			/* old is always a submodule */
> +			if (S_ISGITLINK(new->ce_mode)) {
> +				/*
> +				 * new is also a submodule, so check if we care
> +				 * and then if can checkout the new sha1 safely
> +				 */
> +				if (submodule_is_interesting(old->name, null_sha1)
> +				    && is_submodule_checkout_safe(new->name, &new-
> >oid))
> +					return 0;
> +			} else {
> +				/*
> +				 * new is not a submodule any more, so only
> +				 * care if we care:
> +				 */
> +				if (submodule_is_interesting(old->name, null_sha1)
> +				    && ok_to_remove_submodule(old->name))
> +					return 0;
> +			}

Do we need a return 1 in here somewhere?  Because otherwise, we fall through and return 0 later.

