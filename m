From: "Craig Tataryn" <craiger@tataryn.net>
Subject: Re: Help with merge and git-svn
Date: Fri, 26 Sep 2008 13:02:03 -0500
Message-ID: <8384c2b90809261102l4cd24be7m6be0afde45ccf15@mail.gmail.com>
References: <8384c2b90809260936m21c14e0dve5b08b021da4a342@mail.gmail.com>
	 <20080926172331.GA7879@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 20:03:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjHew-0001Hs-3S
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 20:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYIZSCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2008 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYIZSCG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 14:02:06 -0400
Received: from hs-out-0708.google.com ([64.233.178.250]:43676 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYIZSCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 14:02:04 -0400
Received: by hs-out-0708.google.com with SMTP id 4so292261hsl.5
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 11:02:03 -0700 (PDT)
Received: by 10.100.152.5 with SMTP id z5mr1565385and.86.1222452123361;
        Fri, 26 Sep 2008 11:02:03 -0700 (PDT)
Received: by 10.100.209.12 with HTTP; Fri, 26 Sep 2008 11:02:03 -0700 (PDT)
In-Reply-To: <20080926172331.GA7879@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96880>

On Fri, Sep 26, 2008 at 12:23 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
> On 2008.09.26 11:36:48 -0500, Craig Tataryn wrote:
>> Hi, first time poster to kernel.org mailing lists, so if I commit a
>> taboo, please be kind to me :)
>>
>> I have the following scenario:
>>
>> [remote deveoper]<=3D=3D=3D>[shared git repo]<=3D=3D=3D>[me]<=3D=3D=3D=
>[client's svn repo]
>>
>> So my remote developer and I push and pull to/from the shared git
>> repo, and then I sync changes to and from the client's svn repo usin=
g
>> git-svn.
>>
>> My problem is, when I am ready to merge changes from my local master
>> branch to trunk-local, if I do a "git merge master" and then try to
>> issue any git-svn commands I get the following errors:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> $ git merge master
>> Updating d88106e..77b86ae
>> Fast forward
>>  community/pom.xml |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> $ git svn dcommit
>> Can't call method "full_url" on an undefined value at
>> /usr/local/git/libexec/git-core/git-svn line 425.
>>
>> $ git svn rebase
>> Unable to determine upstream SVN information from working tree histo=
ry
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> The only way I've seem to be able to remedy this is if I add the
>> "subtree" merge strategy to the merge command:
>>
>> git merge -s subtree master
>>
>> Then git-svn doesn't get confused about it's repo, but when you look
>> at the repo using gitk, you see something like:
>>
>> [trunk-local]--[remotes/trunk]  Merge branch 'master' into trunk-loc=
al
>> | \
>> |  \
>> |    [master]--[remotes/origin/master]  "Some commit message from th=
e
>> last master commit"
>> |    |
>> |    |
>> |  /
>> /
>>
>> When I use the normal merge strategy then gitk shows all branches at
>> the same level, but git-svn is of course b0rked.
>>
>> So I guess my question is, am I stuck using "-s subtree", is this th=
e
>> right course of action??  Or can I get this to work with the default
>> strategy?  Is this symptomatic of a messed up or disjoint history
>> (i.e. early on I did some --squash merges).
>>
>> I have full control over the shared repo and I don't mind blowing it
>> away and rebuilding it based on what's in SVN if that's what it take=
s.
>
> The original merge you did ended up as a fast-forward, ie. no merge
> commit was created. I guess that your history is so, that somehow the
> remotes/trunk stuff is reachable through the second parent of some me=
rge
> commit that exists in your history. But git-svn uses --first-parent t=
o
> find its upstream, so it cannot find that in your scenario. I guess i=
t's
> best if you use "git merge --no-ff master" to force the creation of a
> merge commit. Subtree happens to work because it implies --no-ff, but
> I'm not sure whether there might be downsides to using the subtree
> strategy, so I'd rather go with the explicit --no-ff and the normal
> merge strategies.
>
> Bj=F6rn
>

Thanks for this tip Bjorn, I'll give it a shot.

--=20
Craig Tataryn
site: http://www.basementcoders.com/
podcast:http://feeds.feedburner.com/TheBasementCoders
irc: ThaDon on freenode #basementcoders, ##wicket, #papernapkin
im: craiger316@hotmail.com, skype: craig.tataryn
