From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: Auto update submodules after merge and reset
Date: Sun, 11 Dec 2011 22:15:39 +0100
Message-ID: <4EE51D7B.7020806@ursus.ath.cx>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 22:26:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZquM-0003f7-Om
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 22:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1LKV0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 16:26:03 -0500
Received: from brln-4dba15eb.pool.mediaWays.net ([77.186.21.235]:49909 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752391Ab1LKV0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 16:26:01 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Dec 2011 16:26:01 EST
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 02D551A1A90;
	Sun, 11 Dec 2011 22:16:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186817>



On 10.12.2011 00:57 Phil Hord wrote:
>  On Thu, Dec 8, 2011 at 4:13 AM,
>  <andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
>
>  Yes, but maybe you can update this information in the .gitmodules
>  file easily with a command.  Maybe it could be something simpler
>  than "git sync-gitmodules-branches", but that is essentially what it
>  would do: it would save the current branch in each submodule as the
>  "tracked" branch in the .gitmodules file.

Ok, I have read a better description of the "floating submodule" model 
now, so it is a different use case and somehow it makes sense. In that 
case there are probably just a few branches that you would like to 
follow, maybe an "unstable" for the newest development or "stable" for 
the current release or some maintenance branches.

>  Now this makes sense.  I want the same thing.  I want to preserve
>  history on "old" commits, but I want to "advance to tip" on "new"
>  commits.
>
>  The trouble, I think, is in telling the difference between "old" and
>   "new".  I think it means there is a switch, like --auto-follow (or
>  --no-auto-follow for the alternate if core.auto_follow is set).  But
>   having a config option as the default is likely to break lots of
>  scripts.

In my use case the branches on the submodules follow the superproject 
and (mostly) versions that are committed there, it just adds the 
possibility to keep on working without checking out a branch after an 
update and without colliding with existing branchnames in the submodule.

The other use case wants to follow the commits of that other submodule 
without checking the corresponding gitlinks into the superproject. But 
wouldn't it also make sense here to define actually a mapping in the 
.gitmodule that says "if the branch 'develop' is checkedout in the 
supermodule then with every submodule update automatically pull the 
newest 'unstable' commit from the submodule"? Or for "master" follow 
"stable" or for the "maint" branch follow updates in the "bugfixes" branch.

For example

[submodule "commonlib"]
     update = heads develop:unstable master:stable maint:bugfixes


So whenever a defined branch is checked out in the superproject the 
mapped branch will be checked out in the submodule ("new" commit), but 
if a (e.g. tagged) commit is checked out ("old" commit) then the gitlink 
in the superproject is used to check out the referenced commit in the 
submodule.

In http://thread.gmane.org/gmane.comp.version-control.git/183837 was 
discussed whether the gitlink in the superproject should be set to 
all-zero if updates follow the tip or maybe use the SHA1 of the commit 
when the submodule was added. I think the gitlink should be updated 
everytime when a new commit in the superproject is created.
