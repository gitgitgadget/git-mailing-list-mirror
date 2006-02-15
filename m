From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 11:42:55 +0100
Message-ID: <43F305AF.70808@op5.se>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060215101136.GB26911@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 11:43:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9K7g-0002wE-SF
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 11:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWBOKm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Feb 2006 05:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBOKm5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 05:42:57 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:64135 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751134AbWBOKm4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 05:42:56 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 756656BCFF; Wed, 15 Feb 2006 11:42:55 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060215101136.GB26911@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16231>

Karl Hasselstr=F6m wrote:
> On 2006-02-14 15:58:02 -0500, Chuck Lever wrote:
>=20
>=20
>>Karl Hasselstr=F6m wrote:
>>
>>
>>>No, I literally want the opposite of "stg commit", so that the
>>>sequence "stg commit; stg uncommit" has zero net effect.
>>
>>well, that would work OK for maintainers, but would be kind of
>>strange for folks who are pulling from such a repository. how would
>>that work?
>=20
>=20
> I didn't plan to publish branches where this kind of history munging
> was being done. It's precisely like "git rebase" in that regard --
> it's a tool for cleaning up history before it is published.
>=20
>=20
>>my impression of git is that you don't change stuff that's already
>>committed. you revert changes by applying a new commit that backs
>>out the original changes.
>=20
>=20
> You don't change stuff that's already committed _and published_ (well=
,
> except for pu branches :-). Rewriting history is perfectly OK up unti=
l
> the moment someone has pulled your branch.
>=20
>=20
>>i'm speculating, but i suspect that's why there's a "stg pick
>>--reverse" and not a "stg uncommit."
>=20
>=20
> I don't think I've been very successful in communicating exactly what
> I want "stg uncommit" for. It's not that I want to undo a committed
> change -- what I want is to transform it into an stgit patch so that =
I
> can edit it with a minimum of effort.
>=20
>   $ edit edit edit
>   $ git-commit -a -m "create foo"
>   $ edit edit edit
>   $ git-commit -a -m "improve foo"
>   $ edit edit edit
>   $ git-commit -a -m "improve bar"
>=20
>   # Oops, I realize that the "create foo" changeset had a debug
>   # printout left in it, and I wasn't already using stgit.
>=20
>   $ stg init
>   $ stg uncommit improve-bar improve-foo create-foo
>   $ stg stg pop --to=3Dcreate-foo
>   $ edit --remove=3Ddebug-printout
>   $ stg refresh
>   $ stg push --all
>=20

The same workflow, with less hassle (and already implemented)

$ git format-patch -k HEAD~3
$ edit 0001-*
$ git am -k 000*


> Similar use-cases for e.g. reordering commits, merging commits,
> deleting one commit in the middle of a chain of good ones, etc. are
> easy to come up with. The point is that stgit alreay handles all this=
,
> _but only if you have been using stgit from the start_. What "stg
> uncommit" does is basically to import (linear) git history into stgit=
,
> where a powerful toolset exists to edit it.
>=20
> You can actually do this today; just create a new branch where you
> want your new stgit stack to be based, and "stg pick" the
> commits/patches from the old branch:
>=20
>   $ git-checkout -b new-branch HEAD^^^
>   $ stg init
>   $ stg pick old-branch^^^ -n create-foo
>   $ stg pick old-branch^^ -n improve-foo
>   $ stg pick old-branch^ -n improve-bar
>   $ git-branch -D old-branch
>   $ git-checkout -b old-branch
>   $ git-branch -d new-branch
>=20
> This series of commands also converts the top three commits to stgit
> patches, and leaves the user on the same branch where she started (it
> does _exactly_ the same job as "stg uncommit improve-bar improve-foo
> create-foo"), but it's a lot of work, and a typo could lose commits.
>=20

Isn't this akin to what "git cherry-pick" does, except for the "convert=
=20
to stgit patches" thing?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
