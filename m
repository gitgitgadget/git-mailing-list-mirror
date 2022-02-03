Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EC8C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353917AbiBCUBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:01:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58759 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiBCUBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 15:01:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFB3211903B;
        Thu,  3 Feb 2022 15:01:23 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=x3SevfMg8CxTy/e78pVLwVB65g5UFpOuotmGGXJ
        qDOM=; b=Izw1VOiDV7udHu/NkPqMbPQpzJi8LzG4WPDF+x2PrW1VUSywmu1oZ2I
        fQos4nG7jqmUG/UBxz6NH8m/RsD3Tag3irvMOYPdxVXKklKX4GcvyhkDYk1s93Q+
        7euRbTn/RGy3DGtQsgkrbw5IKyr2MeoerKkZPriWrdugnLXhaZQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B37C711903A;
        Thu,  3 Feb 2022 15:01:23 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11037119039;
        Thu,  3 Feb 2022 15:01:23 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 3 Feb 2022 15:01:21 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <Yfw0kapgSSWO3Pyx@pobox.com>
References: <20220203123724.47529-1-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203123724.47529-1-fs@gigacodes.de>
X-Pobox-Relay-ID: 0FC787F2-852C-11EC-9A9B-5E84C8D8090B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabian,

Fabian Stelzer wrote:
> gpgsm v2.3 changed some details about its output:
>  - instead of displaying `fingerprint:` for keys it will print `sha1
>    fpr:` and `sha2 fpr:`
>  - some wording of errors has changed
>  - signing will omit an extra debug output line before the [GNUPG]: tag

