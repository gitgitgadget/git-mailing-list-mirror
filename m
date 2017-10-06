Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843EA1FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbdJFEwh (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:52:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61129 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751587AbdJFEwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBA19A9E26;
        Fri,  6 Oct 2017 00:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=msgPLAvXo1dy
        MiCs/Dy3SsW8QY8=; b=CPX1tuzQrhPCkcjANIhfkuGgxczVUQkiF6lCcwkJJEiy
        CR9nTOeyrDbIIqGq2t4369TVlCVIdhuWEoAbr9LvAMx5mKl+rQqg4FBbxAMbYwzA
        OPnam8NOtRMBnBdMcTyddrXqD/ltlPIE00bsLh2auHVBgHWeDJW1cPTUyj0tqks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KeBAoR
        7l9qvW2r6prWfUleSIz1aUWs2F/FDjUsKsDaqpGyBiNsIZvNi+rx6gkLOxTOHUo4
        xxzdoMhO2Nx/hOUvcJBGNh4fpB30eZqXCNc5B9Q0Nv7JWOOhYbxOslQNqtTckSTX
        S10v7k1sxu3cRbxXoR4ekNfCNSIS6OOWdBCHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E37E0A9E25;
        Fri,  6 Oct 2017 00:52:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6378EA9E20;
        Fri,  6 Oct 2017 00:52:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] run-command: add hint when a hook is ignored
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
        <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
Date:   Fri, 06 Oct 2017 13:52:34 +0900
In-Reply-To: <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
        ("Damien =?utf-8?Q?Mari=C3=A9=22's?= message of "Thu, 5 Oct 2017 20:53:07
 +0000")
Message-ID: <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2BA30B18-AA52-11E7-A42A-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Mari=C3=A9 <damien@dam.io> writes:

>  	if (access(path.buf, X_OK) < 0) {
> +		int err =3D errno;

OK, so we remember how/why we failed in err.

>  #ifdef STRIP_EXTENSION
>  		strbuf_addstr(&path, STRIP_EXTENSION);
>  		if (access(path.buf, X_OK) >=3D 0)
>  			return path.buf;
> +		else if (errno =3D=3D EACCES)
> +			err =3D errno;

I think it is easier to reason about if this were not "else if", but
just a simple "if".

 - We tried foo-hook, and failed.
 - On a platform that foo-hook.exe can also be a hook
   - We try foo-hook.exe and if it seems OK, we return with smile.
   - If not, if we know foo-hook.exe exists but we cannot execute,
     we update err (forgetting the reason why foo-hook was wrong)
     with the reason why foo-hook.exe is bad.

It is OK to forget why foo-hook was unhappy, as on a STRIP_EXTENSION
build, we would have tried to run foo-hook.exe anyway.

>  #endif

So at this point, with or without STRIP_EXTENSION, err tells us why
the file we wanted to be available as a hook did not pass our
criteria.

> +		if (err =3D=3D EACCES && advice_ignored_hook) {

And we want to do the advise thing only if we know we failed due to
EACCES and for no other reason.

> +			advise(_(
> +				"The '%s' hook was ignored because "
> +				"it's not set as executable.\n"
> +				"You can disable this warning with "
> +				"`git config advice.ignoredHook false`."), path.buf);
> +		}
>  		return NULL;
>  	}
>  	return path.buf;

Overall, the logic looks correct to me.  Note that we may have
gotten EACCES not because the path lacked the executable bit, but
because the hook directory was unreadable ;-), but in such a case,
you cannot tell if "it's not set as executable" is true anyway.

> diff --git a/t/t7519-ignored-hook-warning.sh b/t/t7519-ignored-hook-war=
ning.sh
> new file mode 100755
> index 0000000000000..59052a4429111
> --- /dev/null
> +++ b/t/t7519-ignored-hook-warning.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +test_description=3D'ignored hook warning'
> +
> +. ./test-lib.sh
> +

These days, things like this...

> +# install hook that always succeeds
> +HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
> +HOOK=3D"$HOOKDIR/pre-commit"
> +mkdir -p "$HOOKDIR"
> +cat > "$HOOK" <<EOF
> +#!/bin/sh
> +exit 0
> +EOF
> +
> +chmod +x "$HOOK"

...should all go to test_expect_success, i.e.

	test_expect_success setup '
		...
		mkdir -p "$hookdir" &&
		write_script "$hookdir/pre-commit" <<-\EOF
		exit 0
		EOF
	'

write_script takes care of flipping +x on.

> +test_expect_success 'no warning if proper hook' '
> +
> +    if git commit -m "more" 2>&1 >/dev/null | grep hint
> +    then
> +        false
> +    else
> +        true
> +    fi
> +

 - Indents in our shell scripts are done with tab (HT).

 - We try to avoid running git command on the LHS of a pipe when we
   do not have to.

 - "git commit" may fail due to not having anything worth
   committing, even before it notices that pre-commit hook is or is
   not executable.  Avoid relying on the order of things that happen
   to be true in the current implementation when we do not have to.

 - We may see some other hint.  Avoid relying on the set of advises
   that happens to currently be defined when we do not have to.

 - Output from advise() can be localized, so grepping to expect
   something either is there or is not there would be triggered as
   an error in GETTEXT_POISON build.  We unfortunately need to use
   test_i18ngrep to work it around.

Perhaps the above should become more like so:

	git commit --allow-empty -m more 2>message &&
	test_i18ngrep ! "hook was ignored" message

> +'
> +
> +chmod -x "$HOOK"

Move this to the beginning of the next one that is protected with
POSIXPERM.

> +test_expect_success POSIXPERM 'warning if hook not set as executable' =
'
> +
> +    if git commit -m "more" 2>&1 >/dev/null | grep hint
> +    then
> +        true
> +    else
> +        false
> +    fi
> +'

	chmod -x "$hookdir/pre-commit" &&
	git commit --allow-empty -m "even more" 2>message &&
	test_i18ngrep "hook was ignored" message

or something like that.

Thanks.
