From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What I want rebase to do
Date: Thu, 7 Mar 2013 09:48:29 +0100
Message-ID: <87r4jra942.fsf@pctrast.inf.ethz.ch>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
	<7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
	<87sj4aoo3s.fsf@pctrast.inf.ethz.ch>
	<7vppzex2pq.fsf@alter.siamese.dyndns.org>
	<201303061855.r26ItKtM018797@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 07 09:49:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDWVY-0000AL-7B
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 09:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225Ab3CGIse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 03:48:34 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:59133 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002Ab3CGIsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 03:48:33 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Mar
 2013 09:48:22 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 7 Mar 2013 09:48:29 +0100
In-Reply-To: <201303061855.r26ItKtM018797@freeze.ariadne.com> (Dale
	R. Worley's message of "Wed, 6 Mar 2013 13:55:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217581>

worley@alum.mit.edu (Dale R. Worley) writes:
[...snip...]

Isn't that just a very long-winded way of restating what Junio said
earlier:

> > It was suggested to make it apply the first-parent diff and record
> > the result, I think.  If that were an acceptable approach (I didn't
> > think about it through myself, though), that would automatically
> > cover the evil-merge case as well.

You can fake that with something like

git rev-list --first-parent --reverse RANGE_TO_REBASE |
while read rev; do
    if git rev-parse $rev^2 >/dev/null 2>&1; then
        git cherry-pick -n -m1 $rev
        git rev-parse $rev^2 >.git/MERGE_HEAD
        git commit -C$rev
    else
        git cherry-pick $rev
    fi
done

Only tested very lightly.  Dealing with octopii, conflicts and actually
preserving the commit's attributes is left as an exercise to the
reader[1].

I still think that the _right_ solution is first redoing the merge on
its original parents and then seeing how the actual merge differs from
that.  --preserve-merges has bigger issues though, like Junio said.

Perhaps a new option to git-rebase could trigger the above behavior for
merges, who knows.  (It could be called --first-parent.)


[1]  If you don't get the sarcasm: that would amount to reinventing
large parts of git-rebase.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
