From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 19:55:40 +0100
Message-ID: <20091130185540.GA5764@pcpool00.mathematik.uni-freiburg.de>
References: <cover.1259524136.git.brlink@debian.org> <7v8wdnooza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 19:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFBPW-0007kE-Ql
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 19:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZK3Szf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 13:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbZK3Sze
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 13:55:34 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:45825
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbZK3Sze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 13:55:34 -0500
Received: from pcpool01.mathematik.uni-freiburg.de ([132.230.30.151])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NFBPQ-0002Em-Ag
	for git@vger.kernel.org; Mon, 30 Nov 2009 19:55:40 +0100
Received: from brl by pcpool01.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NFBPQ-0001Xr-8p
	for git@vger.kernel.org; Mon, 30 Nov 2009 19:55:40 +0100
Content-Disposition: inline
In-Reply-To: <7v8wdnooza.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134129>

* Junio C Hamano <gitster@pobox.com> [091130 19:19]:
> "Bernhard R. Link" <brlink@debian.org> writes:
> 
> > My idea to solve this is combining both histories, the rebased/revised
> > history and the actualy history, marking with some "equal-tree-merge"
> > the point where they have the same result.
> 
> If you rewrite a series twice, your RFC will work like this, IIUC:
> 
>  * You have commit 1 and rewrite it to 2.  You record the difference
>    between 1 and 2 on top of 1 as commit X and record a same-tree merge as
>    A.  Here, A^1 == 2, A^2 == X, and 2^{tree} == A^{tree}.
> 
>        2-------A
>       /       /
>      0---1---X
> 
>  * You then rewrite it to 3.  You record the difference between A and 3
>    (which is the same as between 2 and 3, because 2^{tree} == A^{tree})
>    as commit Y, and record a same-tree merge as B.  B^1 == 3, B^2 == Y and
>    3^{tree} == B^{tree}.
> 
>          Y---------------B
>         /               /
>        2-------A-------3
>       /       /
>      0---1---X

I think it rather looks like this:

     3---------------B
     |              /
     | 2-------A---Y
     |/       /
     0---1---X

>
>        3-------.
>       /         \
>      0---2---W---B
>       \         /
>        1-------Z
>
> That is, Z and W records the interdifff between 1 to 3 and 2 to 3
> respectively, and B is a same-tree merge of 3, W and Z.

I think changing it to get this would be easy (though only in the case
where the very last commit was such an equal tree merge), but I do not
think it would be actually better:

- it is no longer possible to see the history of changes by just walking
  right on every equal-tree-merge.
- commit a no longer exists. If some downstream already has
  cloned/pulled, no fast-forward is possible any more.

> While I find the primary idea (i.e. keeping the old and new equivalents by
> recording a merge of it, and using the first-parent to traverse when you
> find such a special merge) reasonable (and as Dscho has pointed out, this
> technique is widely used, I suspect---it is an obvious thing to do), I
> think we need something stronger than just "this commit merges commits
> that happen to have the same trees" as the marker.

I've considered adding a new header or only a magic description text for those
commits, but I think it is not necessary.
Because the actual programs making it useful to treat this special
(format-patch producing too many patches, rebases possibly showing conflicts
already resolved and bisect walking too many branches) will be the same when
two branches only resulting in the same tree by pure chance show up.

> To avoid that, I think (1) the marker has to be more reliable than just
> "happens to have the same tree", and (2) the traversal done by Porcelains
> (your patches 3 thru 5) by default should be unaware of eqt.

I think for patch 3 (format-patch) and 4 (rebase -i) it is always better to
have the new behaviour even when only hitting equal trees by chance.
I'm unsure about 5 (rebase -m), but guess it still is.

> I don't know what a suitable marker should look like, though.  The marker
> must be easily identifiable by the lowest level rev-list machinery, so it
> needs to be a sign left somewhere in the commit object.  Perhaps making it
> require to have the same tree as all its parents _and_ a well-known marker
> string in the log message (and nothing else) would be a good start.

It already does always create a unique log message. So one could also
have one more strict and one less strict mode (and some option to decide
on the default).

Hochachtungsvoll,
	Bernhard R. Link
-- 
"Never contain programs so few bugs, as when no debugging tools are available!"
	Niklaus Wirth
