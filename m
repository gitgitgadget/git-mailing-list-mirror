From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Mon, 29 Jul 2013 10:20:41 -0700
Message-ID: <7vmwp5z3iu.fsf@alter.siamese.dyndns.org>
References: <201307270321.32398.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3r7p-0005dN-VI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab3G2RUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 13:20:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab3G2RUp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 13:20:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D911834568;
	Mon, 29 Jul 2013 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dnDdQsYeIN07
	KaurcBo8lE6WsoA=; b=Poiok01ctqZ1rO3ifR8MCQYkDjclzRPiRJAJ638kHlsA
	csG/FUlXI0CncaU7ZTXlfH37Zy54TfrXzRrzwA2VUFbJPnPM4cs9kvks7cPooL6O
	zhd8bk7cLwFyMsZWGRPXyI5uhpjhfbP2SxbTTjxM/UjEwfHJPjomHtsBAbqXjew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EFNRCQ
	WTfzTDsj6hEXmLQYLXYyKa0V7Vwt94s9tHt4kqy9u/759/3VYNIna/ujRrir0Cl7
	ZMz9yrarAgbrDWwBMdwpx9ujt+Jp7R6j/ai5k39MY31C6Fk4fEuIl/9lpD+R+N/H
	pwBfI4Gf8TjUtisH2uywlvUvgdIGblWtv8OsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD66C34564;
	Mon, 29 Jul 2013 17:20:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E76634561;
	Mon, 29 Jul 2013 17:20:43 +0000 (UTC)
In-Reply-To: <201307270321.32398.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sat, 27 Jul 2013 03:21:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32EE8EB4-F873-11E2-AC10-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231302>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> When core.precomposeunicode was introduced, it was set to false
> by default, to be compatible with older versions of Git.
>
> Whenever UTF-8 file names are used in a mixed environment,
> the Mac OS users need to find out that this configuration exist
> and set it to true manually.
>
> There is no measurable performance impact between false and true.

The real reason we default it to auto-sensing in the current code is
for correctness, I think. the new precompose code could be buggy,
and by auto-sensing, we hoped that we would enable it only on
filesystems that the codepath matters.

> A smoother workflow can be achieved for new Git users,
> so change the default to true:
>
> - Remove the auto-sensing

Why?

> - Rename the internal variable into precompose_unicode,
>   and set it to 1 meaning true.

Why the rename?

> - Adjust and clean up test cases
>
> The configuration core.precomposeunicode is still supported.

Sorry, but I do not quite understand the change.  Is this because
the auto-sensing is not working, or after auto-sensing we do a wrong
thing?  If that is the case, perhaps that is what we should fix?

> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 7980abd..5396b91 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -36,30 +36,6 @@ static size_t has_non_ascii(const char *s, size_t =
maxlen, size_t *strlen_c)
>  }
> =20
> =20
> -void probe_utf8_pathname_composition(char *path, int len)
> -{
> -	static const char *auml_nfc =3D "\xc3\xa4";
> -	static const char *auml_nfd =3D "\x61\xcc\x88";
> -	int output_fd;
> -	if (precomposed_unicode !=3D -1)
> -		return; /* We found it defined in the global config, respect it */
> -	strcpy(path + len, auml_nfc);
> -	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);

So we try to create a path under one name, and ...

> -	if (output_fd >=3D 0) {
> -		close(output_fd);
> -		strcpy(path + len, auml_nfd);
> -		/* Indicate to the user, that we can configure it to true */
> -		if (!access(path, R_OK))
> -			git_config_set("core.precomposeunicode", "false");

=2E.. see if that path can be seen under its alias.  Why do we set it
to "false"?  Isn't this the true culprit?

After all, this is not in the "reinit" codepath, so we know we are
dealing with a repository that was created afresh.
