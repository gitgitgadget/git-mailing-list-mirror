From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Idea: "live branches"?
Date: Wed, 9 Jul 2008 18:00:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807091750350.18205@racer>
References: <m28wwbz8h7.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Rychter <jan@rychter.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGd37-0004F5-N8
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbYGIRAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbYGIRAt
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:00:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:39937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750940AbYGIRAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 13:00:49 -0400
Received: (qmail invoked by alias); 09 Jul 2008 17:00:46 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp056) with SMTP; 09 Jul 2008 19:00:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ks753NXzKU1ZOn0ldvhiqt+DZ4UzijnTfZPZy+B
	aKepyQjor9SLgG
X-X-Sender: gene099@racer
In-Reply-To: <m28wwbz8h7.fsf@tnuctip.rychter.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87894>

Hi,

On Wed, 9 Jul 2008, Jan Rychter wrote:

> Which brings me to my point. I think we need a system that can maintain 
> "live branches". We already have impressive systems for dealing with 
> patches and we have made the patch into a first-class citizen of our 
> software development world. Now, instead of statically tracking commits 
> and following a one-way development history, let's have live branches -- 
> branches that can change, causing code that depends on them to change.
> 
> The way this would work is I would have one or two long-term development 
> branches, and each of those would depend on a list of "live branches", 
> managed by a tool similar to StGIT. I should be able to commit to either 
> the main development branch, or to one of the "live branches", in which 
> case I should be able to easily "resync" the main development branch (do 
> a merge or a rebase, but I would prefer the tool to first remove old 
> merge commits, so as not to clutter history).

It should be very easy to write a small shell script which expects some 
config variable

	branch.<currentBranchName>.liveBranches

which contains a list of (local) branches.  It would then just look which 
of those branches contains newer commits, finds the merges that pulled 
those branches in, and redoes those merges (and the commits).  It would 
rely heavily on "git reset" and on an untampered-with merge message.

The main loop would look a little bit like this:

	git rev-list --parents <first-merge-to-be-replaced>^ |
	while read commit parent otherparents
	do
		case "$otherparents" in
		'')
			git cherry-pick $commit
		;;
		*)
			case " $commit " in
			" $mergestoberedone ")
			;;
			*)
				message="$(git cat-file commit $commit |
					sed '/^$/q')"
				git merge -m "$message" $otherparents
			;;
		esac
	done
	# merge changes branches

No wizardry required.

> The tool should also let me pick a commit I've made and move it to one 
> of the live branches easily (similar to stgit).

That is relatively simple, using "git checkout <branch> && git cherry-pick 
<commit> && git checkout <formerBranch> && git resync-live-branches".

I strongly suggest writing that script, and seeing if it is useful for 
you.  If it is, just submit it and earn all the glory.

Hth,
Dscho
