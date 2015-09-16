From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 29/67] use strip_suffix and xstrfmt to replace suffix
Date: Wed, 16 Sep 2015 11:20:02 -0400
Message-ID: <20150916152002.GC547@flurp.local>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154714.GC29753@sigill.intra.peff.net>
 <CAPig+cRefYKBOLJMsu+yAp7D=GYh4Pr5eXEeHXR0b-4hhOfxPQ@mail.gmail.com>
 <20150916105037.GI13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 17:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcEVJ-0000yG-OM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 17:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbbIPPUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 11:20:06 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34048 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbIPPUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 11:20:05 -0400
Received: by iofb144 with SMTP id b144so234425104iof.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4aMlwCHp/tfJi6kx60IzK1UsPPv1UVy9FikZnukvvmg=;
        b=fehR85xrHM0DuSyZsm+sBaFqTtLMkhkypCL+4tghSASOfpOPQ4yng3Om0of1y/pZEw
         O7o5Apc5F0Op1tCtb59XB3iV2RDk/GXSZJpVppXvD8gMzJfGx6VO4VedDdrjHRyGGD57
         stfkXWx3s+8cBzwDKz0FnxEidQX6ds7S2EEjkKhWM+MQuj1OP27u6OKrDxmpPivoxZW7
         nEf7fekEBQO5G4wgXaj3RQSrjRlPgCbyZ/oeQUwVB4R9omjahBSRRfWX/ROaJPOphkO4
         3W+SK2kMdF2Svp5wKR4RyEufTnt2f23hM7NLTkCsJsiPeEmjJlFHbQWzdwJnzok2lTKh
         69GA==
X-Received: by 10.107.16.80 with SMTP id y77mr42756714ioi.183.1442416804208;
        Wed, 16 Sep 2015 08:20:04 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id a4sm2083715igh.16.2015.09.16.08.20.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 08:20:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150916105037.GI13966@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278031>

On Wed, Sep 16, 2015 at 06:50:38AM -0400, Jeff King wrote:
> On Wed, Sep 16, 2015 at 12:38:12AM -0400, Eric Sunshine wrote:
> > > @@ -1524,9 +1525,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
> > >                 lst = &((*lst)->next);
> > >         *lst = (*lst)->next;
> > >
> > > -       tmp_idx = xstrdup(preq->tmpfile);
> > > -       strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
> > > -              ".idx.temp");
> > > +       if (!strip_suffix(preq->tmpfile, ".pack.temp", &len))
> > > +               die("BUG: pack tmpfile does not end in .pack.temp?");
> > > +       tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
> > 
> > These instances of repeated replacement code may argue in favor of a
> > general purpose replace_suffix() function:
> > 
> >     char *replace_suffix(const char *s, const char *old, const char *new)
> >     {
> >         size_t n;
> >         if (!strip_suffix(s, old, &n))
> >             die("BUG: '%s' does not end with '%s', s, old);
> >         return xstrfmt("%.*s%s", (int)n, s, new);
> >     }
> > 
> > or something.
> 
> Yeah, that is tempting, but I think the "die" here is not at all
> appropriate in a reusable function. I'd probably write it as:
> 
>   char *replace_suffix(const char *s, const char *old, const char *new)
>   {
> 	size_t n;
> 	if (!strip_suffix(s, old, &n))
> 		return NULL;
> 	return xstrfmt("%.*s%s", (int)n, s, new);
>   }
> 
> and do:
> 
>   tmp_idx = replace_suffix(preq->tmpfile, ".pack.temp", ".idx.temp");
>   if (!tmp_idx)
> 	die("BUG: pack tmpfile does not end in .pack.temp?");
> 
> but then we are not really saving much. And it is not clear whether
> that is even a sane output for replace_suffix. I can easily imagine
> three behaviors when we do not end in the original suffix:
> 
>   - return NULL to signal error
> 
>   - return the original with no replacement
> 
>   - return the original with "new" appended
> 
> So I'm not sure it makes a good reusable function beyond these three
> call-sites.

Indeed. I had a "gently" version in mind to satisfy callers not
interested in dying, but it's so little code that it likely isn't
worth it.
