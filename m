From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] git clone: is an URL local or ssh
Date: Mon, 28 Oct 2013 13:57:13 -0700
Message-ID: <xmqqmwltdsgm.fsf@gitster.dls.corp.google.com>
References: <201310282116.21551.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	pclouds@gmail.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 28 21:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VatsQ-0007iS-Mr
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 21:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3J1U5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 16:57:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab3J1U5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 16:57:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8DF74E672;
	Mon, 28 Oct 2013 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dEb5QQpqhb15
	WRRDR4ai8+C0uAs=; b=FifUQhu88XItgzPYJpj7JB4G9r6d09U5dqnWslyXyFIZ
	j1VDLXTtS5UIZkrxqRCKBEsGOpncUWn1lAM691H1nuM6x12eGF7JaA9lhZHJrs2d
	o+WCi+qIMRwgjR20gIaYhGynNYdGG/RdzyL9QUMn3UmrHvUZIIm+PV0mm+pvc2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q5BX6m
	mC4orBVTDyuP1QcY512YXIW8Xo2rbvPyJckteaMabLR6yOgTUc781wOd9VZ+WLZi
	LmhIDPIjYwSPVVkuADS4ZPV5iXegrYzGs9Q5wkj4vOnPjpBeFcPL5cvE5wlLo8lF
	qAXBVnmC2JLQVJHnhcCudqPRzADr+oz9TlUYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 992404E671;
	Mon, 28 Oct 2013 20:57:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAD424E66E;
	Mon, 28 Oct 2013 20:57:14 +0000 (UTC)
In-Reply-To: <201310282116.21551.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Mon, 28 Oct 2013 21:16:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 861ABE04-4013-11E3-84FE-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236858>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> (This does apply on pu, not on master.

Hmph.  At least for me, it applies down to cabb411f (Merge branch
'nd/clone-local-with-colon', 2013-10-14) just fine.  Puzzled.

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 1d1c875..a126f08 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -294,39 +294,95 @@ test_expect_success 'setup ssh wrapper' '
>  	export TRASH_DIRECTORY
>  '
> =20
> -clear_ssh () {
> -	>"$TRASH_DIRECTORY/ssh-output"
> -}
> -
> -expect_ssh () {
> +i5601=3D0
> +# $1 url
> +# $2 none|host
> +# $3 path
> +test_clone_url () {
> +	i5601=3D$(($i5601 + 1))
> +	>"$TRASH_DIRECTORY/ssh-output" &&
> +	test_might_fail git clone "$1" tmp$i5601 &&
>  	{
> -		case "$1" in
> +		case "$2" in
>  		none)
>  			;;
>  		*)
> -			echo "ssh: $1 git-upload-pack '$2'"
> +			echo "ssh: $2 git-upload-pack '$3'"
>  		esac
>  	} >"$TRASH_DIRECTORY/ssh-expect" &&

This looks like a strange use of {} (not an issue this patch
introduced, though).  Shouldn't this suffice?

	case ... in
        ...
        esac >"$TRASH_DIRECTORY/ssh-expect"

> +	(
> +		cd "$TRASH_DIRECTORY" &&
> +		test_cmp ssh-expect ssh-output &&
> +		rm -rf ssh-expect ssh-output

Drop "r", please, when you know these are supposed to be files.

> +	)
>  }
> =20
> +# url looks ssh like, and is on disc: should be local
>  test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' =
'
>  	cp -R src "foo:bar" &&
> +	test_clone_url "foo:bar" none &&
> +	( cd tmp$i5601 && git log)

Hmph.  What is this "git log" about?  Leftover from an earlier
debugging session?

The code change to connect.c part seemed to be OK from a cursory
look.

Thanks.
