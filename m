From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 18 Aug 2009 00:02:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172347220.8306@pacific.mpi-cbg.de>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <7vtz06xxao.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302> <7vws52uvxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAHU-00028E-34
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182AbZHQWCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbZHQWCJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:02:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:50404 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752798AbZHQWCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 18:02:08 -0400
Received: (qmail invoked by alias); 17 Aug 2009 22:02:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 18 Aug 2009 00:02:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Tow5ZCl4TR+nV60giglhtsMBWOwGYQ1wvabb+sg
	p5cGH7OOR0R4sd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vws52uvxq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126297>

Hi,

On Mon, 17 Aug 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, my illustration of the scenario was only to one end, namely 
> > to convince all of you that assume-changed != sparse.
> >
> > And maybe to the end to explain that sparse checkout could help this 
> > guy.
> 
> How?  If sparse is _not to check it out_, then that is not what the 
> person is doing either.  It feels to me that you are suggesting an 
> inappropriate hack to replace another inappropriate hack, suggesting to 
> use a hacksaw because an earlier attempt to use a hammer did not quite 
> work to drive the screw in.

Not exactly.

What does "sparse checkout" mean, really?  It means that Git should only 
check out a part of the tracked files, and not even so much as look 
outside.  It means to me that everything outside of that focus is clearly 
to be handled as all the other untracked data.

And here comes the problem: if something is treated untracked because it 
was outside of the sparse checkout, then I want it to be treated as 
untracked _even if_ I happened to broaden the checkout by editing 
.git/info/sparse.  The file did not just magically become subject to 
overwriting just because I edited .git/info/sparse (which could be a 
simple mistake).  So the index _needs_ to know that the sparse'd-out 
attribute is something completely different from the assume-unchanged 
attribute, even if Git should _handle_ the files with those attributes 
pretty similar _most_ of the time.

> I never said assume-unchanged _is_ sparse.  You cannot mark an index 
> entry that does not exist, obviously you need more (either the earlier 
> "hook that tells what should/shouldn't exist", or "the pattern").

Right.

> But I think the work-tree semantics you need to _implement_ sparse 
> matches what you would want from assume-unchanged.  Not the original, 
> draconian one that updates the work tree by saying "you promised me you 
> wouldn't change them", but the updated one that tells git to pretend 
> that the local change is not there but still keep the local 
> modification, including deletion.  The work-tree "local changes" sparse 
> makes is a small subset of possible local changes assume-unchanged would 
> need to support.  It only deletes work tree files.

As I tried to convince you already, it is not wise to mix up the two 
meanings.  They _are_ different: in one case, we _have_ a file, and we 
even _expect_ the file to actually have the same contents as what is 
recorded in the index.  In the other case, we do _not_ have a file, so we 
do _not_ even expect the file to have the same contents.

In fact, in the latter case (the sparse case) we do not want to look for 
the file; not for the reason that we expect the contents to be the same 
anyway, but because we expect it not even to be there!

So while the _technical_ side is pretty much the same (most of the time, I 
illustrated a corner case, it it is very easy to think of other corner 
cases that might even be inadvertent, all the more reason to protect the 
user) -- don't look for the file -- the _semantics_ are _very_ different.

And you see that they are different when all of a sudden you cannot take 
the _absence_ of the file as the indicator for "assume-unchanged" and 
"sparse".

In fact, with the semantics implied by the label 'assume-unchanged', it 
could well be argued that making the file _absent_ (for the sparse 
checkout) is a dirty trick.  This is not what "assume that the file is 
unchanged" implies at all.

So let's just keep the semantics utterly simple and stupid, and have an

- assumed-unchanged bit, which assumes that a file is there, but that the 
  contents need not to be checked for performance reasons, and

- a no-checkout bit, which assumes that the user never checked out that 
  file (if it exists, it comes from somewhere else, and needs to be 
  protected like untracked files that would be overwritten by a branch 
  switch).

I hope this explanation was clear.

Ciao,
Dscho
