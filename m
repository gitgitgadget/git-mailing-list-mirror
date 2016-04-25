From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 07/10] convert: unify the "auto" handling of CRLF
Date: Mon, 25 Apr 2016 12:37:00 -0700
Message-ID: <xmqqtwipjx9f.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461603397-30873-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Apr 25 21:37:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aumJk-0002U2-14
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 21:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933422AbcDYThG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 15:37:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933381AbcDYThE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 15:37:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B2A281610B;
	Mon, 25 Apr 2016 15:37:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JGjEr3sR1CCt
	0s+4Y0Uxqn8slU8=; b=ae3n6VB81aViqzDElFQCWaRQAvbMx++A2m8msr37cNzp
	CHM2Qv4tDyodZWHDpYnHZyn/0DocEALgZo7S+R1MRBlpQO7sTw9Luu+nOXrOj1zh
	7uhkoUHiLUat/piv9wfD6FdbBsqfaua7nKYKbg35e7HkCHLL93a2h9AwO5Fp760=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h+1r+f
	TT5XbC3T0r8LKsYRNBtijcL5YL6qRZMO85WMuVxyVudvu1W0rNSDUWDjy4uBWUmD
	GvrPU7Z6choAtAs61KkIDhYAHiyRlFozJIm6YRULbtTeLAU09JXGSDVg4/2Ts0mT
	ZnWnWG8nz93z+7Ug6/y2uwdTVdjAsUAAaUREw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAFAB1610A;
	Mon, 25 Apr 2016 15:37:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C84516108;
	Mon, 25 Apr 2016 15:37:01 -0400 (EDT)
In-Reply-To: <1461603397-30873-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 25 Apr 2016 18:56:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 154BC772-0B1D-11E6-B9A2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292550>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Before this change,
> $ echo "* text=3Dauto" >.gitattributes
> $ echo "* eol=3Dcrlf" >>.gitattributes
>
> would have the same effect as
> $ echo "* text" >.gitattributes
> $ git config core.eol crlf
>
> Since the 'eol' attribute had higher priority than 'text=3Dauto', thi=
s may
> corrupt binary files and is not what users expect to happen.

Is the last "Since ..." continuation of the above two, i.e. "with
the current code, the first one (unfortunately) means the same as
the second one, BECAUSE ..."?  If so, s/Since/since/ (I needed to
read it twice to guess that is probably what you meant).

The above is a very good justification of the entire series,
illustrating why this is worth doing.

> Make the 'eol' attribute to obey 'text=3Dauto', and now

s/to obey/obey/ (make X do Y, not make X to do Y); I'd probably
further do 's/obey/honor/' or even 's/obey/work better with/'

> $ echo "* text=3Dauto" >.gitattributes
> $ echo "* eol=3Dcrlf" >>.gitattributes
> behaves the same as
> $ echo "* text=3Dauto" >.gitattributes
> $ git config core.eol crlf
>
> In other words,
> $ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
> has the same effect as
> $ git config core.autocrlf true
> and
> $ echo "* text=3Dauto eol=3Dlf" >.gitattributes
> has the same effect as
> $ git config core.autocrlf input

It is kind of disappointing that the none of the above block of
configuration examples does not quite say what the reader really
wants to know directly.  I am guessing that the point is

    now text=3Dauto does autodetection even when eol=3Dcrlf is
    specified, and files that are declared to be non-text will not
    get clobbered with eol=3Dcrlf conversion

right?  If that is the case, replacing everything below "In other
words" with these three lines would make the text much easier to
grok, I would think.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/config.txt        | 14 +++++++-------
>  Documentation/gitattributes.txt | 15 +++++++++------
>  convert.c                       | 42 +++++++++++++++++++++----------=
----------
>  convert.h                       |  3 ++-
>  t/t0025-crlf-auto.sh            |  4 ++--
>  t/t0027-auto-crlf.sh            | 32 +++++++++++++++----------------
>  t/t6038-merge-text-auto.sh      | 23 ++++++++++++++--------
>  7 files changed, 73 insertions(+), 60 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4a27ad4..9caf6ae 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -389,13 +389,13 @@ file with mixed line endings would be reported =
by the `core.safecrlf`
>  mechanism.
> =20
>  core.autocrlf::
> -	Setting this variable to "true" is almost the same as setting
> -	the `text` attribute to "auto" on all files except that text
> -	files are not guaranteed to be normalized: files that contain
> -	`CRLF` in the repository will not be touched.  Use this
> -	setting if you want to have `CRLF` line endings in your
> -	working directory even though the repository does not have
> -	normalized line endings.  This variable can be set to 'input',
> +	Setting this variable to "true" is the same as setting
> +	the `text` attribute to "auto" on all files and core.eol to "crlf".
> +	Set to true if you want to have `CRLF` line endings in your
> +	working directory and the repository has LF line endings.
> +	Text files are guaranteed not to be normalized: files that contain
> +	`CRLF` in the repository will not be touched.

This is not a new problem but the last sentence and a half look
bad.  Telling readers "X is not guaranteed to happen" is not all
that useful--telling them what happens is.  Also the use of colon
there is probably ungrammatical.

	Set to true if you want to have CRLF line endings in your
	working directory and LF line endings in the repository.
	Text files that contain CRLF in the repository will not get
	their end-of-line converted.

perhaps?

> diff --git a/convert.h b/convert.h
> index ccf436b..81b6cdf 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -7,7 +7,8 @@
>  enum safe_crlf {
>  	SAFE_CRLF_FALSE =3D 0,
>  	SAFE_CRLF_FAIL =3D 1,
> -	SAFE_CRLF_WARN =3D 2
> +	SAFE_CRLF_WARN =3D 2,
> +	SAFE_CRLF_RENORMALIZE =3D 4

Are these bits in a word?  If not where did 3 go?

> diff --git a/convert.c b/convert.c
> index 24ab095..3782172 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -227,7 +227,9 @@ static enum eol output_eol(enum crlf_action crlf_=
action)
>  		return EOL_LF;
>  	case CRLF_UNDEFINED:
>  	case CRLF_AUTO_CRLF:
> +		return EOL_CRLF;

Hmph, do we want UNDEFINED case to return EOL_CRLF here?

>  	case CRLF_AUTO_INPUT:
> +		return EOL_LF;
>  	case CRLF_TEXT:
>  	case CRLF_AUTO:
>  		/* fall through */
