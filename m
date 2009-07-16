From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull
 --rebase
Date: Thu, 16 Jul 2009 10:51:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com> <1247731921-2290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1961027589-1247734307=:3155"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jul 16 10:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRMf4-0001wZ-5d
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbZGPIto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 04:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbZGPIto
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:49:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:54628 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753049AbZGPItn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:49:43 -0400
Received: (qmail invoked by alias); 16 Jul 2009 08:49:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 16 Jul 2009 10:49:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DjeEfPULDBUURVGsjq5t8xHWjSZByQ5a08lFJFz
	8lvCr5sMwmCq+6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1247731921-2290-1-git-send-email-santi@agolina.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123389>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1961027589-1247734307=:3155
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 16 Jul 2009, Santi Béjar wrote:

> Use the fork commit of the current branch (where
> the tip of upstream branch used to be) as the upstream parameter of
> "git rebase". Compute it walking the reflog to find the first commit
> which is an ancestor of the current branch.

I finally understand what this patch is about.  Thanks.

> diff --git a/git-pull.sh b/git-pull.sh
> index 4b78a0c..31d3945 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -125,9 +125,14 @@ test true = "$rebase" && {
>  	die "refusing to pull with rebase: your working tree is not up-to-date"
>  
>  	. git-parse-remote &&
> -	reflist="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> -	oldremoteref="$(git rev-parse -q --verify \
> -		"$reflist")"
> +	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> +	num=0 &&
> +	while oldremoteref="$(git rev-parse -q --verify "$remoteref@{$num}")"
> +	do

How about

	oldremoteref="$(git rev-list --boundary HEAD --not \
			$(git rev-list -g $remoteref | sed 's/$/^@/') |
		sed -e '/^[^-]/d' -e q)"

Explanation: the "git rev-list -g $remoteref" lists the previous commits 
the remote ref pointed to, and the ^@ appended to them means all their 
parents.  Now, the outer rev-list says to take everything in HEAD but 
_not_ in those parents, showing the boundary commits.  The "sed" call 
lists the first such boundary commit (which must, by construction, be one 
of the commits shown by the first rev-list).

But maybe this is trying to be too clever, and we should not bother with 
it until git-pull is made a builtin?

Ciao,
Dscho

--8323328-1961027589-1247734307=:3155--
