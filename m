From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 12:24:27 +0200
Message-ID: <20140819102421.GA5012@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 12:24:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJgam-0002Et-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 12:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbaHSKYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 06:24:36 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:33228 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaHSKYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 06:24:35 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XJgae-0002ne-IH; Tue, 19 Aug 2014 12:24:32 +0200
Content-Disposition: inline
In-Reply-To: <20140818205505.GA20185@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255452>

On Mon, Aug 18, 2014 at 01:55:05PM -0700, Jonathan Nieder wrote:
> Robert Dailey wrote:
> 
> > The documentation wasn't 100% clear on this, but I'm assuming by
> > "remote origin", it says that the relative URL is relative to the
> > actual remote *named* origin (and it is not using origin as just a
> > general terminology).
> 
> Thanks for reporting.  The remote used is the default remote that "git
> fetch" without further arguments would use:
> 
> 	get_default_remote () {
> 		curr_branch=$(git symbolic-ref -q HEAD)
> 		curr_branch="${curr_branch#refs/heads/}"
> 		origin=$(git config --get "branch.$curr_branch.remote")
> 		echo ${origin:-origin}
> 	}
> 
> The documentation is wrong.  git-fetch(1) doesn't provide a name for
> this thing.  Any ideas for wording?

How about 'upstream'? Like this[1]?

Lets step back a little is this really what we want in such situation? Is one
remote really the answer here? I suppose you have relative urls in your
.gitmodules file and two remotes in you superproject right?

What you want is that the remote names in the superproject are reflected in the
submodules when you initialise and update them?

Because at the moment what you get is always a remote 'origin' in the
submodule. Even if that remote was called 'fork' in the superproject.

Maybe in the relative URLs case we should teach the clone in submodule update
to use all remotes with their names from the superproject?

Would that solve your issue?

> > Is there a way to specify (on a per-clone basis) which named remote
> > will be used to calculate the URL for submodules?
> 
> Currently there isn't, short of reconfiguring the remote used by
> default by "git fetch".

Well currently it is either the tracked remote by the currently checked out
branch or if the branch has no tracked remote configured: 'origin'.

So by configuring (or checking out a branch with) a different remote you can
choose from remote submodule are cloned. No?

> > Various co-workers use the remote named "central" instead of
> > "upstream" and "fork" instead of "origin" (because that just makes
> > more sense to them and it's perfectly valid).
> >
> > However if relative submodules require 'origin' to exist AND also
> > represent the upstream repository (in triangle workflow), then this
> > breaks on several levels.
> 
> Can you explain further?  In a triangle workflow, "git fetch" will
> pull from the 'origin' remote by default and will push to the remote
> named in the '[remote] pushdefault' setting (see "remote.pushdefault"
> in git-config(1)).  So you can do
> 
> 	[remote]
> 		pushDefault = whereishouldpush
> 
> and then 'git fetch' and 'git fetch --recurse-submodules' will fetch
> from "origin" and 'git push' will push to the whereishouldpush remote.
> 
> It might make sense to introduce a new
> 
> 	[remote]
> 		default = whereishouldfetch
> 
> setting to allow the name "origin" above to be replaced, too.  Is that
> what you mean?

I think the OP problem stems from him having a branch that does not have a
remote configured. Since they do not have 'origin' as a remote and

	git submodule update --init --recursive path/to/submodule

fails. Right?

Cheers Heiko

[1]
From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] submodule: use 'upstream' instead of 'origin' in
 documentation

When talking about relative URL's it is ambiguous to use the term
'origin', since that might denote the default remote name 'origin'. Lets
use 'upstream' to make it more clear that the upstream repository is
meant.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-submodule.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..c6f82e6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -80,15 +80,15 @@ to exist in the superproject. If <path> is not given, the
 The <path> is also used as the submodule's logical name in its
 configuration entries unless `--name` is used to specify a logical name.
 +
-<repository> is the URL of the new submodule's origin repository.
+<repository> is the URL of the new submodule's upstream repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
+or ../), the location relative to the superproject's upstream
 repository (Please note that to specify a repository 'foo.git'
 which is located right next to a superproject 'bar.git', you'll
 have to use '../foo.git' instead of './foo.git' - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
-If the superproject doesn't have an origin configured
+If the superproject doesn't have any remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-- 
2.1.0.rc0.52.gaa544bf
