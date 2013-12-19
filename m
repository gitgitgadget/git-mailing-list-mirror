From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fetch --prune: Repair branchname DF conflicts
Date: Thu, 19 Dec 2013 11:34:51 -0800
Message-ID: <xmqq7gb0fxd0.fsf@gitster.dls.corp.google.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
	<1387401776-30994-3-git-send-email-jackerran@gmail.com>
	<xmqq4n65hlko.fsf@gitster.dls.corp.google.com>
	<20131219014859.GA32240@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 20:35:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtjN7-0001J2-Kj
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 20:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab3LSTe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 14:34:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab3LSTe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 14:34:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 231DE5C7CB;
	Thu, 19 Dec 2013 14:34:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H6RfYSlcuvg1gfkm/SZehXPtxos=; b=DautMz
	3hniJpMLAbv2I49sJtiD7btNA53QoeLQLzjzY1QN2P1Nh44/w6weM9bs0xoldlsC
	SRhT10PMCLhlrqD1ewHK5CIHIltNO4lnXUHliSFu/64dFTbDXPW+EHEQVm0AzJ+x
	O8P8iU8i1InWb4Ti5MD++LxwrtWFqA12cowrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RFjPvHPIUI1pSjeejKYkcDWvw27WJD/B
	ngs2Y/fO3bm9QHd2TiDItr6rPeZqLcip3jwZvvi+LGYnup20APGJPxm2o+xG0dWs
	+iMfdmgGg2wzWfyHdpa5604OmdwRemHX3TRjltnSrl9lXrNMqh+wvDMisY1Y3hOW
	0oBFhLI05UM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0899A5C7CA;
	Thu, 19 Dec 2013 14:34:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C2615C7C9;
	Thu, 19 Dec 2013 14:34:55 -0500 (EST)
In-Reply-To: <20131219014859.GA32240@gmail.com> (Tom Miller's message of "Wed,
	18 Dec 2013 19:48:59 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A348DB2E-68E4-11E3-98EC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239536>

Tom Miller <jackerran@gmail.com> writes:

>> But what should happen when we do not give --prune to "git fetch" in
>> such a situation?  Should it fail, because we still have frotz/nitfol
>> and we cannot create frotz without losing it?
>
> You talk about this to some extent in an email from 2009. I have linked
> it below for your review.
> http://article.gmane.org/gmane.comp.version-control.git/132276

I do not think the old discussion talks about the case.  It was
about "we have remotes/origin/{frotz,nitfol} from the origin from an
earlier fetch, the origin now has updated its frotz and deleted its
nitfol.  'git remote prune' removes our remotes/origin/nitfol
without updating our copy of remotes/origin/frotz, but I do not
think it is sensible.  'git fetch --prune origin' would update both
and make our remote-tracking branches for 'origin' in line with the
reality".  It was not about what 'git fetch' without '--prune'
should do.

Your "'git fetch' without '--prune' should be less destrictive" is a
good guiding principle.  If we have a copy of the 'frotz/nitfol'
branch from the 'origin', removing it so that we can have a new copy
of the 'frotz' branch the 'origin' now has (after it removed
'frotz/nitfol' to make room) is indeed an operation that loses
information.  And it probably is the right thing to do to fail such
a fetch. 'git fetch --prune' on the other hand really means "I do
not care about the branches' histories my 'origin' discarded; bring
me up to date and give me the same view as my 'origin' has in my
remote-tracking branches", so losing 'frotz/nitfol', which the
'origin' already decided to discard, is what the user wants.

The atomicity issue Peff brings up is an interesting and important
one, but I think that is an orthogonal issue.

With the background information from the previous thread between you
and trast, the patch [3/3] looks good to me.

Thanks.
