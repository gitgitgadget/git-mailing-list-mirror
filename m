From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] New commit object headers: generation and note headers
Date: Sat, 9 Feb 2008 12:35:11 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802091220030.13593@iabervon.org>
References: <200802091746.09102.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNtcE-0004Gc-Nb
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYBIRfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 12:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbYBIRfQ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:35:16 -0500
Received: from iabervon.org ([66.92.72.58]:41074 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbYBIRfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 12:35:14 -0500
Received: (qmail 6211 invoked by uid 1000); 9 Feb 2008 17:35:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Feb 2008 17:35:11 -0000
In-Reply-To: <200802091746.09102.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73247>

On Sat, 9 Feb 2008, Jakub Narebski wrote:

> As new major git release 1.6.0 is close (BTW. I wonder if git would ever 
> reach/get 2.0.0 release...), I'd like to sum up here, adding my own 
> thoughts and comments, ideas about extending commit object by adding 
> new headers. I think it would be better to have such major feature 
> introduced in major release, and not with only minor number changed.
> For some headers the faster it is introduced the better.
> 
> 
> 1. 'generation' header
> 
> In the "[BUG?] git log picks up bad commit" thread:
>   http://permalink.gmane.org/gmane.comp.version-control.git/72274
> later "[RFH] revision limiting sometimes ignored" there was resurrected 
> idea of the 'generation' header. This header is meant to simplify 
> removing uninteresting commits in the presence of clock skew, to 
> replace various commit-time related heuristics.
> 
> The proposed solution (which was at least once discussed in the past on 
> git mailing list) is to use for this "generation number":
>  1. For parentless (root) commits it equals 1 (or 0)
>  2. For each commit, it equals maximum of generation numbers of parents,
>     plus 1.
> Of course to not to have to recalculate it from beginning it must be 
> saved somewhere. Best solution is to use 'generation' header for that.
> 
> Unfortunately there is complication that commits written before this 
> header introduced doesn't have generation number handy. It was proposed
> then to use generation number if possible, and fallback to old date 
> based heuristic if it does not exist, and do not (re)calculate it;
> the idea is to avoid such cost.
> 
> My comments:
> ============
> The problem is twofold: when to calculate generation header, and what to 
> do with commits that lacks it. We could require to calculate generation 
> header when creating a commit (commit, amend, rebase, filter-branch), 
> but this might mean that a few first commits after 'generation' header 
> is introduced would be much slower.

Surely, at least sombody has to do the slow commit that's the first one 
with a generation number. Maybe make it optional? If Linus calculates the 
generation number of some v2.6.x and only merges trees that have been 
rebased on it by people with sufficiently recent git, it should only take 
a lot of time once.

It's probably best to start by only including them if all parents have 
them, then having a cycle where figuring them out slowly is optional and 
defaults to off, and then make it default to on once projects are likely 
to have them in general, or at least would be likely to retain them once a 
few slow commits are done.

> 2. 'note' header (no semantical meaning)
> 
> There was some time ago discussion about adding 'note' header, initially 
> to save original sha-1 of a commit for cherry-picking and rebase; then 
> for saving explicit rename or corrected rename info, for saving chosen 
> merge strategy, and for saving original ID of SCM import.

Probably want to have a prescribed syntax for specifying what note this 
is, so that different programs using notes don't confuse each other.

	-Daniel
*This .sig left intentionally blank*
