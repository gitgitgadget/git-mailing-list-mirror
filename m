From: Junio C Hamano <gitster@pobox.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 10:18:49 -0800
Message-ID: <7v8wdnooza.fsf@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFAq0-0000OD-9r
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 19:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZK3SSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbZK3SSw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 13:18:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZK3SSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 13:18:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7BA62A27FB;
	Mon, 30 Nov 2009 13:18:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ca+vYBsBEubpcKadmEDlh/nY2Co=; b=cbpUsV
	U69atCT1eSLwBCX46p6zihcG/zgxRG7SP9I1Ds8QFj5pHaf7HROpubQzcMFWcXDX
	hUIydTADbJ+X0bwQ4UmDZnYtc48O4rSh54/rNQDnXp6enAqq/L4SRILODfxCcoIz
	GPurBTRTHoFUXe5hcM2GbDhYcs/5QtlHZUsrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u4OHGEWOOFVZvm7Wvp9o4NPJoT50LkwG
	svYcVE4AVricCN7/nBOYyHaVCvXFpuVpqPhe6OE7ODUPv8Fuu1gUqw/3hdJ+E3cU
	3ysrdKnbQD+0FoFxU2vpwTFdgmODsCuEJwphNtlcobcDlMIbXa8fRMFlMR1AXmtl
	AliWo1FfUmw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A346A27F6;
	Mon, 30 Nov 2009 13:18:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 20C71A27F4; Mon, 30 Nov 2009
 13:18:50 -0500 (EST)
In-Reply-To: <cover.1259524136.git.brlink@debian.org> (Bernhard R. Link's
 message of "Mon\, 30 Nov 2009 15\:43\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D164A796-DDDC-11DE-B194-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134127>

"Bernhard R. Link" <brlink@debian.org> writes:

> My idea to solve this is combining both histories, the rebased/revised
> history and the actualy history, marking with some "equal-tree-merge"
> the point where they have the same result.

If you rewrite a series twice, your RFC will work like this, IIUC:

 * You have commit 1 and rewrite it to 2.  You record the difference
   between 1 and 2 on top of 1 as commit X and record a same-tree merge as
   A.  Here, A^1 == 2, A^2 == X, and 2^{tree} == A^{tree}.

       2-------A
      /       /
     0---1---X

 * You then rewrite it to 3.  You record the difference between A and 3
   (which is the same as between 2 and 3, because 2^{tree} == A^{tree})
   as commit Y, and record a same-tree merge as B.  B^1 == 3, B^2 == Y and
   3^{tree} == B^{tree}.

         Y---------------B
        /               /
       2-------A-------3
      /       /
     0---1---X

It however might be easier to review what happened if you create a history
this way upon the second rewrite (forget the second picture above):

       3-------.
      /         \
     0---2---W---B
      \         /
       1-------Z

That is, Z and W records the interdifff between 1 to 3 and 2 to 3
respectively, and B is a same-tree merge of 3, W and Z.

As you are giving some specific meaning to the order of merge parents of a
marker commit, namely, the first parent is the latest version of this
series (i.e. B^1 == 3), you can extend it to declare that the second
parent is the next to the latest incarnation (i.e. B^2 == W) and the third
one is one version older than the second one (i.e. B^3 == Z).

Doing it this way allows you to publish the final result "3" without any
cruft in the history.

In your code you have comment wondering if there is a better wording for
the fix-up commit you create during rebase when the trees do not match.  I
would suggest calling it "interdiff".  That is exactly what "git show W"
would show.

While I find the primary idea (i.e. keeping the old and new equivalents by
recording a merge of it, and using the first-parent to traverse when you
find such a special merge) reasonable (and as Dscho has pointed out, this
technique is widely used, I suspect---it is an obvious thing to do), I
think we need something stronger than just "this commit merges commits
that happen to have the same trees" as the marker.

Git is designed to work well in an environment where multiple people
produces identical result.  A 3-way merge resolves cleanly when both
branches modified a path to the same result (at contents level as well at
path level).  If you take this principle to the extreme, you should be
able to merge two branches that were developed independently but still
reached the same conclusion at the end, without marking such a merge as
anything funny.  With your RFC code, one branch will be mistakenly treated
as "old cruft that was improved by the other branch by rewriting".

To avoid that, I think (1) the marker has to be more reliable than just
"happens to have the same tree", and (2) the traversal done by Porcelains
(your patches 3 thru 5) by default should be unaware of eqt.

I don't know what a suitable marker should look like, though.  The marker
must be easily identifiable by the lowest level rev-list machinery, so it
needs to be a sign left somewhere in the commit object.  Perhaps making it
require to have the same tree as all its parents _and_ a well-known marker
string in the log message (and nothing else) would be a good start.

In the longer term, if the line of this direction turns out to be a good
one, I do not mind adding a special header to the commit object separate
from the log message, but we should start without one until this proves to
be a useful ingredient in people's workflows.  With a reliable marker, we
can obviously drop the "same-tree" ness from the definition of the marker
commit, which in turn means that you do not need "interdiff" commits while
rebasing.

The command to build such a merge could be an option to "git merge -s ours"
(perhaps something like "git merge -s ours -Xeqt").
