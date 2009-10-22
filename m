From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: keeping track of where a patch begins
Date: Thu, 22 Oct 2009 10:27:31 +0200
Message-ID: <200910221027.32739.trast@student.ethz.ch>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com> <alpine.LFD.2.00.0910211402490.21460@xanadu.home> <7veiow4iqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, E R <pc88mxer@gmail.com>,
	<git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0t21-00061c-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbZJVI2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZJVI2P
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:28:15 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56280 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbZJVI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:28:14 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:28:17 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:28:06 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7veiow4iqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131006>

Junio C Hamano wrote:
> 
> A branch in git, as Randal often used to say on #git, is an illusion---it
> points only at the top and does not identify the bottom.
> 
> But it does _not_ have to stay that way at the Porcelain level.
> 
> Here is a rough sketch of one possible solution.  It is not fully thought
> out; the basic idea is probably sound but I did not try to exhaustively
> cover changes to various tools that are necessary to maintain the
> invariants this scheme requires.
> 
>  (0) Define a way to identify the bottom of a branch.  One way to do this
>      is by an extra ref (e.g. refs/branchpoints/frotz).  Then the commits
>      between refs/branchpoints/frotz..refs/heads/frotz identifies the
>      commits on the branch.  None of the additional restrictions below
>      applies when the branch does not have such bottom defined (i.e.
>      created by the current git without this extension).
> 
>  (1) At branch creation, the branchpoint is noted. [...]
> 
>  (2) You can grow the branch naturally with "commit", "am" and "merge".
>      The bottom of the branch does not have to move with these operations.
> 
>  (3) Operations that alter histories, e.g. "commit --amend", "rebase",
>      "reset", while on a branch that records its bottom need to be taught
>      to pay attention to not break its bottom. [...]
> 
>  (4) Operations that browse histories, e.g. "log", "show-branch", while on
>      a branch that records its bottom can be taught to pay attention to
>      the bottom. [...]

I think this not only changes the model of branches, but also commits,
to some extent.  Currently, commit have no intrinsic branch
membership; if you say

  git branch foo bar

you cannot distinguish whether the commits on 'bar' were created on
'foo' or on 'bar'.  (By git's means; of course the decision would
favour 'master' if I had used that instead.)

Technically your proposal does not change this fact very much; it is
still possible to create "clones" of branches that are
indistinguishable.  However, to the *user* I think we would create a
notion that "a commit belongs to one specific branch", in that, during
the course of normal operations, a commit will end up on exactly one

  git rev-list --first-parent base..branch

range.

(Not sure if I consider this as an argument in favour or against yet,
but I wanted to point it out anyway.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
