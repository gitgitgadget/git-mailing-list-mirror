Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE31B272
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="EMELTtue"
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1083A5D9
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail2; t=1699612604; x=1699871804;
	bh=TeOrd9q9Ebz1xdFTvN248uotDc8XDPeQGOZYSdZcWk4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EMELTtueyVOZm9C/l5Ja7lGQFjwz0UCeGQZoxbRjTKHQMa3i/djPcGGHbNX8CJPh6
	 w0vayvZnTvZtTBC58WZeylV++zCHSQ+OWjQ9fuDBD5dNGLSNoLQW802xLoxs8VV/2d
	 ST9fBJeuKzjTR/oVFkge7goFOHIetnX0qTfTTfEXkhlXNuGQ/a+S2ghJPULet9KD1t
	 QW4jpowsHGwEB71SErWTSGJlChWn/GUNIGACIVN5/V7s0Kvcr9njFK1IWL+pPwH6n9
	 S1yxca7OWb9dPcJZ0j1A/l/pTjezwC9jCFMqMdsG7S/oXgvQ+K9DJFvQrxOFSYW1d2
	 0LFhc5v0ijhlA==
Date: Fri, 10 Nov 2023 10:36:22 +0000
To: Jeff King <peff@peff.net>
From: Simon Ser <contact@emersion.fr>
Cc: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: fix ignored encode_email_headers for cover letter
Message-ID: <VTz8XT3MCqWUh1HFQon62NxmGJiYFfNmBeWTtR8MwmeuaSkovfBJ02P-S79GsD94XwlxlrL6W80YZ8OwfpDd1BqA0E4GwFQlDKN5DWq0Qtg=@emersion.fr>
In-Reply-To: <20231109183506.GB2711684@coredump.intra.peff.net>
References: <20231109111950.387219-1-contact@emersion.fr> <20231109183506.GB2711684@coredump.intra.peff.net>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 9th, 2023 at 19:35, Jeff King <peff@peff.net> wrote:

> That makes sense, and your patch looks the right thing to do as an
> immediate fix. But I have to wonder:
>=20
>   1. Are there other bits that need to be copied? Grepping for other
>      code that does the same thing, I see that show_log() and
>      cmd_format_patch() copy a lot more. (For that matter, why doesn't
>      make_cover_letter() just use the context set up by
>      cmd_format_patch()?).
>=20
>   2. Why are we copying this stuff at all? When we introduced the
>      pretty-print context back in 6bf139440c (clean up calling
>      conventions for pretty.c functions, 2011-05-26), the idea was just
>      to keep all of the format options together. But later, 6d167fd7cc
>      (pretty: use fmt_output_email_subject(), 2017-03-01) added a
>      pointer to the rev_info directly. So could/should we just be using
>      pp->rev->encode_email_headers here?
>=20
>      Or if that field is not always set (or we want to override some
>      elements), should there be a single helper function to initialize
>      the pretty_print_context from a rev_info, that could be shared
>      between spots like show_log() and make_cover_letter()?
>=20
> I don't think that answering those questions needs to hold up your
> patch. We can take it as a quick fix for a real bug, and then anybody
> interested can dig further as a separate topic on top.

These are good questions indeed. Unfortunately I don't hink I'll have time =
to
work on this though.

> > +test_expect_success 'cover letter with --cover-from-description subjec=
t (UTF-8 subject line)' '
> > +=09test_config branch.rebuild-1.description "Caf=C3=A9?
> > +
> > +body" &&
> > +=09git checkout rebuild-1 &&
> > +=09git format-patch --stdout --cover-letter --cover-from-description s=
ubject --encode-email-headers main >actual &&
> > +=09grep "^Subject: \[PATCH 0/2\] =3D?UTF-8?q?Caf=3DC3=3DA9=3D3F?=3D$" =
actual &&
> > +=09! grep "Caf=C3=A9" actual
> > +'
>=20
> The test looks correct to me.
>=20
> Some of these long lines (and the in-string newlines!) make this ugly
> and hard to read. But it is also just copying the already-ugly style of
> nearby tests. So I'm OK with that. But a prettier version might be:
>=20
>   test_expect_success 'cover letter respects --encode-email-headers' '
>         test_config branch.rebuild-1.description "Caf=C3=A9?" &&
>         git checkout rebuild-1 &&
>         git format-patch --stdout --encode-email-headers \
>                 --cover-letter --cover-from-description=3Dsubject \
>                 main >actual &&
>         ...
>   '

Yeah, that sounds better indeed. Let me know if you want me to resend a cle=
aner
version of the test.

> I also wondered if we could be just be testing this much more easily
> with another header like "--to". But I guess that would be found in both
> the cover letter and the actual patches (we also don't seem to encode
> it even in the regular patches; is that a bug?).

That sounds like another bug indeed=E2=80=A6 But maybe that'll be harder to=
 fix. To
Q-encode this field one needs to split off the full name and actual mail
address ("Andr=C3=A9 <andre@example.org>" would be split into "Andr=C3=
=A9" and
"andre@example.org"), then Q-encode the full name, then join the strings
together again. In particular, it's incorrect to Q-encode the full string.
