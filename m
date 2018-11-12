Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD2B1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 06:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbeKLQgK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 11:36:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63223 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbeKLQgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 11:36:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8593E101496;
        Mon, 12 Nov 2018 01:44:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BV4sgCBtyiVD
        iDfQSmAijpLQ2kc=; b=V88XtKBk4FzsfsjGBTG1UJ7GoHP8sxEc7M1S80AOc8vX
        NB7zOPkizVTexJxzvOVg5N5Za5JybEX1Ti4RQ3AqUKPxP/Zk/BR0Lo3GJQqBfJRn
        RFSKCSsV7JA8Z5eK+kxiNX3Z5jkooxxZviRtid30T5qG0gxE+UEvEBed1jCPaL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=l4PbxJ
        25voBdybWWaUJyNfxuKsevzPoiEmdQAW0hLs7OFtd2/PMCqzDG27B+3JW17XJZDV
        m+BlfQNigItjiS2VHybPAUWzdNUiq65SCn6xR2enZ6oKnqox3M+VTaEPtkq8paZ6
        knV6m8+Pl1cFTYomfgVdEOl0nYiAjJDR+pABw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67E64101495;
        Mon, 12 Nov 2018 01:44:16 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B95BB101493;
        Mon, 12 Nov 2018 01:44:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout: disambiguate dwim tracking branches and local files
References: <20181110120707.25846-1-pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 15:44:14 +0900
In-Reply-To: <20181110120707.25846-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 10 Nov 2018 13:07:07 +0100")
Message-ID: <xmqq36s63idd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F6A54D4-E646-11E8-A18C-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -1079,9 +1079,15 @@ static int parse_branchname_arg(int argc, const =
char **argv,
>  		 */
>  		int recover_with_dwim =3D dwim_new_local_branch_ok;
> =20
> -		if (!has_dash_dash &&
> -		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
> -			recover_with_dwim =3D 0;
> +		/*
> +		 * If both refs/remotes/origin/master and the file
> +		 * 'master'. Don't blindly go for 'master' file
> +		 * because it's ambiguous. Leave it for the user to
> +		 * decide.
> +		 */
> +		int disambi_local_file =3D !has_dash_dash &&
> +			(check_filename(opts->prefix, arg) || !no_wildcard(arg));

What you are computing on the right hand side is if the arg is
ambiguous.  And the code that looks at this variable does not
disambiguate, but it just punts and makes it responsibility to the
user (which is by the way the correct thing to do).

When a file with exact name is in the working tree, we do not
declare it is a pathspec and not a rev, as we may be allowed to dwim
and create a rev with that name and at that point we'd be in an
ambigous situation.  If the arg _has_ wildcard, however, it is a
strong sign that it *is* a pathspec, isn't it?  It is iffy that a
single variable that cannot be used to distinguish these two cases
is introduced---one of these cases will be mishandled.

Also how does the patch ensures that this new logic does not kick in
for those who refuse to let the command dwim to create a new branch?

>  		/*
>  		 * Accept "git checkout foo" and "git checkout foo --"
>  		 * as candidates for dwim.
> @@ -1094,6 +1100,9 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
>  			const char *remote =3D unique_tracking_name(arg, rev,
>  								  dwim_remotes_matched);
>  			if (remote) {
> +				if (disambi_local_file)
> +					die(_("'%s' could be both a local file and a tracking branch.\n"
> +					      "Please use -- to disambiguate"), arg);

Ah, the only user of this variable triggers when recover_with_dwim
is true, so that is how dwim-less case is handled, OK.

That still leaves the question if it is OK to handle these two cases
the same way in a repository without 'next' branch whose origin has
one:

    $ >next; git checkout --guess next
    $ >next; git checkout --guess 'n??t'

Perhaps the variable should be named "local_file_crashes_with_rev"
and its the scope narrowed to the same block as "remote" is
computed.  Or just remove the variable and check the condition right
there where you need to.  I.e.

	if (remote) {
		if (!has_dash_dash &&
		    check_filename(opts->prefix, arg))
			die("did you mean a branch or path?: '%s'", arg);
		...

