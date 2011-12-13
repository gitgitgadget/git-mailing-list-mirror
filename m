From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: Auto update submodules after merge and reset
Date: Tue, 13 Dec 2011 10:45:03 +0100
Message-ID: <4EE71E9F.90204@ursus.ath.cx>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE51D7B.7020806@ursus.ath.cx> <4EE682A3.8070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 13 10:46:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaOw2-0005kj-Av
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 10:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1LMJqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 04:46:01 -0500
Received: from brln-4d0cbd2c.pool.mediaWays.net ([77.12.189.44]:38755 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750873Ab1LMJp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 04:45:59 -0500
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 20B9E1A1BE2;
	Tue, 13 Dec 2011 10:46:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <4EE682A3.8070704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187011>



On 12.12.2011 23:39 Jens Lehmann wrote:
>  Am 11.12.2011 22:15, schrieb Andreas T.Auer:
> >
> > In my use case the branches on the submodules follow the
> > superproject and (mostly) versions that are committed there, it
> > just adds the possibility to keep on working without checking out
> > a branch after an update and without colliding with existing
> > branchnames in the submodule.
>
>  Using superproject branch names in the submodules make no sense for a
>  lot of use cases.
The most useful workflows for some use cases make no sense for a lot of 
other use cases. That is why configuration options are useful, right? 
There is no one-size-fits-all. It surely won't make sense for 
independent submodules.

> > The other use case wants to follow the commits of that other
> > submodule without checking the corresponding gitlinks into the
> > superproject. But wouldn't it also make sense here to define
> > actually a mapping in the .gitmodule that says "if the branch
> > 'develop' is checkedout in the supermodule then with every
> > submodule update automatically pull the newest 'unstable' commit
> > from the submodule"? Or for "master" follow "stable" or for the
> > "maint" branch follow updates in the "bugfixes" branch.
> >
> > For example
> >
> > [submodule "commonlib"] update = heads develop:unstable
> > master:stable maint:bugfixes
>
>  Having that configured with "branch=unstable", "branch=stable" etc.
>  in .gitmodules on the superprojects branches would be simpler and
>  achieve the same functionality.

Yes, this has been my first thought also, but there is also a good point 
to keep the .gitmodules stable, or you always have to change the file 
when branches change their names. So when the maint branch of version 
1.3 become an archive branch and the new maint is on 1.4, which was the 
master before then you have to change the .gitmodules on these branches. 
I.e. .gitmodules of 1.4 have "stable" and must have "bugfixes" now and 
.gitmodules of 1.3 has "bugfixes" and must remove the floating 
completely. I'm not sure that this can always be solved with "easy" 
merging and therefore it is probably not really simpler, when you have 
to do this for every new release. Or what do you think?

> > So whenever a defined branch is checked out in the superproject
> > the mapped branch will be checked out in the submodule ("new"
> > commit), but if a (e.g. tagged) commit is checked out ("old"
> > commit) then the gitlink in the superproject is used to check out
> > the referenced commit in the submodule.
>
>  I think checkout should only use the submodule commit recorded in the
>  superproject and a subsequent "git submodule update" should be needed
>  to update the submodule to tip. Otherwise you record SHA-1 but still
>  won't be able to bisect ...

bisect would leave the branch and therefore uses the recorded SHA1 for 
the submodule checkout instead of the tip. "follow-the-tip" should only 
work if the superproject follows the tip.
If you configure auto-update on checkout you would not expect that a 
separate git submodule update has a different behavior.

> > In http://thread.gmane.org/gmane.comp.version-control.git/183837
> > was discussed whether the gitlink in the superproject should be
> > set to all-zero if updates follow the tip or maybe use the SHA1 of
> > the commit when the submodule was added. I think the gitlink should
> > be updated everytime when a new commit in the superproject is
> > created.
>
>  Nope, only when "git submodule update" is run. Otherwise you'll
>  spray the history with submodule updates totally unrelated to the
>  commits in the superproject, which is rather confusing.

Of course, committing a new version to the superproject should not 
trigger pulling in a new version for the submodule or an automatic jump 
to the tip of the submodule. I just meant a normal manual "commit -a" 
behavior. Putting a 0{40} hash in the gitlink or only the hash of the 
submodule, when it first was added would be a special treatment that is 
neither needed nor wanted.
