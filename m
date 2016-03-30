From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/16] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Wed, 30 Mar 2016 15:17:54 -0700
Message-ID: <xmqqtwjnr4od.fsf@gitster.mtv.corp.google.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	<1459330800-12525-10-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:18:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alOR8-0005vF-45
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 00:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbcC3WR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 18:17:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752693AbcC3WR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 18:17:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB1E95187B;
	Wed, 30 Mar 2016 18:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FX1AfWJuM4ddzohxyrlBRV5yua0=; b=sOWvJN
	l7uZuX5lxnCqdUGBIE/Lfs5/wqsIDmEk/y6Qmj3yUOD1lNVHFAU95Jxg3h2agbAV
	nbPMjGXKnAMKWAWOdcc9EKsQgQWcHh6fyaV4FE3kvnylv1P8+mbr20GUbJSwIIRP
	P7vCwxHndUgHA/U4fQUxYLOTJWYuFz9mHFTOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUZlB11EQLyzs7AwqMiwc2ScCN6zYcql
	R8I058DsMaT6+8Sjj2tyX1R1bAqa1jCG+sNhPW5BxTguB6T708czOQL7BwOFIK7D
	14edCEHcricka1hSZBO5nn329JCVR62Dlv82MsMyUK7+QzuIldJ2/DGucbHD/3mo
	siIXoocZE4A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C40445187A;
	Wed, 30 Mar 2016 18:17:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4CF5151879;
	Wed, 30 Mar 2016 18:17:56 -0400 (EDT)
In-Reply-To: <1459330800-12525-10-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 30 Mar 2016 15:09:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40F2137A-F6C5-11E5-8C15-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290353>

Karthik Nayak <karthik.188@gmail.com> writes:

> The "%(symref)" atom doesn't work when used with the ':short' modifier
> because we strictly match only 'symref' for setting the 'need_symref'
> indicator. Fix this by using comparing with valid_atom rather than used_atom.
>
> Add tests for %(symref) and %(symref:short) while we're here.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c            |  2 +-
>  t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 8c97cdb..5c59b17 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>  		valid_atom[i].parser(&used_atom[at], arg);
>  	if (*atom == '*')
>  		need_tagged = 1;
> -	if (!strcmp(used_atom[at].name, "symref"))
> +	if (!strcmp(valid_atom[i].name, "symref"))
>  		need_symref = 1;
>  	return at;
>  }

Makes perfect sense.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2c5f177..b06ea1c 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -38,6 +38,7 @@ test_atom() {
>  	case "$1" in
>  		head) ref=refs/heads/master ;;
>  		 tag) ref=refs/tags/testtag ;;
> +		 sym) ref=refs/heads/sym ;;
>  		   *) ref=$1 ;;
>  	esac

An earlier review may have missed this, but I just noticed that the
body of this case/esac is over-indented.  Something we can fix later
after the dust settles.

>  	printf '%s\n' "$3" >expected
> @@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
>  		refs/tags/bogo refs/tags/master > actual &&
>  	test_cmp expected actual
>  '
> +
> +test_expect_success 'Add symbolic ref for the following tests' '
> +	git symbolic-ref refs/heads/sym refs/heads/master
> +'
> +
> +cat >expected <<EOF
> +refs/heads/master
> +EOF
> +
> +test_expect_success 'Verify usage of %(symref) atom' '
> +	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
> +	test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +heads/master
> +EOF
> +
> +test_expect_success 'Verify usage of %(symref:short) atom' '
> +	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
