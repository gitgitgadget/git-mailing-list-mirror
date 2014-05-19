From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Mon, 19 May 2014 14:08:42 -0700
Message-ID: <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 23:08:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmUnk-00081T-H0
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 23:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbaESVIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 17:08:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59994 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbaESVIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 17:08:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 872B3195C7;
	Mon, 19 May 2014 17:08:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TqanrOIJDm9GBDng/pBmPvItaD0=; b=fGNky8
	/TxXRzGqOoN56gbElqai8VVt0V/ObwR7iDVt+HouLW0bbVNRvgFHtpisoUmWRN4q
	i8tHWCOVLBB+/hLMyIxb3wlJ3wcw4aSyHbp9WmxhekJg4mYjs2+eCrV9NlPuC+rT
	hEvBYUVcdfAOA83SZIyz408URx1KmteIA5pBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dC443BFq+jar+5O566a2tKlFyGZafV8N
	2jHCWePW6KAFGiT77CVATFpdpVRd2o0F/5hmY1kvGNKTrn3XsmaiFNrFz3E/ItY8
	MyLdECnV/7tz2Q567XCuVyt4q4MFRLXsoYLZHzgPgg2ae/4dCbdW8mWYeoUYFbrN
	SfuSkx/XjQc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7855E195C6;
	Mon, 19 May 2014 17:08:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 568E7195C2;
	Mon, 19 May 2014 17:08:44 -0400 (EDT)
In-Reply-To: <53795175664d5_10da88d308ce@nysa.notmuch> (Felipe Contreras's
	message of "Sun, 18 May 2014 19:33:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C2DF02C0-DF99-11E3-B8B5-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249621>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> ...
> Which will generate the integration instructions for you:
>
>   % git reintegrate --cat
>   base master
>   merge jl/submodule-mv
>
>     Moving a regular file in a repository with a .gitmodules file was
>     producing a warning 'Could not find section in .gitmodules where
>     path=<filename>'.
>
>   merge ap/remote-hg-unquote-cquote
>
> It also has support for "evil merges", so it should be perfectly
> usable for git.git maintenance.

Yeah, it sounds like it is almost there.

I think the infrastructure to maintain "What's cooking" could be
updated to use these comments after "merge" instructions if I wanted
to.

I build two branches on top of 'master', one is called 'jch' and has
a marker line somewhere that says '### match next' that is turned
into an empty commit, and 'pu' that is built on top of the tip of
'jch'.  The marker line is used to apply only an earlier part of the
instruction stream to build 'jch' on top of 'master' on top of
'next' (i.e. "base master" in the above example will not be applied
to hard-reset 'next' to match master) and stop there, and is meant
to be a way to sanity check 'next' (which is made by repeated
incremental merges on top of 'master' without rewinding) by
comparing the "### match next" commit between 'master' and 'jch'
(which is made afresh from 'master' by taking only the necessary
topics).  They must match or I caught a possible mismerge on 'next'.

I presume that the workflow can be mimicked by having another branch
'match-next' and building it on top of 'master', and then building
'jch' on top of it, and then building 'pu' on top of it.  Then you
should be able to play 'match-next' instruction on top of 'next'
(provided that there is a way to tell it to replay on HEAD and
ignore "base" and have "merge" instruction become a no-op when the
branch has already been merged).

Fun.
