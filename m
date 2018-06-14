Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE431F403
	for <e@80x24.org>; Thu, 14 Jun 2018 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964865AbeFNPP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 11:15:27 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:32424 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeFNPP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 11:15:26 -0400
Received: from [88.130.56.254] (helo=book.hvoigt.net)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fTTy6-0003gS-Va; Thu, 14 Jun 2018 17:15:23 +0200
Date:   Thu, 14 Jun 2018 17:15:21 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: BUG: submodule code prints '(null)'
Message-ID: <20180614151521.GA2436@book.hvoigt.net>
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
 <20180609110414.GA5273@duynguyen.home>
 <CAGZ79kZk=OGPJdsDEHtgmPUrO7P2rOLSV40aJawdLs5e0=Kduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZk=OGPJdsDEHtgmPUrO7P2rOLSV40aJawdLs5e0=Kduw@mail.gmail.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 03:56:16PM -0700, Stefan Beller wrote:
> On Sat, Jun 9, 2018 at 4:04 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Tue, Jun 05, 2018 at 05:31:41PM +0200, Duy Nguyen wrote:
> > > I do not know how to reproduce this (and didn't bother to look deeply
> > > into it after I found it was not a trivial fix) but one of my "git
> > > fetch" showed
> > >
> > > warning: Submodule in commit be2db96a6c506464525f588da59cade0cedddb5e
> > > at path: '(null)' collides with a submodule named the same. Skipping
> > > it.
> >
> > The problem is default_name_or_path() can return NULL when a submodule
> > is not populated. The fix could simply be printing path instead of
> > name (because we are talking about path in the commit message), like
> > below.
> >
> > But I don't really understand c68f837576 (implement fetching of moved
> > submodules - 2017-10-16), the commit that made this change, and not
> > sure if we should be reporting name here or path. Heiko?
> >
> > diff --git a/submodule.c b/submodule.c
> > index 939d6870ec..61c2177755 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -745,7 +745,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
> 
> [Not in the context of this patch, but in the code right before the
> context starts:]
> 
>             name = default_name_or_path(p->two->path);
>             /* make sure name does not collide with existing one */
>             submodule = submodule_from_name(the_repository, commit_oid, name);
>             if (submodule) {
> 
> Currently I see 4 callers of default_name_or_path and the other 3 except this
> one have checks against NULL in place, which is good.
> However I think we have to guard this even more, and have to check
> for !name before we call submodule_from_name.
> 
> It is technically ok to call submodule_from_name with a NULL name,
> but it is semantically broken, see the comment in config_from that
> is called from submodule_from_name:
> 
>     /*
>      * If any parameter except the cache is a NULL pointer just
>      * return the first submodule. Can be used to check whether
>      * there are any submodules parsed.
>      */
>     if (!treeish_name || !key) {
>         ...
> 
> 
> >                                 warning("Submodule in commit %s at path: "
> >                                         "'%s' collides with a submodule named "
> >                                         "the same. Skipping it.",
> > -                                       oid_to_hex(commit_oid), name);
> > +                                       oid_to_hex(commit_oid), p->two->path);
> 
> This is correct for the error message, both in terms of not crashing as well
> as correctness, we really need to report a *path* here and no the name_or_path,
> which  default_name_or_path gives.

Sorry for the late reply. I agree with Stefan, this change is correct,
since we are talking about the path in the warning message anyway. It
seems to me that this resulted from the name being the same as the path
in this location here.

I think we should report both here, if we can, the path and the name.

We are skipping the submodule if we can not get a name later:

                if (!name)     
                        continue;

I also agree, that it does not make sense to call submodule_from_name
with a NULL name. I think we should simply skip calling it in case the
name is NULL and then let the code later handle it.

E.g.: 

...
                        /* make sure name does not collide with existing one */
		        if (name)	
                            submodule = submodule_from_name(the_repository, commit_oid, name);
                        if (submodule) {
                                warning("Submodule in commit %s at path: "
...

Would you want to update your patch? Or should I put one on top?

Cheers Heiko
