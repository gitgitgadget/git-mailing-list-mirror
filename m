From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] symbolic-ref: check format of given refname
Date: Mon, 16 Jul 2012 10:12:30 -0700
Message-ID: <7v394r4old.fsf@alter.siamese.dyndns.org>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
 <1342440781-18816-3-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:12:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqoqd-00033F-C2
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 19:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab2GPRMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 13:12:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab2GPRMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 13:12:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DDBE8935;
	Mon, 16 Jul 2012 13:12:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/KeecnUiSf8o2O9kiy/qdfISV0=; b=yf6p64
	nWwqXkcg3HxMqYsiBNJattyN4/mlwcgRGVS6vmN2nhF5wv+rx45NZFWU+mTuCz0p
	PcNzdAyseQDBrqmG+PAOpvuhRs0pSoC4UZqCyI6j0jspfsMKffw/W44nLYfQR6LG
	k2DDDXHBvJHm9RjoOwilrSWuAJLEB6SOYMO9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XXUDikAbVLljBthQ/T/8B2uCqiQ4DsxL
	wkCowZcvsTBsy5eH7le/5h4qa0QwWZ7EgONkyUL5kL94JwHLFKLCHbgJJH4jqzR+
	HTieS6+OQxo43Lxn6+1nPjKlCIMBZz0rJghO8RWXcEGX1uko21qkfQKPxzic4Yov
	qssNVe/q40k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF19E8934;
	Mon, 16 Jul 2012 13:12:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52BF68932; Mon, 16 Jul 2012
 13:12:32 -0400 (EDT)
In-Reply-To: <1342440781-18816-3-git-send-email-mschub@elegosoft.com>
 (Michael Schubert's message of "Mon, 16 Jul 2012 14:13:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E18D30C-CF69-11E1-B28F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201533>

Michael Schubert <mschub@elegosoft.com> writes:

> Currently, it's possible to update HEAD with a nonsense reference since
> no strict validation ist performed. Example:
>
> 	$ git symbolic-ref HEAD 'refs/heads/master
>     >
>     >
>     > '
>
> Fix this by checking the given reference with check_refname_format().
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>  builtin/symbolic-ref.c  |  4 +++-
>  t/t1401-symbolic-ref.sh | 10 ++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 801d62e..a529541 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -44,13 +44,15 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_symbolic_ref_usage, 0);
> -	if (msg &&!*msg)
> +	if (msg && !*msg)
>  		die("Refusing to perform update with empty message");
>  	switch (argc) {
>  	case 1:
>  		check_symref(argv[0], quiet);
>  		break;
>  	case 2:
> +		if (check_refname_format(argv[1], 0))
> +			die("No valid reference format: '%s'", argv[1]);
>  		if (!strcmp(argv[0], "HEAD") &&
>  		    prefixcmp(argv[1], "refs/"))
>  			die("Refusing to point HEAD outside of refs/");

The existing context lines above may give a clue why this patch is
not such a good idea.  We only limit HEAD to point under refs/ but
allow advanced users and scripts creative uses of other kinds of
symrefs.  Shouldn't the patch apply the new restriction only to HEAD
as well?

By the way, should "git symbolic-ref _ HEAD" work?

> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index 2c96551..b1cd508 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -27,6 +27,16 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
>  '
>  reset_to_sane
>  
> +test_expect_success 'symbolic-ref refuses ref with leading dot' '
> +	test_must_fail git symbolic-ref HEAD refs/heads/.foo
> +'
> +reset_to_sane
> +
> +test_expect_success 'symbolic-ref refuses ref with leading dash' '
> +	test_must_fail git symbolic-ref HEAD refs/heads/-foo
> +'
> +reset_to_sane
> +
>  test_expect_success 'symbolic-ref refuses bare sha1' '
>  	echo content >file && git add file && git commit -m one &&
>  	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
