From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: warn on split packs disabling bitmaps
Date: Wed, 27 Apr 2016 15:56:46 -0700
Message-ID: <xmqqfuu67j9t.fsf@gitster.mtv.corp.google.com>
References: <20160427215324.GA22165@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:56:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avYO6-0002z1-1O
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 00:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbcD0W4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 18:56:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751679AbcD0W4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 18:56:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 450ED16900;
	Wed, 27 Apr 2016 18:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L8zCaA1eu0vDkLwdoykPMMSvu2c=; b=r6S3qi
	VfrxR3g/udeTRQx58TBVDwa9SbzqBWlnUukSql8XAXy9W8Ap41NCinDnCom8w1ML
	jzQo16rfE4seUTbcmy9yt7Aqm2jGrv5i1WjJC35xUJDwARDabT6clYhUfxWUzb0/
	cQ4KI0GZIm1kTnMw8EEfcgcd9/AJweUjjyg7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j67+dfWGxF5IHBVKLt+ntfb/6UUT7OBt
	F1vr8PZWN27cBO/Y5zxsyiS9lUQf7032rw17RV+Y9SfFVPObLnFeeV/F2QqhRwcL
	Sup24zYmF/9121E7F5OM5uKxmgJlwAknk/asAwD/zp18OapVyCtOClwqXTHayL6J
	npKg9EZQrlQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D3E0168FF;
	Wed, 27 Apr 2016 18:56:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A182C168FE;
	Wed, 27 Apr 2016 18:56:47 -0400 (EDT)
In-Reply-To: <20160427215324.GA22165@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 27 Apr 2016 21:53:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 521A54C0-0CCB-11E6-AB6D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292838>

Eric Wong <normalperson@yhbt.net> writes:

> It can be tempting for a server admin to want a stable set of
> long-lived packs for dumb clients; but also want to enable
> bitmaps to serve smart clients more quickly.
>
> Unfortunately, such a configuration is impossible;
> so at least warn users of this incompatibility since
> commit 21134714787a02a37da15424d72c0119b2b8ed71
> ("pack-objects: turn off bitmaps when we split packs").
>
> Tested the warning by inspecting the output of:
>
> 	make -C t t5310-pack-bitmaps.sh GIT_TEST_OPTS=-v

While I do not think the update in this patch is wrong, this makes
me wonder what happens to a server admin who wants a stable set of
long-lived objects in a pack, and other objects in another pack that
is frequently recreated, by first packing objects needed for the
latest released version into a single pack and marking it with .keep
and then running "git repack" to create the second pack for the
remainder.

There is no automatic split involved, so we would get a bitmap file
for each of these two packs.  Would that pose a problem?  The pack
with the newer part of the history would not satisfy "all of the
reachable objects are in the same pack" condition.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 42d2b50..ec31170 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2156,8 +2156,10 @@ pack.packSizeLimit::
>  	The maximum size of a pack.  This setting only affects
>  	packing to a file when repacking, i.e. the git:// protocol
>  	is unaffected.  It can be overridden by the `--max-pack-size`
> -	option of linkgit:git-repack[1]. The minimum size allowed is
> -	limited to 1 MiB. The default is unlimited.
> +	option of linkgit:git-repack[1].  Reaching this limit prevents
> +	pack bitmaps from being written when `repack.writeBitmaps`
> +	is configured.  The minimum size allowed is limited to 1 MiB.
> +	The default is unlimited.

This is not wrong per-se, but I find the additional text overly
verbose.  The resulting text has at least three issues:

 - This sets maximum.  It does not say what happens when the maximum
   is reached ("packing fails" is a valid expectation).  We should
   spell out that when the maximum is reached, we will create
   multiple packfiles.

 - It is not "reaching this limit" that prevents bitmaps from being
   written.  It is "we will create multiple packfiles" that does.

 - Even when repack.writeBitmaps is not configured, but bitmap is
   requested via the command line option "repack -b", bitmap
   generation is disabled once we end up creating multiple
   packfiles.

> @@ -2557,8 +2559,9 @@ repack.writeBitmaps::
>  	objects to disk (e.g., when `git repack -a` is run).  This
>  	index can speed up the "counting objects" phase of subsequent
>  	packs created for clones and fetches, at the cost of some disk
> -	space and extra time spent on the initial repack.  Defaults to
> -	false.
> +	space and extra time spent on the initial repack.  This has
> +	no effect if `pack.packSizeLimit` is configured and reached.
> +	Defaults to false.

This has the opposite issue as the third point above.  We have to
ignore repack.writeBitmaps when we end up splitting a pack,
regardless of the reason why we split was pack.packSizeLimit or by
an explicit request from the command line.

Also to future-proof these two paragraphs (and those that are
touched by later parts of this patch), it may even be a good idea to
omit the mention of packsizelimit altogether.  We may invent a new
and different reason why we end up producing multiple packfiles,
other than packsizelimit.  What this patch wants to make readers
aware is that when multiple packs are generated, bitmap generation
is disabled.  Other details (e.g. how the user asks us to create
multiple packs, either via command line or configuration, or how the
use asks us to generate bitmaps) are of lessor importance.

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index bbea529..19cdcd0 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -110,7 +110,8 @@ base-name::
>  --max-pack-size=<n>::
>  	Maximum size of each output pack file. The size can be suffixed with
>  	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
> -	If specified,  multiple packfiles may be created.
> +	If specified, multiple packfiles may be created, which also
> +	prevents the creation of a bitmap index.

This is a good update, judging with the yardstick I set in the
previous paragraph in this review.

>  	The default is unlimited, unless the config variable
>  	`pack.packSizeLimit` is set.
>  
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index af230d0..2065812 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -106,7 +106,8 @@ other objects in that pack they already have locally.
>  --max-pack-size=<n>::
>  	Maximum size of each output pack file. The size can be suffixed with
>  	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
> -	If specified,  multiple packfiles may be created.
> +	If specified, multiple packfiles may be created, causing
> +	`--write-bitmap-index` and `repack.writeBitmaps` to be ignored.

And this is not.  Just say "bitmap index is not created".

> @@ -115,7 +116,9 @@ other objects in that pack they already have locally.
>  	Write a reachability bitmap index as part of the repack. This
>  	only makes sense when used with `-a` or `-A`, as the bitmaps
>  	must be able to refer to all reachable objects. This option
> -	overrides the setting of `pack.writeBitmaps`.
> +	overrides the setting of `repack.writeBitmaps`.  This option
> +	has no effect if a multiple packfiles are created due to
> +	reaching `pack.packSizeLimit` or `--max-pack-size`.

Dropping "due to ..." makes it perfect.
