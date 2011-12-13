From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: Auto update submodules after merge and reset
Date: Wed, 14 Dec 2011 00:05:16 +0100
Message-ID: <4EE7DA2C.7000300@ursus.ath.cx>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE51D7B.7020806@ursus.ath.cx> <4EE682A3.8070704@web.de> <4EE71E9F.90204@ursus.ath.cx> <4EE7C733.4010209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RabQR-0003io-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab1LMXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:06:15 -0500
Received: from brln-4d0cbd2c.pool.mediaWays.net ([77.12.189.44]:57384 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751909Ab1LMXGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:06:15 -0500
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id B415F1A1F73;
	Wed, 14 Dec 2011 00:06:17 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <4EE7C733.4010209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187071>



On 13.12.2011 22:44 Jens Lehmann wrote:
>  Am 13.12.2011 10:45, schrieb Andreas T.Auer:
> > On 12.12.2011 23:39 Jens Lehmann wrote:
> >> Am 11.12.2011 22:15, schrieb Andreas T.Auer:
> >>> For example
> >>>
> >>> [submodule "commonlib"] update = heads develop:unstable
> >>> master:stable maint:bugfixes
> >>
> >> Having that configured with "branch=unstable", "branch=stable"
> >> etc. in .gitmodules on the superprojects branches would be
> >> simpler and achieve the same functionality.
> >
> > Yes, this has been my first thought also, but there is also a good
> > point to keep the .gitmodules stable, or you always have to change
> > the file when branches change their names. So when the maint branch
> > of version 1.3 become an archive branch and the new maint is on
> > 1.4, which was the master before then you have to change the
> > .gitmodules on these branches. I.e. .gitmodules of 1.4 have
> > "stable" and must have "bugfixes" now and .gitmodules of 1.3 has
> > "bugfixes" and must remove the floating completely. I'm not sure
> > that this can always be solved with "easy" merging and therefore it
> > is probably not really simpler, when you have to do this for every
> > new release. Or what do you think?
>
>  I never rename branches, so I do not concur ;-)

Well, maybe you don't, but Junio does something like that. There is a 
maint-1.7.7 where maint has been before and maint jumped to master.

>  And I think the .gitmodules file could benefit from a special merge
>  driver being aware of the format and some subtleties (like not just
>  adding a "branch" setting but rather creating a merge conflict)
>  anyways.

If that would work it would be fine, but you would still have to create 
a new commit, when maint jumps to master and you need to update the 
.gitmodules to be a maint .gitmodules.

>  So I'd prefer to keep it simple and just use the .gitmodules we
>  already have which can be different in different branches.

I agree that the .gitmodule format would be simpler, but I'd prefer the 
.gitmodule to be a little bit more complex, but more stable.

> >>> So whenever a defined branch is checked out in the
> >>> superproject the mapped branch will be checked out in the
> >>> submodule ("new" commit), but if a (e.g. tagged) commit is
> >>> checked out ("old" commit) then the gitlink in the superproject
> >>> is used to check out the referenced commit in the submodule.
> >>
> >> I think checkout should only use the submodule commit recorded in
> >> the superproject and a subsequent "git submodule update" should
> >> be needed to update the submodule to tip. Otherwise you record
> >> SHA-1 but still won't be able to bisect ...
> >
> > bisect would leave the branch and therefore uses the recorded SHA1
> > for the submodule checkout instead of the tip. "follow-the-tip"
> > should only work if the superproject follows the tip.
>
>  If you follow a tip there won't be any new SHA-1s recorded during
>  that following so you could not do a bisect and expect the submodule
>  to be what the developer had when doing the commits, no?

If you never commit something to the superproject, you wouldn't get 
SHA1s recorded, that's right. But when you commit something to the 
superproject, why shouldn't the current submodule SHA1 be stored? 
Floating is about _ignoring_ the recorded SHA1 in _some_ cases, not 
about disabling the recording. So you can bisect to the bad superproject 
commit. If you suspect a bad submodule commit causing the problem then 
you could still bisect the submodule commits between the recorded SHA1s.
