From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner cases
Date: Tue, 03 May 2016 09:07:41 -0700
Message-ID: <xmqqzis7nn02.fsf@gitster.mtv.corp.google.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462265452-32360-1-git-send-email-mh@glandium.org>
	<1462265452-32360-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 03 18:08:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcrd-0007HM-Au
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933790AbcECQHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:07:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932884AbcECQHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:07:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15FDD172A7;
	Tue,  3 May 2016 12:07:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WPtIhBIiex9yAQD3ycc5AWKuXGY=; b=r7LUxO
	C5P4toiXUCNSda07CloVm0oKITn2/+XcilfhSFj0cEXTl92rgwhv1dxDkgK4D+Yp
	9NuXGtsrB9/XBlm/pwX/KXqzGYj0Ip5qKrU+0XEu8HALMdpRpOFbLXra2t9p28Dm
	7YG+/C+bDyARUQJUcnF69U2QP38KO7383R0O0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q/SKkzKHfvpLslR2QosYIcfY4k5JUT/X
	I2ExiO2rfTiT/uXFM5XsMwcLfNF9C9nz1HpbtgOr1QYudV+xhsc/Oj5supk6d0Be
	/baayw3Go7Rwf4dYR+nmpdtZ1h9X5JSUVomKFwwcADzhCOMb632Q5Qj/dD+3U6iO
	rE5YnsarHvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E5BB172A6;
	Tue,  3 May 2016 12:07:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66865172A5;
	Tue,  3 May 2016 12:07:43 -0400 (EDT)
In-Reply-To: <1462265452-32360-2-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Tue, 3 May 2016 17:50:42 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2B132924-1149-11E6-87D4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293408>

Mike Hommey <mh@glandium.org> writes:

> t5603-clone-dirname uses url patterns that are not tested with
> fetch-pack --diag-url, and it would be useful if they were.
>
> Interestingly, some of those tests, involving both a port and a
> user:password pair, don't currently pass. Note that even if a
> user:password pair is actually not supported by git, the values used
> could be valid user names (user names can actually contain colons
> and at signs), and are still worth testing the url parser for.

I am not sure about the last part of this (and the tests in the
patch for them).  When you are constrained by the Common Internet
Scheme Syntax, i.e.

    <scheme>://<user>:<password>@<host>:<port>/<url-path>

you cannot have arbitrary characters in these parts; within the user
and password field, any ":", "@", or "/" must be encoded.

Which maens that for the purpose of the parser you are modifying,
you can rely on these three special characters to parse things out
(decoding after the code determines which part is user and which
part is password is a separate issue).

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> Note I'm not /entirely/ sure about colons in user names, but ssh happily
> sends requests to authenticate with logins containing colons. I however
> *do* know it works with at signs (hg.mozilla.org ssh accounts are email
> addresses).
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index e5f83bf..1f0133f 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -569,12 +569,27 @@ check_prot_host_port_path () {
>  	test_cmp expected actual
>  }
>  
> -for r in repo re:po re/po
> +test_maybe_fail () {

That is way too confusing a name when reading the caller of it by
being too close to generic test helpers like test_might_fail,
test_must_fail, etc.

> +	host=$1; shift
> +	case $host in
> +		git=*)

Dedent this line by one level.

> +		test_expect_success "$@"
> +		;;

These two lines are indented correctly.
