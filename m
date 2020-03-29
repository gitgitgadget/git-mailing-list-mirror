Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C181C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 19:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C53F2073E
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 19:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=sourcephile.fr header.i=@sourcephile.fr header.b="wVd84/Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgC2TOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:14:04 -0400
Received: from revolt129.abo.ilico.org ([80.67.180.129]:41634 "EHLO
        mermet.sourcephile.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgC2TOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 15:14:03 -0400
Date:   Sun, 29 Mar 2020 21:14:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sourcephile.fr;
        s=20200101; t=1585509240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jgtok8FDK9MLNzP+E4IOvT3aewHX9Ck64guFuH7PFTY=;
        b=wVd84/RhBWEtOHxULVZF+pAX4bpVTPcqr34XrNyJ4GfrHuuOVubpsjJKo3lmr8kGahLec9
        bfFH0xFbg94jK1Dp/haGxwKZmJhrR6aICazSizGdJwW9remkzfvxkEwHNCcwiye7qhTlTU
        WCx47eRUfF1KMKvv9O3GXW36tMlcmmj/2j/CNW3UvzchIYWVgmtyIBNwwsKohcSgs8cxxT
        wdMK2/yTe/gvxURox6oNkep2bSRCkTw9IRX/IzX9Xu9ZtYyM9ZD/tya5OdjmxHfuIP2IVW
        g7edcUa1Bad9gbitImFBENAjj7zEv6RIzckj5yLBoSBC9cD4cbp9nant2w70dU4tIZeoPP
        NAAYYEOgPGm7EchY/0ov+ZrAV6JW4pLwCNcSTMSnqOMAVR2bqTxjkIQVK8uHNWkBwPQ4L/
        076qb8lE8zU+kH8K63OJo/66RrWmbed90+ZS+jWIlf8DzroZWWyW84BETVD2IeSQRQsk8I
        zloEuoHNJrn1U+/H842jfeDP4w1ETfAKPa7vAg6eugKK6O3WNYIg3hy4FyKkI29/zP0x1H
        24wvsmFWUqrr7cch2w/ewb1WZMc+IjSoUKi9fxMqfFVACFWDIADmkVkjTZoL4hNhbv2w43
        C774ejoOVVZydeTQADzNrLMFz3HY0K46YTT9ZjMKCH6vPIKy6tvek=
From:   Julien Moutinho <julm+git@sourcephile.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitweb: fix UTF-8 encoding when using CGI::Fast
Message-ID: <20200329191400.eh377knm4fxm66pd@sourcephile.fr>
References: <20200329002028.26080-1-julm+git@sourcephile.fr>
 <xmqqr1xbb0xr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqr1xbb0xr.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le dim. 29 mars 2020 09h06 -0700, Junio C Hamano a =C3=A9crit=C2=A0:
> Julien Moutinho <julm+git@sourcephile.fr> writes:
> >  	require CGI::Fast;
> >  	our $CGI =3D 'CGI::Fast';
> > +	# FCGI is not Unicode aware hence the UTF-8 encoding must be done man=
ually.
> > +	# However no encoding must be done within git_blob_plain() and git_sn=
apshot()
> > +	# which must still output in raw binary mode.
>=20
> I guess this comment would be sufficient to help future developers
> when they find that newer version of CGI::Fast has become Unicode
> aware later can make this part conditional to the version of the
> module, perhaps?
Sure, though as long as CGI::Fast will be relying on FCGI,
I would not bet on any improvement on this bug
which has been waiting to be fixed on FCGI's bugtracker since 2013:
https://rt.cpan.org/Public/Bug/Display.html?id=3D89383

> Would "use CGI::Fast (-utf8)" instead of the whole thing help, by
> the way?
Unfortunately not, the -utf8 option (aka. $CGI::$PARAM_UTF8)
controls the decoding of the input parameters,
not the encoding of the output.
- https://metacpan.org/pod/CGI#-utf8
- https://stackoverflow.com/questions/5005104/how-to-force-fastcgi-to-encod=
e-form-data-as-utf-8-as-cgi-pm-has-option/7097698#7097698

> > our $FCGI_Stream_PRINT_raw =3D \&FCGI::Stream::PRINT;
> [...]
> > +	local *FCGI::Stream::PRINT =3D $FCGI_Stream_PRINT_raw;
I had forgotten to test the patch without FastCGI,
but AFAICS it is innocuous in non-FastCGI mode:
Perl does not chokes on \&FCGI::Stream::PRINT despite it being not reachabl=
e,
and the local binding emits no redefine warning since it's not a redefine
in this case, but a define.

Regards,
