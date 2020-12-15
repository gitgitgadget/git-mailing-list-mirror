Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CEAC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 15:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AAC224F4
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 15:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgLOP4g convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Dec 2020 10:56:36 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17005 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgLOP4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 10:56:31 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BFFte1F001938
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Dec 2020 10:55:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Elijah Newren'" <newren@gmail.com>, <git@vger.kernel.org>
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com> <xmqqeejraiw7.fsf@gitster.c.googlers.com> <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
In-Reply-To: <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
Date:   Tue, 15 Dec 2020 10:55:33 -0500
Message-ID: <001e01d6d2fa$bc1afab0$3450f010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQInSaJaLNehwWvOmRwIC/Ctw4llswKbIC1HATfee0GpOMjO4A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 14, 2020 9:53 PM, Peff wrote:
> On Mon, Dec 14, 2020 at 06:43:36PM -0800, Junio C Hamano wrote:
> 
> > diff --git c/git-compat-util.h w/git-compat-util.h index
> > 7d509c5022..58cd0761be 100644
> > --- c/git-compat-util.h
> > +++ w/git-compat-util.h
> > @@ -273,7 +273,8 @@ struct itimerval {
> >
> >  #ifdef NO_SETITIMER
> >  static inline int setitimer(int which, const struct itimerval *value, struct
> itimerval *newvalue) {
> > -	; /* nothing */
> > +	errno = ENOSYS;
> > +	return -1; /* not implemented */
> >  }
> >  #endif
> >
> > Alternatively we could pretend that the call always succeeds by
> > without touching errno and returning 0.  That might be safer, but I
> > dunno which one we want, and I do not have a system affected by the
> > choice.
> 
> I think this is a sensible choice. Before the conversion to an inline, the code
> was removed entirely! So anybody checking the return value would have
> seen an error, and we do not have to worry much about breaking them.
> 
> For new callers, anybody checking the return value would probably
> appreciate the warning that support for the function is optional (OTOH, they
> would probably not find out themselves, but rather when Randall tells them ;)
> ).
> 
> It would be nice to have a way to warn them even on platforms that have
> setitimer(), but I can't think of an easy way.

Strangely, we do have setitimer() on NonStop. I'm not sure how we get into this situation, unless it's not being detected correctly.

> > > Aside from inlining bodies, this should not have compiled on any
> platform:
> > >
> > > static inline void strset_remove(struct strset *set, const char
> > > *str) {
> > >         return strmap_remove(&set->map, str, 0); }
> > >
> > > What is really intended here?
> >
> > I think we should just drop "return"; a void function should be called
> > in void context without requiring a value, even if that return expects
> > no value.
> 
> Yeah, I think that is right. I checked earlier iterations of the series to see if
> perhaps strmap_remove() had previously returned a value, but it never did in
> any on the list.
> 
> > diff --git i/strmap.h w/strmap.h
> > index c4c104411b..1e152d832d 100644
> > --- i/strmap.h
> > +++ w/strmap.h
> > @@ -165,7 +165,7 @@ static inline int strintmap_contains(struct
> > strintmap *map, const char *str)
> >
> >  static inline void strintmap_remove(struct strintmap *map, const char
> > *str)  {
> > -	return strmap_remove(&map->map, str, 0);
> > +	strmap_remove(&map->map, str, 0);
> >  }
> 
> So yeah, I think that is the right fix. +cc Elijah for any other insight.

FYI: We successfully built 2.29.2 without issues. I'm not sure how this all happened but seems like it was at 1201eb628a.
 
Thanks,
Randall

