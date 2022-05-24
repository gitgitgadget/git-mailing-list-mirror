Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC5DC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiEXLyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiEXLx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:53:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B305E5D1A1
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653393221;
        bh=JpoWVEvckukLAaudBkrg2AknWME0XKwtKEa5ymJ7VPs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SHj1Q0WoPaGN0EAKdn0ILor2LXlRl8W3K9SYxGbbI3SBj9rfMajjS12W12DMWmkY+
         wfgHu7oljVS8MzaTSIdztNjMe17fpuOc7J+0Vq9j/HgkeSWBBGa4m7JSEuNHAAICj/
         0rhqEbRP8T6ic1aBTneU+xwbfJeagNLX1/igvZLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1o54lr0wYM-00G48s; Tue, 24
 May 2022 13:53:41 +0200
Date:   Tue, 24 May 2022 13:53:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 20/28] fsmonitor: optimize processing of directory
 events
In-Reply-To: <c716b1d6-a0a8-6d03-dfe5-70613e4ed942@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2205241353030.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com> <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <48af0813deccab924d3591b4df025b17bf309260.1650662994.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2205121708400.352@tvgsbejvaqbjf.bet>
 <c716b1d6-a0a8-6d03-dfe5-70613e4ed942@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nlH5DdUP2F9xcLq7+tzAcIFOV34yDcDcugwLT+VUAzgChI5IGza
 Y+f52tbiSfWJF9iO/3tQv/iKlAnNLCzhcFKegz0+7bCPF61Qox8YPgP+j81w2oQGXq6X9iC
 ZqYHABIyeoCq12yCqmi2o/n7L2dNgTO/ab07LbcamHRaR8QNEOtc+cqpRUkKYYpNW9t3rRW
 OYidKwxymw9bQgZk4yW0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0/qHnZ/xPQ=:ht4C55bUMXr8tQ0kSvrtn7
 vAFtyMG8jbt1AqJ+BOZt0l1hlUEu9dPSVLyJ1/9IfUjj94yw0vN1AoelhM1qX4AFcldXg8L+k
 zBTqMV1OX6mqDhrzOEHHq9dnHP+IymyKB0NpEfqTXbasHzumpW8vSBP2fg6/ybx9jUJU9fB71
 bKGdDT8KKhR+53Jak7g7eNgJAaGFxfUGqMHs4FMmA/QVZeDmmgpER5o7BKPpFtvGZILvOSkWL
 v3VBjJvb7k1wh1zMGSD6F+ZFrWhiBxZ8JF5Zq1GPhp92t/CMFkrYt7hyGplumi8FJoV5yCqXE
 fC6r1TchYlZs2VgtEcINES5qh9M0RHbtXd89YEjqps2u7x+ec1wYYMjeu8RtT4n5LARuAZArW
 yezuYzX9RxmwPOIiGsciWImMQ+Sn6aXbviiviUFoVBIAR0H9h9Wh9wAtdcHYrktPFUzojt8Ti
 V7yX5ZggGlq0Mk9WR+mEYfGeT0q1qm9sTCQSqGm5WOWF41aRAkkons/LE/7XoldtV10DjHEDh
 YMNuqnUE2XrzeRL3MMetPAgBdOlkiSgIug3BFdNVF6QvI2MbRf5+2om2rH1vr1dVc2cNkB+Ij
 3ZSu6FXI7BOiy43+czca/ds/y0D5VVMPwOKREHL06PcWLGjWkBoSMApUW0ietotyMCTqfSSbe
 jGuCKyJNQIWUCpPpDvdsb08I95owTRTBYcAqleigPSWc7b/yXLIIwfXuyHAaToA8foLlG7WNr
 Mm4e02f+KX0voxpy7yFCCeWASq5MLsPRoXuhUAj5im1Dy5ESoRy4YFjU/pjSp5On/eSv9HCCh
 5LjDnYEQkDcHr5CGVvkTSClDHUxaXQWJ1lCfeEaUukY8fCjNMdVdcBuSxNhJno7e82+4qqxsU
 GcrcVFubw99HOBejvf3uNcyEkn0QxHwHXsKha04FRegLQGJB7ne1xoG7kYegpfoiKSgCI1Idw
 q++v9c+eMvW86eYlOT8j92pl6oGHTNEAVE+BdGnRv+kRdbOGPY39VD1bG0NqdU/643NCvNBAd
 9Jevigrdn+Tb12+PrJNWh5kuqYQpBWS/Xf0me+sQ0cxb78UbXT+boxp6kne7wdOuVtDMCdu0y
 E3Aaly9rSojezW96e49h1g3lKUItCyxsPtittD9Wr4RuTEzGgRpGqUT9w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, 17 May 2022, Jeff Hostetler wrote:

> On 5/12/22 11:08 AM, Johannes Schindelin wrote:
> >
> > On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:
> >
> > > From: Jeff Hostetler <jeffhost@microsoft.com>
> > >
> > > Teach Git to perform binary search over the cache-entries for a dire=
ctory
> > > notification and then linearly scan forward to find the immediate
> > > children.
> > >
> [...]
>
> > >   static void fsmonitor_refresh_callback(struct index_state *istate,=
 char
> > >   *name)
> > >   {
> > >   	int i, len =3D strlen(name);
> > > -	if (name[len - 1] =3D=3D '/') {
> > > +	int pos =3D index_name_pos(istate, name, len);
> > > +
> > > +	trace_printf_key(&trace_fsmonitor,
> > > +			 "fsmonitor_refresh_callback '%s' (pos %d)",
> > > +			 name, pos);
> > >
> [...]
>
> > > +	if (name[len - 1] =3D=3D '/') {
> [...]
> > >    }
>
> > > @@ -215,7 +253,6 @@ static void fsmonitor_refresh_callback(struct
> > > index_state *istate, char *name)
> > >     * Mark the untracked cache dirty even if it wasn't found in the =
index
> > >     * as it could be a new untracked file.
> > >     */
> > > -	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s=
'",
> > > name);
> >
> > Did you mean to remove this statement in this patch? Not a big issue, =
but
> > I wonder what the rationale for it is, and since I have an inquisitive
> > mind, I figured I'd just ask.
>
> I just moved it to the top of the function.  That lets me see `name`
> before it is modified in one of the else arms (it was helpful to see
> whether the daemon sent a trailing slash or not).  And I also wanted
> to see the computed value of `pos` (before the "-pos - 1" tricks).

Oh, I missed that it was moved rather than removed. Sorry for that!

Thank you,
Dscho
