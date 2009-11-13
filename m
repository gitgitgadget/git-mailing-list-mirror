From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sat, 14 Nov 2009 07:19:46 +0900
Message-ID: <20091114071946.6117@nanako3.lavabit.com>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
	<1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Fri Nov 13 23:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N94VK-0004io-2D
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 23:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbZKMWUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 17:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbZKMWUR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 17:20:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55644 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbZKMWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 17:20:16 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id DAC5B11B78B;
	Fri, 13 Nov 2009 16:20:21 -0600 (CST)
Received: from 1172.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 8XWPVX348UN3; Fri, 13 Nov 2009 16:20:21 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tmVdMJ1SxqU7vMuBGHsiGI+3LxrnhowZ+eX+sXw07v7/IVEN5GZ+3JA9xa0ny2lEVNl2QX1l5+1UcDj1HiG3mf4l3j6JzLpXKG8AEN8yW0X4PneB5AiRsLANL8FXOSOEIwJip2CqPIHf1Ubya8RQ0PetgXDVBXaFw5EQyAzNafM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132847>

Quoting rocketraman@fastmail.fm

> From: Raman Gupta <raman@rocketraman.com>
>
> The current man page does a reasonable job at describing branch management
> during the development process, but it does not contain any guidance as to
> how the branches are affected by releases.
>
> Add a basic introduction to the branch management undertaken during a
> git.git release, so that a reader may gain some insight into how the
> integration, maintenance, and topic branches are affected during the
> release transition, and is thus able to better design the process for their
> own project.
>
> Other release activities such as reviews, testing, and creating
> distributions are currently out of scope.
> ---

You are missing Signed-off-by: line. 

Here are some corrections that can be applied on top of your change.

-- >8 --
Subject: [PATCH] Corrections to release management section in gitworkflows.txt

The maintenance branch is supposed to be a strict subset of the master
branch at all times. If you find out that this condition was violated
after you pushed a release from the master branch, it is too late.
Correcting that mistake will require redoing and retagging an already
published release.

In http://article.gmane.org/gmane.comp.version-control.git/132692, Junio
explained that the first step is:

        - doubly make sure that there is nothing left in 'maint' that
          is not in 'master';

to avoid that mistake.  Explain the exact procedure in a recipe format,
and make sure it is done before the tip of the master branch is tagged.
Also use --ff-only when merging master into maint.

Rebuilding of 'next' must be done on 'next' branch; correct the
command sequence in the recipe.

Other minor clarifications in the text are also included in this change:

 * Clarify "building documentation" a bit; the post-update hook
   creates preformatted documentation pages.

 * The latest documentation set uses "fast-forward", not "fast
   forward".

 * Call 'next' branch an integration branch, not a "testing" branch, to be
   consistent with the Graduation section.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/gitworkflows.txt |   57 +++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 7000930..b1c7ef3 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -216,8 +216,19 @@ Assuming you are using the merge approach discussed above, when you
 are releasing your project you will need to do some additional branch
 management work.
 
-Creating a release is easy. Since 'master' is tracking the commits
-that should go into the next feature release, simply tag the tip of
+Since 'master' is supposed to be always a superset of 'maint', you
+should first make sure that condition holds.
+
+.Make sure 'maint' fast-forwards to 'master'
+[caption="Recipe: "]
+=====================================
+git log master..maint
+=====================================
+
+There should be no commit listed from this command (otherwise, check
+out 'master' and merge 'maint' into it).
+
+Then you can tag the tip of
 'master' with a tag indicating the release version.
 
 .Release tagging
@@ -230,11 +241,15 @@ Similarly, for a maintenance release, 'maint' is tracking the commits
 to be released. Therefore, simply replace 'master' above with
 'maint'.
 
-Generally, you should push the new tag to a public git server (see
+You need to push the new tag to a public git server,
+at the same time you push the updated 'master' or 'maint',
+if you are making a maintenance release. (see
 "DISTRIBUTED WORKFLOWS" below). This push makes the tag available to
 others tracking your project. The push could also trigger a
 post-update hook to perform release-related items such as building
-documentation.
+release tarballs and preformatted documentation pages.  You may want
+to wait this push-out before you update your 'maint' branch (see the
+next section).
 
 
 Maintenance branch management after a feature release
@@ -256,47 +271,37 @@ where X.Y.Z is the current release).
 `git branch maint-X.Y.(Z-1) maint`
 =====================================
 
-The 'maint' branch should now be fast forwarded to the newly released
+The 'maint' branch should now be fast-forwarded to the newly released
 code so that maintenance fixes can be tracked for the current release:
 
 .Update maint to new release
 [caption="Recipe: "]
 =====================================
-* `git checkout maint`
-* `git merge master`
+* `git checkout maint`
+* `git merge --ff-only master`
 =====================================
 
-This 'should' fast forward 'maint' from 'master'. If it is not a fast
-forward, then 'maint' contained some commits that were not included on
+This should fast-forward 'maint' from 'master'. If it is not a
+fast-forward, then 'maint' contained some commits that were not included on
 'master', which means that the recent feature release could be missing
-some fixes made on 'maint'. The exception is if there were any commits
-that were cherry-picked to 'maint' as described above in "Merging
-upwards". In this case, the merge will not be a fast forward.
-
-An alternative approach to updating the 'maint' branch, though one
-not used in git.git, is to rename the current 'maint' branch to track
-maintenance fixes for the older release and then to recreate 'maint'
-from 'master':
-
-  $ git branch -m maint maint-X.Y.(Z-1)
-  $ git branch maint master
-
-The latter step will create a new 'maint' branch based on 'master'. If
-commits were cherry-picked to 'maint', then this will create a new
-'maint' branch without a merge commit.
+some fixes made on 'maint'.  If that happens, you need to go back to the
+previous "Branch management for a release" step.  Correcting this mistake
+becomes messy if you have already pushed the release tag, and that is why
+you should wait until finishing this step before pushing the release out.
 
 
 Branch management for next and pu after a feature release
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-After a feature release, the 'next' testing branch may optionally be
+After a feature release, the integration branch 'next' may optionally be
 rewound and rebuilt from the tip of 'master' using the surviving
 topics on 'next':
 
 .Update maint to new release
 [caption="Recipe: "]
 =====================================
-* `git branch -f next master`
+* `git checkout next`
+* `git reset --hard master`
 * `git merge ai/topic_in_next1`
 * `git merge ai/topic_in_next2`
 * ...
-- 
1.6.5.2.159.g67ee8

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
