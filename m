From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Thu, 21 Aug 2008 23:10:54 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 06:15:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWO3o-0002TY-RC
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 06:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbYHVEL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 00:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbYHVEL2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 00:11:28 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:47360 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbYHVEL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 00:11:27 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7M4Aux7032512;
	Thu, 21 Aug 2008 23:10:56 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7M4AsYW009239;
	Thu, 21 Aug 2008 23:10:54 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93249>

Hi,

Jonathan Nieder wrote:

> I quite like the idea of this patch series.  When I try to test it with
> "git merge jc/ita; make test", t0020-crlf setup fails
[...]
> This could be me doing something [stupid]

and it was.  In a sleepy daze, I resolved a conflict

<<<<<<<
#define ADD_CACHE_IGNORE_REMOVAL 8
=======
#define ADD_CACHE_INTENT 8
>>>>>>>

by using the same bit for both.  Sorry for the noise.

Others can experience that unpleasant error message for themselves
with next + jc/add-ita merged properly:

	$ mkdir test-repo && cd test-repo
	$ git init
	Initialized empty Git repository in /var/tmp/jrnieder/test-repo/.git/
	$ : >a
	$ git add -N a
	$ git commit
	error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
	error: Error building trees

I think the first error comes from update_one, which creates a tree
object from the index.  It is complaining, because after all, that
object is not in any sha1 file.

If the empty blob happened to be in our object database, the user's
mistake would be hidden:

	$ git add a && git commit
	error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
	error: Error building trees
	$ git rm -f --cached a
	rm 'a'
	$ git add a
	$ git commit -m initial
	$ echo hi >b
	$ git add -N b
	$ git commit && echo ok
	Created commit 91325db: some commit message
	 0 files changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 b
	ok

Maybe it would be better to use some other magic blob (or a bit
somewhere) to remember that the file has not been added yet.

Thoughts?

Regards,
Jonathan
