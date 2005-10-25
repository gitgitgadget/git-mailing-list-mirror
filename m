From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make fetch-pack play nicer with servers which do not
 speak multi_ack
Date: Tue, 25 Oct 2005 11:51:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510251104470.24174@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510250854240.22398@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy84igfrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-600504738-1130233865=:24174"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 11:52:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EULSl-0000Ge-5Y
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 11:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVJYJvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 05:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVJYJvI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 05:51:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62640 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932117AbVJYJvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 05:51:06 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9E78913F1A1; Tue, 25 Oct 2005 11:51:05 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 80083B0D34; Tue, 25 Oct 2005 11:51:05 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4F373B0D30; Tue, 25 Oct 2005 11:51:05 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 338A513F254; Tue, 25 Oct 2005 11:51:05 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy84igfrl.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10579>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-600504738-1130233865=:24174
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 25 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > +		if (insert)
> > +			insert_by_date(commit, &rev_list);
> > +		else
> >  			commit_list_insert(commit, &rev_list);
>=20
> Hmph.  I do not think insert_by_date and commit_list_insert on
> the same commit_list would play well together, since the former
> assumes that the list is already sorted by age (i.e. younger ones
> near the head, older ones close to the tail).

I=B4m sorry. The 2nd time, it should be &(rev_list_end->next), not=20
&rev_list. (See my reply to myself). In effect, rev_list would be filled=20
first by insert_by_date() with the refs we have and the known-to-be-commo=
n=20
refs from the other side. From then on, only commit_list_insert would=20
effectively *append* the ancestors. So it does play nicely. If there=B4s =
not=20
yet another bug.

> But you are right.  If you made 20 commits on top of my "master"
> branch head, we should send those 20 (and the commit you based
> on your changes, which the other end has), way before sending
> the ancient v0.99 tag.  Probably, we should never be sending
> v0.99 tag as "have" if we are going to send your "master" branch
> head, since the commit that tag refers to is reachable by your
> "master" branch head but there are a lot more commit between
> them, some of which will give us better "common" selected, and
> that v0.99 tag is what the other end said they have so is known
> to be ACKed if sent.

You=B4re right. Complete common refs are sent even if they are ancestors =
of=20
other complete common refs. I=B4ll think about that.

> Although we are doing a traversal on the fetch side to figure
> out the commit ancestry chain, I think we are not fully
> utilizing the information we receive from the other end.
> Typically we pull specific heads only, so get_remote_heads()
> culls the information about remote refs and you would not have a
> chance to know that v0.99 tag you have in your .git/refs/tags is
> something the remote also has, unless you asked for that
> particular tag.  I wonder if we can take advantage of that
> information without discarding it.  For example,
> get_remote_heads() itself knows the object name of v0.99.8 tag
> and the object name of the commit the tag refers to, and you
> have those objects locally already.  If you have many local
> branches, and v0.99.8 commit is reachable from the heads of all
> of your local branches, then you should be able to tell that you
> do not have to (and you do not want to) send "have" for v0.99.7
> and older tags even though they are also in your .git/refs/,
> since you know they are all reachable from v0.99.8 commit and
> likely to be worse common than v0.99.8.  The best common is
> somewhere between v0.99.8 and the tips of your local branches.

IOW v0.99.7 is an ancestor of v0.99.8, which is complete. Therefore, the=20
former should not be sent. Remember that we do not have to send the=20
optimal edges:

If v0.99.7 were the optimal common rev for some_branch, but we send=20
v0.99.8, the server side will do a "git-rev-list some_branch ^v0.99.8",=20
which has the same effect as if passing "^v0.99.7" instead.

So let=B4s change the definition of COMMON_REF to not include COMMON. The=
n,=20
do not mark the COMMON_REFs in find_common, but before that. And mark=20
their ancestors (as far as they were already parsed in everything_local()=
)=20
as COMMON.

Oh, and pass nr_match=3D0 to get_remote_heads() and do the culling after=20
using the information.

> This is a minor nit but I think you no longer need to have the
> rev_list_end in this version.  It is only used to maintain
> itself and not for any other purpose as far as I can see.

My mistake: the revs should be appended, not unshifted into rev_list.

If they got unshifted, that would mean that we first send all the=20
ancestors of the youngest refs until we get a common rev, then all the=20
ancestors of the 2nd youngest, etc.

When the revs are appended instead, first all the refs get sent (sorted b=
y=20
date), then the parents of them (sorted by the date of the refs), then=20
their grand parents, etc.

While writing this, I cannot remember why I decided not to=20
insert_by_date() all the time.

Ciao,
Dscho

---1148973799-600504738-1130233865=:24174--
