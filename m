From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 13:59:30 -0600
Organization: icecavern.net
Message-ID: <200910201359.30880.wjl@icecavern.net>
References: <200910201947.50423.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Krw-0006u4-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbZJTT7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbZJTT7d
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:59:33 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:51697 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751733AbZJTT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:59:32 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 4665136871;
	Tue, 20 Oct 2009 21:59:33 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.29-2-amd64; KDE/4.3.2; x86_64; ; )
In-Reply-To: <200910201947.50423.trast@student.ethz.ch>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130833>

On Tuesday 20 October 2009 11:47:45 Thomas Rast wrote:
> Especially on IRC, we see many people who are some combination of
> misunderstanding, misusing or overusing git-pull.  I figure this is
> the result of several factors, notably
> 
> a) pull/push are not symmetric,
> 
> b) guides/tutorials recommend pull for situations where they
>    shouldn't,
> 
> c) people blindly fire commands at git.

This may be minor, but also:

d) in mercurial, pull/push are symmetric, but fetch means pull+merge

> As you probably guessed by now, here is an idea for a very aggressive
> transition plan to address (a) in four phases:

I would love to see this change, not because I get confused about pull/fetch 
(it honestly only took a few days to get used to), but because having 
push/pull be symmetric just is so much more conceptually pure / easier 
explain to co-workers / separation between orthogonal operations / 
satisfying to my inner perfectionist / etc.
  
> 1. git-fetch gets options --merge/-m and --rebase that make it behave
>    like (current) git-pull, but requiring explicit arguments.
>    git-pull gets a new option --merge (-m) that only enforces presence
>    of arguments.
> 
> 2. git-pull refuses to do any work unless given either --merge or
>    --rebase.  Deprecation warnings for this start at the same time as
>    (1.).
>
> 3. git-pull becomes a synonym for git-fetch.
> 
> 4. git-fetch gives deprecation warnings that point the user to
>    git-pull instead.

Hmmm, maybe this would be better for easier transition; replace 2-4 above 
with:

2. git-pull learns --merge and gets a configuration option that allows 
turning auto-merging off (e.g. pull.merge = merge/yes (default), rebase, or 
no). This doesn't change any behavior by default, but allows individual 
users to essentially make pull == fetch, and is forward compatible with 
changes up to #4.

3. git-pull gives a deprecation warning if the configuration option is not 
set, but otherwise defaults to merge. To get rid of the warning, you can set 
it explicitly (one way or another).

4. The configuration option default changes to "no", and a helpful message 
is printed telling you that you can set the configuration option to merge to 
get the old behavior.

5. Drop deprecation messages. At this point, git fetch and git pull are 
identical, except git fetch never merges, regardless of the pull 
configuration setting.

This has a few nice properties:

  * There is lots and lots of warning; this transition could happen slowly.

  * Early on, it will be possible to make git pull have symmetric behavior 
by default, which is the desired endgame.

  * In the end, people who want "git pull" to always keep it's current 
behavior can do so by setting the proper configuration variable.

  * git fetch doesn't need to be deprecated (but could be).
