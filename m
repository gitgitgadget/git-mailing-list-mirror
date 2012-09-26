From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug in Submodule add
Date: Wed, 26 Sep 2012 22:56:32 +0200
Message-ID: <50636C00.6080906@web.de>
References: <BC634E06939C44239106E7A8DD229130@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Johnson <me@jondavidjohn.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 22:56:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGyf0-0004H7-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 22:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab2IZU4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 16:56:39 -0400
Received: from mout.web.de ([212.227.15.4]:55284 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab2IZU4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 16:56:37 -0400
Received: from [192.168.178.41] ([91.3.167.99]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MOAjQ-1TMURL34Cq-00687w; Wed, 26 Sep 2012 22:56:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <BC634E06939C44239106E7A8DD229130@gmail.com>
X-Provags-ID: V02:K0:LeUIar2PMfjZFjDx5VnwwK9/kNwTLVH0VQESnAZLRSq
 ZOv7KIenKy0I9Uj0tfghri/1zh1StU9W8E/z3yx9jk1yuG8Byf
 xz/nbTzRT/X41uDDSD4er5T0FOBI9RDO6XB32ywUTYqCw0W8d+
 fkAoRhja0ZubAXDlMjUGKnVnyyp067zebnf50dNyRYVxmNpITZ
 mxR8kddY+AGhXYVqWSvIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206445>

Am 26.09.2012 06:18, schrieb Jonathan Johnson:
> I believe I have found an issue with the way `submodule add` detects a submodule that already exists in the repository. 

Yes, this is an issue and thanks for the detailed report.

> To reproduce
> 
> 1) add a git submodule in a specific location (we'll say it's at `./submodule/location`)
> 2) go through the normal steps of removing a submodule, as listed here - https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial
> 3) Now the submodule is completely removed and there is no reference to it in .gitmodules or .git/config
> 4) Re-add a different repository at the same location (`./submodule/location`)
> 
> Expected - The new submodule repository will be set up at ./submodule/location and have the new repository as its origin
> 
> What Actually Happens - The new submodule uses the existing `$gitdir` (old repository) as the actual backing repository to the submodule, but the new repository is reflected in .gitmodules and .git/config.
> 
> So to recap, the result is that `git remote show origin`  in the submodule shows a different origin than is in .gitmodules and .git/config
> 
> One simple step to remedy this would be to add the deletion of the backing repository from the .git/modules directory, but again, I think an actual command to take care of all of these steps is in order anyways.  Not sure you want to encourage people poking around in the .git directory.

Unfortunately just throwing away the old repository under .git/modules,
whether manually or by a git command, is no real solution here: it would
make it impossible to go back to a commit which records the old submodule
and check that out again.

The reason for this issue is that the submodule path is used as its name
by "git submodule add". While we could check this type of conflict locally,
we can't really avoid it due to the distributed nature of git (somebody
else could add a different repo under the same path - and thus the same
name - in another clone of the repo).

The only long term solution I can think of is to use some kind of UUID for
the name, so that the names of newly added submodules won't have a chance
to clash anymore. For the short term aborting "git submodule add" when a
submodule of that name already exists in .git/modules of the superproject
together with the ability to provide a custom name might at least solve
the local clashes.
