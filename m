Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F3C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 22:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F9F207D4
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFOWip convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 15 Jun 2020 18:38:45 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40341 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOWip (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 18:38:45 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05FMcenP093800
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Jun 2020 18:38:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <015c01d63ddd$97d65080$c782f180$@nexbridge.com> <20200615215937.GA636737@coredump.intra.peff.net>
In-Reply-To: <20200615215937.GA636737@coredump.intra.peff.net>
Subject: RE: [Possible Bug] Use of write on size-limited platforms
Date:   Mon, 15 Jun 2020 18:38:34 -0400
Message-ID: <002801d64365$b6fdc2d0$24f94870$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIiTx0sS4gALBW8notSiC9T8n4M5QKWXqXkqC1xhlA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 15, 2020 6:00 PM, Jeff King wrote:
> On Mon, Jun 08, 2020 at 05:41:34PM -0400, Randall S. Becker wrote:
> > I just wanted to check the following calls to make sure that it does
> > not fwrite or write should be xread/xwrite or are guaranteed not to
> > exceed
> > MAX_IO_SIZE:
> >
> > strbuf.c: strbuf_write, strbuf_write_fd, the size is not specified.
> >
> > The other uses of read/write appear to be safe.
> 
> strbuf_write() is using fwrite(), and we don't enforce MAX_IO_SIZE with stdio
> anywhere else. And I'd expect in general that if there are any platform
> limitations, the system libc would choose a sane value anyway.
> So that one is probably fine.
> 
> I think strbuf_write_fd() is wrong to use a raw write(), but for several
> reasons:
> 
>  - it won't enforce MAX_IO_SIZE, as you note
> 
>  - it won't handle EINTR, etc; callers need to be prepared to restart
>    such a write
> 
>  - it won't handle a partial write by looping until all output is sent
> 
> For the latter two, there are cases where some callers want the flexibility to
> stop when seeing a signal or a partial write. But I don't think that makes any
> sense for strbuf_write_fd(). If I pass in a strbuf with 8kb of data and I get a
> return value that indicates we only wrote 4kb, what do I do next? I certainly
> can't call strbuf_write_fd() again, since it would write from the beginning of
> the strbuf again. I'd have to call xwrite() myself after that. At which point I
> may as well have done so for the first call. :)
> 
> So I think this really ought to be using write_in_full(). There's only one caller,
> and I think it would be improved by the switch. Do you want to write a
> patch?
> 
> You could make an argument that the fwrite() version ought to also loop,
> since it's possible to get a partial write there, too. But we don't do that in
> general. I suspect in practice most stdio implementations will keep writing
> until they see an error, and most callers don't bother checking stdio errors at
> all, or use ferror().

I'll give the patch a go. It is very simple. Would you suggest removing the strbuf_write_fd() as part of this patch since it only impacts bugreport.c?

Regards,
Randall