Thanks for sending this.  I noticed these as well, as Fedora
started shipping gnupg-2.3 a few months back.  I have been
trying (and failing) to make time to submit (when I know I
won't be too distracted to actually converse about them).
The commits I made for the tests in Fedora are all here:

    https://src.fedoraproject.org/rpms/git/c/a7d2f7e53

I don't intend that as something anyone here should feel the
need to chase down.  But since they provide some additional
context on the changes I made in the same area, it might
help if anyone's curious.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index b52eb0e2e0..299e7f588a 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -939,7 +939,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>  			   signature, 1024, &gpg_status, 0);
>  	sigchain_pop(SIGPIPE);
>  
> -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
> +	ret |= !strstr(gpg_status.buf, "[GNUPG:] SIG_CREATED ");
>  	strbuf_release(&gpg_status);
>  	if (ret)
>  		return error(_("gpg failed to sign the data"));

As Junio noted, this loosens the GPG parsing a good bit.  I
worried it could lead to security issues as well.  The
simple fix I made in Fedora was to add a newline to the
gpg_status string buffer before adding the command output to
it:

    diff --git a/gpg-interface.c b/gpg-interface.c
    index 3e7255a2a9..d179dfb3ab 100644
    --- a/gpg-interface.c
    +++ b/gpg-interface.c
    @@ -859,6 +859,12 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     
	bottom = signature->len;
     
    +	/*
    +	 * Ensure gpg_status begins with a newline or we'll fail to match if
    +	 * the SIG_CREATED line is at the start of the gpg output.
    +	 */
    +	strbuf_addch(&gpg_status, '\n');
    +
	/*
	* When the username signingkey is bad, program could be terminated
	* because gpg exits without reading and then write gets SIGPIPE.

https://src.fedoraproject.org/rpms/git/blob/a7d2f7e53/f/0005-gpg-interface-match-SIG_CREATED-if-it-s-the-first-li.patch

But that seemed like a bit of a hack.  What I had queued up
to submit for discussion (as I'm not sure that it isn't
entirely horrible) used the string-list API to parse the gpg
output:

    diff --git a/gpg-interface.c b/gpg-interface.c
    index b52eb0e2e0..e63ccdcb11 100644
    --- a/gpg-interface.c
    +++ b/gpg-interface.c
    @@ -921,6 +921,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     	int ret;
     	size_t bottom;
     	struct strbuf gpg_status = STRBUF_INIT;
    +	struct string_list lines = { .cmp = starts_with };
     
     	strvec_pushl(&gpg.args,
     		     use_format->program,
    @@ -939,8 +940,11 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     			   signature, 1024, &gpg_status, 0);
     	sigchain_pop(SIGPIPE);
     
    -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
    +	string_list_split_in_place(&lines, gpg_status.buf, '\n', -1);
    +	ret |= !unsorted_string_list_has_string(&lines, "[GNUPG:] SIG_CREATED ");
     	strbuf_release(&gpg_status);
    +	string_list_clear(&lines, 0);
    +
     	if (ret)
     		return error(_("gpg failed to sign the data"));

That's the commit I was most in doubt about though, as my C
"skills" are close to non-existant.  I'd rather have
something ugly and clear (like the `strbuf_addch(...)`
above) than clever and wrong in gpg-interface.c.

(To be clear, I mean "clever and wrong" in regard to my use
of the string list API, not anyone else's code.)

> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 3e7ee1386a..6c2dd4b14b 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -73,8 +73,8 @@ test_lazy_prereq GPGSM '
>  		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>  
>  	gpgsm --homedir "${GNUPGHOME}" -K |
> -	grep fingerprint: |
> -	cut -d" " -f4 |
> +	grep -E "(fingerprint|sha1 fpr):" |
> +	cut -d":" -f2- | tr -d " " |
>  	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&

I think this whole thing can (and should) be simplified by
using gpg's --with-colons output which is intended to be
machine parsable.

If we'd been using that previously, we wouldn't need to make
any further changes here.

I think we're making our lives difficult by screen scraping
here wher we don't need to do so.

The change I made for the Fedora package to fix this does
it like this:

    --- a/t/lib-gpg.sh
    +++ b/t/lib-gpg.sh
    @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
                    --passphrase-fd 0 --pinentry-mode loopback \
                    --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&

    -	gpgsm --homedir "${GNUPGHOME}" -K |
    -	grep fingerprint: |
    -	cut -d" " -f4 |
    -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
    +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
    +	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
    +		>"${GNUPGHOME}/trustlist.txt" &&

    -	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
            echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
                   -u committer@example.com -o /dev/null --sign -
     '

With a commit message:

    https://src.fedoraproject.org/rpms/git/blob/a7d2f7e53/f/0001-t-lib-gpg-use-with-colons-when-parsing-gpgsm-output.patch

I was hoping to submit that small series in the next day or
two, while I've got a few days away from $work.  If doing it
that way is appealing, I can submit them.  But only if that
looks like a reasonable improvement to you and others.

>  	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5049559861..08556493ce 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1931,7 +1931,10 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
>  	git merge --no-ff -m msg signed_tag_x509_nokey &&
>  	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
>  	grep "^|\\\  merged tag" actual &&
> -	grep "^| | gpgsm: certificate not found" actual
> +	(
> +		grep "^| | gpgsm: certificate not found" actual ||
> +		grep "^| | gpgsm: failed to find the certificate: Not found" actual
> +	)
>  '
>  
>  test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '

Can we make this simpler by adjusting the grep pattern?
It's certainly a slight trade-off in ease of reading, but it
saves a subshell and an extra command:

    -	grep "^| | gpgsm: certificate not found" actual
    +	grep -Ei "^| | gpgsm:( failed to find the)? certificate:? not found" actual

I did that in a separate patch:

    https://src.fedoraproject.org/rpms/git/blob/a7d2f7e53/f/0004-t4202-match-gpgsm-output-from-GnuPG-2.3.patch

IMO, this is a bug in gnupg-2.3.  I submitted a patch to
resolve it back in November, but have not gotten any
response as yet. :(

    https://lists.gnupg.org/pipermail/gnupg-devel/2021-November/034991.html

Not that it will preclude us from having to fix this for the
test suite, but it's worth noting why the change is needed
(and when it will no longer be relevant -- if/when we don't
care to support the few early gnupg-2.3.x releases).

Thanks,

-- 
Todd
