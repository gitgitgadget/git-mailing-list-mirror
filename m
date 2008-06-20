From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Introduce filter_independent() in commit.c
Date: Fri, 20 Jun 2008 13:53:06 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0806201350000.32725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <cover.1213917600.git.vmiklos@frugalware.org> <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org> <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org> <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org> <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
 <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org> <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org> <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org>
 <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org> <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 13:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fCC-0001lQ-Kz
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 13:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbYFTLxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYFTLxK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 07:53:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:35403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752834AbYFTLxI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 07:53:08 -0400
Received: (qmail invoked by alias); 20 Jun 2008 11:53:06 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp012) with SMTP; 20 Jun 2008 13:53:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TqzYE6RmTV3tOz6PWGk17KtcNkUFu2BYm9bAphS
	QQaI3jqiHe3Ac/
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85624>

Hi,

On Thu, 19 Jun 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > This is similar to git-show-branch --independent: It filters out commits
> > which are reachable from any other item from the input list.
> >
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> > ---
> >  commit.c |   16 ++++++++++++++++
> >  commit.h |    1 +
> >  2 files changed, 17 insertions(+), 0 deletions(-)
> >
> > diff --git a/commit.c b/commit.c
> > index 6052ca3..0dbf4b7 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -705,3 +705,19 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
> >  	free_commit_list(bases);
> >  	return ret;
> >  }
> > +
> > +struct commit_list *filter_independent(unsigned char *head,
> > +	struct commit_list *heads)
> > +{
> > +	struct commit_list *i, *bases, *ret = NULL;
> > +	struct commit_list **pptr = &ret;
> > +
> > +	commit_list_insert(lookup_commit(head), &heads);
> > +
> > +	bases = get_octopus_merge_bases(heads);
> > +
> > +	for (i = heads; i; i = i->next)
> > +		if (!(i->item->object.flags & RESULT))
> > +			pptr = &commit_list_insert(i->item, pptr)->next;
> 
> Hmm.  How well was this function tested?
> 
> Because RESULT is an implementation detail of merge_bases(), I do not
> think we would want to expose it outside of it.

Well, filter_independent() lives in commit.c, too, so it is in the same 
scope as merge_branches().

> More worryingly, the flag is supposed to be cleaned from the objects 
> after get_merge_bases() returns.  I am not sure what you'll learn by 
> looking at the flag here.

That is a valid point, methinks.  Probably the octopus_merge_base and the 
cleanup have to be decoupled here.  The cleanup should be nothing more 
than calling clear_commit_marks() for every head.

A test case would be desirable, but probably pretty complicated.  Hmm.  I 
like tests when they are simple, because they are easy to verify by a 
human.  Miklos, any chance for such a test case?

Ciao,
Dscho
