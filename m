From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 12:42:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908271139520.7562@intel-tinevez-2-302>
References: <1251337437-16947-1-git-send-email-johan@herland.net> <1251337437-16947-9-git-send-email-johan@herland.net> <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 12:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgcQv-0004Q2-SG
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 12:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbZH0KmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 06:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbZH0KmK
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 06:42:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:47745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750768AbZH0KmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 06:42:09 -0400
Received: (qmail invoked by alias); 27 Aug 2009 10:42:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 27 Aug 2009 12:42:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J745/lOOJq4d829KMokLwhGJarzaRVokYIVhXqH
	/nooIBgAV8r/n3
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127153>

Hi,

On Wed, 26 Aug 2009, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > The semantics used when parsing notes trees (with regards to fanout subtrees)
> > follow Dscho's proposal fairly closely:
> > - No concatenation/merging of notes is performed. If there are several notes
> >   objects referencing a given commit, only one of those objects are used.
> > - If a notes object for a given commit is present in the "root" notes tree,
> >   no subtrees are consulted; the object in the root tree is used directly.
> > - If there are more than one subtree that prefix-matches the given commit,
> >   only the subtree with the longest matching prefix is consulted. This
> >   means that if the given commit is e.g. "deadbeef", and the notes tree have
> >   subtrees "de" and "dead", then the following paths in the notes tree are
> >   searched: "deadbeef", "dead/beef". Note that "de/adbeef" is NOT searched.
> > - Fanout directories (subtrees) must references a whole number of bytes
> >   from the SHA1 sum they subdivide. E.g. subtrees "dead" and "de" are
> >   acceptable; "d" and "dea" are not.
> > - Multiple levels of fanout are allowed. All the above rules apply
> >   recursively. E.g. "de/adbeef" is preferred over "de/adbe/ef", etc.
> 
> If I am reading this correctly, the earlier parts of the series were
> aiming to let multiple people to add notes to the same commit more or less
> uncordinated while still allowing to merge them sensibly, but now such a
> workflow becomes impossible with this change.  
> 
> The above claims notes trees with different levels of fan-out are allowed,
> but what it really means is that merging notes trees with different levels
> of fan-out will produce a useless result that records notes for the same
> commit in different blobs all over the notes tree, and asking the notes
> mechanism to give the notes for one commit will give only one piece that
> originates in the tree whose creator happened to have used the longest
> prefix while ignoring all others.  It may _allow_ such a layout, but how
> would such semantics be useful in the first place?
> 
> I suspect that I am missing something but my gut feeling is that this
> change turns an interesting hack (even though it might be expensive) into
> a hack that is not useful at all in the real world, without some order,
> discipline, or guideline is applied.
> 
> What's the recommended way to work with this system from the end user's
> point of view in a distirbuted environment?  Somebody up in the project is
> supposed to decide what fan-out is to be used for the whole project and
> everybody should follow that structure?  If a participant in the project
> forgets that rule (or makes a mistake), a notes tree that mistakenly
> merges his notes tree becomes practically useless?  If so, perhaps we
> would need a mechanism to avoid such a mistake from happening?

Hmm...

Maybe you're right (and mugwump was right all along) that _all_ matching 
notes should be shown...

Ciao,
Dscho
