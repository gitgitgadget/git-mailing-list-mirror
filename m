From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Sun, 8 Mar 2009 04:49:26 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903080447450.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org> <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com> <7vocwcl8ku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:51:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgEis-0003zD-9g
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 09:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZCHItb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbZCHIta
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 04:49:30 -0400
Received: from iabervon.org ([66.92.72.58]:52563 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbZCHIt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 04:49:29 -0400
Received: (qmail 31642 invoked by uid 1000); 8 Mar 2009 08:49:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2009 08:49:26 -0000
In-Reply-To: <7vocwcl8ku.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112614>

On Sun, 8 Mar 2009, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > This series and js/remote-improvements (e5dcbfd) in pu may not get
> > along completely. "git remote show" tries to show how the refspecs
> > expand out.
> 
> I've created an "early semantic conflict resolution" topic branch that is
> a cross between this series and js/remote-improvements, like so:
> 
>     $ git checkout -b xx/db-refspec-vs-js-remote db/refspec-wildcard-in-the-middle
>     $ git merge js/remote-improvements
>     $ git apply evil-fixup.diff
>     $ git commit --amend -a -m "Evil merge."
> 
> with the following "fixup-as-an-evil-merge patch", which I'd appreciate if
> you two can sanity check.

That looks like what I'd come up with as a resolution, too, so I think 
it's sane unless Jay knows of another way to get remote to care about 
patterns.

> The result will be queued at the tip of 'pu', and hopefully I can merge it
> to 'next' when this series goes to 'next'.  Similarly, whichever one goes
> first to 'master' can be merged straight, but the merge of the other one
> needs to merge this branch as well.
> 
> diff --git a/builtin-remote.c b/builtin-remote.c
> index 7e82a52..3e4a41b 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -359,14 +358,9 @@ static int get_push_ref_states_noquery(struct ref_states *states)
>  	}
>  	for (i = 0; i < remote->push_refspec_nr; i++) {
>  		struct refspec *spec = remote->push + i;
> -		char buf[PATH_MAX];
>  		if (spec->matching)
>  			item = string_list_append("(matching)", &states->push);
> -		else if (spec->pattern) {
> -			snprintf(buf, (sizeof(buf)), "%s*", spec->src);
> -			item = string_list_append(buf, &states->push);
> -			snprintf(buf, (sizeof(buf)), "%s*", spec->dst);
> -		} else if (strlen(spec->src))
> +		else if (strlen(spec->src))
>  			item = string_list_append(spec->src, &states->push);
>  		else
>  			item = string_list_append("(delete)", &states->push);
> @@ -374,10 +368,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
>  		info = item->util = xcalloc(sizeof(struct push_info), 1);
>  		info->forced = spec->force;
>  		info->status = PUSH_STATUS_NOTQUERIED;
> -		if (spec->pattern)
> -			info->dest = xstrdup(buf);
> -		else
> -			info->dest = xstrdup(spec->dst ? spec->dst : item->string);
> +		info->dest = xstrdup(spec->dst ? spec->dst : item->string);
>  	}
>  	return 0;
>  }
> @@ -390,7 +381,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
>  
>  	refspec.force = 0;
>  	refspec.pattern = 1;
> -	refspec.src = refspec.dst = "refs/heads/";
> +	refspec.src = refspec.dst = "refs/heads/*";
>  	states->heads.strdup_strings = 1;
>  	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
>  	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> 
