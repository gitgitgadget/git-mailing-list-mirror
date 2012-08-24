From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 11:32:14 +0200
Message-ID: <87sjbceiu9.fsf@thomas.inf.ethz.ch>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
	<878vd5k7uu.fsf@thomas.inf.ethz.ch>
	<7vd32h4h1t.fsf@alter.siamese.dyndns.org>
	<7v393d49xs.fsf@alter.siamese.dyndns.org>
	<7vy5l52ueg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:32:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4qFe-0002k4-AF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab2HXJcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 05:32:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26306 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab2HXJcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 05:32:18 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 24 Aug
 2012 11:32:06 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 24 Aug
 2012 11:32:14 +0200
In-Reply-To: <7vy5l52ueg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 23 Aug 2012 14:03:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204195>

Junio C Hamano <gitster@pobox.com> writes:

> As a corollary, the "is pu@{0} a fast-forward of pu@{1}?" check does
> not need merge base computation at all.  The only thing it needs to
> do is to prove pu@{1} is reachable from pu@{0}, and that can be done
> the same way in which '1' can be proved unreachable from '2' in the
> post processing phase as described above, i.e. it needs only the
> first phase of running merge_bases_many() without postprocessing.

Well, yeah, you snipped this part from my original post :-)

} Even if this turns out to be flawed, we should also identify uses of
} in_merge_bases() where the real question was is_descendant_of() [I
} somewhat suspect that's all of them], and then replace is_descendant_of
} with a much cheaper lookup.  This can be as simple as propagating a mark
} from the candidate until it either goes beyond all possible ancestors,
} or hits one of them.

As far as the "real question" goes, I'm purely guessing here -- it is
entirely possible that a bunch of the in_merge_bases() checks really do
need the pruned set of merge bases.  But this particular check, and I
suspect a bunch of others, does not.

Then there's the next bit:

} By the way, the internal slowness of git-merge-base also affects the
} A...B syntax.  For example,
} 
}   git rev-list --left-right --count @{upstream}...
} 
} is used by the __git_ps1 code to determine the prompt display, which
} just got very slow for me today.  Again, it should be easy to figure out
} the boundary of the symmetric difference simply by propagating two
} marks.  I do not think that the result of A...B actually depends on
} figuring out exactly what the merge bases are, simply excluding *any*
} candidate without pruning is enough.

Apart from __git_ps1, this is also used by git-status, git-checkout and
'git branch -v' to show "your branch is N behind and M ahead".  Again
it's a bit of a hunch, but I think figuring out the symmetric difference
is a simple matter of propagating two marks and including only commits
that ended up having exactly one of them.  At least the counting case
should be easy, rev-list is slightly harder to fix.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
