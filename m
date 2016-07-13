Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B347C1F744
	for <e@80x24.org>; Wed, 13 Jul 2016 07:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcGMHWS (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 03:22:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46966 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbcGMHWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 03:22:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u6D7LaeW026618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Jul 2016 09:21:36 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u6D7Lb41013717;
	Wed, 13 Jul 2016 09:21:37 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, sschuberth@gmail.com
Subject: Re: [PATCH v3] config: add conditional include
References: <20160628172641.26381-3-pclouds@gmail.com>
	<20160712164216.24072-1-pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 09:21:37 +0200
In-Reply-To: <20160712164216.24072-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 12 Jul 2016 18:42:16 +0200")
Message-ID: <vpqa8hmroji.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 13 Jul 2016 09:21:37 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u6D7LaeW026618
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1468999297.724@GF6/Kp6iZF3meU18RFMRng
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy <pclouds@gmail.com> writes:

> +`gitdir`::
> +	The environment variable `GIT_DIR` must match the following
> +	pattern for files to be included. The pattern can contain
> +	standard globbing wildcards and two additional ones, `**/` and
> +	`/**`, that can match multiple path components. Please refer
> +	to linkgit:gitignore[5] for details. For convenience:

It's unclear to me whether the whole content of GIT_DIR must match, or
whether the pattern should be included (or a be prefix) of $GIT_DIR.
From this text, I read it as "the whole content", but ...

> +	; include for all repositories inside /path/to/group
> +	[include "gitdir:/path/to/group/"]
> +		path = /path/to/foo.inc
> +
> +	; include for all repositories inside $HOME/to/group
> +	[include "gitdir:~/to/group/"]
> +		path = /path/to/foo.inc

... here it seems it only has to be a prefix.

> +static int prepare_include_condition_pattern(struct strbuf *pat)
> +{
> +	int prefix = 0;
> +
> +	/* TODO: maybe support ~user/ too */
> +	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
> +		struct strbuf path = STRBUF_INIT;
> +		const char *home = getenv("HOME");
> +
> +		if (!home)
> +			return error(_("$HOME is not defined"));

expand_user_path in path.c seems to do the same as you're doing (but
does deal with ~user). Any reason not to use it?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
