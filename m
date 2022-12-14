Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B5C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 14:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiLNOxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbiLNOxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 09:53:44 -0500
Received: from smtp95.ord1d.emailsrvr.com (smtp95.ord1d.emailsrvr.com [184.106.54.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97226A84
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1671029622;
        bh=wZ/1r/VpBERjOo+Qbn5gp6WIXRkMs0Rw2zCHhAm2WrI=;
        h=Date:From:To:Subject:From;
        b=LoYlrj0JD2NQziTL00Pb4AihavzlotKZOAmc+l2w4er8zGrPRr6dT+8Alb6FDMRDs
         J2PpGriwGuRgGpKsAlujNutA3TtLrSr5UxvU55QjAD1jLucV7Ky7VDFF/FQjN+cF0Y
         JJQrybCciuIx/SbTCLXcP51wi6dn56GebUYBeT2s=
X-Auth-ID: lars@oddbit.com
Received: by smtp20.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 3891DC0223;
        Wed, 14 Dec 2022 09:53:42 -0500 (EST)
Date:   Wed, 14 Dec 2022 09:53:41 -0500
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] line-range: Fix infinite loop bug with degenerate '$'
 regex
Message-ID: <20221214145341.sonppjtshwqoxs6n@oddbit.com>
References: <20221205193625.2424202-1-lars@oddbit.com>
 <20221211015340.2181837-1-lars@oddbit.com>
 <xmqq5yeiwr6x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5yeiwr6x.fsf@gitster.g>
X-Classification-ID: a54f1369-a459-4aa1-89f0-46d2eea8b97f-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 11, 2022 at 12:32:38PM +0900, Junio C Hamano wrote:
> Lars Kellogg-Stedman <lars@oddbit.com> writes:
> 
> > When the -L argument to "git log" is passed the degenerate regular
> > expression "$" (as in "-L :$:line-range.c"), this results in an
> > infinite loop in find_funcname_matching_regexp().
> 
> Is "matching an empty line" the only way a regular expression can be
> a "degenerate" one?  If not, perhaps being a bit more explicit would
> help the readers, e.g.

"Matching an empty line" isn't the issue (and if I implied that it
was, that's my bad). The issue only crops up when matching the
zero-width regular expression at the *end* of a line.

I'll update the subject and description to be more clear...

> This clear explanation probably deserves to be in the commit log
> message proper.

...including adding the extended description to the commit message. Some projects
object if commit messages get too wordy.

> Please write it on two lines, and highlight an empty body of the
> loop, like so

Will do.

> > @@ -161,6 +160,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
> >  			return bol;
> >  		start = eol;
> >  	}
> > +	return NULL;
> >  }
> 
> What is this change about?  Isn't the above an endless loop without
> break, from which the only way for the control to leave it is by
> returning?

It's not an endless loop without break; this change modified the loop
condition:

> -       while (1) {
> +       while (*start) {

That would have prevented the infinite loop in the first place. I'm
happy to drop this change if you prefer, but if this condition had
been in place originally we wouldn't have had the infinite loop bug
(we would still have had incorrect behavior, but it would have been
perhaps easier for an end user to diagnose).

> Style: lose the SP after "cat >".

Will do.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS
