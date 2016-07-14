Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3CE20196
	for <e@80x24.org>; Thu, 14 Jul 2016 17:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcGNRvO (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:51:14 -0400
Received: from lixid.tarent.de ([193.107.123.118]:41831 "EHLO mail.lixid.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbcGNRvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 13:51:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.lixid.net (MTA) with ESMTP id 1508214029E;
	Thu, 14 Jul 2016 19:51:10 +0200 (CEST)
Received: from mail.lixid.net ([127.0.0.1])
	by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
	id Z_WwOVo-jkW3; Thu, 14 Jul 2016 19:51:09 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.lixid.net (MTA) with ESMTPS id D3A4B14022E;
	Thu, 14 Jul 2016 19:51:09 +0200 (CEST)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
	id 4D1B0221C7A; Thu, 14 Jul 2016 19:51:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tglase.lan.tarent.de (Postfix) with ESMTP id 2FA93221A73;
	Thu, 14 Jul 2016 19:51:09 +0200 (CEST)
Date:	Thu, 14 Jul 2016 19:51:09 +0200 (CEST)
From:	Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To:	Stefan Beller <sbeller@google.com>
cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Server-side preventing some files from being overwritten
In-Reply-To: <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de> <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 14 Jul 2016, Stefan Beller wrote:

> go roughly like

Thanks, that did the trick!

Although I’m ordinarily loath to write GNU bash scripts, this
helps avoiding temporary files. This works:

-----cutting here may damage your screen surface-----
#!/bin/bash
export LC_ALL=C
subdir=x/y
while IFS=' ' read -r old new name; do
	test x"$name" = x"refs/heads/master" || continue
	if test x"0" != x"$(comm -23z \
	    <(git ls-tree -r -z "$old" "$subdir" | sort -z) \
	    <(git ls-tree -r -z "$new" "$subdir" | sort -z) | wc -c)"; then
		echo >&2 'Untouchable files touched, commit rejected!'
		exit 1
	fi
done
exit 0
-----cutting here may damage your screen surface-----

Of course, set “subdir” in line 3 correctly, and GNU coreutils
are required for the NUL line termination, which is not an issue
here. (BSD has “-R ''” for sort(1), for example.)

bye,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
