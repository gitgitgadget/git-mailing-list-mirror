Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E167C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15B522249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bc3ZgVE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505309AbgJUU2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:28:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54675 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505306AbgJUU2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:28:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B85497F3E4;
        Wed, 21 Oct 2020 16:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7+bfISfyGQE0
        bJPvHUJ+1WWbuPs=; b=bc3ZgVE8MurtfGuexjvH6iwL0tJKEK5h2hxPJRfzsjFy
        Vo67EGmVdfUPelo3r5fb/m0ZwuWBVfwt76Hc1T38TAQhBdx9dRdA2d/6uRPS6FNb
        7/oOar7BMzlkWyMlwJMM2s1MNTGek4fhPPHD6lNMeStu4mzNey6is6Zzx2FVi1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NMD/jj
        oJs8jbs1fSdCWHT0zqcg+LWaP0cV0uAjCEvj35jLqMt0cyz8ojrp6Pu3xmGSPe9H
        KAUiPpWW6sUVDpcHfn7dYgMCuaG8H4fm4a4PEGM6BudhYFhoBVcJs5wCCmXLtf+u
        AR850x0P7kk/JOleXHcxpYgs6enEUdJpuWhFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF2607F3E1;
        Wed, 21 Oct 2020 16:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 272087F3E0;
        Wed, 21 Oct 2020 16:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/11] merge-one-file: rewrite in C
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-3-alban.gruin@gmail.com>
        <xmqqmu0z3tge.fsf@gitster.c.googlers.com>
        <e407ce78-8f93-3fb1-4ef2-ce8213f39df2@gmail.com>
Date:   Wed, 21 Oct 2020 13:28:31 -0700
In-Reply-To: <e407ce78-8f93-3fb1-4ef2-ce8213f39df2@gmail.com> (Alban Gruin's
        message of "Wed, 21 Oct 2020 21:47:39 +0200")
Message-ID: <xmqqimb3728g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD34BADC-13DB-11EB-96B0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>>> +	/*
>>> +	 * Create the working tree file, using "our tree" version from
>>> +	 * the index, and then store the result of the merge.
>>> +	 */
>>=20
>> The above is copied from the original, to explain what it did after
>> the comment, but it does not seem to match what the new code does.
>>=20
>>> +	ce =3D index_file_exists(istate, path, strlen(path), 0);
>>> +	if (!ce)
>>> +		BUG("file is not present in the cache?");
>>> +
>>> +	unlink(path);
>>> +	if ((dest =3D open(path, O_WRONLY | O_CREAT, ce->ce_mode)) < 0) {
>>> +		free(result.ptr);
>>> +		return error_errno(_("failed to open file '%s'"), path);
>>> +	}
>>> +
>>> +	written =3D write_in_full(dest, result.ptr, result.size);
>>> +	close(dest);
>>> +
>>> +	free(result.ptr);
>>> +
>>> +	if (written < 0)
>>> +		return error_errno(_("failed to write to '%s'"), path);
>>> +
>>=20
>> This open(..., ce->ce_mode) call is way insufficient.
>>=20
>> The comment we have above this part of the code talks about the
>> difficulty of doing this correctly in scripted version.  Creating a
>> file by 'git checkout-index -f --stage=3D2 -- "$4"' and reusing it to
>> store the merged contents was the cleanest and easiest way without
>> having direct access to adjust_shared_perm() to create a working
>> tree file with the correct permission bits.

The original that the comment applies to does this

	git checkout-index -f --stage=3D2 -- "$4" && cat "$src1" >"$4" || exit 1

to create path "$4" with the correct mode bits, instead of a na=C3=AFve

	mv "$src1" "$4"

because the filemode 'git checkout-index -f --stage=3D2 -- "$4"' gives
to file "$4" is by definition the most correct one for the path.
The command knows how user's umask and type bits in the index should
interact and produce the final mode bits, but "$src1" was created
without any regard to the mode bits---the 'git merge-file' command
only cares about the contents and not filemode.  We can even lose
the executable bit that way.  And preparing "$4" and then catting
the computed contents into it was a roundabout way (it wastes the
entire writing-out of the contents from the index), and that was
what the comment was about.

But all that is unnecessary once you port this to C.  So the comment
does not apply to the code you wrote, I think, and should just be
dropped.

