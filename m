Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4BB1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfH0Sxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:53:36 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:45703 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Sxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:53:36 -0400
Date:   Tue, 27 Aug 2019 18:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566932013; bh=/GrRlGepAMr70z/RVgGnCaX9CsjaaP4sq+oo9P3v85w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=DkcmJSRx6vNCo7IHYXmwnW1vZgzdGZKZPe3VTdxAKau91aP2WR+yf4lc7JvI/nanQ
         J8WRvLS2svNZJGdt5jIRuPULVjGek4R9vYTG2H7Huzf9OkVuGQgCFsDZha4kFbb346
         GaA5mLunl0ZjkfrKTNEAdNnJvstH4MkBUPUhM1S+ncUsffuEOh4D0e6yrFYSMxDv7z
         ZpnVaYsabIGrsKr9soJrnPoFqbxz2QVPFJu2w7j/FR/oMFR+sqDqugA72C575oYKN9
         QRl2apP/LJKQARqu0ezjuM5rs9p7vKVBRawbWgYAhtcoIf/ZtEndSI0pyfEKXXqi+e
         4FvZkQLiiyATA==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: Re: [PATCH 2/5] Signing API: Added new signing interface API
Message-ID: <MrYfVyRUfRfQtkZBwukJOtmKlPvA5pAc_UWEry7t3-Ngm-YYo49XgquXQ3EgjMLPJkoN5eaHsSWJxg0jl0Gh7TpxfZh4HGfv_EjZ0EGSROI=@pm.me>
In-Reply-To: <20190826230429.GB11334@genre.crustytoothpaste.net>
References: <CkxnpIEi2c1o1FmI2ZJP8CJQybGMZFbL6uQAd3w7ApKdaki4vcCrlgbTWmPMrrfIedBSvLV56q6txzvCo7bnO1wHlS6cB3bUYpYfNW80w_s=@pm.me>
 <20190826230429.GB11334@genre.crustytoothpaste.net>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thx for your feedback. I will incorporate the detailed explanation and re-s=
ubmit the patches.


Ibrahim El Rhezzali

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, August 26, 2019 11:04 PM, brian m. carlson <sandals@crustytoothp=
aste.net> wrote:

> On 2019-08-26 at 19:58:00, Ibrahim El wrote:
>
> > From: Ibrahim El Rhezzali ibrahim.el@pm.me
> > 7e3e6c9e4 Added new signing interface API
> > Adding files for the new signing interface and also support drivers for=
 the two existing GPG and GPGSM X.509 tools
>
> I'd like to see an explanation here why a new signing interface is
> necessary and we need to make a wholesale replacement of the existing
> one instead of making incremental changes.
>
> > diff --git a/signing-interface.c b/signing-interface.c
> > new file mode 100644
> > index 000000000..c744ef499
> > --- /dev/null
> > +++ b/signing-interface.c
> > @@ -0,0 +1,487 @@
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +#include "cache.h"
> > +#include "config.h"
> > +#include "run-command.h"
> > +#include "strbuf.h"
> > +#include "signing-interface.h"
> > +#include "signing-tool.h"
> > +#include "sigchain.h"
> > +#include "tempfile.h"
> > +
> > +extern const struct signing_tool openpgp_tool;
> > +extern const struct signing_tool x509_tool;
> > +
> > +static const struct signing_tool *signing_tools[SIGNATURE_TYPE_COUNT] =
=3D {
> >
> > -   &openpgp_tool,
> > -   &x509_tool,
> >     +};
> >
>
> It looks like we've hard-coded only two tools here. I was under the
> impression this series was supposed to make signing pluggable with any
> tool, but that doesn't seem to be the case.
>
> > +size_t parse_signatures(const char *payload, size_t size,
> >
> > -       struct signatures *sigs)
> >
> >
> >
> > +{
> >
> > -   enum signature_type st;
> > -   size_t first;
> > -   size_t begin =3D 0;
> > -   const struct signing_tool *tool;
> > -   struct signature *psig =3D NULL;
> > -
> > -   first =3D size;
> > -   for (st =3D SIGNATURE_TYPE_FIRST; st < SIGNATURE_TYPE_LAST; st++) {
> > -       tool =3D signing_tools[st];
> >
> >
> > -
> > -       if (!tool || !tool->parse)
> >
> >
> > -       =09BUG("signing tool %s undefined", signature_type_name(st));
> >
> >
>
> If this is supposed to make parsing generic, won't we have to add
> support for each individual tool in the codebase so tool->parse is
> defined? Having to do that would defeat the point of having a pluggable
> interface set up in the configuration.
>
> > -   buf =3D xstrdup(var);
> > -   t1 =3D strtok(buf, ".");
> > -   t2 =3D strtok(NULL, ".");
> > -   t3 =3D strtok(NULL, ".");
>
> I don't think we make a lot of use of strtok. Perhaps you'd like to use
> parse_config_key or another function in config.c?
>
> -------------------------------------------------------------------------=
---------------------------------------------------
>
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


