From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Sat, 12 Jun 2010 12:12:50 +0200
Message-ID: <201006121212.50545.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jun 12 12:13:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONNi0-0004I4-ID
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 12:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab0FLKMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 06:12:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:36745 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab0FLKMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 06:12:53 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3W009MPCDFBP00@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Jun 2010 12:12:51 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 577391EA5887_C135DA3B	for <git@vger.kernel.org>; Sat,
 12 Jun 2010 10:12:51 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 032CF1EA3428_C135DA3F	for <git@vger.kernel.org>; Sat,
 12 Jun 2010 10:12:51 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3W0077NCDEKC20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Jun 2010 12:12:50 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <cover.1276059473.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149003>

On Friday 11 June 2010, Heiko Voigt wrote:
> The following patch series is a work in progress. The idea is whenever
> you need to merge two SHA1's of a submodule we search for a ref in the
> submodule which already contains both. If one such ref exists the
> resulting SHA1 is the one pointed at by that ref.

I appreciate the effort to improve submodule handling, but I'm not sure I 
like this approach. Even though you try to apply it as conservatively as 
possible, it still smells a little like trying to make Git too clever for 
its own good.

E.g. say we have the following commit history in the submodule:

  A---B---C---D  <-- master

Now, say that your merge conflict comes from one branch updating the 
submodule from B to C, while the other branch reverts the submodule from B 
to A. In your proposed scheme, Git would auto-resolve the conflict to D.

In this case Git has no way of knowing whether the update from B to C is 
"better" than the revert from B to A. Maybe the revert to A happened because 
there is a showstopper bug in B that has not yet been fixed, and the best 
solution is to revert to A until a fix can be made. Or maybe C fixes that 
showstopper bug, so C is safe after all.

In any case, fast-forwarding to D seems irresponsible, since we have no 
concept of how well D is tested. Maybe it introduces another showstopper 
bug, and that is why neither branch has upgraded to it yet?

This whole idea is somewhat similar to branch-tracking submodules (recently 
discussed in another thread), except that it only applies on _merge_ in the 
superproject, and you don't get to choose _which_ branch it's tracking. 
That's _way_ too arbitrary for my tastes.

> The implementation currently searches through all refs and if one (and
> only one) ref exists which contains both sides it merges. In all other
> cases it fails.

Still doesn't solve the fundamental A---B---C---D problem I demonstrated 
above.

> Future Plans:
> 
>   * Only search stable branches. E.g. by default only master and
>     */master. The stable branch list will be configurable.

What is this "stable" branch of which you speak? "Stable" is a very relative 
concept, depending on which repo you're working in, and which branch you're 
working on. In any case, master is often not the most stable branch in a 
given repo. In git.git for example, maint is more stable than master. Also, 
I have many repos where master should not be considered "stable" at all...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
