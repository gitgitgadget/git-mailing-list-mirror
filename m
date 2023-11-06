Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7229428
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xzwip14f"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178FD73
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:06:27 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D2951CC444;
	Mon,  6 Nov 2023 18:06:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fQN6Vo7fXwS7
	62uE/Zwp52WXxxYw30mf1p4C/W5G2LE=; b=Xzwip14faX0EdssEX9oBYHTZWqSV
	8BEjEFxtLuP+R24VO0y6phiF0Fg9hYU2VUzMbhWlbpJQrHD5u7X65uKh+EEirBUf
	ZUYjM/v28Tsp3OmLz04B2eK9k865IA8xz81uIrF2b/09wYwXS3JFJIs52SROngve
	Kznucavqe9iVLNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 415A41CC442;
	Mon,  6 Nov 2023 18:06:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0CB31CC441;
	Mon,  6 Nov 2023 18:06:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
    Michael Strawbridge <michael.strawbridge@amd.com>
Cc: git@vger.kernel.org,  Douglas Anderson <dianders@chromium.org>,
  entwicklung@pengutronix.de
Subject: Re: Regression: git send-email Message-Id: numbering doesn't start
 at 1 any more
In-Reply-To: <20231106153214.s5abourejkuiwk64@pengutronix.de> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 6 Nov 2023 16:32:14
 +0100")
References: <20231106153214.s5abourejkuiwk64@pengutronix.de>
Date: Tue, 07 Nov 2023 08:06:22 +0900
Message-ID: <xmqqwmuucwi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1B00656E-7CF9-11EE-A0E4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>
> Since commit 3ece9bf0f9e24909b090cf348d89e8920bd4f82f I experience that
> the generated Message-Ids don't start at ....-1-... any more. I have:
>
> $ git send-email w/*
> ...
> Subject: [PATCH 0/5] watchdog: Drop platform_driver_probe() and convert=
 to platform remove callback returning void (part II)
> Date: Mon,  6 Nov 2023 16:10:04 +0100
> Message-ID: <20231106151003.3844134-7-u.kleine-koenig@pengutronix.de>
> ...
>
> So the cover letter is sent with Message-Id: ...-7-...

The above is consistent with the fact that a 5-patch series with a
cover letter consists of 6 messages.  Dry-run uses message numbers
1-6 and forgets to reset the counter, so the next message becomes 7.
As you identified, the fix in 3ece9bf0 (send-email: clear the
$message_id after validation, 2023-05-17) for the fallout from an
even earlier change to process each message twice still had left an
observable side effect subject to the Hyrum's law, it seems.

> +my ($message_id_stamp, $message_id_serial);
>  if ($validate) {
>  	# FIFOs can only be read once, exclude them from validation.
>  	my @real_files =3D ();
> @@ -821,6 +822,7 @@ sub is_format_patch_arg {
>  	}
>  	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
>  	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
> +	$message_id_serial =3D 0;
>  }

This fix looks quite logical to me, but even with this, the side
effects of the earlier "read message twice" persists in end-user
observable form, don't they?  IIRC, when sending out an N message
series, we start from the timestamp as of N seconds ago and give
each message the Date: header that increments by 1 second, which
would mean the validator will see Date: that is different from what
will actually be sent out, and more importantly, the messages sent
out for real will have timestamps from the future, negating the
point of starting from N seconds ago in the first place.  Your
script may not have been paying attention to it and only noticed the
difference in id_serial, but somebody else would complain the
difference coming from calling gen_header more than once for each
messages since a8022c5f (send-email: expose header information to
git-send-email's sendemail-validate hook, 2023-04-19).

So, I dunno.  Michael, what do you think?  It appears to me that a
more fundamental fix to the fallout from a8022c5f might be needed
(e.g., we still let gen_header run while validating, but once
validation is done, save the headers that validator saw and use them
without calling gen_header again when we send the messages out, or
something), if we truly want to be regression free.

By the way, out of curiosity, earlier you said your script looks at
the Message-IDs and counts the number of messages.  How does it do
that?  Does it read the output of send-email and pass the messages
to MTA for sending out for real?

Thanks.

>  @files =3D handle_backup_files(@files);
> @@ -1181,7 +1183,6 @@ sub validate_address_list {
> =20
>  # We'll setup a template for the message id, using the "from" address:
> =20
> -my ($message_id_stamp, $message_id_serial);
>  sub make_message_id {
>  	my $uniq;
>  	if (!defined $message_id_stamp) {
>
> But I guess this could be done prettier by someone who is fluent in
> Perl.
>
> Best regards
> Uwe
