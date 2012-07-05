From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] Teach rm to better handle submodules
Date: Wed, 04 Jul 2012 17:44:49 -0700
Message-ID: <7vpq8brq7y.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 02:45:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmaCL-0002Jx-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 02:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2GEAow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 20:44:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab2GEAow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 20:44:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54ADE8348;
	Wed,  4 Jul 2012 20:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L66hNtlJTWVOM0fdhpzbk817q08=; b=uAkb0Y
	aaWQa6eOT/XeI3CT8lFuignoo6JhqWeT0nush5+LFSYdqzAmk+H5U1xHMocFEI/1
	qZxI1BOOcS+Qy6lN+IORs00GNe3PG/e/5EKV9VpwO+t2Qd46rDGBaQvpKmpOCJmX
	X7idHJJYky6zsUfuzKdcA07IbOAx8GvBrRL+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bUse5xfv8rZxJJHVykuaSxlXn6KzNAMV
	Z3qClxriWuoaupiGLOgG5EvodBHTNXLvqQiNVIC7fTE+L5IR45lRrjph5sOnHs7f
	ziz3hkLDvckaNI627p7T9w/dziINi6bRBNPj0ygN2+WgvzFf9FmR4nQGGOd0A77u
	1X0UeXv6Wuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C0908347;
	Wed,  4 Jul 2012 20:44:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7C658346; Wed,  4 Jul 2012
 20:44:50 -0400 (EDT)
In-Reply-To: <4FF4AAE7.40604@web.de> (Jens Lehmann's message of "Wed, 04 Jul
 2012 22:43:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0E060B2-C63A-11E1-BB79-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201018>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This is a follow-up to gmane thread 200564 about teaching "git
> submodule" the "rm" command. It has the intention to only having
> to add a small amount of new code to the submodule script while
> handling the heavy lifting in core git.
>
> With this series I also intend to make submodule handling a bit
> easier for users by teaching "git rm" to remove the submodule
> section from the .gitmodules file, no matter if the submodule is
> populated or not. Not being able to do that because the section
> is not found there or the .gitmodules file is already deleted
> will only issue a warning (with the intent to make the user aware
> that "git rm" would do that for him in case he did that himself).

I wouldn't claim that I have thought things through yet, but in
general my instinct tells me that it is a bad idea to try pushing
down "submodule management" related bits to the core.

Let me think aloud about removing a directory, in a checkout of a
superproject, that has a submodule checkout.  There are at least two
majorly different reasons a user wants to do this:

 (1) The project used to bind a submodule as a part of the
     superproject there, but it no longer wants to do so (e.g. we
     used to ship compiler toolchain as part of our embedded
     appliance superproject, but from this release on, we expect
     developers to install the toolchain on their own).  We want to
     remove the submodule directory, we want to remove the submodule
     entry in the superproject's tree, and we want to remove the
     submodule entry from .gitmodules file.

 (2) One particular project participant has been working on one part
     of the superproject, say "the documentation submodule", hence
     "submodule init" was used for that submodule part to populate
     it.  Since the participant has done with the work, there is no
     longer need to keep the submodule checkout (submodule uninit?),
     and getting rid of it makes the working tree leaner and "git
     pull" faster (as there is no longer need to fetch updated
     history in the uninteresting submodule).  We just want to
     remove the contents of the submodule directory.  We do want to
     keep the index entry for the submodule in the superproject.  We
     do want to keep the .gitmodules intact.

This kind (1) of reorganization hopefully is rare (in other words,
you wouldn't drop a submodule today and turn around to add it again
tomorrow), done by one person and the result is propagated to all
other project participants.  On the other hand, (2) can be done by
any and all participants of the project at any time.

Which audience should "git rm $path" serve?  My gut feeling is that
the "project structure change" part that goes beyond the core
(e.g. what is in ".gitmodules") and should be a rare flag-day event
deserves a separate command, if only to make the user aware that the
user is invoking a heavy-weight (from the point-of-view of the
workflow) operation.

I am not convinced that "git rm $path" is a good interface for (2),
though.  For one thing, you would need to keep an empty directory at
the submodule path for the purpose of (2), so it is not really "rm".

Perhaps "git submodule uninit" might be needed to support (2), in
addition to "git submodule rm" to support (1).
