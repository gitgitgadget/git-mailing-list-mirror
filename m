Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357FCC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiGOVcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiGOVcX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 17:32:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C378224
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 14:32:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BDCD137F9A;
        Fri, 15 Jul 2022 17:32:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s4xeqsnr4Rr8digN4luYmBHLQ7mOZ762or9Yje
        JvVEk=; b=G3BkNCHM/iHCTRfp0+33Y0/D4u19MuUFAgwyvGGYWHuUeaiTd83RZ/
        2MMMlaDK9suiOwlfC2SThGrrB5hwWtNZLdXdmNb6H2tH93WeU3AVDntmDEerqavv
        lHic6w1v4QcwoVGeEBVseicGGbtJIVpur/ltC/aojYaJhIjG3u4iU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84189137F99;
        Fri, 15 Jul 2022 17:32:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F31E8137F92;
        Fri, 15 Jul 2022 17:32:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org, Konstantin Khomoutov <kostix@bswap.ru>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] Add note that conflict resolution is still performed
References: <xmqq35f6fe0j.fsf@gitster.g>
        <20220715092527.1567837-1-mail@beyermatthias.de>
Date:   Fri, 15 Jul 2022 14:32:18 -0700
In-Reply-To: <20220715092527.1567837-1-mail@beyermatthias.de> (Matthias
        Beyer's message of "Fri, 15 Jul 2022 11:25:27 +0200")
Message-ID: <xmqq35f2ysd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B3EFD0A-0485-11ED-BE54-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Beyer <mail@beyermatthias.de> writes:

> We should note that conflict resolution is still performed, even if
> `--no-rerere-autoupdate` is specified, to make sure users do not get
> confused by the setting and assume this disables rerere conflict
> resultion altogether.
>
> CC: Phillip Wood <phillip.wood@dunelm.org.uk>
> CC: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Matthias Beyer <mail@beyermatthias.de>
> ---
>  Documentation/git-cherry-pick.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 78dcc9171f..b92aa1f9da 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -160,6 +160,10 @@ effect to your index in a row.
>  --no-rerere-autoupdate::
>  	Allow the rerere mechanism to update the index with the
>  	result of auto-conflict resolution if possible.
> +	The `--no-rerere-autoupdate` option does not prevent the conflict
> +	resolution, but prevents the index from being updated. This gives the
> +	user a chance for a final sanity check before using linkgit:git-add[1]
> +	to add the result.

$ git grep -l "^--rerere-autoupdate::" Documentation
Documentation/git-am.txt
Documentation/git-cherry-pick.txt
Documentation/git-merge.txt
Documentation/git-rebase.txt
Documentation/git-revert.txt

I made a cursory scan of these and I suspect the existing two-line
description are shread among all of them.  At this point it may make
sense to split the description to a separate file to be included by
these places (the attached patch may be a starting point) in a
patch, and then follow up with the text change in a follow-up patch.

A tangent that may be worth thinking about, that does not have to be
part of this topic (as it probably will involve code change).

It makes sense that "--no-rerere-autoupdate" does not disable the
"rerere" mechanism (when it is enabled, of course), because it makes
sense to reuse recorded resolution without updating the index with
the result.

However, it may make sense to have "--rerere-autoupdate" option to
enable the "rerere" mechanism when it is disabled, because with
"rerere" disabled, there is nothing to auto-update.

Anyway, here is the preliminary restructuring patch.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] doc: consolidate --rerere-autoupdate description

The `--rerere-autoupdate` option is shared across 5 commands, and
are described the same way because it works exactly the same way in
these commands.

Create a separate file and include it from the help pages for these
commands, so that we can improve the description at one place to
improve all of them at once, and keep them in sync.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.txt          | 5 +----
 Documentation/git-cherry-pick.txt | 5 +----
 Documentation/git-merge.txt       | 5 +----
 Documentation/git-rebase.txt      | 5 +----
 Documentation/git-revert.txt      | 5 +----
 Documentation/rerere-options.txt  | 4 ++++
 6 files changed, 9 insertions(+), 20 deletions(-)

diff --git c/Documentation/git-am.txt w/Documentation/git-am.txt
index 09107fb106..320da6c4f7 100644
--- c/Documentation/git-am.txt
+++ w/Documentation/git-am.txt
@@ -112,10 +112,7 @@ default.   You can use `--no-utf8` to override this.
 	am.threeWay configuration variable. For more information,
 	see am.threeWay in linkgit:git-config[1].
 
---rerere-autoupdate::
---no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+include::rerere-options.txt[]
 
 --ignore-space-change::
 --ignore-whitespace::
diff --git c/Documentation/git-cherry-pick.txt w/Documentation/git-cherry-pick.txt
index 78dcc9171f..1e8ac9df60 100644
--- c/Documentation/git-cherry-pick.txt
+++ w/Documentation/git-cherry-pick.txt
@@ -156,10 +156,7 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+include::rerere-options.txt[]
 
 SEQUENCER SUBCOMMANDS
 ---------------------
diff --git c/Documentation/git-merge.txt w/Documentation/git-merge.txt
index 3125473cc1..fee1dc2df2 100644
--- c/Documentation/git-merge.txt
+++ w/Documentation/git-merge.txt
@@ -90,10 +90,7 @@ invocations. The automated message can include the branch description.
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+include::rerere-options.txt[]
 
 --overwrite-ignore::
 --no-overwrite-ignore::
diff --git c/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
index a872ab0fbd..ff0b643ec0 100644
--- c/Documentation/git-rebase.txt
+++ w/Documentation/git-rebase.txt
@@ -376,10 +376,7 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+include::rerere-options.txt[]
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
diff --git c/Documentation/git-revert.txt w/Documentation/git-revert.txt
index 8463fe9cf7..0105a54c1a 100644
--- c/Documentation/git-revert.txt
+++ w/Documentation/git-revert.txt
@@ -112,10 +112,7 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+include::rerere-options.txt[]
 
 --reference::
 	Instead of starting the body of the log message with "This
diff --git c/Documentation/rerere-options.txt w/Documentation/rerere-options.txt
new file mode 100644
index 0000000000..8f4849e272
--- /dev/null
+++ w/Documentation/rerere-options.txt
@@ -0,0 +1,4 @@
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
