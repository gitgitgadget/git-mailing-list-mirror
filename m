Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AF2C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiBYPgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiBYPgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:36:40 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE921D088
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:36:07 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,136,1643670000"; 
   d="scan'208";a="23256780"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 16:36:05 +0100
Date:   Fri, 25 Feb 2022 16:36:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
In-Reply-To: <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
Message-ID: <alpine.DEB.2.22.394.2202251630510.2577@hadrien>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com> <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com> <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet> <220222.867d9n83ir.gmgdl@evledraar.gmail.com> <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
 <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-858204238-1645803364=:2577"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-858204238-1645803364=:2577
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 25 Feb 2022, Johannes Schindelin wrote:

> Hi Julia,
>
> On Tue, 22 Feb 2022, Julia Lawall wrote:
>
> > [I]f there are some cases that are useful to do statically, with only
> > local information, then using Coccinelle could be useful to get the
> > problem out of the way once and for all.  Coccinelle doesn't support
> > much processing of strings directly, but you can always write some
> > python code to test the contents of a string and to create a new one.
> >
> > Let me know if you want to try this.  You can also check, eg the demo
> > demos/pythontococci.cocci to see how to create code in a python script and
> > then use it in a normal SmPL rule.
> >
> > If some context has to be taken into account and the context in the same
> > function, then that can also be done with Coccinelle, eg
> >
> > A
> > ...
> > B
> >
> > matches the case where after an A there is a B on all execution paths
> > (except perhaps those that end in an error exit) and
> >
> > A
> > ... when exists
> > B
> >
> > matches the case where there is a B sometime after executing A, even if
> > that does not always occur.
> >
> > If the context that you are interested in is in a called function or is in
> > the calling context, then Coccinelle might not be the ideal choice.
> > Coccinelle works on one function at a time, so to do anything
> > interprocedural, you have to do some hacks.
>
> Right. The code in question is not actually calling a function, but a
> macro, and passes a literal string to the macro that we would want to
> check statically.

Coccinelle doesn't care about whether a function is called or whether a
macro is called.  It considers everything to be a function.

>
> I did have my doubts that it would be easy with Coccinelle, but since Ævar
> seemed so confident, I tried it, struggled, and decided to follow up with
> you.

Something like this:

@r1@
expression e;
@@

N(e)

@script:python s@
e << r1.e;
replacement;
@@

if string_ok e
then cocci.include_match(False)
else coccinelle.replacement = "\"better string\""

@@
expression r1.e;
expression s.replacement;
@@
- N(e)
+ N(replacement)

------------------

You can fill in the definition of string_ok and better string.  I think
the \" will be necessary, because the value of an expression metavariable
at the python level is a string, so there should be a string inside of it
to make it a string expression.

julia
--8323329-858204238-1645803364=:2577--
