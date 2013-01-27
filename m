From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch-pack: avoid repeatedly re-scanning pack
 directory
Date: Sun, 27 Jan 2013 12:09:39 -0800
Message-ID: <7vvcaiv14s.fsf@alter.siamese.dyndns.org>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <20130126224043.GB20849@sigill.intra.peff.net>
 <20130127102753.GB4228@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:10:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYYG-0005dH-T4
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab3A0UJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:09:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab3A0UJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:09:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24FEEC51B;
	Sun, 27 Jan 2013 15:09:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZUvgB78xk+Q41RdseaXkCuPZc8=; b=rc/MYc
	h69ApGORLgvJ/29JGpE9P+VdxawiMGUoXcQk6xhcawj7zpQjOKWGMCT4twftnLy4
	W6vBjs554XKK02Biox8WOikbDbF87ZPyDU4qoiuB9dT/ug0t+Wb/IkwdMI02slxL
	t7BKS7BbbJ42Yowb1bOkY8tX4SZIwpf51laY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hIkubfgu/fO1gtM/mE7R+k5LknT7m2nz
	VazIoTIcGDG9eHtdnz1/bnyfNj+EYpB495lOeXEImY9kTczmteT+bG0wjrjLdE1V
	rH4C8Y2y7CxP2EzhYBC4CCvaCVLagq2FAeWHbZU+Mt/U7NrE0yl1lRBc6cG+Dms9
	dPTXXCS/yFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 176C0C51A;
	Sun, 27 Jan 2013 15:09:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78D93C517; Sun, 27 Jan 2013
 15:09:41 -0500 (EST)
In-Reply-To: <20130127102753.GB4228@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 27 Jan 2013 02:27:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C1EAF56-68BD-11E2-9550-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214724>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> When we look up a sha1 object for reading, we first check
>> packfiles, and then loose objects. If we still haven't found
>> it, we re-scan the list of packfiles in `objects/pack`. This
>> final step ensures that we can co-exist with a simultaneous
>> repack process which creates a new pack and then prunes the
>> old object.
>
> I like the context above and what follows it, but I think you forgot
> to mention what the patch actually does. :)
>
> I guess it is:
>
> 	However, in the first scan over refs in fetch-pack.c::everything_local,
> 	this double-check of packfiles is not necessary since we are only
> 	trying to get a rough estimate of the last time we fetched from this
> 	remote repository in order to find good candidate common commits ---
> 	a missed object would only result in a slightly slower fetch.

It is not about a rough estimate nor common commits, though.  The
"everything local" check in question is interested in only one
thing: are we _clearly_ up to date without fetching anything from
them?

Loosening the check may miss the rare case where we race against a
simultaneous repack and will cause us to go to the network when we
do not have to, and it becomes a trade off between the common unracy
case going faster by allowing the "Are we clearly up to date" check
to cheat, at the expense of rare racy cases suffering unnecessary
object transfer overhead.

> 	Avoid that slow second scan in the common case by guarding the object
> 	lookup with has_sha1_file().

This conclusion is correct.

> I had not read this codepath before.  I'm left with a few questions:
>
>  * Why is 49bb805e ("Do not ask for objects known to be complete",
>    2005-10-19) trying to do?  Are we hurting that in any way?

An earlier fetch may have acquired all the necessary objects but may
not have updated our refs for some reason (e.g. fast-forward check
may have fired).  In such a case, we may already have a history that
is good (i.e. not missing paths down to the common history) in our
repository that is not connected to any of our refs, and we can
update our refs (or write to FETCH_HEAD) without asking the remote
end to do any common ancestor computation or object transfer.

That was the primary thing the patch wanted to do.

As a side-effect, we know more objects than just the objects at the
tips of our refs are complete and that may help the later common
history discovery step, but obviously we do not want to dig the
history down to root.  The cutoff value is merely a heuristics
chosen without any deep thought.

>  * Is has_sha1_file() generally succeptible to the race against repack
>    you mentioned?  How is that normally dealt with?

By failing to find, so that the user will restart.  When the caller
really wants to use the object, parse_objects() => read_sha1_file()
=> read_object() is used and we will see the retry.

>  * Can a slow operation get confused if an object is incorporated into
>    a pack and then expelled again by two repacks in sequence?

If it checks "the object should be there" first, wait for a long
time, and then tries to find that object's data, the later access
will go to the parse_objects() callpath and I think it should do the
right thing.  If that slow opearation stops inside read_object(), it
could find it unable to map the loose object file and then unable to
find it in the pack, either.  Is that what you are worried about?
