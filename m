From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Fri, 11 Sep 2015 09:35:13 -0700
Message-ID: <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaRIK-0000m9-K1
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbbIKQfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 12:35:17 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34353 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbbIKQfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 12:35:15 -0400
Received: by padhy16 with SMTP id hy16so79241162pad.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qmCyZpGgZ6yHufiBs0VbJc/jLl2XupU7WIiG5YMPwEM=;
        b=T6hqDKMymyrjw/7Fyv/BKCkjWQ2scCsUhmR9ii5YOjuZqME13uXFvcjO/UJwvLZ/6y
         EN2dd+dPJCOMSROyj8eg4jcVirFx9QO2gbDBzHQtToEdWk5S3A9IAQza2yc9n8perQLF
         AGhzd1Xhm9mD9D8wLr9RaH2uCxVn9zSs9fA/djWYcpECyyZwf+8dSPwu/F4pjJS5kC2e
         FWlvCpBDpKNmSFcTEpqKOg9FMcoNlzIwUWT63I72dwHLfnMehUwOqGEm5eHNz+yaew1e
         vbqWfgH14mHGlYh+CspD1VXXFxFIrx1NRPX/WGBE1KsiBDEmRtWoheHiBiO2mU/G/dNC
         SgAg==
X-Received: by 10.66.165.106 with SMTP id yx10mr89126730pab.102.1441989314825;
        Fri, 11 Sep 2015 09:35:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id xf6sm1243075pbc.70.2015.09.11.09.35.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 09:35:14 -0700 (PDT)
In-Reply-To: <20150911140133.GA14311@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Sep 2015 10:01:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277680>

Jeff King <peff@peff.net> writes:

> I'm not too familiar with the code, but this _seems_ to work for me:
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 21321be..2e03d47 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1375,6 +1375,10 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
>  static int num_scapegoats(struct rev_info *revs, struct commit *commit)
>  {
>  	struct commit_list *l = first_scapegoat(revs, commit);
> +	if (!l)
> +		return 0;
> +	if (revs->first_parent_only)
> +		return 1;
>  	return commit_list_count(l);
>  }
>
> I suspect it doesn't work at all with `--reverse`. I also have the
> nagging feeling that this could be handled inside revision.c with
> parent-rewriting, but I don't really know.

I am not sure how well --children, which is what we use from
revision.c, works with --first-parent flag passed to the revision
walking machinery.  If it already does the right thing, then the
revs.children decoration that collects all children of any given
commit should automatically give its "sole child" (in the world
limited to the first-parent chain) from first_scapegoat().

And if it does not, perhaps that is what we would want to fix,
i.e. making sure rev-list --first-parent --children does what
people would expect.

> But "git blame --first-parent <file>" seems to behave sanely in git.git
> with this.

It is intresting to see that the above is the only thing necessary,
as a naive way to try all parents would be to do:

	for (sg = first_scapegoat(...); sg; sg = sg->next)
		assign blame to sg;
	take the remainder ourselves;

in which case, a better place to patch would be first_scapegoat(),
not this function, so that we will always see zero or one element
parent list returned from the function.

But in reality, the code instead does this:

	num_sg = num_scapegoats(...);
	for (i = 0, sg = first_scapegoat(...);
             i < num_sg && sg;
             i++, sg = sg->next)
		assign blame to sg;
	take the remainder ourselves;

so you do not have to touch first_scapegoat() at all.

I do not offhand know if this was a sign of foresight in the
original, or just an overly redundant programming ;-).
