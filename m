From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 23:45:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172339040.8306@pacific.mpi-cbg.de>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <7vtz06xxao.fsf@alter.siamese.dyndns.org> <7vvdkmwfqs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1188527963-1250545530=:8306"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:44:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdA0Y-0003gr-06
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbZHQVom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZHQVom
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:44:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:54027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbZHQVol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:44:41 -0400
Received: (qmail invoked by alias); 17 Aug 2009 21:44:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 17 Aug 2009 23:44:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SGb1UfFJSRfY3cfeaysI7zBKN2iZAHv9/PP1DfS
	dxIzi5IBFhGMPm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdkmwfqs.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126296>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1188527963-1250545530=:8306
Content-Type: TEXT/PLAIN; charset=VISCII
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Local changes in git do not belong to any particular branch.  They 
> > belong to the work tree and the index.  Hence you (1) can switch from 
> > branch A to branch B iff the branches do not have difference in the 
> > path with local changes, and (2) have to stash save, switch branches 
> > and then stash pop if you have local changes to paths that are 
> > different between branches you are switching between.
> >
> > How should assume-unchanged play with this philosophy?
> >
> > I'd say that assume-unchanged is a promise you make git that you won't 
> > change these paths, and in return to the promise git will give you 
> > faster response by not running lstat on them.  Having changes in such 
> > paths is your problem and you deserve these chanegs to be lost.  At 
> > least, that is the interpretation according to the original 
> > assume-unchanged semantics.
> 
> Having said that, we could (re)define assume-unchanged to mean "I may or
> may not have changes to these paths, but I do not mean to commit them, so
> do not show them as modified when I ask you for diff.  But the changes are
> precious nevertheless"

I am hesitant.  The feature was introduced because of some report that Git 
was too slow.  While the speed has increased dramatically (the report was 
for Windows), we cannot work miracles: the file system layer is just not 
cooperative.

So I could imagine that redefining the meaning of assume-unchanged results 
in a substantially longer runtime again, which some people (yours truly) 
might interpret as regression.

> I think the writeout codepath pays attention to assume-unchanged bit 
> already for that reason (CE_MATCH_IGNORE_VALID is all about this issue).

If I were that reporter, I would not be happy, I guess.  Basically, when 
new files come in and I marked all the files as "assume unchanged; I know 
what I'm doing!" Git would tell me "no you're an idiot, dummy, I know 
better, and I will check all over again!".

> So with that, how should assume-unchanged play with the "local changes 
> belong to the index and the work tree"?
> 
>  - When adding to the index, the changes should be ignored;
> 
>  - When checking out of the index?  I.e. the user tells "git checkout
>    path" when path is marked as assume-unchanged.  Such an explicit
>    request should probably lose the local changes in the work tree.
> 
>  - When checking out of a commit?  The same deal.
> 
>  - When switching branches?
> 
>    - If the branches do not touch assume-unchanged paths, we should keep
>      changes _and_ assume-unchanged bit.  I do not know if that is what
>      the current code does.
> 
>    - If the branches do touch assume-unchanged paths, what should happen?
>      We shouldn't blindly overwrite the local changes, so at least we
>      should change the code to error out if we do not already do so.  But
>      then what?  How does the user deal with this?  Perhaps...
> 
>      - Drop assume-unchanged temporarily;
>      - Stash save;
>      - Switch;
>      - Stash pop;
>      - Add assume-unchanged again.
> 
>      ???

In my book all this is overly complicated.  If I tell Git to assume a file 
is unchanged, it is not Git's business to question me.

> Is such an updated (or "corrected") assume-unchanged any different from a
> sparse checkout?  After all, paths that are not to be checked out in a
> sparse checkout are "pretend that the lack of these paths are illusion--they
> are logically there.  I do not intend to commit their removal, and I do not
> want to lose the sparseness across branch switch".
> 
> There is one nit about this.  If a path is outside the checkout area,
> should it unconditionally stay outside the checkout area when you switch
> branches?  I may be interested in not checking out Documentation/
> subdirectory and that may hold true for all _my_ branches, and it is a
> sane thing not to complain "Oops, you actually removed Makefile in
> Documentation/ in your work tree in reality, and you are switching to
> another branch that has a different Makefile --- it is a delete-modify
> conflict you need to resolve, and we won't let you switch branches" in
> such a case.
> 
> But is that generally true in all "sparse checkout" settings?
> 
> It is unfortunate that this message raises more questions than it answers,
> but I think a sparse checkout will have to answer them, whether it uses a
> bit separate from assume-unchanged or it reuses the assume-unchanged bit.

I think you will come around and agree that the original, very simple 
therefore powerful, concept of "assume-unchanged" should be, well, 
unchanged, and not be bent to half-fit the original intention and half-fit 
the sparse intention.

Rather, I agree with Nguy­n that the no-checkout bit (which is definitely 
free to behave differently from assume-unchanged) is needed.

Maybe I contradict myself here with what I said after the third iteration 
of the sparse checkout series, but that only proves that I am able to 
learn.

Ciao,
Dscho

--8323328-1188527963-1250545530=:8306--
