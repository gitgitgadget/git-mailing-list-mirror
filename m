Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF28CC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C86A22482
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgLWUW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:22:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65050 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLWUW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:22:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EB8099233;
        Wed, 23 Dec 2020 15:21:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JxaY0ychRRLXKSbsHO5TrkkghHQ=; b=ERh9xY
        JfNCfOmCX1RfWW6gc7qN1DEePiZgLW38jW2GrmG2W28dibPsS++1jG9YEAOC3g6z
        9Z5uyElvEeEl7Ui5Rfxrj8eS3GWqPHy+/4sKO3vGpW/qlfHEVmhErdgIl0mL/pv3
        v6wrcjimGIkM8MN5qHP5Xtlb10MNGhkDprMWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gWxa68yrRwcjCLIEkDcgH6Xjf7rZOH0R
        kyc65U9qg5og7hBXUh2jxnC02JrILG/yfmnokuPOOOmyh3NEKHIex+mZ5XKD6xEq
        b7smlepuuNNulx/ZtmtFCeYriQob/YQHI0jVNHcLnwa1EyLz9yy8AG4eyDpCxzhg
        VfjMd2LRTnY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05E1099232;
        Wed, 23 Dec 2020 15:21:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88FEF99231;
        Wed, 23 Dec 2020 15:21:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201223045358.100754-2-felipe.contreras@gmail.com>
        <xmqqblekabof.fsf@gitster.c.googlers.com>
        <5fe352e3968f6_198be2083@natae.notmuch>
Date:   Wed, 23 Dec 2020 12:21:43 -0800
In-Reply-To: <5fe352e3968f6_198be2083@natae.notmuch> (Felipe Contreras's
        message of "Wed, 23 Dec 2020 08:23:31 -0600")
Message-ID: <xmqqblek8e94.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79AF896E-455C-11EB-817D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > +auto_merge () {
>> > +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
>> > +	if test -s "$DIFF3"
>> > +	then
>> 
>> We do not want to ignore the exit status from the command.  IOW, I
>> think the above wants to be rather
>> 
>> 	if git merge-file ... >"$DIFF3" &&
>> 	   test -s "$DIFF3"
>> 	then
>> 		...
>
> That doesn't work.
>
> "git merge-file" always returns non-zero status when it succeeds (it's
> the number of conflicts generated).

Ah, I forgot about that one.  I think "the number of conflicts" was
a UI mistake (the original that it mimics is "merge" from RCS suite,
which uses 1 and 2 for "conflicts" and "trouble") but we know we
will get conflicts, so it is wrong to expect success from the
command.  Deliberately ignoring the return status is the right thing
to do.

> What if the original file does have these markers?
>
> Which is probably something we should be checking beforehand and not
> attempt an automerge in those cases.

Yes, that is a much better approach to avoid unnecessary work.

When we made the conflict marker length configurable, we were hoping
that we no longer have to worry about the cases where payload files
(original or ours or theirs) have lines that are confusingly similar
to the conflict markers, but because we are interfacing external tools
that are unaware of the facility, it probably would not help us in
this case all that much.

FWIW, we use a fiarly large size for our own files in t/ and
Documentation/ directories ourselves, and it does help topic branch
merges somewhat frequently.
