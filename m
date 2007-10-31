From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 05:17:51 +0100
Message-ID: <20071031041751.GA3326@atjola.homenet>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <Pine.LNX.4.64.0710310329520.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 05:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In51s-0001mx-NF
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 05:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbXJaERz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 00:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbXJaERz
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 00:17:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750879AbXJaERy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 00:17:54 -0400
Received: (qmail invoked by alias); 31 Oct 2007 04:17:52 -0000
Received: from i577B89A4.versanet.de (EHLO localhost) [87.123.137.164]
  by mail.gmx.net (mp048) with SMTP; 31 Oct 2007 05:17:52 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/pPQlEj8bpSeHoCS7Ub2bJIQRyHHdXLfjIMy0z8D
	C9et1Adkqi7p4U
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710310329520.4362@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62789>

On 2007.10.31 03:34:47 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 31 Oct 2007, Bj=F6rn Steinbrink wrote:
>=20
> > @@ -246,6 +292,13 @@ OPTIONS
> >  	Instead of ignoring merges, try to recreate them.  This option
> >  	only works in interactive mode.
> > =20
> > +\--first-parent::
> > +	Only follow the first parent commits in merge commits when lookin=
g
> > +	for the commits that are to be rebased. This is most useful with =
-p
> > +	as it will cause rebase to recreate the merges against the origin=
al
> > +	branches instead of rebasing those branches as well. This option
> > +	only works in interactive mode.
> > +
>=20
> Hmm.  I had to read this several times to understand it.  Maybe somet=
hing=20
> like this instead?
>=20
> \--first-parent::
> 	When you want to preserve merges, this option allows you to rebase=20
> 	only the commits which were not merged in, i.e. which are in the
> 	first parent ancestry of the current HEAD.
> +
> This option only makes sense together with --preserve-merges.

Hm, I think that it might make might sense without -p. Say that your
topic branch is following two other branches like this:

---o---o---o--------o topicB
            \        \
--o---A---o---o---o---o---B topicA
         /       /
o---o---o---o---o master

topicB branched off from master earlier than topicA and you currently
require stuff from master..topicB _and_ topicB..master, so AFAICT, you
need sth. like the above.

Let's say that topicB simplifies some internal API and you desperately
wanted to use that, while master introduced some new stuff that you als=
o
use. Now your stuff is finished, but it becomes obvious that topicB is
still too broken to go into master any time soon. Then you could do:

git rebase -i --first-parent master topicA

to get:

--o---o---o topicB (branched from master somewhere to the left)

             o---o---o---A---B topicA
            /
---o---o---o master

Depending on how much topicA really depends on topicB, you might need t=
o
fix a bunch of stuff, but it might be worth it.

How about:
\--first-parent::
	When this option is given and --preserve-merges is not, then
	merge commits are completely ignored and only commits from the
	first parent ancestry are rebased. This allows to pretend that
	merges never happened.

	If --preserve-merges is also given, the merge commits are
	preserved, but only their first parent is rebased as opposed to
	the default behaviour which would rebase all parents.

> Also, could you please add a test case to make sure that your patch w=
orks=20
> as advertised (and that this functionality will not be broken in futu=
re=20
> commits)?

Ok, might take some time, as I currently have no clue how the test stuf=
f
for git works :-/ Well, I'm sure #git will be helpful :-)

Thanks,
Bj=F6rn
