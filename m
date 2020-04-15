Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CAC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A504820774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437935AbgDOUT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:19:56 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:46675 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437924AbgDOUTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 16:19:55 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 6B00E9C133;
        Wed, 15 Apr 2020 20:19:53 +0000 (UTC)
        (envelope-from vd@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 492YcT1MTNz4Lms;
        Wed, 15 Apr 2020 20:19:53 +0000 (UTC)
        (envelope-from vd@FreeBSD.org)
Received: from localhost (APN-123-247-45-gprs.simobil.net [46.123.247.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: vd)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 4B1B51998C;
        Wed, 15 Apr 2020 20:19:52 +0000 (UTC)
        (envelope-from vd@FreeBSD.org)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id c65755d7;
        Wed, 15 Apr 2020 22:19:47 +0200 (CEST)
Date:   Wed, 15 Apr 2020 22:19:47 +0200
From:   Vasil Dimov <vd@freebsd.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] range-diff: avoid negative string precision
Message-ID: <20200415201947.GA47498@smle>
Reply-To: vd@freebsd.org
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <b3384880c7201d65adb7341ce23386d578e69193.1586960921.git.gitgitgadget@gmail.com>
 <20200415162035.GD22823@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415162035.GD22823@syl.local>
User-Agent: Mutt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 10:20:35 -0600, Taylor Blau wrote:
> On Wed, Apr 15, 2020 at 02:28:41PM +0000, Vasil Dimov via GitGitGadget wrote:
> > From: Vasil Dimov <vd@FreeBSD.org>
> >
> > If the supplied integer for "precisoin" is negative in
> 
> s/precisoin/precision

Fixed in v2.

> > `"%.*s", len, line` then it is ignored. So the current code is
> > equivalent to just `"%s", line` because it is executed only if
> > `len` is negative.
> >
> > Fix this by saving the value of `len` before overwriting it with the
> > return value of `parse_git_diff_header()`.
> >
> > Signed-off-by: Vasil Dimov <vd@FreeBSD.org>
> > ---
> >  range-diff.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/range-diff.c b/range-diff.c
> > index 5cc920be391..40af0862818 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -123,16 +123,19 @@ static int read_patches(const char *range, struct string_list *list,
> >  			struct patch patch = { 0 };
> >  			struct strbuf root = STRBUF_INIT;
> >  			int linenr = 0;
> > +			int orig_len;
> 
> Any reason to not assign this to 'len' up here?

I believe that assigning it just before len is changed and that grouping
all usage of the new variable close to each other makes the code more
readable. Ideally it would also be defined below.

> >  			in_header = 0;
> >  			strbuf_addch(&buf, '\n');
> >  			if (!util->diff_offset)
> >  				util->diff_offset = buf.len;
> >  			line[len - 1] = '\n';
> > +			orig_len = len;
> >  			len = parse_git_diff_header(&root, &linenr, 0, line,
> >  						    len, size, &patch);
> 
> OK, so we cut up the line by placing a NL at len, and then feed it to
> 'parse_git_diff_header' which will tell us the length of the thing that
> it parsed, or give a negative value if it couldn't parse...
> 
> >  			if (len < 0)
> > -				die(_("could not parse git header '%.*s'"), (int)len, line);
> > +				die(_("could not parse git header '%.*s'"),
> > +				    orig_len, line);
> 
> ...and then you restore the original length and print it out here. It
> seems like this error is now misleading though, because the line is
> already modified at the point that the newline was inserted.
[...]

It was '\0' before we overwrote it with '\n':

 89                 len = find_end_of_line(line, size);
 90                 line[len - 1] = '\0';

`line` points to a buffer of the entire output of `git log`, with many
newlines in it. In the beginning of the loop we overwrite the first new
line char in the buffer with '\0', then we restore it to '\n' and
eventually advance the pointer to the start of the next line.

I think that the intention of this code is to print only one line (the
current one).

-- 
Vasil Dimov
gro.DSBeerF@dv
%
Success consists of going from failure to failure without loss of
enthusiasm.
                -- Winston Churchill
