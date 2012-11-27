From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Wed, 28 Nov 2012 00:28:58 +0100
Message-ID: <20121127232858.GA4742@book.hvoigt.net>
References: <20121127183125.GA4185@book.hvoigt.net> <20121123175402.GH2806@odin.tremily.us> <20121127190105.GQ10656@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUaj-00016F-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab2K0X3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:29:11 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:36676 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab2K0X3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:29:07 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TdUaJ-00013e-2e; Wed, 28 Nov 2012 00:28:59 +0100
Content-Disposition: inline
In-Reply-To: <20121127190105.GQ10656@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210629>

Hi,

On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
> On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> The v4 series leaves the remote branch amigious, but it helps you
> point the local branch at the right hash so that future calls to
> 
>   $ git submodule foreach 'git pull'
> 
> can use the branch's .git/modules/<name>/config settings.

But IMO thats the functionality which should be implemented in submodule
update and not left to the user.

> > I would think more of some convention like:
> > 
> > 	$ git checkout -t origin/$branch
> > 
> > when first initialising the submodule with e.g.
> > 
> > 	$ git submodule update --init --branch
> > 
> > Then later calls of
> > 
> > 	$ git submodule update --branch
> > 
> > would have a branch configured to pull from. I imagine that results in
> > a similar behavior gerrit is doing on the server side?
> 
> That sounds like it's doing pretty much the same thing.  Can you think
> of a test that would distinguish it from my current v4 implementation?

Well the main difference is that gerrit is automatically updating the
superproject AFAIK. I would like it if we could implement the same
workflow support in the submodule script. It seems to me that this is
already proven to be useful workflow.

I do not have a test but a small draft diff (completely untested, quick and
dirty) to illustrate the approach I am talking about.

You can find the whole change at

https://github.com/hvoigt/git/commits/hv/floating_submodules_draft

and the interesting patch for easy commenting below[1].

> > How about reusing the -b|--branch option for add? Since we only change
> > the behavior when submodule.$name.update is set to branch it seems
> > reasonable to me. Opinions?
> 
> That was the approach I used in v1, but people were concerned that we
> would be stomping on previously unclaimed config space.  Since noone
> has pointed out other uses besides Gerrit's very similar case, I'm not
> sure if that is still an issue.

Could you point me to that mail? I cannot seem to find it in my archive.

> > > Because you need to recurse through submodules for `update --branch`
> > > even if "$subsha1" == "$sha1", I had to amend the conditional
> > > controlling that block.  This broke one of the existing tests, which I
> > > "fixed" in patch 4.  I think a proper fix would involve rewriting
> > > 
> > >   (clear_local_git_env; cd "$sm_path" &&
> > >    ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> > >     test -z "$rev") || git-fetch)) ||
> > >   die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> > > 
> > > but I'm not familiar enough with rev-list to want to dig into that
> > > yet.  If feedback for the earlier three patches is positive, I'll work
> > > up a clean fix and resubmit.
> > 
> > You probably need to separate your handling here. The comparison of the
> > currently checked out sha1 and the recorded sha1 is an optimization
> > which skips unnecessary fetching in case the submodules commits are
> > already correct. This code snippet checks whether the to be checked out
> > sha1 is already local and also skips the fetch if it is. We should not
> > break that.
> 
> Agreed.  However, determining if the target $sha1 is local should have
> nothing to do with the current checked out $subsha1.

See my draft or the diff below for an illustration of the splitup.

Cheers Heiko

[1]
diff --git a/git-submodule.sh b/git-submodule.sh
index 9ad4370..3fa1465 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -183,6 +183,7 @@ module_clone()
 	sm_path=$1
 	url=$2
 	reference="$3"
+	branch="$4"
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -209,6 +210,8 @@ module_clone()
 			clear_local_git_env
 			git clone $quiet -n ${reference:+"$reference"} \
 				--separate-git-dir "$gitdir" "$url" "$sm_path"
+			test -n "$branch" && (cd $sm_path &&
+				git checkout -t origin/$branch)
 		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
 	fi
@@ -361,7 +364,7 @@ Use -f if you really want to add it." >&2
 
 	else
 
-		module_clone "$sm_path" "$realrepo" "$reference" || exit
+		module_clone "$sm_path" "$realrepo" "$reference" "$local_branch" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -577,6 +580,12 @@ handle_on_demand_update () {
 	fi
 }
 
+handle_tracking_branch_update () {
+	(clear_local_git_env; cd "$sm_path" &&
+		git-checkout $branch && git-pull --ff-only) ||
+	die "$(eval_gettext "Unable to pull branch '\$branch' in submodule path '\$sm_path'")"
+}
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -648,6 +657,7 @@ cmd_update()
 	cloned_modules=
 	module_list "$@" | {
 	err=
+	floating_submodules=
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -684,7 +694,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$url" "$reference"|| exit
+			module_clone "$sm_path" "$url" "$reference" "$branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -693,7 +703,13 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
 		fi
 
-		handle_on_demand_update
+		if test "$update_module" = "branch"
+		then
+			handle_tracking_branch_update
+			floating_submodules="$floating_submodules $sm_path"
+		else
+			handle_on_demand_update
+		fi
 
 		if test -n "$recursive"
 		then
@@ -727,6 +743,11 @@ Maybe you want to use 'update --init'?")"
 		IFS=$OIFS
 		exit 1
 	fi
+	if test -n "$floating_submodules"
+	then
+		git add $floating_submodules &&
+		git commit -m "Updated submodules"
+	fi
 	}
 }
