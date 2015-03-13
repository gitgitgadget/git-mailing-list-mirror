From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] upload-pack: fix transfer.hiderefs over smart-http
Date: Thu, 12 Mar 2015 23:21:09 -0700
Message-ID: <xmqqioe5zacq.fsf@gitster.dls.corp.google.com>
References: <20150313044101.GA18476@peff.net>
	<20150313044212.GA18532@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:21:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWIyH-0003Xk-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 07:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbbCMGVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 02:21:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751862AbbCMGVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 02:21:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AE6E3A296;
	Fri, 13 Mar 2015 02:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Goi5aqKRepF3C2ueytQfAr8Ngc=; b=wYTgI0
	MaPvPgDnU8AFOv3atpUODh35zum1QUmhvbTV8riMcLQSEyjgbkWhVb/yQrXP7sSH
	I+GcN4EBr7EOJjK+Hh7Jq8na8x8sGlJXGXsmhaxAg5N2vh72XAh/XjbSi7yvJCtS
	H5E3NQbd+r1hJNYj7ialjxnrh4OzIRCGmOBuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gvNZ0bO0OzcxOa3PuPPW7/EOewff6o8J
	uEp2swKyIa+i9XOPAD8rdd3PY9JT+66JcmXLJatkg/MwiZrrRclGizUwMabBYmLt
	tn+yqjCzyvpWOXzqdAughg6JQPLd1h+laqjzA8YuDsGMG2Xcwyo/qM5DGsKR4NOY
	u/6NYMDxaYM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2168A3A295;
	Fri, 13 Mar 2015 02:21:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 980013A293;
	Fri, 13 Mar 2015 02:21:10 -0400 (EDT)
In-Reply-To: <20150313044212.GA18532@peff.net> (Jeff King's message of "Fri,
	13 Mar 2015 00:42:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24467220-C949-11E4-8BBA-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265404>

Jeff King <peff@peff.net> writes:

> When upload-pack advertises the refs (either for a normal,
> non-stateless request, or for the initial contact in a
> stateless one), we call for_each_ref with the send_ref
> function as its callback. send_ref, in turn, calls
> mark_our_ref, which checks whether the ref is hidden, and
> sets OUR_REF or HIDDEN_REF on the object as appropriate.  If
> it is hidden, mark_our_ref also returns "1" to signal
> send_ref that the ref should not be advertised.
>
> If we are not advertising refs, (i.e., the follow-up
> invocation by an http client to send its "want" lines), we
> use mark_our_ref directly as a callback to for_each_ref. Its
> marking does the right thing, but when it then returns "1"
> to for_each_ref, the latter interprets this as an error and
> stops iterating. As a result, we skip marking all of the
> refs that come lexicographically after it. Any "want" lines
> from the client asking for those objects will fail, as they
> were not properly marked with OUR_REF.

Nicely described in a way that the reason of the breakage and the
fix is obvious to those who already know what the codepath is
supposed to be doing.

> To solve this, we introduce a wrapper callback around
> mark_our_ref which always returns 0 (even if the ref is
> hidden, we want to keep iterating). We also tweak the
> signature of mark_our_ref to exclude unnecessary parameters
> that were present only to conform to the callback interface.
> This should make it less likely for somebody to accidentally
> use it as a callback in the future.

I especially love this kind of future-proofing ;-).

Thanks, will queue.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5551-http-fetch-smart.sh | 11 +++++++++++
>  upload-pack.c               | 14 ++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 6cbc12d..b970773 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -213,6 +213,17 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
>  	test_cmp expect_cookies.txt cookies_tail.txt
>  '
>  
> +test_expect_success 'transfer.hiderefs works over smart-http' '
> +	test_commit hidden &&
> +	test_commit visible &&
> +	git push public HEAD^:refs/heads/a HEAD:refs/heads/b &&
> +	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> +		config transfer.hiderefs refs/heads/a &&
> +	git clone --bare "$HTTPD_URL/smart/repo.git" hidden.git &&
> +	test_must_fail git -C hidden.git rev-parse --verify a &&
> +	git -C hidden.git rev-parse --verify b
> +'
> +
>  test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
>  	(
>  	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> diff --git a/upload-pack.c b/upload-pack.c
> index b531a32..c8e8713 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -681,7 +681,7 @@ static void receive_needs(void)
>  }
>  
>  /* return non-zero if the ref is hidden, otherwise 0 */
> -static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
> +static int mark_our_ref(const char *refname, const unsigned char *sha1)
>  {
>  	struct object *o = lookup_unknown_object(sha1);
>  
> @@ -695,6 +695,12 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
>  	return 0;
>  }
>  
> +static int check_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
> +{
> +	mark_our_ref(refname, sha1);
> +	return 0;
> +}
> +
>  static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>  {
>  	struct string_list_item *item;
> @@ -713,7 +719,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  	const char *refname_nons = strip_namespace(refname);
>  	unsigned char peeled[20];
>  
> -	if (mark_our_ref(refname, sha1, flag, NULL))
> +	if (mark_our_ref(refname, sha1))
>  		return 0;
>  
>  	if (capabilities) {
> @@ -767,8 +773,8 @@ static void upload_pack(void)
>  		advertise_shallow_grafts(1);
>  		packet_flush(1);
>  	} else {
> -		head_ref_namespaced(mark_our_ref, NULL);
> -		for_each_namespaced_ref(mark_our_ref, NULL);
> +		head_ref_namespaced(check_ref, NULL);
> +		for_each_namespaced_ref(check_ref, NULL);
>  	}
>  	string_list_clear(&symref, 1);
>  	if (advertise_refs)
