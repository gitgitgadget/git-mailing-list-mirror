From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Sun, 20 Jun 2010 11:04:42 -0700
Message-ID: <7vzkyptwat.fsf@alter.siamese.dyndns.org>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006170239.01951.johan@herland.net> <4C1A8FDC.7010309@web.de>
 <201006181140.16652.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 20 20:05:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQOtG-0000W7-Fj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 20:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab0FTSE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 14:04:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab0FTSE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 14:04:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6439BBD5BF;
	Sun, 20 Jun 2010 14:04:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z+lCIyV1F/4EEBI5NaETHoLc5AA=; b=s98ZUt
	vSho5dfOC/1eaLlJ8dk2UblnqltnR6uhzmshO7MZGvTpXoMi2FYO5BQ28Mhg4Thj
	5qPMb1lrkytEqitM0pEFtPTR5v1oCqScPWtfBU8qV3ZOu9OKonmjUyG16yccnvs2
	G8QcDa+6cBCy0LDf4P0WAzUR2v74HY6SO6wQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UL9wgDjWQerQbiDVUWVQv+gFPDo2A6xK
	VG5w+T+DzZCDuQRqSNYnxc6xQELTOhx8ugVfUtfQDp+oDADjkCEbYj6XbBsDPZ6A
	m0JYhA/Iq99YR8KNHr2D52P8cscSeyw6JL4UFPRtXRvPUUbbauoNn9JG0vLLIZzO
	Srbssn0wg1w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23EE7BD5B7;
	Sun, 20 Jun 2010 14:04:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FAF5BD5B6; Sun, 20 Jun
 2010 14:04:43 -0400 (EDT)
In-Reply-To: <201006181140.16652.johan@herland.net> (Johan Herland's message
 of "Fri\, 18 Jun 2010 11\:40\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 510DC6C8-7C96-11DF-93D9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149401>

Johan Herland <johan@herland.net> writes:

> On Thursday 17 June 2010, Jens Lehmann wrote:
> ...
>> And no 'special' branch is used here.
>
> Well, you need to traverse _some_ submodule ref(s) in order to find 'E' at 
> all. My argument is that there may also be _other_ submodule refs that 
> contain merges of 'B' and 'F' as well, and they should _also_ be considered 
> as valid candidates for the resolution in '5'. I would in fact argue that 
> you should traverse _all_ submodule refs (maybe even including remote-
> tracking refs) to look for merges of 'B' and 'F' [1], and present them all 
> as equal alternatives.
>
> Consider for example this submodule scenario:
>
>         -----------G      [maint]
>        /          /
>    ---B--------  /        [feature_a]
>   /    \       \/
>  A--C---D---E  /\         [master]
>      \     /  /  \
>       ----F---    \       [feature_b]
>               \    \
>                --H--I--J  [next]
>
> If there exist multiple merges that resolve 'B' and 'F' (in this case: 'G', 
> 'E' and 'I'), then all of those should be presented as equal alternatives to 
> the user.

You lost me completely here.

I thought you were going to argue that it would be an utterly wrong thing
to suggest E or I as a probably resolution if the superproject merge that
needs to merge superproject commits that binds B and F as its submodules
is being done in the context of advance 'maint' track of the superproject.

Think of 'D' as a commit that corresponds to a major version bump point of
the superproject; i.e. it introduces a major change to the submodule.  In
the 'maintenance track' of the superproject for maintaining the previous
version, you don't want to have any commit that has 'D' as an ancestor.

For an "automated" heuristics based on "find common descendants" to make
sense, the branches you are merging have to share the common purpose, and
you need to limit the common descendants you find to the ones that are
compatible with the shared purpose.  The purpose of 'maintenance track'
may be to maintain the previous version without dragging newer and more
exciting things that happened in the later development.  In the above
picture, G (that has nothing but B and F) is the only commit that can be
safely assumed that two commits in the superproject space that bind B and
F respectively can use as the submodule as their merge result.  E and I
are contaminated with D and H whose purpose in the superproject space is
unknown without further hint.
