Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F37AC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 05:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiHOFMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 01:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiHOFMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 01:12:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C710EE61
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 22:12:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 503671C7FF1;
        Mon, 15 Aug 2022 01:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=d3SyvbQTNi0uexhkctVT0dBMY
        bXU9lOAcaziUGNJLWI=; b=pB5azR3/17IoESKXkxbTIrVWdDkVMzmrCHR0r+tW+
        HD2wlqpvS/mOSeKQdwsr/KQaSvbwy+FptqBTx1Ivw0rTgE84hNdSN6o7e/PxeWnn
        pFRo58FZ7YwM6fIxF/4zFkAHSJrrxSQkWk35Jpt6MmN0RyvoB1bdHxjU8CA2CSug
        xg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 491A41C7FF0;
        Mon, 15 Aug 2022 01:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ED89C1C7FEE;
        Mon, 15 Aug 2022 01:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mention the magic pathspec ":/"
References: <20220814095253.3422612-1-thomas@t-8ch.de>
Date:   Sun, 14 Aug 2022 22:12:12 -0700
Message-ID: <xmqqsfly3xar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2EE126E-1C58-11ED-A103-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> writes:

Here before your sign-off is the place for you to justify why this
patch is a good idea.

> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> ---
>  Documentation/gitcli.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 1819a5a185..a421855bdb 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -78,6 +78,8 @@ you will.
>     using a '.' as a repository name in Git (a dot-repository) is a rel=
ative
>     path and means your current repository.
> =20
> + * The magic pathspec `:/` refers to the root of the working tree.
> +

This looks somewhat out of place.  Reading the previous entry, I
notice it is about the path to a repository, not about path in your
working tree.  The entry before it is about pathspec, so in a sense,
what is truly out of place is the "dot is how you refer to the
current repository".

I do not quite see why we want to single out ":/", i.e.  the "top"
pathspec magic applied to an empty string, and not talk about the
case when it was applied to non-empty string, e.g.  ":/*.c".  If we
talk about pathspec magic, shouldn't we also talk about "exclude"
magic, e.g. ":!\*.o", here?

Besides, the new description is not exactly correct. The "top"
pathspec magic does not inherently refers to the root.  In

    $ cd sub/dire/ctory && git grep -e pattern

we tell "git grep" to look for patterns in the current directory
and in its subdirectories, and with

    $ cd sub/dire/ctory && git grep -e pattern :/

we lift the "current directory and below" limitation and instead
look for matches everywhere, not limited to the root-level directory.
We can find a patch from sub/foo.txt that is neither in our current
directory or at the root-level directory.

So, I do agree that the users must know more than "Many commands
allow wildcards in paths" (the entry before the "dot is how you can
refer to the current repository"), I do not think singling out ":/"
and refer only to that is a wrong way to go about it for this
document.  The gitcli manual does not even mention 'pathspec', which
is the keyword to effectively find many things to learn in the
glossary ("git help glossary"), and it would be the first thing to
fix here, I would think.

So after reading your patch and thinking about it for a few days,
here is what I think is wrong in the current description, plus its
fix.

Thoughts?

 Documentation/gitcli.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index 1819a5a185..40553fc578 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -57,9 +57,11 @@ When writing a script that is expected to handle rando=
m user-input, it is
 a good practice to make it explicit which arguments are which by placing
 disambiguating `--` at appropriate places.
=20
- * Many commands allow wildcards in paths, but you need to protect
-   them from getting globbed by the shell.  These two mean different
-   things:
+ * Many commands take paths to work on as "pathspec".  A pathspec elemen=
t
+   can be a literal string, which specifies the named path itself, or it
+   can be a wildcard pattern, which specifies all paths that match the
+   pattern.  Wildcards may need to be protected from getting globbed by
+   the shell.  These two mean different things:
 +
 --------------------------------
 $ git restore *.c
@@ -73,6 +75,8 @@ the paths in the index that match the pattern to be che=
cked out to your
 working tree.  After running `git add hello.c; rm hello.c`, you will _no=
t_
 see `hello.c` in your working tree with the former, but with the latter
 you will.
++
+To learn more about pathspec, see linkgit:gitglossary[7].
=20
  * Just as the filesystem '.' (period) refers to the current directory,
    using a '.' as a repository name in Git (a dot-repository) is a relat=
ive
