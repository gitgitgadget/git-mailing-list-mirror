From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Unexpected behaviour after removing submodule
Date: Fri, 26 Oct 2012 00:47:46 +0200
Message-ID: <5089C192.2050903@web.de>
References: <50895580.9080408@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: devel-git@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Fri Oct 26 00:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRWDY-000835-M4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 00:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab2JYWrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 18:47:49 -0400
Received: from mout.web.de ([212.227.17.11]:55339 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab2JYWrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 18:47:48 -0400
Received: from [192.168.178.41] ([91.3.191.79]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LvSU3-1TIp6H1nsJ-00zvjL; Fri, 26 Oct 2012 00:47:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <50895580.9080408@morey-chaisemartin.com>
X-Provags-ID: V02:K0:/WmuKRZXyFPQ2MvUmybKPgSYG3CG2yG1nOzF0Y2WgU1
 EzlRzDm+3HbhsJ6E/bK5KXlz8Zdxr7xssrx26TPMBCQP+6Yl7a
 Wm69uZv88xCKGW6ZkFk/ZkRTdSA6229To9LUr6Lg75Q6+Jb7oH
 xKdFhC0HmvU2R1NFSVLtKGkCYRmqDEQShrkKdYVzUewY7M/2lX
 hYTpqj45q3uuCBjU1pAfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208424>

Am 25.10.2012 17:06, schrieb Nicolas Morey-Chaisemartin:
> At work, we use a lot of submodules (several levels of submodules actually).
> As we also work with development branches, we use scripts to resync the whole checked-out tree (mainly in automated integration)
> 
> We recently run across an issue where a branch (dev) contained a submodule while it had been removed in master and the files were imported in a subdirectory with the same name (probably using git-subtree).
> 
> Basically:
> 
> On dev:
> * top/refs(submodule)/file1
> On master:
> * top/refs(dir)/file1
> 
> Outside the fact that it is quite hard to move from one branch to the other while having a perfectly clean tree checked out underneath, we manage to end up into a weird (invalid) state
> that was neither clearly described nor "easy" to cleanup (using standard git clean/checkout/reset commands).

<snipped example without submodules>

> The issue is, there is no way from folder2 to see that something "wrong" is going on inside your tree!
> As we manage to reach this state using only standard git commands (I'll try to reproduce it) with submodules, and this being part of an automated flow, it is quite worrying.
> We may actually be committing in the wrong repo and pushing the wrong things around.
> 
> Is there or should there be a way to look for such issues? And is this an expected behaviour?

Unfortunately this is how things work at the moment. If you remove a
submodule its work tree will currently stay around nonetheless. And
when you replace it with a directory containing files tracked by git,
things start to get really weird when you do checkouts crossing that
conversion.

But the solution to that problem is coming closer. The first step was
to move the .git directory out of the submodule's work tree, so that
we are able to remove it without loosing any history. The next step
will be to enable git to remove and re-add submodules on checkout. The
"remove a submodule" part already works in my - still experimental -
recursive_submodule_checkout branch at my github repo. The thing that
is still missing - apart from tests ;) - is that checkout has to learn
to look into the to-be-checked-out .gitmodules to be able to populate
a re-appearing submodule. I plan to add that for git fetch first (so
it can fetch submodules the user showed interest in but which aren't
currently checked out) and after that I'll reuse it for checkout.

But that's still some work to do and will take some time ...
