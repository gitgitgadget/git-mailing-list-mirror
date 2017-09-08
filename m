Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A09208E3
	for <e@80x24.org>; Fri,  8 Sep 2017 01:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdIHBNd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 21:13:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53370 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750966AbdIHBNc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 21:13:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFEF6938FE;
        Thu,  7 Sep 2017 21:13:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Dj07oFz2miNc
        Sk7QTEW1hYIdtnQ=; b=wc4A/w6BJYKk2uW/opuODlrfBlSOuTt02v9Fv+BWcbAL
        kk+ZSxJx+Ln6wy778o1g/wZN/FyTZ61u6WDvgYgRTB835R7sqSgUl2iKmsfg9QQl
        Q1hREnwBndMenoHzWVFyK1zk40NbMPQ0hLeVOtwYp5ZDuzGgr9bG3u+siB/0G2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W3otcu
        LaOvRDVNZgt+Xj3YfmIavdT7tJ9bilH9pjV4y6RXY6WnbnXiSiiXfL84LVHShQt5
        Ljlfgd07ZWTa8iUM/O2z+hEaDzyLRBqYg5oEZU4wZCuy+fX7hbETyJ5fPkgPGx0C
        SZSoKpf1mx9Sx7t1Mk+mBp4mIG3KeGPurXh3o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A80BA938FD;
        Thu,  7 Sep 2017 21:13:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04EEB938FC;
        Thu,  7 Sep 2017 21:13:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv3] builtin/merge: honor commit-msg hook for merges
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170907220429.31312-1-sbeller@google.com>
Date:   Fri, 08 Sep 2017 10:13:29 +0900
In-Reply-To: <20170907220429.31312-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 7 Sep 2017 15:04:29 -0700")
Message-ID: <xmqqr2vi0z7q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED67E92A-9432-11E7-A670-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> .... The --no-verify option however is not remembered across invocation=
s
> of git-merge. Originally the author assumed an alternative in which the
> 'git merge --continue' command accepts the --no-verify flag, but that
> opens up the discussion which flags are allows to the continued merge
> command and which must be given in the first invocation.

This leaves a reader (me) wondering what the final conclusion was,
after the author assumed something and thought about alternatives.
I am guessing that your final decision was not to remember
"--no-verify" so a user who started "merge --no-verify" that stopped
in the middle must say "merge --continue --no-verify" or "commit
--no-verify" to conclude the merge?  Or you added some mechanism to
remember the fact that no-verify was given so that "merge --continue"
will read from there, ignoring "merge --continue --verify" from the
command line?  Not just the above part of the log message confusing,
but there is no update to the documentation, and we shouldn't expect
end-users to find out what ought to happen by reading t7504 X-<.

The new test in t7504 tells me that you remember --[no-]verify from
the initial invocation and use the same when --continue is given; it
is unclear how that remembered one interacts with --[no-]verify that
is given when --continue is given.  It is not documented, tested and
explained in the log message.  I would expect that the command line=20
trumps what was given in the initial invocation.


> +static int verify_msg =3D 1;
> =20
>  static struct strategy all_strategy[] =3D {
>  	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
> @@ -236,6 +237,7 @@ static struct option builtin_merge_options[] =3D {
>  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored=
 files (default)")),
>  	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
> +	OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
>  	OPT_END()
>  };

I suspect that the previous iteration gives a much better end-user
experience when "git merge -h" is used.  This will give the
impression that the user MUST say "merge --verify" if the user wants
to verify commit-msg hook (whatever that means), but because the
option defaults to true, that is not what happens.  The user instead
must say "merge --no-verify" if the verification is unwanted.

"git commit -h" explains=20

    --no-verify        bypass pre-commit and commit-msg hooks

and I think that is the way how we want to explain this option in
"git merge" too.  Normally it is not bypassed, and the user can ask
with "--no-verify".  Thanks to Ren=C3=A9's change in 2012, the option
definition you had in the previous one will make --[no-]verify
accepted just fine.

> +test_expect_success 'merge fails with failing hook' '
> + ...
> +'
> +
> +test_expect_success 'merge bypasses failing hook with --no-verify' '
> + ...
> +'

Both look sensible.

> +test_expect_failure 'merge --continue remembers --no-verify' '
> +	test_when_finished "git branch -D newbranch" &&
> +	test_when_finished "git checkout -f master" &&
> +	git checkout master &&
> +	echo a >file2 &&
> +	git add file2 &&
> +	git commit --no-verify -m "add file2 to master" &&
> +	git checkout -b newbranch master^ &&
> +	echo b >file2 &&
> +	git add file2 &&
> +	git commit --no-verify file2 -m in-side-branch &&
> +	git merge --no-verify -m not-rewritten-by-hook master &&
> +	# resolve conflict:
> +	echo c >file2 &&
> +	git add file2 &&
> +	git merge --continue &&
> +	commit_msg_is not-rewritten-by-hook
>  '

OK.  What should happen when the last "merge --continue" was given
"--verify" at the same time?  A similar test whose title is
"--no-verify remembered by merge --continue can be overriden" may be
a good thing to follow this one, perhaps?

Thanks.
