Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB4C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC79E611CC
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhFSGtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:49:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51538 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFSGth (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 02:49:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 156B0129445;
        Sat, 19 Jun 2021 02:47:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=noxHPANACtSdQQUSdUvjUbV0RsgPBc5WdICJ+X
        BjCv0=; b=Fdu6fwt+92VnU4plfDGOEhpFIqZa1F1KC9k9DktDHxsiju9dpfIZqn
        7pn0oGkViFB9VmsaqJiHFmhYvwRCAcvbahv7/oG/+u3hbH5sUSQ3pCXuLd9ro0L3
        Tmwk/L2DY2CJv+WBwRjC6uHnaKoX2p9vOqKN9pq0wEAJ190bdietg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DA8D129444;
        Sat, 19 Jun 2021 02:47:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D59D129443;
        Sat, 19 Jun 2021 02:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "dorgon chang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dorgon chang <dorgonman@hotmail.com>
Subject: Re: [PATCH] git-p4: fix failed submit by skip non-text data files
References: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
Date:   Sat, 19 Jun 2021 15:47:22 +0900
In-Reply-To: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com> (dorgon
        chang via GitGitGadget's message of "Fri, 12 Mar 2021 07:47:49 +0000")
Message-ID: <xmqq35tel5ad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 343CCCDA-D0CA-11EB-BF07-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"dorgon chang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "dorgon.chang" <dorgonman@hotmail.com>
>
> If the submit contain binary files, it will throw exception and
> stop submit when try to append diff line description.

OK, that explains how the program fails.

> This commit will skip non-text data files when exception
> UnicodeDecodeError thrown.

If there are changes in aText and aBinary file and you try to submit
a cl that contains both changes, you do want changes to both files
go together, no?  If you skip non-text, does that mean you ignore
the changes to aBinary file and submit only the changes to aText
file?

I guess my confusion comes from not understanding what you exactly
mean by "append diff line description".  Whatever that means, if
that is purely informational and does not affect what is actually
submit in the resulting cl, then the patch would be an improvement.
If not, and if for example it loses changes to binary files, then it
is merely sweeping the problem under the rug.

In short the explanation of the solution does not build confidence
in the readers minds.  You'd need to explain why such a skipping is
a safe thing to do a bit better.

Even if we assuming that what happens in the loop you threw in
try/except block is purely cosmetic and optional thing that does not
affect the correct operation of the program or its outcome,  I
wonder if we can do better.  When you get a decode error, you'd have
an early part of the change (which could be empty) before you hit
the error in newdiff, and that is returned to the caller without any
sign that it is a truncated output.  I wonder something like

	except UnicodeDecodeError:
		newdiff = '<<new binary file>>'

may be more helpful to the user.  Assuming that this is purely for
human consumption without affecting the correctness or outcome of
the program and we can place pretty much any text there, that is.
But because the proposed commit log message does not explain why
skipping is safe, I do not know if that assumption holds in the
first place.

Thanks.

> diff --git a/git-p4.py b/git-p4.py
> index 4433ca53de7e..29a8c202399a 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1977,8 +1977,11 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
>                  newdiff += "+%s\n" % os.readlink(newFile)
>              else:
>                  f = open(newFile, "r")
> -                for line in f.readlines():
> -                    newdiff += "+" + line
> +                try:
> +                    for line in f.readlines():
> +                        newdiff += "+" + line
> +                except UnicodeDecodeError:
> +                    pass # Fond non-text data

s/Fond/Found/ I would think.

>                  f.close()
>  
>          return (diff + newdiff).replace('\r\n', '\n')
>
> base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
