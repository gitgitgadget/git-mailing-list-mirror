From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Fri, 28 Feb 2014 10:09:08 -0700
Message-ID: <2E523500-558A-42CF-A761-618DD2821347@codeaurora.org>
References: <20140124022822.GC4521@sigill.intra.peff.net> <52E1D39B.4050103@fb.com> <20140128060954.GA26401@sigill.intra.peff.net> <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com> <20140224082459.GA32594@sigill.intra.peff.net> <xmqq1tys9vie.fsf@gitster.dls.corp.google.com> <20140226101353.GA25711@sigill.intra.peff.net> <xmqqr46p39cj.fsf@gitster.dls.corp.google.com> <20140227112734.GC29668@sigill.intra.peff.net> <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com> <20140228085546.GA11709@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Siddharth Agarwal <sid0@fb.com>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQw3-0001P5-7I
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbaB1RJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:09:14 -0500
Received: from smtp.codeaurora.org ([198.145.11.231]:43285 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbaB1RJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 12:09:13 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id D95B513EF50;
	Fri, 28 Feb 2014 17:09:12 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id CB08913F066; Fri, 28 Feb 2014 17:09:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from nasserg1-mac.wlan.qualcomm.com (proxy6-global253.qualcomm.com [199.106.103.253])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nasser@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EDD113EF78;
	Fri, 28 Feb 2014 17:09:10 +0000 (UTC)
In-Reply-To: <20140228085546.GA11709@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1827)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242988>

On Feb 28, 2014, at 1:55 AM, Jeff King <peff@peff.net> wrote:

> On Thu, Feb 27, 2014 at 10:04:44AM -0800, Junio C Hamano wrote:
> 
>> I wonder if it makes sense to link it with "pack.writebitmaps" more
>> tightly, without even exposing it as a seemingly orthogonal knob
>> that can be tweaked, though.
>> 
>> I think that is because I do not fully understand the ", because ..."
>> part of the below:
>> 
>>>> This patch introduces an option to disable the
>>>> `--honor-pack-keep` option.  It is not triggered by default,
>>>> even when pack.writeBitmaps is turned on, because its use
>>>> depends on your overall packing strategy and use of .keep
>>>> files.
>> 
>> If you ask --write-bitmap-index (or have pack.writeBitmaps on), you
>> do want the bitmap-index to be written, and unless you tell
>> pack-objects to ignore the .keep marker, it cannot do so, no?
>> 
>> Does the ", because ..." part above mean "you may have an overall
>> packing strategy to use .keep file to not ever repack some subset of
>> the objects, so we will not silently explode the kept objects into a
>> new pack"?
> 
> Exactly. The two features (bitmaps and .keep) are not compatible with
> each other, so you have to prioritize one. If you are using static .keep
> files, you might want them to continue being respected at the expense of
> using bitmaps for that repo. So I think you want a separate option from
> --write-bitmap-index to allow the appropriate flexibility.

Has anyone thought about how to make them compatible? We're using Martin Fick's git-exproll script which makes heavy use of keeps to reduce pack file churn. In addition to the on-disk benefits we get there, the driving factor behind creating exproll was to prevent Gerrit from having two large (30GB+) mostly duplicated pack files open in memory at the same time. Repacking in JGit would help in a single-master environment, but we'd be back to having this problem once we go to a multi-master setup.

Perhaps the solution here is actually something in JGit where it could aggressively try to close references to pack files, but that still doesn't help the disk churn problem. As Peff says below, we would want to repack often to get up-to-date bitmaps, but ideally we could do that without writing hundreds of GBs to disk (which is obviously worse when "disk" is a NFS mount).

> 
> The default is another matter.  I think most people using .bitmaps on a
> server would probably want to set repack.packKeptObjects.  They would
> want to repack often to take advantage of the .bitmaps anyway, so they
> probably don't care about .keep files (any they see are due to races
> with incoming pushes).
> 
> So we could do something like falling back to turning the option on if
> --write-bitmap-index is on _and_ the user didn't specify
> --pack-kept-objects. The existing default is mostly there because it is
> the conservative choice (.keep files continue to do their thing as
> normal unless you say otherwise). But the fallback thing would be one
> less knob that bitmap users would need to turn in the common case.
> 
> Here's the interdiff for doing the fallback:
> 
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3a3d84f..a8ddc7f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2139,7 +2139,9 @@ repack.usedeltabaseoffset::
> repack.packKeptObjects::
> 	If set to true, makes `git repack` act as if
> 	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
> -	details. Defaults to false.
> +	details. Defaults to `false` normally, but `true` if a bitmap
> +	index is being written (either via `--write-bitmap-index` or
> +	`pack.writeBitmaps`).
> 
> rerere.autoupdate::
> 	When set to true, `git-rerere` updates the index with the
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 49947b2..6b0b62d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -9,7 +9,7 @@
> #include "argv-array.h"
> 
> static int delta_base_offset = 1;
> -static int pack_kept_objects;
> +static int pack_kept_objects = -1;
> static char *packdir, *packtmp;
> 
> static const char *const git_repack_usage[] = {
> @@ -190,6 +190,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
> 				git_repack_usage, 0);
> 
> +	if (pack_kept_objects < 0)
> +		pack_kept_objects = write_bitmap;
> +
> 	packdir = mkpathdup("%s/pack", get_object_directory());
> 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
> 
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index f8431a8..b1eed5c 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -21,7 +21,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
> 	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
> 		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
> 	mv pack-* .git/objects/pack/ &&
> -	git repack -A -d -l &&
> +	git repack --no-pack-kept-objects -A -d -l &&
> 	git prune-packed &&
> 	for p in .git/objects/pack/*.idx; do
> 		idx=$(basename $p)
> @@ -35,9 +35,9 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
> 	test -z "$found_duplicate_object"
> '
> 
> -test_expect_success '--pack-kept-objects duplicates objects' '
> +test_expect_success 'writing bitmaps duplicates .keep objects' '
> 	# build on $objsha1, $packsha1, and .keep state from previous
> -	git repack -Adl --pack-kept-objects &&
> +	git repack -Adl &&
> 	test_when_finished "found_duplicate_object=" &&
> 	for p in .git/objects/pack/*.idx; do
> 		idx=$(basename $p)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
