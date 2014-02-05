From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 12:57:14 -0800
Message-ID: <xmqqfvnx2s7p.fsf@gitster.dls.corp.google.com>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
	<20140205011632.GA3923@sigill.intra.peff.net>
	<xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
	<20140205201243.GA16899@sigill.intra.peff.net>
	<xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
	<20140205203740.GA17077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:57:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9XI-0003Mn-7s
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbaBEU5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:57:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194AbaBEU5R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:57:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3F0E699B5;
	Wed,  5 Feb 2014 15:57:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K1zvJZC86DA6Q/rnVUbBrKLZioQ=; b=aMFbb5
	EWcfwOIkXM2GJ6eAPwZLBbxlgI+FZLiG2VQo+7TwcEI1fYrch+/rn5ippdEhVnAC
	cN/I95i89Yyv65ws7bROxhnpTYMyagTdsH7idAL28Lcv6Nl9OGGQ2kgeGAoerVdy
	fSTr2T6AFGoWBTxIljl2VuEk/WygS1SOboxu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FiBj3MJ+oKLvG9k+uggpnvD2i75hAW9B
	FtvrXJ7poWRre+gXwscYdWXfdOrALZ3fI3E+igSEP9hUZCi/gtiU/fp4UxdUw05p
	3otI9gV5g6Rb3f3eeCZzHcApTp9HNyaeWM9C6Ak3FZDYRtkwli2U2NggdeBq5RjR
	bntfgO4iMGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFB03699B3;
	Wed,  5 Feb 2014 15:57:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA2C6699B1;
	Wed,  5 Feb 2014 15:57:15 -0500 (EST)
In-Reply-To: <20140205203740.GA17077@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 15:37:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18023760-8EA8-11E3-B086-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241660>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 05, 2014 at 12:31:34PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > The minimal fix you posted below does make sense to me as a stopgap, and
>> > we can look into dropping the code entirely during the next cycle. It
>> > would be nice to have a test to cover this case, though.
>> 
>> Sounds sensible.  Run "repack -a -d" once, and then another while
>> forcing it to be single threaded, or something?
>
> Certainly that's the way to trigger the code, but doing this:
>
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index b45bd1e..6647ba1 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -162,7 +162,12 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
>  	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
>  	git repack -a -d &&
>  	git cat-file -t $H1
> -	'
> +'
> +
> +test_expect_success 'repack can handle generating the same pack again' '
> +	git -c pack.threads=1 repack -ad &&
> +	git -c pack.threads=1 repack -ad
> +'
>  
>  test_done
>  
>
> ...does not seem to fail, and it does not seem to leave any cruft in
> place. So maybe I am misunderstanding the thing the patch is meant to
> fix. Is it that we simply do not replace the pack in this instance?

Yes.  Not just the command finishing OK, but the packfile left by
the first repack needs to be left intact.  One bug was that after
learning that a new packfile XXXX needs to be installed, the command
did not check existing .git/objects/pack/pack-XXXX.{pack,idx}, but
checked .git/objects/pack/XXXX.{pack,idx}, deciding that there is
nothing that needs to be saved by renaming with s|pack-|old-|.  This
would have caused it to rename the new packfile left by pack-object
at .git/objects/pack/.tmp-$pid-pack-XXXX.{pack,idx} directly to the
final .git/objects/pack/pack-XXXX.{pack,idx}, which would work only
on filesystems that allow renaming over an existing file.

Another bug fixed by Torsten was in the codepath to roll the rename
back from .git/objects/pack/old-XXXX.{pack,idx} to the original (the
command tried to rename .git/objects/pack/old-pack-XXXX.{pack,idx}
which would not have been the ones it renamed), but because of the
earlier bug, it would never have triggered in the first place.

> I guess we would have to generate a pack with the identical set of
> objects, then, but somehow different in its pack parameters (perhaps
> turning off deltas?).

Unfortunately, that would trigger different codepath on v1.9-rc0 and
later with 1190a1ac (pack-objects: name pack files after trailer
hash, 2013-12-05), as it is likely not to name the packfiles the
same.

We could use test-chmtime to reset the timestamp of the packfile
generated by the first repack to somewhere reasonably old and then
rerun the repack to see that it is a different file, which may be
more portable than inspecting the inum of the packfile.
