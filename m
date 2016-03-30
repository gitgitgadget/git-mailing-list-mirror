From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [ANNOUNCE] git-push-update, tool to push with "server-side"
 merge or rebase
Date: Tue, 29 Mar 2016 21:29:45 -0400
Message-ID: <20160330012945.GA8888@ball>
References: <20160328080841.GA12932@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:34:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al51K-0005wU-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbcC3BeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:34:01 -0400
Received: from tbsaunde.org ([66.228.47.254]:50606 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcC3BeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:34:00 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Mar 2016 21:34:00 EDT
Received: from ball (unknown [IPv6:2607:f0c8:8000:80e0:56ee:75ff:fe52:afb9])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 946ECC07C;
	Wed, 30 Mar 2016 01:25:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160328080841.GA12932@wheezy.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290260>

On Mon, Mar 28, 2016 at 11:08:41AM +0300, Max Kirillov wrote:
> Hello.
> 
> I would like to announce git-push-update, a tool which emulates
> server-side merge or rebase.
> 
> The link: https://github.com/max630/git-push-update
> 
> It is a bash script which fetches latest remote branch, creates
> temporary clone, performs there merge or rebase, pushes results to
> server. If during the merge or rebase remote branch was updated, it
> fails cleanly, so you are not left with merge which did not go anywhere.
> Or it can even retry the whole task from the beginning, until it
> eventually succeeds.
> 
> I tried to make it easy to use by unexperienced users by making as few
> options as possible and checking for some dangerous mistakes. It would
> be nice if somebody tried to really use it, so there would be some data
> does this direction worth exploring. Any other feedback is also welcome.
> 
> A longer explanation:
> 
> While topic branches/pullrequests/whatever-it-named workflow is
> obviously superior to push-to-trunk approach which is used with
> centralized VCSes, there can be cases to use the latter one. But doing
> it with Git is not easy:

hm how? the workflow you use locally has basically nothingto do with how
pushes work.  I work on several projects daily where everyone pushes to
trunk, but locally I use branches.  You just need to fetch rebase then
either merge your branch into master before pushing or explicitly tell
git push what refs to update how.

> * when the trunk goes forward, user have to run merge or
>   rebase (further "update"), interrupting other work which
>   might be in progress.

I don't really understand this either, if you develope everything on
master then it would seem obvious if you want to update what version of
trunk you are using you either need to rebase or merge the remote master
with yours.

> * while doing fetch, update and push back a concurrent push can happen,
>   making user to have to repeat it all over.

I think this is more or less the reason for the hg extension, but I
think the script to deal with this is basically

while true
do
	git fetch origin
	git rebase origin/master
	git push origin HEAD:master && break
done

obviously with a little more error checking thrown in if you care.

> * some scenarios allow user to make a mistake combining branches which
>   mean to be unrelated, for example merging or rebasing active
>   development branch into maintenance branch for older version.
> * for a merge case there is a problem of "evil pull"
>   (http://thread.gmane.org/gmane.comp.version-control.git/247237)
>   In short: the merges which are to go to remote branch should be "from
>   local to remote", and git-pull merges "from remote to local".
> 
> This was discussed around some time ago, but I could not find anything
> done about it. It might seem like nobody really interested much. But I
> still can see discussions here and there. Also, some time ago extension
> "pushrebase" for mercurial appeared, which indicates that there is
> really a demand.

I think that was really for very heavily used repos where there was a
ton of fetch rebase push repeating going on.

> Looks like current git remote protocol does not really allow server to
> tweak pushed commits: if it accepts reference, client will remember
> exactly the commit it was pushing, no modifications is possible. Also,
> if it is implemented as server-side feature, it might take years to
> appear at github or other big public hostings, if ever. Until that most
> users would not be able to try it.

I'm not really clear what this is helping for most of those use cases,
but if you want to maintain it why not?

Trev

> This leaves only one option: perform merge or rebase locally, pretending
> that it was done at server. It does not even have to be implemented in
> git itself, instead a wrapper script can do everything.
> 
> So here is the script.
> 
> -- 
> Max
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
