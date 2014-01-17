From: John Keeping <john@keeping.me.uk>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such
 ref: ''" for branches without an upstream
Date: Fri, 17 Jan 2014 19:26:19 +0000
Message-ID: <20140117192619.GP7608@serenity.lan>
References: <52D8827E.3060007@fb.com>
 <20140117022152.GB12444@sigill.intra.peff.net>
 <xmqq8uuexwp7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Siddharth Agarwal <sid0@fb.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:26:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4F43-0002mr-Um
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaAQT0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:26:31 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35329 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbaAQT02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:26:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 31254CDA593;
	Fri, 17 Jan 2014 19:26:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyPYx6RMYkXT; Fri, 17 Jan 2014 19:26:27 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id A9ABBCDA2D4;
	Fri, 17 Jan 2014 19:26:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8A164161E504;
	Fri, 17 Jan 2014 19:26:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2MG7yOT5oXaz; Fri, 17 Jan 2014 19:26:27 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 88DD3161E21B;
	Fri, 17 Jan 2014 19:26:21 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqq8uuexwp7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240615>

On Fri, Jan 17, 2014 at 10:57:56AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Jan 16, 2014 at 05:08:14PM -0800, Siddharth Agarwal wrote:
> >
> >> With git-next, where git pull --rebase can print out "fatal: No such
> >> ref: ''" if git pull --rebase is run on branches without an upstream.
> >
> > This is already fixed in bb3f458 (rebase: fix fork-point with zero
> > arguments, 2014-01-09), I think.
> 
> Doesn't the call to get_remote_merge_branch in this part
> 
>         test -n "$curr_branch" &&
>         . git-parse-remote &&
>         remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
>         oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch)
> 
> yield an empty string, feeding it to "merge-base --fork-point" as
> its first parameter?

For some reason I assumed that get_remote_merge_branch would either
yield a non-empty string or return failure, meaning that the &&-chain
makes everything OK.

Before the change to use "merge-base --fork-point", the code was:

	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
	do
		if test "$reflog" = "$(git merge-base $reflog $curr_branch)"
		then
			oldremoteref="$reflog"
			break
		fi
	done

which has a similar failure - rev-list requires a revision argument and
prints its usage if not given one.

> Perhaps something like this is needed?
> 
>  git-pull.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index 605e957..467c66c 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -229,6 +229,7 @@ test true = "$rebase" && {
>  	test -n "$curr_branch" &&
>  	. git-parse-remote &&
>  	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> +	test -n "$remoteref" &&
>  	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch)
>  }
>  orig_head=$(git rev-parse -q --verify HEAD)

Either that or "2>/dev/null" like in the original, yes.
