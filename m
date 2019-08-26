Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,UNPARSEABLE_RELAY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DBB1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfHZSCp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:02:45 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:49001 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387588AbfHZSCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:02:45 -0400
X-Envelope-From: stsp@stsp.name
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id x7QI2bKj025267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 20:02:38 +0200
Received: from localhost (ted.stsp.name [local])
        by ted.stsp.name (OpenSMTPD) with ESMTPA id 58b81044;
        Mon, 26 Aug 2019 20:02:37 +0200 (CEST)
Date:   Mon, 26 Aug 2019 20:02:37 +0200
From:   Stefan Sperling <stsp@stsp.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] fix segv with corrupt tag object
Message-ID: <20190826180237.GN14213@ted.stsp.name>
References: <20190824230944.GA14132@jessup.stsp.name>
 <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
 <20190826115715.GB71935@jessup.stsp.name>
 <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 10:20:20AM -0700, Junio C Hamano wrote:
> Stefan Sperling <stsp@stsp.name> writes:
> 
> > The root cause of this bug seems to be that the valid assumption
> > that obj->parsed implies a successfully parsed object is broken by
> > parse_tag_buffer() because this function sets the 'parsed' flag even
> > if errors occur during parsing.
> 
> I am mildly negative about that approach.  obj->parsed is about
> "we've done all we need to do to attempt parsing this object" (so
> that next person who gets hold of the object knows that fact---one
> of the reasons why may be that the caller who wants to ensure that
> the fields are ready to be accessed does not have to spend extra
> cycles, but that is not the only one).  Those that want to look at
> various fields in the object (e.g. the tagged object of a tag, the
> tagger identity of a tag, etc.) should be prepared to see and react
> to NULL in there so that they can gracefully handle "slightly"
> corrupt objects.
> 

I will respectfully agree to disagree :-)
If an object is corrupt the repository is broken and should be fixed.
Now, if this code was running in a tool which intends to fix up such
problems, sure, let it handle corrupt objects. But I don't see the point
of complicating code all over the place just to have the main tool's
intended functionality partly working in face of corruption.

That said, since you state that the 'parsed' flag already carries a
different meaning than I was assuming it did, my patch is wrong and
should be rewritten by someone else who can fully make sense of the
existing internals.
