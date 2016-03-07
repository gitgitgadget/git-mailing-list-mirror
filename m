From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/15] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Mon, 07 Mar 2016 15:08:27 -0800
Message-ID: <xmqqtwkhnaxg.fsf@gitster.mtv.corp.google.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
	<1457265902-7949-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:08:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad4GW-00073P-67
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 00:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbcCGXIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 18:08:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932360AbcCGXIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 18:08:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 841594B115;
	Mon,  7 Mar 2016 18:08:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WrlQRpAHOpHMEOCazwGuR85og8M=; b=Ra9Anp
	No4rCYogQWVvCxC8kHyUiWhEAxhxO0odizXSCunfhnTcJDWe+5CjEs59TTLx3eiN
	kSCvOEMogZNjapTyyKb9Jm2Jlrz/Bi5PeDMR51+xMUZtOza51TNKrlmNf4PdmWhy
	Kulew6Q/Lmk4Assw5L51uYyNeZs/Ak39pw6Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzxSIQakoLkuNbM6arwsg7a0kyzrfjvt
	BaVcnbyEoL543DvT+XGBiB9i0Fsxfu11gc1gERkEO0dftYDNk7ZiFK5FBIrNuMWq
	xSeWEkzC8ichyuptVEo9VXeElR5+DZtt6ZGyyvZzi710MV5w3fUNT1kN0SGhwC6+
	A5ZvNSd66NY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C5874B114;
	Mon,  7 Mar 2016 18:08:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F40984B113;
	Mon,  7 Mar 2016 18:08:28 -0500 (EST)
In-Reply-To: <1457265902-7949-9-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 6 Mar 2016 17:34:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81110876-E4B9-11E5-A844-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288407>

Karthik Nayak <karthik.188@gmail.com> writes:

> The "%(symref)" atom doesn't work when used with the ':short' modifier
> because we strictly match only 'symref' for setting the 'need_symref'
> indicator. Fix this by using 'starts_with()' rather than 'strcmp()'.

Does that mean you also accept %(symrefgarbage) without complaining?

>
> Add tests for %(symref) and %(symref:short) while we're here.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c            |  2 +-
>  t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 0e6ab75..ab860a3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -323,7 +323,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>  		valid_atom[i].parser(&used_atom[at], arg);
>  	if (*atom == '*')
>  		need_tagged = 1;
> -	if (!strcmp(used_atom[at].name, "symref"))
> +	if (starts_with(used_atom[at].name, "symref"))
>  		need_symref = 1;
>  	return at;
>  }
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
