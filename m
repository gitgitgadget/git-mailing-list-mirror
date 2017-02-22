Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCA3201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933121AbdBVR3u (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:29:50 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:53048 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933023AbdBVR3r (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 12:29:47 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 1A006348070;
        Wed, 22 Feb 2017 09:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:in-reply-to:references
        :content-type:date:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=ZabhrT3rXHrUIq1kDWOY1eoOh/Y=; b=UwEvE02xBG
        wloQnxc5g2lGCIpqI6mbidLyf7tfg5Lg7pTSkvEiOpPhSrxTL+/PtLiFIDPFHGV6
        tL90B55lfpX8ZcGBqs6bXYZqMCFlEAkY5YbXX2Rm0UQXE+qDykq4Y9JsGjluVJ7C
        Io+D7O1eIMwAREHKlZGjiB8pSMZJAKjXU=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 7D2FE34806F;
        Wed, 22 Feb 2017 09:29:46 -0800 (PST)
Message-ID: <1487784377.3016.14.camel@mattmccutchen.net>
Subject: Re: [PATCH 1/3] fetch-pack: move code to report unmatched refs to
 a function
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
References: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
         <b9b52233e84a7f5bd0526f9625e4be06cbbd0ace.1487779910.git.matt@mattmccutchen.net>
         <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 22 Feb 2017 12:26:17 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-02-22 at 09:11 -0800, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>=20
> > We're preparing to reuse this code in transport.c for "git fetch".
> >=20
> > While I'm here, internationalize the existing error message.
> > ---
>=20
> Sounds good.=C2=A0=C2=A0Please just say it is OK for me to forge your s=
ign-off
> ;-)

Oops.  Given the other issue below, I'll just regenerate the patch
series.

> > diff --git a/fetch-pack.h b/fetch-pack.h
> > index c912e3d..fd4d80e 100644
> > --- a/fetch-pack.h
> > +++ b/fetch-pack.h
> > @@ -45,4 +45,13 @@ struct ref *fetch_pack(struct fetch_pack_args
> > *args,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sha1_array *=
shallow,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char **pack_lockfil=
e);
> > =C2=A0
> > +/*
> > + * Print an appropriate error message for each sought ref that
> > wasn't
> > + * matched.=C2=A0=C2=A0Return 0 if all sought refs were matched, oth=
erwise
> > 1.
> > + *
> > + * The type of "sought" should be "const struct ref *const *" but
> > for
> > + * http://stackoverflow.com/questions/5055655/double-pointer-const
> > -correctness-warnings-in-c .
> > + */
>=20
> This is an unfinished sentence, but I wonder if we even need to have
> it here?=C2=A0=C2=A0I'd be surprised if this function was unique in the
> codebase that takes an array pointer whose type is looser than
> necessary because of well-known language rules.

You're probably right.  I'm in the habit of documenting things that
were unknown to me, but I'll take your word for what's well-known to
the average git developer.  I'll remove the remark.

Matt
