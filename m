From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [RFC] blame: new option to better handle merged cherry-picks
Date: Thu, 2 Jan 2014 22:15:07 +0100
Message-ID: <20140102211507.GA6323@client.brlink.eu>
References: <20140102175529.GA4669@client.brlink.eu>
 <xmqqlhyyp1oo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vypdg-0007jZ-WC
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaABVRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:17:08 -0500
Received: from server.brlink.eu ([78.46.187.186]:49405 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaABVRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:17:07 -0500
Received: from workstation.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash VPEZql)
	id 1VypdX-0008It-DL; Thu, 02 Jan 2014 22:17:03 +0100
Received: with local; Thu, 02 Jan 2014 22:15:08 +0100
Content-Disposition: inline
In-Reply-To: <xmqqlhyyp1oo.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239884>

* Junio C Hamano <gitster@pobox.com> [140102 21:29]:
> > This optimization, while being faster in the usual case, means that in
> > the case of cherry-picks the blamed commit depends on which other commits
> > touched a file.
> >
> > If for example one commit A modified both files b and c. And there are
> > commits B and C, B only modifies file b and C only modifies file c
> > (so that no conflicts happen), and assume A is cherry-picked as A'
> > and the two branches then merged:
> >
> > --o-----B---A
> >    \         \
> >     ---C---A'--M---
>
> So the contents of b at M is as the same as in A, so following 'b'
> will see A and B changed that path, which is correct.
>
> The contents of c at M is?  It is different from A because at A c
> lacks the change made to it at C.  The merged result at M would
> match C in A', no?  So following 'c' will see A' and C changed that
> path, no?
>
> So what is wrong about it?

It's not wrong (that's why I do not suggest to change the default
behaviour), but it's inconsistent and can be a bit confusing to
have either the one or the other commit blamed depending on whether
some file was touched or not.
The history I'm a bit more concerned is something like (with ...
being unrelated commits not touching B or C):

 --o-----...---A--...---B---...--
    \                            \
     ---...---A'--...---C---...---M---


Here having B or C touching b or c determines which of A or A' is
blamed for which part of the patch.

It's even enough to have:

       --...---A'--...---B---...--
      /                            \
 ---o---...---A--................---M---

To have the A/A' changes of c to be attributed to A while the b changes
are attributed to A'. I.e. you have a master branch that has commit A,
which is also cherry-picked to some previously forked side-branch.
Once that side-branch is merged back, parts of the change are attributed
to A' if they are in a file that is not touched otherwise in the main
branch.


> Also, when handling a merge, we have to handle parents sequencially,
> checking the difference between M with its first parent first, and
> then passing blame for the remaining common lines to the remaining
> parents.  If you flip the order of parents of M when you merge A and
> A' in your original history, and with your patch, what would you
> see when you blame c?  Wouldn't it notice that M:c is identical to c
> in its first parent (now A') and pass the whole blame to A' anyway
> with or without your change?

When giving git-blame the new option introduced with my patch, only
the order of parents determines which commit is blamed. Without
the option (i.e. the currently only possible behaviour) which commit
is blamed depends what else touches other parts of the file.
If both branches make modifications to the file (or if there is
any merge conflict resolution in the merge) then the bahaviour with
or without the option are the same.

But in the example with one commit B touching also b and one commit C
touching also c, there is (without the new option) always one part
of the cherry-picked commit is blamed on the original and one on the
cherry-picked, no matter how you order the parents.
(While by having your mainline always the most leftward parent, with
the the new option you always get those commit blamed that is the
"first one this was introduced to mainline".)

	Bernhard R. Link
-- 
F8AC 04D5 0B9B 064B 3383  C3DA AFFC 96D1 151D FFDC
