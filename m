From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 21:15:10 +0200
Message-ID: <87zjwqpebl.fsf@hexa.v.cablecom.net>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
	<CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
	<CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMCy-0007vU-1f
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab3DVTPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:15:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:51316 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab3DVTPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 15:15:14 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 21:15:10 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 21:15:10 +0200
In-Reply-To: <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 22 Apr 2013 22:59:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222046>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>> And if you're still not convinced, run 'git log HEAD^2 -- README.md'
>> from the toplevel directory.  You'll get the log of README.md from the
>> subproject.
>
> On IRC, Thomas explained to me that mixing in changes from various
> branches into the pathspec will break this so-called determinism.  To
> try it out for yourself, do:
>
>     $ cd /tmp
>     $ git clone gh:trast/subtree-mainline-example
>     $ cd subtree-mainline-example
>     $ git log HEAD^2 -- sub # only lists the side changes
>     $ git log -- dir/sub # only lists the mainline changes
>
> What we should really expect is a mix of the two.

So after lots of confusing misunderstandings across the entire thread,
and a long IRC discussion, I do have one take-away that I think is worth
writing down:

There is a market for a rename detection that works at the tree level.

Bear with me while I explain.

The average subtree merge (after the initial one) looks like this,
focusing on the subtree:

  M    new state in sub/
  | \
  |  * new state in /
  |
  * old state in sub/

(The example in the quote above additionally complicates the issue by
changing sub/ in the mainline.)

Ideally we'd like our hypothetical fixed --follow to accurately track a
pathspec 'sub/foo' so that in the mainline it remains the same, but in
the side it becomes 'foo'.  Because of reasons already explained in
earlier mails, -M does not suffice for all cases (in particular, it
fails if there is a /foo in the mainline too).  -C works, but is slow.

So how can we fix that?  We could try to somehow figure out that M:sub/
refers to the same thing as M^2:/, by looking at them at the tree level.
Let's provisionally call this --follow-tree-rename.

I don't quite know how to heuristically[1] detect such a rename, but
since 'merge -ssubtree' does it (if you don't specify a tree prefix
explicitly), it can't be That Hard(tm).  If we're extra lucky it's fast
enough to be enabled by default.

In the special case where the subtree was not modified in the mainline
since the last merge, the problem is pretty trivial: simply check if any
subtree of M agrees with the root tree of each merge parent; if so, diff
those trees instead of the root trees.

That should then help subtree users to get better logs.


[1]  the quoted example shows that you can't just go looking for
identical trees in the general case, so it is really a heuristic

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
