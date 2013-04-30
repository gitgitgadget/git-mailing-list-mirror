From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] revision.c: discount UNINTERESTING parents
Date: Tue, 30 Apr 2013 14:18:40 -0700
Message-ID: <7vmwsfbtu7.fsf@alter.siamese.dyndns.org>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
	<1367342788-7795-9-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue Apr 30 23:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXHx2-0006nX-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058Ab3D3VS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:18:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933609Ab3D3VSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:18:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C3911BBEA;
	Tue, 30 Apr 2013 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vghfJqll5H39/4cmT2wX95vyfL8=; b=rCk/Tz
	cAf/f208Sast/z56PREaKMcbFjRVcmg6BOURsSFxvlbcy9lbAfVYkk4ypSykvzPY
	XtcKDmrzLuxI0HzGzKN/rBPD4KgdhqZ3rxBvttKCsQRQBhYBXqyIzJD/1Bn4NeV9
	TwrZbrCrBhQ3kzcuzwGYzUxYRB4WXH5/5qj7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fN2ImE9hRtvOMK4dqrrtx/W40tK76pit
	WYTQdbjaM65SOi9fgF/5YAC3SnI6thHysku6m3vAEGVXuegJtRH4C2TajlUuoSjx
	jd2dFRJ893YKkGc3paqblKYzLp6GwMgzeMi6j3/Ka/zmK+FWPwuw1JtbVMNsW9rw
	6UInawPTPD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 936FE1BBE9;
	Tue, 30 Apr 2013 21:18:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C53DC1BBE8;
	Tue, 30 Apr 2013 21:18:41 +0000 (UTC)
In-Reply-To: <1367342788-7795-9-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Tue, 30 Apr 2013 20:26:28 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 885B9C72-B1DB-11E2-B506-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223011>

Kevin Bracey <kevin@bracey.fi> writes:

> The simplification and rewriting logic previously paid little heed to
> whether parents were UNINTERESTING, leading to situations where limited
> histories could unnecessarily include a lot of irrelevant merges along
> the boundary. Tighten up the rules to properly account for limited
> lists:
>
> 1) If a merge has INTERESTING parents, and it is TREESAME to them, then
> do not let UNINTERESTING parents cause the merge to be treated as
> !TREESAME. If we match our walked parents, we don't care if we don't
> match unwalked parents.

OK.

> 2) Do not let UNINTERESTING parents prevent commits from being
> simplified or omitted: merges with exactly 1 INTERESTING parent that
> they are TREESAME to can be treated as a non-merge commit.

OK.

> 3) When rewriting parents, we don't need to show all merges - only merges
> with 2 or more INTERESTING parents are required to hold topology together.

OK.

> These changes greatly increase simplification in pruned, limited
> revision lists - irrelevant merges from unlisted or partially listed
> side branches can be omitted.

It is a bit unclear what "unlisted" and "partially listed" mean in
this sentence.

> These rules paying more attention to UNINTERESTING do add a tricky
> wrinkle to behaviour. Because limited revision lists are conventionally
> expressed as A..B (ie B ^A), the bottom commit is UNINTERESTING.

OK.

> Thus
> its connection to the INTERESTING graph is not privileged over side
> branches,

I take that "its connection" refers to the "===" link below, the
nodes connected with "---" form the "INTERESTING graph", and

     ....Z...A===X---o---o---B
          \\    /  
           W---Y
    
"side branches" refer to the development that built W and Y and
merged at X.  And you are saying that A===X is not "privileged" over
"Y---X", with some definition of "privileged" I am not sure about.

> and this can lead to its first descendant merge being shown
> for no particularly good reason.

Whose first descendant merge?  Sorry, I am lost at this point, and
anything I would say in the remainder of this response may be
nonsense coming from this confusion.

> See t6019's "--ancestry-path G..M -- G.t" for an example of this effect.

>  #          D---E-------F
>  #         /     \       \
> +#    B---C-G0-G--H---I---J
>  #   /                     \
>  #  A-------K---------------L--M
>  #
> +#  D..M                 == E F G G0 H I J K L M
>  #  --ancestry-path D..M == E F H I J L M
>  #
>  #  D..M -- M.t                 == M
>  #  --ancestry-path D..M -- M.t == M
>  #
>  #  G..M -- G.t                 == [nothing - was dropped in "-s ours" merge L]
> -#  --ancestry-path G..M -- G.t == H J L
> +#  --ancestry-path G0..M-- G.t == G L

> Merges H and J are semantically identical and equally irrelevant, from
> the point of view of tracking the history of G.t, but H is shown and J
> isn't.
> > Bottom commit G is marked UNINTERESTING, and thus isn't
> privileged over E, so H is shown because it differs from E.

Doesn't that suggest we should do --ancestry-path a lot earlier?

Conceptually, the "ancestry-path" shouldn't get affected by any
pathspec. The range "--ancestry-path G0..M" should be equivalent to
the range "G0..M ^F ^E ^K", and with the rule to ignore non-sameness
with uninteresting side branches, I would have expected that H and J
would be equally irrelevant, because E and F would be outside the
graph we would want to look at sameness.

> Whereas
> higher up the graph, I is INTERESTING and thus privileged over F, so we
> don't care that J differs from F.
>
> So should we treat bottom commits as "interesting" for the rules above?
