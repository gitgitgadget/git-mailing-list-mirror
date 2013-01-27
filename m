From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Sat, 26 Jan 2013 22:32:42 -0800
Message-ID: <7vlibfxhit.fsf@alter.siamese.dyndns.org>
References: <20130126224011.GA20675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 27 07:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzLng-00015w-Ah
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 07:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab3A0Gcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 01:32:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755925Ab3A0Gcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 01:32:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D4C4B56A;
	Sun, 27 Jan 2013 01:32:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zkdeaVyS+8TS1cK0JTLJAXyV1FU=; b=GR6ARx
	d4WARhAZuXar6myrITqueeAe1AIIcRmyOjYBfA1oJA0qsq6f6iyR/oO9asAAd9dC
	p81rrl6a3ajI5eMtvRmyvMhhbDBP2hAwuQqS8BdNPHEeXrUnEpROz7rtTiT6ZxOF
	mHKvmfaekT1t7+3RSs4o7Fe+fdLtr0GKGm/dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZHJuS9bsIHzvXUsl5c+gLMQTzVZHaO/
	/Q8tj7+7LBPYEfrUjyeQME0+kiE/L90k7SaFIy9fXawF3a3FNgpJa2xXsZoOsyIY
	OaoFfjUl/7Z/Z4cF8dYXNsJIzdeFXeTV5H8Y1SGAMtGsgEywsH4MVcFc6mokHAy7
	1BSYv4mMeQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7191AB569;
	Sun, 27 Jan 2013 01:32:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00B97B567; Sun, 27 Jan 2013
 01:32:43 -0500 (EST)
In-Reply-To: <20130126224011.GA20675@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Jan 2013 17:40:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B6B0BF0-684B-11E2-94B0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214683>

Jeff King <peff@peff.net> writes:

> This is a repost from here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/211176
>
> which got no response initially. Basically the issue is that read-only
> repos (e.g., a CI server) whose workflow is something like:
>
>   git fetch $some_branch &&
>   git checkout -f $some_branch &&
>   make test
>
> will never run git-gc, and will accumulate a bunch of small packs and
> loose objects, leading to poor performance.
>
> Patch 1 runs "gc --auto" on fetch, which I think is sane to do.
>
> Patch 2 optimizes our pack dir re-scanning for fetch-pack (which, unlike
> the rest of git, should expect to be missing lots of objects, since we
> are deciding what to fetch).
>
> I think 1 is a no-brainer. If your repo is packed, patch 2 matters less,
> but it still seems like a sensible optimization to me.
>
>   [1/2]: fetch: run gc --auto after fetching
>   [2/2]: fetch-pack: avoid repeatedly re-scanning pack directory
>
> -Peff

Both makes sense to me.

I also wonder if we would be helped by another "repack" mode that
coalesces small packs into a single one with minimum overhead, and
run that often from "gc --auto", so that we do not end up having to
have 50 packfiles.

When we have 2 or more small and young packs, we could:

 - iterate over idx files for these packs to enumerate the objects
   to be packed, replacing read_object_list_from_stdin() step;

 - always choose to copy the data we have in these existing packs,
   instead of doing a full prepare_pack(); and

 - use the order the objects appear in the original packs, bypassing
   compute_write_order().

The procedure cannot be a straight byte-for-byte copy, because some
objects may appear in multiple packs, and extra copies of the same
object have to be excised from the result.  OFS_DELTA offsets need
to be adjusted for objects that appear later in the output and for
objects that were deltified against such an object that recorded its
base with OFS_DELTA format.

But other than such OFS_DELTA adjustments, it feels that such an
"only coalesce multiple packs into one" mode should be fairly quick.
