From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Looking for a way to set up Git correctly
Date: Thu, 11 Nov 2010 13:38:59 -0600
Message-ID: <20101111193859.GI16972@burratino>
References: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
 <20101111132502.GB23423@nibiru.local>
 <20101111164606.GA16972@burratino>
 <20101111190724.00vcimqm8w0cw8s0@dennymagicsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Enrico Weigelt <weigelt@metux.de>
To: denny@dennymagicsite.com
X-From: git-owner@vger.kernel.org Thu Nov 11 20:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGczb-0006YY-V5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab0KKTj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:39:26 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64462 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab0KKTjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:39:25 -0500
Received: by ewy7 with SMTP id 7so1407859ewy.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rqKDrOw6bujTuo0Fe5DXKg6NFIFvJqg3jTwmtfEXGv8=;
        b=LFoLlbskmHmGApWndbTMz3KrhZeWlWd7Ue98xrRYSCkpeusCBF5f0K8nMrymnlq8f3
         JjK1fLm2tnRs0n74PGF+RTZfzuI44tuwFchfAO5lQ7HTRxtZZpjuXTIwgbDU9E9qgkoL
         4FHEu1iRRF3USWwuuUXwUWq1GlaEcTaaLnhng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CLSQqN4BrmRW1WXJCOMLXJDDoaCuMm62FnwOf/iQd3lLvG9m1bY+a5+3kE0bp4Zb0R
         VoLdcCj8cWIwtJuHMmWFleqhFrS6XI8ikJvLiyAaJ9JTDSoUEah6e5TDqva+VLfsW+p3
         evIQw6KpBnPO8yPe+PCgdNc5XtdOX8xC9TfDw=
Received: by 10.216.199.81 with SMTP id w59mr2568460wen.100.1289504363863;
        Thu, 11 Nov 2010 11:39:23 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x6sm1549281weq.13.2010.11.11.11.39.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 11:39:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101111190724.00vcimqm8w0cw8s0@dennymagicsite.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161298>

denny@dennymagicsite.com wrote:

> I am still looking through your replies and getting familiar with
> git commands.

By the way, please ignore that GIT_WORK_TREE stuff I did.  It
probably works, but it's ugly. :)  That example could have been
written better as

	git init everything
	GIT_DIR=$(pwd)/everything/.git; export GIT_DIR
	(
		cd common-ancestor
		git add -A
		git commit
		git branch -m ancestor
	)
	(
		cd project1
		git checkout -b project1 ancestor
		git add -A
		git commit
	)
	... etc ..
	unset GIT_DIR

	cd everything
	git checkout project1

[...]
> From a developer's point of view, working on projectX means making
> some changes and committing them to the repo for that project.  The
> developer may not be aware of other pojects existing.

For concreteness, I am imagining these directories represent various
versions of the Almquist shell.  The common ancestor is the BSD4.3/Net-2
version and various projects may have built from there in different
directions: NetBSD sh, FreeBSD sh, dash.  (Yes, I am oversimplifying. :))

Now suppose they have diverged so wildly that it is never possible to
synchronize code with each other.  Instead, they can copy fixes, and
this is especially convenient when the fixes are phrased as diffs to
the common ancestor.

To facilitate this, Alice revives the BSD4.3/Net-2 sh project with a
"fixes only" policy.  Her daily work might look like this:

 $ git fetch netbsd
 $ git log netbsd/for-alice@{1}..netbsd/for-alice; # any good patches today?
 $ git cherry-pick -s 67fd89980; # a good patch.
 ... quick test ...
 $ git cherry-pick -s 897ac8; # another good patch.
 ... quick test ...
 ...
 $ git fetch freebsd
 ... and similarly for the rest of the patch submitters ...
 $ git am emailed-patch

Then to more thoroughly test the result:

 $ git checkout -b throwaway;	# new throw-away branch.[1]
 $ git merge netbsd/master;	# will the changes work for netbsd?
 ... thorough test ...
 $ git reset --keep master
 $ git merge freebsd/master;	# how about freebsd?
 ... etc ...

And finally she pushes the changes out.

> Without knowing anything about git for a moment, one ideal workflow
> is where a developer makes changes to projectX that touch the base
> and projectX specific features.  Then the developer commits them and
> pushes them to the main repo.  The main repo contains all projects.
> During the commit, chages to the base automagically get pushed to
> all projects that share that base

If it is a matter of what files are touched, then maybe the base is
actually something like a library, which should be managed as a
separate project.  See the "git submodule" manual if you would like to
try something like this but still keep the projects coupled.

On the other hand, remaining in the situation from before:

Suppose Sam is the NetBSD sh maintainer.  The first step in working on
a new release might be

 $ git fetch ancestor
 $ git log -p HEAD..FETCH_HEAD;	# fixes look okay?
 $ git pull ancestor

since Alice tends to include only safe, well tested fixes.

Many changes Sam makes are specific to his project, but today he comes
up with a fix that might be useful for other ash descendants.

So instead of commiting directly, he can try:

 $ git checkout for-alice;	# carry the fix to the for-alice branch
 ... test ...
 $ git commit -a;		# commit it.

If it is not an urgent fix, at this point he might do

 $ git checkout master;		# back to the main NetBSD branch, without the fix

and give the other projects some time to work on the patch and come up
with a better fix.  Or he might cherry-pick the commit from for-alice,
and even publish it and encourage others to cherry-pick directly from
him to get the fix out ASAP.

Notice that not all changes to the base files are necessarily useful
for other descendants of the ancestral program.  So in this example,
propagation of changes between projects is fairly explicit.

[1] "git checkout HEAD^0" would be more convenient.
See DETACHED HEAD in the git checkout manual if interested.
