From: Theodore Tso <tytso@mit.edu>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 10:56:10 -0500
Message-ID: <20081215155610.GA11502@mit.edu>
References: <808wqhzjl9.fsf@tiny.isode.net> <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com> <20081215140834.GA3684@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 16:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCFpA-0003nr-Dg
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 16:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYLOP4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2008 10:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbYLOP4S
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 10:56:18 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:48861 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751657AbYLOP4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 10:56:17 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LCFnn-0003sM-Ug; Mon, 15 Dec 2008 10:56:12 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LCFnm-0003jK-I1; Mon, 15 Dec 2008 10:56:10 -0500
Content-Disposition: inline
In-Reply-To: <20081215140834.GA3684@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103174>

On Mon, Dec 15, 2008 at 03:08:34PM +0100, Bj=F6rn Steinbrink wrote:
> To clarify that a bit more: git gc keeps unreachable objects unpacked=
,
> so that git prune can drop them. And git gc invokes git prune so that
> only unreachable objects older than 2 weeks are dropped.

To be even more explicit, "git gc" will **unpack** objects that have
become unreachable and were currently in packs.  As a result, the
amount of disk space used by a git repository can actually go **up**
dramatically after a "git gc" operation, which could be surprising for
someone who is running close to full on their filesystem, deletes a
number of branches from a tracking repository, and then does a "git
gc" may get a very unpleasant surprise.

A really good repository which shows this is linux-next, since it is
constantly getting rewound, and old branches are reserved via a tag
such as next-20081204.  If you update the your local copy of the
linux-next repository every day, you will accumulate a large number of
these old branch tags.  If you then delete a whole series of them, and
run git-gc, the operation will take quite a while, and the number of
blocks and inodes used will grow significantly.  They will disappear
after a "git prune", but when I do this housekeeping operation, I've
often wished for a --yes-I-know-what-I-am-doing-and-it's-unsafe-but-
just-drop-the-unreachable-objects-cause-this-is-just-a-tracking-reposit=
ory
option to "git gc".

						- Ted
