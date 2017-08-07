Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577AD2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 22:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdHGWor (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 18:44:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63859 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751761AbdHGWoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 18:44:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B05D2A6CF4;
        Mon,  7 Aug 2017 18:44:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pqlIyHV1szn3hJE9HQxQ5/8kItQ=; b=CqMztW
        I++fHJNHdk5qiHIYXDuq/eIwkYU/SZeR8ARGn3cneluEnSmuK1Lt92l143vtgW3E
        eU4w+mzwiJCVb1ceuK/0fDPzs2LfavAOYArxfUKWgOsjTE9geGtvpUvtzR5gpzOu
        Ik9u1R9IeAPHjCp0pTf7z4ylQ7XqmlEv2QQOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K3VNP1I5FDVUvWtlq0farwvlSHuIDeZe
        FLlzj9RmyCpd2oIq3QCXgfBzjZO0dOLjLRS5r/Y3gJuJ8Dr5S+462vKqUTVxiJAJ
        J+dimTOGYIEoG4fX36BhtafwPAe8ANpG8LwF70sBQTcvD6U43gwpUKTqJy+iUICH
        +AYciTlHL5A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6046A6CF3;
        Mon,  7 Aug 2017 18:44:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14AD9A6CF1;
        Mon,  7 Aug 2017 18:44:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion: better error message when an ambiguous checkout is executed
References: <CACcTrKdzVCKUR8EfwhqBQR7vWzRqTLcwRJ_r-hx3VztD=xvNuQ@mail.gmail.com>
Date:   Mon, 07 Aug 2017 15:44:43 -0700
In-Reply-To: <CACcTrKdzVCKUR8EfwhqBQR7vWzRqTLcwRJ_r-hx3VztD=xvNuQ@mail.gmail.com>
        (Mahmoud Al-Qudsi's message of "Mon, 7 Aug 2017 16:49:18 -0500")
Message-ID: <xmqq8tivngkk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02537860-7BC2-11E7-BD1B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mahmoud Al-Qudsi <mqudsi@neosmart.net> writes:

> The default git behavior when attempting to `git checkout xxx` for
> some value of "xxx" that cannot be resolved to a single, unique
> file/path/branch/tag/commit/etc is to display the following:
>
>> error: pathspec 'xxx' did not match any file(s) known to git

Yes, it is true that the user may have wanted to instead checkout a
branch 'xxy' and misspelled it as 'xxx'.  Or the user may have more
than one remotes, from which there are remote-tracking branches for
'xxx' branch.  Neither of these cases allow Git to interpret 'xxx'
as a rev, and Git blindly thinks that 'xxx' must be a pathspec, and
wants to ensure that such a path exists in the working tree (if
'xxx' does not look like a wildcard or otherwise magic pathspec).

> Unfortunately, this is (IMHO) at best misleading when the actual case
> is that "git could not unambiguously resolve pathspec xxx"

The actual case you want to address is "git could not tell that the
user meant 'xxx' as a revision, even though the end user meant it as
such".

> Can the case where xxx _was_ resolved but to more than one value be
> improved in both utility and comprehensibility by providing an error
> message that
>
> 1) indicates that xxx was a valid pathspec, but not a unique one

Just the terminology, you are no longer talking about a pathspec.
You are talking about a rev; i.e. when refs/remotes/origin[12]/xxx 
exist, the user may have meant 'xxx' as a rev, but Git is not allowed
to pick one of them randomly.

It would be nice to take this case into account.

Note that if refs/remotes/origin/xxy exists and the user misspelled
it as 'xxx', you would still get the same "(because 'xxx' cannot be
a rev, it must be a pathspec) pathspec 'xxx' did not match..." error
message, though, so there might not be much point in special casing
"more than one potentially matching revs" case over "there is no
potentially matching revs" case, though.

> 2) provides a list of unique pathspecs that xxx matched against
>
> e.g. in the case where xxx is the name of a branch on both origin1 and
> origin2, it would be ideal if git could instead report
>
>> error: pathspec 'xxx' could not be uniquely resolved
>> xxx can refer to one of the following:
>> * branch origin1/xxx
>> * branch origin2/xxx

Again you are talking about "revs", not pathspecs.  The above (with
tweak to the wrong terminology) would work as a better error message
*if* there is no chance that the user meant 'xxx' as a pathspec,
i.e. "I want to overwrite the files in the working tree that matches
the pathspec 'xxx' with matching contents from the index".

So a possible implementation approach would be

 - to let the current code do what it is doing

 - except that you add new code immediately before the code that
   issues 'xxx' did not match (i.e. the code already checked that
   'xxx' taken as a pathspec does not match anything, and about to
   give the error message but hasn't done so just yet).

 - your new code 

   . checks if 'xxx' could be an attempt to refer to a rev but
     insufficiently spelled out (e.g. both origin[12]/xxx exists, or
     for a bonus point, a similarly named origin/xxy exists and
     could be a typo).

   . if the above check found something, then you report it and
     terminate without complaining "pathspec 'xxx' did not
     match..."

   . on the other hand, if the above check did not find anything,
     then you let the current code issue the same error message as
     before.


