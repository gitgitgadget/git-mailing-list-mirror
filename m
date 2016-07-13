Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5862018F
	for <e@80x24.org>; Wed, 13 Jul 2016 12:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbcGMMt5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 08:49:57 -0400
Received: from [129.88.30.17] ([129.88.30.17]:59616 "EHLO mx2.imag.fr"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcGMMtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 08:49:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u6DCmiSO020124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Jul 2016 14:48:44 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u6DCmjFS021094;
	Wed, 13 Jul 2016 14:48:45 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH v3] config: add conditional include
References: <20160628172641.26381-3-pclouds@gmail.com>
	<20160712164216.24072-1-pclouds@gmail.com>
	<vpqa8hmroji.fsf@anie.imag.fr>
	<20160713072607.GA15153@sigill.intra.peff.net>
Date:	Wed, 13 Jul 2016 14:48:45 +0200
In-Reply-To: <20160713072607.GA15153@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 13 Jul 2016 03:26:07 -0400")
Message-ID: <vpqmvllhff6.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 13 Jul 2016 14:48:44 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u6DCmiSO020124
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1469018929.06272@vssnjYUpLUxPUpBeRLVNIQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 13, 2016 at 09:21:37AM +0200, Matthieu Moy wrote:
>
>> > +static int prepare_include_condition_pattern(struct strbuf *pat)
>> > +{
>> > +	int prefix = 0;
>> > +
>> > +	/* TODO: maybe support ~user/ too */
>> > +	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
>> > +		struct strbuf path = STRBUF_INIT;
>> > +		const char *home = getenv("HOME");
>> > +
>> > +		if (!home)
>> > +			return error(_("$HOME is not defined"));
>> 
>> expand_user_path in path.c seems to do the same as you're doing (but
>> does deal with ~user). Any reason not to use it?
>
> I had a similar question, which Duy answered in:
>
>   http://article.gmane.org/gmane.comp.version-control.git/298528
>
> It does feel pretty hacky, though (especially for a case that seems
> unlikely to come up: people having wildcard patterns in the name of
> their home directory).

Ah, OK. Then I'd suggest at least an improvement in the comment:

 		/*
-		 * perform literal matching on the prefix part so that
- 		 * any wildcard character in it can't create side effects.
+		 * perform literal matching on the expanded prefix part
+		 * so that any wildcard character in it (e.g in the
+		 * expansion of ~) can't create side effects.
 		 */

I would also rename the variable prefix -> expanded_prefix. As-is, the
code is really hard to understand IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
