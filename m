From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: state of the art with moving submodules
Date: Tue, 26 Feb 2013 19:25:42 +0100
Message-ID: <512CFE26.8060303@web.de>
References: <bcaec55555fe91182f04d698b37f@google.com> <512C6DD2.4000208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:26:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPEH-0001sx-O2
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901Ab3BZSZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:25:54 -0500
Received: from mout.web.de ([212.227.15.4]:51684 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932887Ab3BZSZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:25:50 -0500
Received: from [192.168.178.41] ([79.193.92.94]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MDPI5-1U2uxt0Cjd-00HTY9; Tue, 26 Feb 2013 19:25:48
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <512C6DD2.4000208@gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:UEuyoht03vT0a2OhjaVJHSlCxg2yBVXaYiZxDzevypb
 9Z8lYvzV/Zy4JEBp9yVg/RMvYmjii6MjCRqAU7gPiqp0jKS2Oj
 EmfWzff+CtSjXBu/Ahspf+4/R9pJ2JccsXd0Ua6vVfCDJsz3fQ
 gUklySMYOdVHvr1wQDgfzKHqU352cIyaWRLfu0cgAAWdVrS/XR
 tXWpRnLRT0tlotIWGKv+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217155>

Am 26.02.2013 09:09, schrieb Chris Packham:
> At $dayjob we were discussing a potential re-org of our super-projects
> to introduce a bit of hierarchy to the submodules (at the moment it's
> fairly flat). One downside of this is the potential loss of locally
> committed work. There is also a cost in terms of additional fetching but
> we think that will be OK (fetches from local servers with smallish repos).

Local commits will be preserved iff the submodules use gitfiles, also
extra fetches won't happen in that case. This holds true as long as you
only change the path and not the name of the submodules in .gitmodules
(Which I'd strongly advise to do and is just what my upcoming "git mv"
patch will be doing, my plan is to post that as RFC rather soon).

> I was just wondering where things were at with git detecting submodule
> moving/renaming? Will our developers be able to keep any local commits
> when they happen to pull in the super-project commit that moves a commit.

Current Git detects that, but won't move the submodules work tree.
Instead you'll have the old work tree of a moved submodule still lying
around and need to call "git submodule update" to create the submodule's
work tree in the new location. Also switching back to a commit where the
submodule is still in the old location won't work at first because of
the now outdated core.worktree setting in the Git repo of the submodule,
still pointing to the new location. You'd have to delete the old
submodule work tree and use "git submodule update" to recreate it again
with proper settings. That'll somehow work while at the same time is not
terribly user friendly (but don't even think about replacing an existing
directory with tracked files with a submodule or vice versa with current
Git!).

The solution for all that is my recursive submodule update series, and
finishing that it is next on my todo list after "git mv <submodule>".
Also Heiko's recently posted "fetch moved submodules on-demand" series
is necessary for that (and the work he does about parsing a config file
from a blob is essential to create a submodule which doesn't have the
correct path in the .gitmodules file of the current work tree, this is
the major thing that doesn't work as expected in my current code).

> I think some people with older clones will suffer without the newer
> .git/modules layout but those can be manually fixed prior to the re-org.

Or maybe someone could step up to add a "to-gitfile" command to "git
submodule" which converts older submodules ;-)  I'll be happy to help
and review such a patch but will concentrate on materializing recursive
submodule update for the next time.

> FYI our current stock workstation install uses git version 1.7.9.5 but
> I'm recommending we update to 1.8.x before this re-org to pick up some
> of the recent submodule improvements.

I think the stuff you need to make this transition painless (unless you
are ok with a flag day or the manual steps described above to make that
work) will not hit master that soon. While recursive update is working
for me (except for creating a submodule not in the current .gitmodules)
it still needs the config options and a ton of tests. My plan is to
bring recursive submodule update into a shape others can test and
comment on before the Git Merge in May, let's see how that plan works
out.
