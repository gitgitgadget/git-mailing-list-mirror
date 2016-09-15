Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13542070F
	for <e@80x24.org>; Thu, 15 Sep 2016 22:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756401AbcIOWIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 18:08:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55783 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756272AbcIOWIl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 18:08:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13D7E3E214;
        Thu, 15 Sep 2016 18:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mRQLcUqMGKZOzw5OQccQsl9gOzI=; b=BQp1r6
        JpBd3h6PGM6zsCwYIt327DEwfcYMKc3RylSTLjhyXEK5SuvtrVDlQM03nzrBLjSZ
        7nYh8V8Y+8QmQ7PJ5PEyAfJJChtZLH0eqYJKmOeYT8Y8VvhPF9tcDmViU5r/RuS0
        TfvONyb5TPD+CAUAPb9m2KDeeaOquFIXVELwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ebrueA0a0i9pujx8OfJedjqV5AQa3E/m
        ehNjA4EikPi1PPRO34o+zMP+sBx6VuB/uvvKyE7HNb58SmiLTqAj3mcDs/+bt1u2
        zOiIzZhOH/4qRlc8ZdtLXsRIOpeR+9FBxfNDoNGDQ78skNLFXTwo99LAFgOtL7Ca
        Pxd5fVGMK0s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C1453E212;
        Thu, 15 Sep 2016 18:08:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83DC63E211;
        Thu, 15 Sep 2016 18:08:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
        pclouds@gmail.com, Jens Lehmann <jens.lehmann@web.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] extending pathspec support to submodules
References: <1473897473-154528-1-git-send-email-bmwill@google.com>
        <20160915115752.GA37903@book.hvoigt.net>
        <CAKoko1rtEydwbWoEq9MBW41qqa10Bm+x0d6zS+Bptk51RjMOMA@mail.gmail.com>
Date:   Thu, 15 Sep 2016 15:08:37 -0700
In-Reply-To: <CAKoko1rtEydwbWoEq9MBW41qqa10Bm+x0d6zS+Bptk51RjMOMA@mail.gmail.com>
        (Brandon Williams's message of "Thu, 15 Sep 2016 08:26:22 -0700")
Message-ID: <xmqqr38klst6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4EEC10C-7B90-11E6-B5D3-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> You're right that seems like the best course of action and it already falls
> inline with what I did with a first patch to ls-files to support submodules.
> In that patch I did exactly as you suggest and pass in the prefix to the
> submodule and make the child responsible for prepending the prefix to all of
> its output.  This way we can simply pass through the whole pathspec (as apposed
> to my original idea of stripping the prefix off the pathspec prior to passing
> it to the child...which can get complicated with wild characters) to the
> childprocess and when checking if a file matches the pathspec we can check if
> the prefix + file path matches.

That's brilliant.  A few observations.

 * With that change to tell the command that is spawned in a
   submodule directory where the submodule repository is in the
   context of the top-level superproject _and_ require it to take a
   pathspec as relative to the top-level superproject, you no longer
   worry about having to find where to cut the pathspec given at the
   top-level to adjust it for the submodule's context.  That may
   simplify things.

 * Your program that runs in the top-level superproject still needs
   to be able to say "this pathspec from the top cannot possibly
   match anything in the submodule, so let's not even bother
   descending into it".

 * Earlier while reviewing "ls-files" recursion, I suggested (and
   you took) --output-path-prefix as the option name, because it was
   meant to be "when you output any path, prefix this string".  But
   the suggested name is suboptimal, as it is no longer an option
   that is only about "output".  A command that runs in a submodule
   would:

   - enumerate paths in the context of the submodule repository,
   - prepend the "prefix" to these paths,
   - filter by applying the full-tree pathspec, and
   - work on the surviving paths after filtering.

   When the last step, "work on", involves just "printing", the
   whole path (with "prefix") is sent to the output.  If it involves
   some operation relative to the submodule repository (e.g. seeing
   if it is in the index), the "prefix" may have to be stripped
   while the operation is carried out.

   So we may have to rethink what this option name should be.  "You
   are running in a repository that is used as a submodule in a
   larger context, which has the submodule at this path" is what the
   option tells the command; if any existing command already has
   such an option, we should use it.  If we are inventing one,
   perhaps "--submodule-path" (I didn't check if there are existing
   options that sound similar to it and mean completely different
   things, in which case that name is not usable)?

Thanks.

   
