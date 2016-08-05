Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53602018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938235AbcHES4E (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:56:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52494 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938212AbcHES4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:56:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E452018E;
	Fri,  5 Aug 2016 18:55:59 +0000 (UTC)
Date:	Fri, 5 Aug 2016 18:55:59 +0000
From:	Eric Wong <e@80x24.org>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Message-ID: <20160805185559.GB463@starla>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <20160727094102.GA31374@starla>
 <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> > On 27 Jul 2016, at 11:41, Eric Wong <e@80x24.org> wrote:
> > larsxschneider@gmail.com wrote:
> >> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
> >> +						int fd, struct strbuf *dst, const char *cmd,
> >> +						const char *filter_type)
> >> +{
> > 
> > <snip>
> > 
> >> +	if (fd >= 0 && !src) {
> >> +		ret &= fstat(fd, &file_stat) != -1;
> >> +		len = file_stat.st_size;
> > 
> > Same truncation bug I noticed earlier; what I originally meant
> > is the `len' arg probably ought to be off_t, here, not size_t.
> > 32-bit x86 Linux systems have 32-bit size_t (unsigned), but
> > large file support means off_t is 64-bits (signed).
> 
> OK. Would it be OK to keep size_t for this patch series?

I think there should at least be a truncation warning (or die)
for larger-than-4GB files on 32-bit.  I don't know how common
they are for git-lfs users.

Perhaps using xsize_t in git-compat-util.h works for now:

	len = xsize_t(file_stat.st_size);

(sorry, I haven't had much time to look at your other updates)
