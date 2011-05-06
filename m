From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Fri, 06 May 2011 15:59:20 -0700
Message-ID: <7vbozfxwon.fsf@alter.siamese.dyndns.org>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
 <20110506223847.GC17848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 00:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITzv-0004Od-Qn
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1EFW7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:59:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab1EFW73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:59:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B25F44DC;
	Fri,  6 May 2011 19:01:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pZg3u9ZAcZanc7rrnPpC75QmRqU=; b=YQzA9X
	h9pHlZr7RwccEEI8SgKOab5HkEBV6ZhLwppRLVOg7GRkA/f1buPtXKO+xX7Jkodi
	j47XkD13BTMjBmJ1S6DwWTYHJf0jxnU3FMjFzqdZZHBhp3qf8t20m3dXkVJYnwHv
	EQyZe58ve9BI2C0SB5PvE4X+KzPXfgB6SreFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aIy995sWc38WF5fr44EF+eqaGuqIm4TL
	aZ3SIcyOiACF+m45LHBrOeP7cG27edo5gTYaZbuN+1ubrBWnUku0xGjldQ5eDvSM
	rAbg0TW6EDRHNWNZ6wm1xUGCrNQoeYCTar0D2+eOIQbkQXnd8gmx36XsJ7d8xdH8
	HxZp9mcf2ZE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08E8C44DB;
	Fri,  6 May 2011 19:01:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E969844DA; Fri,  6 May 2011
 19:01:25 -0400 (EDT)
In-Reply-To: <20110506223847.GC17848@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 May 2011 18:38:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6C47C00-7834-11E0-A165-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173026>

Jeff King <peff@peff.net> writes:

> On Fri, May 06, 2011 at 01:35:37PM -0700, Junio C Hamano wrote:
>
>> When switching away from a detached HEAD with "git checkout", we give a
>> final warning to tell how to resurrect the commits being left behind since
>> 8e2dc6a (commit: give final warning when reattaching HEAD to leave commits
>> behind, 2011-02-18) rather loudly.
>> 
>> This is a good safety measure for people who are not comfortable with the
>> detached HEAD state, but the warning was given even to those who set the
>> advice.detachedHead to false to decline the warning given when detaching,
>> resulting in an asymmetric experience.  Silent when going detached, and
>> very loud when coming back.
>
> I'm somewhat negative on this. I think there are actually 5 distinct
> pieces of information that git currently gives in going to and from a
> detached HEAD, and the motivations for suppressing them may be
> different:
>
>   1. On detaching, we indicate briefly that the HEAD has been detached
>      by saying "HEAD is now at ..." instead of "Switched to branch ...".
>
>   2. On detaching, we give a large warning on what the detached HEAD
>      state means, and advise on how to get out of it.
>
>   3. On leaving, if there are no orphaned commits, we indicate briefly
>      where the previous HEAD position was with "Previous HEAD position
>      was...".
>
>   4. On leaving, if there are orphaned commits, we list them.
>
>   5. On leaving, if there are orphaned commits, we give advice on how to
>      make branches out of them.
>
> Right now, advice.detachedhead suppresses (2); that is, we leave the
> short indicator that provides distinct per-use information to the user
> (1), but suppress the lengthy advice that is not helpful to advanced
> user.
>
> So if you wanted symmetry, I think that would mean suppressing (5), but
> leaving (4), which contains per-use information, intact.

The patch does leave per-use information by giving 3. "HEAD was" as you
noted above, and that is more than sufficient (you can also look at
HEAD@{0}).  If and only if the list is needed (i.e. the user wants to
recover), the user can run "git log $that_commit".

> I can also see somebody wanting to suppress (4), either because it takes
> too much time to compute, or because even though there is distinct
> information in the message, it is lengthy. But I think that should be a
> separate knob.

Ok, then a separate configuration that is.

> I tend to think (3) is now just useless.

Quite the contrary. If you do not want to pay the price of (4) that is
useless most of the time, (3) is a cheap, space efficient and useful
information that is essential to allow you to get rid of (4) without
having to look at reflog.
