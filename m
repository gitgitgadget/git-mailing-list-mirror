From: Jeff King <peff@peff.net>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Fri, 11 Sep 2015 23:30:55 -0400
Message-ID: <20150912033054.GA30431@sigill.intra.peff.net>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
 <20150911140133.GA14311@sigill.intra.peff.net>
 <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
 <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 05:31:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZabWw-0001Pj-6b
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 05:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbbILDa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 23:30:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:58015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754566AbbILDa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 23:30:58 -0400
Received: (qmail 12671 invoked by uid 102); 12 Sep 2015 03:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Sep 2015 22:30:57 -0500
Received: (qmail 9140 invoked by uid 107); 12 Sep 2015 03:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Sep 2015 23:31:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2015 23:30:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277713>

On Fri, Sep 11, 2015 at 12:06:27PM -0700, Junio C Hamano wrote:

> So here is an outline of what I had in mind when I was writing the
> above.  Instead of trusting that num_scapegoats() is always used to
> limit the enumeration of commit->parents, we discard the second and
> subsequent parents from the commit objects, and also make sure the
> later parents do not participate in the revs.children annotation, so
> that the world "blame" sees truly becomes a single strand of pearls.

Yeah, I think what is happening in this first hunk:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4db01c1..bc87d9d 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1366,8 +1366,15 @@ static void pass_whole_blame(struct scoreboard *sb,
>   */
>  static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
>  {
> -	if (!reverse)
> +	if (!reverse) {
> +		if (revs->first_parent_only &&
> +		    commit->parents &&
> +		    commit->parents->next) {
> +			free_commit_list(commit->parents->next);
> +			commit->parents->next = NULL;
> +		}
>  		return commit->parents;
> +	}
>  	return lookup_decoration(&revs->children, &commit->object);
>  }

is doing the right thing. It did feel a little weird to me to be munging
the global commit objects themselves, but I guess it is fairly normal
for git code.

I wondered if you could then simplify away the counters used in the
for-loops. I.e., to end up with:

  for (sg = first_scapegoat(revs, commit); sg; sg = sg->next)

in the callers. But no. One of the reasons for the counters is that we
need to know we are on the n'th parent, so we can compare it to parent
n-1, n-2, etc, for sameness.

> diff --git a/revision.c b/revision.c
> index af2a18e..a020a42 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2765,7 +2765,9 @@ static void set_children(struct rev_info *revs)
>  		struct commit *commit = l->item;
>  		struct commit_list *p;
>  
> -		for (p = commit->parents; p; p = p->next)
> +		for (p = commit->parents;
> +		     p && !revs->first_parent_only;
> +		     p = p->next)
>  			add_child(revs, p->item, commit);
>  	}
>  }

Yeah, this makes sense to me. Adding all children to the decoration list
and then later choosing only the first child (as my earlier suggestion
did) is not right. You can tell immediately that it is nonsense because
the child you would get depends on the order we visited the commits when
building up the decoration. And that does not necessarily have any real
meaning.

-Peff
