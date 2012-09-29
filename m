From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] Let "git submodule add" fail when .git/modules/<name>
 already exists
Date: Sun, 30 Sep 2012 01:04:22 +0200
Message-ID: <50677E76.1050204@web.de>
References: <BC634E06939C44239106E7A8DD229130@gmail.com> <50636C00.6080906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Johnson <me@jondavidjohn.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:04:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI65i-0003LH-UW
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 01:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab2I2XEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 19:04:48 -0400
Received: from mout.web.de ([212.227.17.12]:54287 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2I2XEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 19:04:48 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MarqU-1T24Im3fVy-00Kmw8; Sun, 30 Sep 2012 01:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <50636C00.6080906@web.de>
X-Provags-ID: V02:K0:NtaAEVfG5Qe17ukCQ8rLA3h5moHOHWbI73RLrI0PTns
 4AL2SxFxfM+FThucNmNZX5AhuHx0OvdzYoVEYjOAFbcPckMr5r
 lgNaJnDupznBq8LF3UBCd4qy3VvW47Uby9b/1roTJN+x66tk9v
 0DP/kmmk+rciClyrnLPJAN5zkQicT/2wWQc9011DSbJ0ny0IWN
 G1TrneWHakCYeFc3e10Gw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206658>

Am 26.09.2012 22:56, schrieb Jens Lehmann:
> Am 26.09.2012 06:18, schrieb Jonathan Johnson:
>> To reproduce
>>
>> 1) add a git submodule in a specific location (we'll say it's at `./submodule/location`)
>> 2) go through the normal steps of removing a submodule, as listed here - https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial
>> 3) Now the submodule is completely removed and there is no reference to it in .gitmodules or .git/config
>> 4) Re-add a different repository at the same location (`./submodule/location`)
>>
>> Expected - The new submodule repository will be set up at ./submodule/location and have the new repository as its origin
>>
>> What Actually Happens - The new submodule uses the existing `$gitdir` (old repository) as the actual backing repository to the submodule, but the new repository is reflected in .gitmodules and .git/config.
>>
>> So to recap, the result is that `git remote show origin`  in the submodule shows a different origin than is in .gitmodules and .git/config
>>
>> One simple step to remedy this would be to add the deletion of the backing repository from the .git/modules directory, but again, I think an actual command to take care of all of these steps is in order anyways.  Not sure you want to encourage people poking around in the .git directory.
> 
> Unfortunately just throwing away the old repository under .git/modules,
> whether manually or by a git command, is no real solution here: it would
> make it impossible to go back to a commit which records the old submodule
> and check that out again.
> 
> The reason for this issue is that the submodule path is used as its name
> by "git submodule add". While we could check this type of conflict locally,
> we can't really avoid it due to the distributed nature of git (somebody
> else could add a different repo under the same path - and thus the same
> name - in another clone of the repo).
> 
> The only long term solution I can think of is to use some kind of UUID for
> the name, so that the names of newly added submodules won't have a chance
> to clash anymore. For the short term aborting "git submodule add" when a
> submodule of that name already exists in .git/modules of the superproject
> together with the ability to provide a custom name might at least solve
> the local clashes.

This two patch series implements the short term solution described above.

Using some kind of UUID can easily be added in a subsequent patch, we just
have to replace 'sm_name="$sm_path"' with 'sm_name=$(<generate uuid>)' in
line 348 of git-submodule.sh. I think it'll be the best solution to just
use a random UUID for that, as doing anything clever (like using the SHA1
of the url to avoid copies of the same remote repo) might lead to subtle
breakages (e.g. because it assumes the url stays unique forever, which it
sometimes won't). But maybe the short term solution is sufficient as most
of the time people won't produce submodule name conflicts (and names
derived from paths are much more readable that UUIDs). Thoughts?


Jens Lehmann (2):
  Teach "git submodule add" the --name option
  submodule add: Fail when .git/modules/<name> already exists

 Documentation/git-submodule.txt |  7 ++++-
 Documentation/gitmodules.txt    |  4 ++-
 git-submodule.sh                | 35 ++++++++++++++++-------
 t/t7400-submodule-basic.sh      | 63 +++++++++++++++++++++++++++++++++++++++++
 t/t7406-submodule-update.sh     |  2 +-
 5 files changed, 97 insertions(+), 14 deletions(-)

-- 
1.7.12.1.430.g4fd6dc4
