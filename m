From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 21:44:15 +0200
Message-ID: <20080616194415.GA11447@elte.hu>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <7vabhlb3ho.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Kdo-0001ku-H9
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYFPTo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 15:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbYFPTo1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 15:44:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43253 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbYFPTo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 15:44:26 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K8Kck-0004q9-CX
	from <mingo@elte.hu>; Mon, 16 Jun 2008 21:44:24 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 18D6A3E21DD; Mon, 16 Jun 2008 21:44:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabhlb3ho.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85219>


* Junio C Hamano <gitster@pobox.com> wrote:

> > Ingo Molnar <mingo@elte.hu> writes:
> > ...
> >>  - Automation: would be nice to have a git-rerere modus operandi where
> >>    it would auto-commit things if and only if all conflicting files were 
> >>    resolved.
> >
> > I am not sure how safe this is.  rerere as originally designed does 
> > not even update the index with merge results so that the application 
> > of earlier resolution can be manually inspected, and this is exactly 
> > because I consider a blind textual reapplication of previous 
> > resolution always iffy, even though I invented the whole mechanism.
> 
> By the way, this safety is not a theoretical issue but has been a real 
> one.  I had two topics that changed the calling convention of the same 
> function in different ways, and when they were merged to 'pu', the 
> declaration, definition, and call sites existed on both of these 
> branches were handled beautifully by rerere.
> 
> Recording autoresolution would have been a wrong thing to do.  One of 
> the branches added a new call site to a file that was not among the 
> ones that conflicted in the merge between the two branches.  That call 
> site, that uses the calling convention of one branch, needed to be 
> adjusted to accomodate the change of calling convention from the other 
> branch (from textual merge's point of view, this has to be an evil 
> merge).  I had to make and keep a mental note about that new call site 
> until both topics graduated to 'master' (similar to your need to 
> remember a particular merge is resolved to removal right now).
> 
> To safely automate reapplication of such a merge, rerere needs to 
> become much more clever.

in our workflow, we dont ever do any semantic things during the 
integration run. I.e. we dont put more complex merge changes into the 
integration merge commits.

Such integration effects do come up occasionally (especially when a 
topic changes some widely used infrastructure), and we handle them via 
separate merge branches. The current ones in -tip are 
tip/tracing/ftrace-mergefixups and tip/tracing/mmiotrace-mergefixups.

They are one or two orders of magnitude more rare than regular 
conflicts, and they show up immediately during testing. (or we 
anticipate them beforehand)

i.e. we'd like to have a 'dumb' phase of integration, as much cached and 
automated as possible. Things that need more thought need to go into 
separate branches anyway, for better reviewability - merge commits are 
rather hard to debug as they hide their true contents, so we try to keep 
them simple and contextual only.

	Ingo
