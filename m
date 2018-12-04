Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0245211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 05:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLDFYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 00:24:54 -0500
Received: from www.dnalounge.com ([3.16.178.106]:59746 "EHLO
        cerebrum.dnalounge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 00:24:54 -0500
Received: from [10.0.1.2] (70-36-236-109.dsl.static.fusionbroadband.com [70.36.236.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cerebrum.dnalounge.com (Postfix) with ESMTPSA id BD493E47;
        Mon,  3 Dec 2018 21:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jwz.org; s=mail;
        t=1543901093; bh=LBaN2/WnmpW7y13nRhzaiJJRPYvlUWhiJAMjonna5a8=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ecC8nBzrIanTIbKEdJpjX93p4ri0vXNAfBHeRHvhQxRNI4U7jzrtIFe6XDugTZdLX
         43fahLTWJMU1BV7vnJntfvMLZMyFqMhglqtYwtotCFFvyE3EuxsKVLIW1REC6g9QeE
         iHW1qtoXS9sORHhQatz4dY7OW1ixGHAoUz67p5WA=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: sharedrepository=group not working
From:   Jamie Zawinski <jwz@jwz.org>
In-Reply-To: <20181204045051.GA23351@sigill.intra.peff.net>
Date:   Mon, 3 Dec 2018 21:24:51 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <903E1F42-3911-471D-B754-7592A5FD2CC7@jwz.org>
References: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
 <20181204040903.GA17059@sigill.intra.peff.net>
 <53C59F2A-6D97-45F9-AF86-E255F6777E7F@jwz.org>
 <20181204045051.GA23351@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 3, 2018, at 8:50 PM, Jeff King <peff@peff.net> wrote:
>=20
> I don't suppose this is leaving those incoming-* directories sitting
> around so we can inspect their permissions (it's suppose to clean them
> up, so I doubt it). If you're up for it, it might be interesting to
> patch Git to inspect the umask and "ls -l" the objects/ directory at =
the
> problematic moment. The interesting point is when we call into
> tmp-objdir.c:setup_tmp_objdir().

The problem was that Apache was setting my umask to 113! With that:

+ ls -ldF ./objects/incoming-w7agmb/pack objects/incoming-w7agmb
ls: cannot access ./objects/incoming-w7agmb/pack: Permission denied
drw---S--- 2 apache cvs 4096 Dec  3 21:14 objects/incoming-w7agmb/
error: remote unpack failed: unable to create temporary object directory

With 002 it succeeds:

+ ls -ldF ./objects/incoming-IbGS6h/pack objects/incoming-IbGS6h
drwx--S--- 3 apache cvs 4096 Dec  3 21:19 objects/incoming-IbGS6h/
drwxrwsr-x 2 apache cvs 4096 Dec  3 21:19 =
./objects/incoming-IbGS6h/pack/

So I fixed my umask and got it working, but maybe a test for "your umask =
is dumb" is worthwhile.

Thanks for your help!

--
Jamie Zawinski      https://www.jwz.org/      https://www.dnalounge.com/

