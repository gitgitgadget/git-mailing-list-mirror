From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] submodule recursion in git-archive
Date: Fri, 29 Nov 2013 23:38:45 +0100
Message-ID: <20131129223845.GA31636@sandbox-ub>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de>
 <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
 <9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
 <xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Townsend <nick.townsend@mac.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 23:39:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmWiS-0001jc-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 23:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3K2WjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 17:39:00 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:57505 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab3K2Wi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 17:38:58 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VmWi2-0003qy-Bc; Fri, 29 Nov 2013 23:38:50 +0100
Content-Disposition: inline
In-Reply-To: <xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238540>

On Wed, Nov 27, 2013 at 11:43:44AM -0800, Junio C Hamano wrote:
> Nick Townsend <nick.townsend@mac.com> writes:
> > * The .gitmodules file can be dirty (easy to flag, but should we
> > allow archive to proceed?)
> 
> As we are discussing "archive", which takes a tree object from the
> top-level project that is recorded in the object database, the
> information _about_ the submodule in question should come from the
> given tree being archived.  There is no reason for the .gitmodules
> file that happens to be sitting in the working tree of the top-level
> project to be involved in the decision, so its dirtyness should not
> matter, I think.  If the tree being archived has a submodule whose
> name is "kernel" at path "linux/" (relative to the top-level
> project), its repository should be at .git/modules/kernel in the
> layout recent git-submodule prepares, and we should find that
> path-and-name mapping from .gitmodules recorded in that tree object
> we are archiving. The version that happens to be checked out to the
> working tree may have moved the submodule to a new path "linux-3.0/"
> and "linux-3.0/.git" may have "gitdir: .git/modules/kernel" in it,
> but when archiving a tree that has the submodule at "linux/", it
> would not help---we would not know to look at "linux-3.0/.git" to
> learn that information anyway because .gitmodules in the working
> tree would say that the submodule at path "linux-3.0/" is with name
> "kernel", and would not tell us anything about "linux/".
> 
> > * Users can mess with settings both prior to git submodule init
> > and before git submodule update.
> 
> I think this is irrelevant for exactly the same reason as above.
> 
> What makes this tricker, however, is how to deal with an old-style
> repository, where the submodule repositories are embedded in the
> working tree that happens to be checked out.  In that case, we may
> have to read .gitmodules from two places, i.e.
> 
>  (1) We are archiving a tree with a submodule at "linux/";
> 
>  (2) We read .gitmodules from that tree and learn that the submodule
>      has name "kernel";
> 
>  (3) There is no ".git/modules/kernel" because the repository uses
>      the old layout (if the user never was interested in this
>      submodule, .git/modules/kernel may also be missing, and we
>      should tell these two cases apart by checking .git/config to
>      see if a corresponding entry for the "kernel" submodule exists
>      there);
> 
>  (4) In a repository that uses the old layout, there must be the
>      repository somewhere embedded in the current working tree (this
>      inability to remove is why we use the new layout these days).
>      We can learn where it is by looking at .gitmodules in the
>      working tree---map the name "kernel" we learned earlier, and
>      map it to the current path ("linux-3.0/" if you have been
>      following this example so far).
> 
> And in that fallback context, I would say that reading from a dirty
> (or "messed with by the user") .gitmodules is the right thing to
> do.  Perhaps the user may be in the process of moving the submodule
> in his working tree with
> 
>     $ mv linux-3.0 linux-3.2
>     $ git config -f .gitmodules submodule.kernel.path linux-3.2
> 
> but hasn't committed the change yet.
> 
> > For those reasons I deliberately decided not to reproduce the
> > above logic all by myself.
> 
> As I already hinted, I agree that the "how to find the location of
> submodule repository, given a particular tree in the top-level
> project the submodule belongs to and the path to the submodule in
> question" deserves a separate thread to discuss with area experts.

FYI, I already started to implement this lookup of submodule paths early
this year[1] but have not found the time to proceed on that yet. I am
planning to continue on that topic soonish. We need it to implement a
correct recursive fetch with clone on-demand as a basis for the future
recursive checkout.

During the work on this I hit too many open questions. Thats why I am
currently working on a complete plan[2] so we can discuss and define how
this needs to be implemented. It is an asciidoc document which I will
send out once I am finished with it.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/217020
[2] https://github.com/hvoigt/git/wiki/submodule-fetch-config
