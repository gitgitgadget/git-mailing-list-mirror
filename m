From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/6] submodule: Explicit local branch creation in module_clone
Date: Thu, 16 Jan 2014 11:43:44 -0800
Message-ID: <xmqqiotjzp8v.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:43:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sr2-0000kQ-3P
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaAPTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:43:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaAPTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 14:43:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1272B630AA;
	Thu, 16 Jan 2014 14:43:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZIf5fj4JzQU0bx+qfEqrbO8vJp8=; b=ppLE9v
	pEirbGpxt/iukgpIouyAeaqmScEzEiYdIuwG1bPUJzUfYIieBnEqB6dX6QHAlgD5
	uSBxPoa6B5Zpb1h5B0uY/mLb92Bl/zblmizFDDb/hnJOQRpXga20UUPPlY+1505L
	Rhxc+F0xyG05Tn+xwt+N3W0AAhlE8b0IaJ2FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJBK20C9q8f1sAvKT54oS/wMK/wLkngg
	ji4rvPadtn5n3QGoVh+5CVS9fiF4Yi7yjEjjKYj+mDS7L75twhJHQFJS+dt95FA0
	jFu2GoErK8WTV3NjuK6huyQodA5czCnHiSb1PNxirrB1hgTEcTZoCy9ojjGkaEg0
	Iulm2MLneyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F34E3630A9;
	Thu, 16 Jan 2014 14:43:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4814A630A5;
	Thu, 16 Jan 2014 14:43:46 -0500 (EST)
In-Reply-To: <96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
	(W. Trevor King's message of "Wed, 15 Jan 2014 20:10:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 836D0F6A-7EE6-11E3-A1E7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240526>

"W. Trevor King" <wking@tremily.us> writes:

> @@ -817,11 +831,15 @@ cmd_update()
>  
>  		displaypath=$(relative_path "$prefix$sm_path")
>  
> -		if test "$update_module" = "none"
> -		then
> +		case "$update_module" in
> +		none)
>  			echo "Skipping submodule '$displaypath'"
>  			continue
> -		fi
> +			;;
> +		checkout)
> +			local_branch=""
> +			;;
> +		esac

I wonder if there is a way to avoid detaching (and you may need to
update the coddpath that resets the submodule to the commit
specified by the superproject tree) when it is safe to do so.

For an end user, running "submodule update" is similar to running
"git pull" in a project that does not use submodules, expressing "I
want to catch up with the work done by others".  In a working tree
with local changes, we do allow you to run "git pull" as long as
your local changes do not overlap with the work done by others, and
the result of the pull would look as if you did not have any of the
local changes when you ran "git pull" and then you did the local
changes on top of the state that is up-to-date with their work.

Can't we design "submodule update --checkout" to work in a similar
fashion?  The updated superproject may say it wants $oSHA-1 at a
submodule path P, and also its .gitmodules may say that commit is
supposed to be at the tip of branch B=submodule.P.branch in the
submodule repository.  You may locally have advanced that branch in
your submodule repository in the meantime to point at $ySHA-1 while
others worked in the superproject and the submodule, and the
difference $oSHA-1...$ySHA-1 can be considered as the local change
made by you from the perspective of the superproject.

Without thinking things through, if $ySHA-1 matches or is a
descendant of $oSHA-1 (assuming that remote-tracking branch
origin/$B in the submodule does point at $oSHA-1 in either case), it
should be safe to do this update.

And in a situation where you cannot do the checkout safely, it is
perfectly fine to say "the submodules X and Y have local changes;
you cannot do 'submodule update' until you upstream them" and fail
the update, just like we fail a 'git pull' saying "you cannot do
pull until you commit them", no?

Perhaps that kind of "'git submodule update' is parallel to 'git
pull' in the project without submodules" is better done with other
update modes like --rebase or --merge.  If so, how should we explain
what 'submodule update --checkout' is to the end users?  Is it
supposed to be like "git fetch && git checkout origin/master"?
