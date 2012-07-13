From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: avoid work after --max-count is reached
Date: Fri, 13 Jul 2012 15:12:47 -0700
Message-ID: <7vwr2771k0.fsf@alter.siamese.dyndns.org>
References: <20120713075023.GA31618@sigill.intra.peff.net>
 <7v7gu78izl.fsf@alter.siamese.dyndns.org>
 <20120713212050.GB10767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 00:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spo6c-0007ig-RO
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 00:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab2GMWMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 18:12:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab2GMWMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 18:12:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49FD86B4;
	Fri, 13 Jul 2012 18:12:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vDArP/2nxO35vANN+L9r+qI3qdQ=; b=EsE8xv
	uiR6LiYLEW3EHe+zID9hSh1JN9dDfWSIaLsM/FTMzFps1YOfPMfNaVYsqVdLtnIA
	ndItRJsU6soGBulag+LHBczE9djj6+hXI1LgGupuGMRUpRk4xaYswwoxWEKEQ4S4
	9cB2yrO5gb+qqgrmBPqeAB6ssKxCHnujLzhMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdeHosKg0htOGx7W5qRxCz1a0jRT22++
	sZ9lP9BXDaMKj0wAKF9Gln47kDDlbDTNsse5pwzZ3Sb9P34Ug5F2X8J6oaG3M4Y6
	/L1WX3kCu570P8AW91w7vlzoDJvsnQ1b4tPrnZHMHgutBBrmkoV2YMEoOlISHTki
	2J0tKYBeV0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C280F86B2;
	Fri, 13 Jul 2012 18:12:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E56E86AD; Fri, 13 Jul 2012
 18:12:49 -0400 (EDT)
In-Reply-To: <20120713212050.GB10767@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 13 Jul 2012 17:20:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1BCE872-CD37-11E1-9530-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201425>

Jeff King <peff@peff.net> writes:

> Yeah, this was my analysis, too. Though reading get_revision-1, it seems
> like we can actually set SHOWN, but I wasn't able to trigger any change
> of behavior in practice. I think it is because we must set both SHOWN
> and BOUNDARY to have an effect, and we do not do so.

In principle, SHOWN is only given when get_revision_internal gives
the commit back to be shown, and the parents of the returned commit
are painted CHILD_SHOWN.  This should be the only place to paint
commit as CHILD_SHOWN.

A handful of places set the bit to commits that would be shown if
some options that further limit what is shown by topological
property (e.g. --left-only, --cherry-pick), which may cause that a
parent of a commit that was omitted due to these conditions may
later be marked incorrectly as a boundary inside
create_boundary_commit_list().

BOUNDARY is only given in create_boundary_commit_list() using
CHILD_SHOWN and SHOWN, and that should happen only once when
get_revision_1() runs out of the commits.

By the way, cherry_pick_list() pays attention to BOUNDARY, but I
think it is written overly defensively to protect itself from future
callsites.  With the current code structure, it is only called from
limit_list() and get_revision_*() functions are never called until
limit_list() returns (and again create_boundary_commit_list() that
is called from get_revision_internal() is the only place that sets
BOUNDARY, so the commits cherry_pick_list() sees would never have
that bit set.

> So the only questionable thing would be: are there commits with BOUNDARY
> set but not SHOWN that could be affected by calling get_revision_1? For
> that matter, if such a commit existed, would the current behavior even
> be correct? We would not have actually shown the commit, so if such a
> case did exist, I wonder if we would be fixing a bug.
