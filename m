Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C5B1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 23:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbdFIXhD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 19:37:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33008 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdFIXhD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 19:37:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 293D81F8CF;
        Fri,  9 Jun 2017 23:37:02 +0000 (UTC)
Date:   Fri, 9 Jun 2017 23:37:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around
 free(ptr); ptr = NULL
Message-ID: <20170609233701.GA7195@whir>
References: <20170609085346.19974-1-avarab@gmail.com>
 <20170609220420.4910-2-avarab@gmail.com>
 <20170609222738.GF21733@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170609222738.GF21733@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
> 
> Ævar Arnfjörð Bjarmason wrote:
> 
> > Add a FREEZ() wrapper marco for the common pattern of freeing a
> > pointer and assigning NULL to it right afterwards.
> 
> I'm conflicted.  On one hand it makes code more concise and makes it
> easier for people to remember to assign NULL after freeing a variable.
> On the other hand it makes git more of a custom dialect of C, which
> may make the code harder to read and hack on for new contributors.

I think this problem could be avoided by using a more explicit
name, perhaps: "free_and_null"

Seeing the initial subject, I thought this series was short for
"freeze" (like "creat").

However, I admit FREEZ caught my eye because I thought it was
a way to freeze a repository, somehow :)

> My feeling is that the costs outweigh the benefits, but I haven't
> thought it through thoroughly.

<snip>

> > index 4b7dcf21ad..ba2d0c8c80 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -805,6 +805,12 @@ extern int xmkstemp_mode(char *template, int mode);
> >  extern char *xgetcwd(void);
> >  extern FILE *fopen_for_writing(const char *path);
> > 
> > +/*
> > + * FREEZ(ptr) is like free(ptr) followed by ptr = NULL. Note that ptr
> > + * is used twice, so don't pass e.g. ptr++.
> > + */
> > +#define FREEZ(p) do { free(p); (p) = NULL; } while (0)
> > +
> >  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
> >  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
> 
> Golfing: it's possible to do this without ptr being used twice by
> introducing a helper function:
> 
> 	static inline void freez_impl(void **p) {
> 		free(*p);
> 		*p = NULL;
> 	}

Yes.  I think it's prudent to avoid macros in case there are
side effects.

> 	#define FREEZ(p) freez_impl(&(p))
> 
> That way side-effectful callers like FREEZ(func() ? a : b) would
> work.

I don't see the point of a macro wrapper, forcing the user to
type out the '&' should drive home the point that the pointer
gets set to NULL.  I also find capitalization tiring-to-read
because all characters are the same height.

<snip>

> I kind of wish that 'free' returned NULL so that callers could do
> 
> 	p = free(p);
> 
> without requiring a custom helper.  We could introduce a free_wrapper
> that works that way but that is probably not worth it, either.

Sometimes I have wished similar things, too, but that means the
same identifier shows up twice in one line and camouflages the
code.
