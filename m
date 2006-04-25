From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 08:44:08 +0200
Organization: At home
Message-ID: <e2kgga$d7q$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 08:45:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYHI3-0001IC-VP
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 08:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWDYGot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 02:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDYGot
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 02:44:49 -0400
Received: from main.gmane.org ([80.91.229.2]:64197 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751366AbWDYGos (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 02:44:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYHHt-0001GU-12
	for git@vger.kernel.org; Tue, 25 Apr 2006 08:44:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 08:44:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 08:44:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19131>

Sam Vilain wrote:

> This patch series implements "prior" links in commit objects.  A
> 'prior' link on a commit represents its historical precedent, as
> opposed to the previous commit(s) that this commit builds upon.
> 
> This is a proof of concept only; there is an outstanding bug (I put
> the prior header right after parent, when it should really go after
> author/committer), and room for improvement no doubt remain elsewhere.
> Not to mention my shocking C coding style ;)

I think "prior" link concept is to generic and is used for quite unrelated
things

> Examples of use cases this helps:
> 
>  1. heads that represent topic branch merges
> 
>     This is the "pu" branch case, where the head is a merge of several
>     topic branches that is continually moved forward.
> 
>     topic branches     head
>       ,___.   ,___.
>      | TA1 | | TB1 |
>       `---'   `---'    ,__.
>          ^\_____^\____| H1 |
>                        `--'
> 
>     + some topic branch changes and a republish:
> 
>       ,___.   ,___.
>      | TA1 | | TB1 |
>       `---'   `---'^   ,__.
>         |^\_____^\____| H1 |
>         |       |      `--'
>       ,_|_.   ,_|_.      P
>      | TA2 | | TB2 |     |
>       `---'   `---'^     |
>         ^       ^        |
>       ,_|_.     |        |
>      | TA3 |    |        |
>       `---'     |      ,__.
>          ^\______\____| H2 |
>                        `--'
> 
>     key:  ^ = parent   P = prior

This case is clear. You want to record previous head of "pu"-like branch,
but you also want to drop the history, so you don't want to record it as
one of parents. I'm not sure if this link would be informative only, or if
it could be usefull e.g. in merge computing.
 
>  2. revising published commits / re-basing
> 
>     This is what "stg" et al do.  The tools allow you to commit,
>     rewind, revise, recommit, fast forward, etc.
> 
>     In this case, the "prior" link would point to the last revision of
>     a patch.  Tools would probably support only doing this for selected, 
>     "published" patch chains 

This case is quite different. If I understand it correctly prior either
points to the previous patch in patch stack, or the bottom of the
stack/patch stack attachment point. If this cannot be computed easily, it
could I guess be added, but perhaps using other name for link.

>  3. sub-projects
> 
>     In this case, the commit on the "main" commit line would have a
>     "prior" link to the commit on the sub-project.  The sub-project
>     would effectively be its own head with copied commits objects on
>     the main head.
>
>  4. tracking cherry picking
> 
>     In this case, the "prior" link just points to the commit that was
>     cherry picked.  This is perhaps a little different, but an idea
>     that somebody else had for this feature.

Those two are yet another case altogether, the "prior" link pointing to "the
same" commit in another history line. I agree with Junio that for (3)
"bind" proposal (if I understand correctly it points to tree rather than to
commit) is more clean way to go. As to cherry picking (and perhaps
"cherry-pick on steroids" aka rebase), there is truly 0-1 relation (either
this link is not needed at all, or there is only one commit to link to),
but I don't think it should have the same name as in case (1), as this is
very different. And there is a problem that the link might be dangling if
we deleted the branch we cherry-picked commit from, or did some history
rewrite. Perhaps "cherry" would be better name for this link :-)

Additionally for each of those cases we have to consider how to compute the
link and which commands should be modified, which commands can make use of
the link and should be modified, should the link be to commit, tag, tree or
blob, what we want to do with link when pulling/pushing/cloning into
another repository and which commands should be modified. Not only use case
scenarios.

-- 
Jakub Narebski
Warsaw, Poland
