Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472FC433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 02:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856A9207E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 02:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qRU6EdaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbgGWCjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:39:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40568 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730837AbgGWCjJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 22:39:09 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0C6EA6044F;
        Thu, 23 Jul 2020 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595471948;
        bh=f5uKxAqWfm9xrrki22TFFSjAsMI7zfVTZRhkGvSRUCM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qRU6EdaX3cYkG3/IIoQiqHy/2XQdOCjx5P1UiNG4gNYGCuxCtAjzcHPjQS+oUFimt
         nDj9mMztKdEdijsIShFX49VhEU6fQTWemxadQfZh/pawD5fW7MsMiAM/bdSrDfHY2B
         MBESwhIo3fnQMFFUfOuLMg+KLhfOojnAFtLD5WiVOdXMVCMATSXNqKxq60TcWB7c2M
         Y9A+N/jHN7bYSjTuzkC9i07UmcMb9Nouztbet1GycWggQpUxkLQg8RjPlnQOJYlugJ
         6aQ8rbEo+V1fwmj/y7lrK4e/B1N2Ws7XytraqqV9hd3vnSECtFX7JcPIO3xbvaaNEp
         uJhwU3WQ0Cskv41+KDd2rUgKQT+fXQlu10uFAY66m127Q75PSlBLn+eevQrF1pXEPw
         7ilvrfnYt7CEztycYDD9u251ILSiW5JH6wX3ZVEHsyt0iBIFloIP0AfVRID4FOMua4
         irpCZxef/wrPdILGxRRr+OnHSv5wyQKlwhnyhBnmTx/7q7DkS/e
Date:   Thu, 23 Jul 2020 02:39:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 32/39] setup: add support for reading
 extensions.objectformat
Message-ID: <20200723023900.GA1758454@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
 <20200723010943.2329634-33-sandals@crustytoothpaste.net>
 <xmqqblk73s1n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblk73s1n.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-23 at 02:04:52, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > @@ -613,6 +622,11 @@ int verify_repository_format(const struct repository_format *format,
> >  		return -1;
> >  	}
> >  
> > +	if (format->version <= 0 && format->hash_algo != GIT_HASH_SHA1) {
> > +		strbuf_addstr(err, _("extensions.objectFormat is not valid in repo v0"));
> > +		return -1;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> 
> By declaring that the repository is invalid if its version is less
> than 1 and objectFormat extension defined, we prevent unwanted
> upgrading from happening by mistake.

Yes, and more specifically:

* If the repository is v0 and has an objectFormat set, we fail in newer
  versions of Git (i.e., after this series).  Older versions which do
  not support the extension will see breakage (because unknown
  extensions are not fatal in v0), but we hope by adding this check that
  nobody will ever configure a repo this way, since it will be totally
  nonfunctional in this state, regardless of version.
* If the repository is v1 and has an objectFormat set, we work with
  newer Git and everything is great.  Older Git versions fail hard here,
  and the user gets a moderately helpful error message.

v2 of the series just ignored the setting in v0, which would make it
equally broken in older and newer versions, but would provide a less
useful error message (probably about a corrupt index).
-- 
brian m. carlson: Houston, Texas, US
