Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38024C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E31661075
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJ2Uwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:52:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:48024 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2Uwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:52:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TKo4ks074273
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 16:50:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <012301d7cd01$90428960$b0c79c20$@nexbridge.com> <xmqqsfwjk1s3.fsf@gitster.g>
In-Reply-To: <xmqqsfwjk1s3.fsf@gitster.g>
Subject: RE: [Bug] wrapper.c uses unportable unsetenv
Date:   Fri, 29 Oct 2021 16:49:58 -0400
Organization: Nexbridge Inc.
Message-ID: <013501d7cd06$8c8281e0$a58785a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJKjg/2nH6CxKxEU8WUbwNfWnFG+wGTjv0AqvhSleA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 4:35 PM, Junio C Hamano:
> <rsbecker@nexbridge.com> writes:
> 
> > The unsetenv()/setenv(overwrite) calls are not 100% portable - as in
> > not on all POSIX implementations. It breaks the build on some of the
> > NonStop platforms. This will change in a year or two but I really
> > don't want to fall behind on git releases.
> >
> > This was introduced at 3540c71 but I was on vacation when it happened
> > so did not catch it during reviews - my apologies for that.
> 
> I do not quite understand.  xsetenv() does use the three-arg setenv(), but
that is
> not anything new.  It merely replaced a call to the same three-arg
setenv() in
> environment.c that have already been there, introduced by d7ac12b2 (Add
> set_git_dir() function, 2007-08-01).
> 
> You may argue that 3540c71 has done a shoddy job by introducing
> xunsetenv() without adding any caller, and to this day, we do not have a
single
> caller to the wrapper, but we already have a few calls to unsetenv() that
is
> compiled unconditionally.
> 
> So if you built any version of Git, you must have had these somehow
"available"
> in your build (e.g. your system headers may have made them a no-op), and
I'd
> expect you'd keep doing the same to locally work it around on the platform
side,
> without ...
> 
> > Is it critical that this be called or can we #ifdef it away if it
> > isn't supported for a build? The #if is exactly this:
> 
> ... doing something like this in the generic part of the code.
> Please don't do this.
> 
> > wrapper.c@150
> > + #if (_TANDEM_ARCH_ > 3 || (_TANDEM_ARCH_ == 3 && __L_Series_RVU >=
> > + 2010))
> > 	if (setenv(name, value, overwrite))
> > 		die_errno(_("could not setenv '%s'"), name ? name :
> > "(null)");
> > + #endif
> >
> > wrapper.c@154
> > + #if (_TANDEM_ARCH_ > 3 || (_TANDEM_ARCH_ == 3 && __L_Series_RVU >=
> > + 2010))
> > 	if (!unsetenv(name))
> > 		die_errno(_("could not unsetenv '%s'"), name ? name :
> > "(null)");
> > + #endif
> 
> 
> There are compat/setenv.c and compat/unsetenv.c to be used when
> NO_SETENV and NO_UNSETENV are defined.  Is that how you built your Git
> earlier since 2007, perhaps?

We have defined NO_SETENV and NO_UNSETENV since I have been maintaining it,
so I don't get how we are getting into this situation. I was planning on
removing NO_SETENV when the OS caught up for that on our minimum support
builds next year. NO_UNSETENV needs to stick around for bit longer. The
setenv() code is actually fine. It is unsetenv() that is causing problems.
Should not git-compat-util.h be included in wrapper.c so that we reference
gitunsetenv?



