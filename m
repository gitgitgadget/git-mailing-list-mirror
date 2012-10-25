From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Unexpected behaviour after removing submodule
Date: Thu, 25 Oct 2012 17:06:40 +0200
Message-ID: <50895580.9080408@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 17:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRP8N-0006pA-BW
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 17:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934120Ab2JYPN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 11:13:56 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:35537 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946074Ab2JYPNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 11:13:53 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2012 11:13:53 EDT
Received: from mail247.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id A76F910501ED
	for <git@vger.kernel.org>; Thu, 25 Oct 2012 17:13:38 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 25 Oct 2012 17:06:42 +0200
Received: from unknown (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@5.23.40.158)
  by ns0.ovh.net with SMTP; 25 Oct 2012 17:06:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Ovh-Tracer-Id: 6161205766418915294
X-Ovh-Remote: 5.23.40.158 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeehfedrtdelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecunecuhfhrohhmpefpihgtohhlrghsucfoohhrvgihqdevhhgrihhsvghmrghrthhinhcuoeguvghvvghlqdhgihhtsehmohhrvgihqdgthhgrihhsvghmrghrthhinhdrtghomheqnecujfgurhepkfffhfhrfgggvffutgfgsehtjegrtddtfedu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeehfedrtdelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecunecuhfhrohhmpefpihgtohhlrghsucfoohhrvgihqdevhhgrihhsvghmrghrthhinhcuoeguvghvvghlqdhgihhtsehmohhrvgihqdgthhgrihhsvghmrghrthhinhdrtghomheqnecujfgurhepkfffhfhrfgggvffutgfgsehtjegrtddtfedu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208402>

Hi,

At work, we use a lot of submodules (several levels of submodules actually).
As we also work with development branches, we use scripts to resync the whole checked-out tree (mainly in automated integration)

We recently run across an issue where a branch (dev) contained a submodule while it had been removed in master and the files were imported in a subdirectory with the same name (probably using git-subtree).

Basically:

On dev:
* top/refs(submodule)/file1
On master:
* top/refs(dir)/file1

Outside the fact that it is quite hard to move from one branch to the other while having a perfectly clean tree checked out underneath, we manage to end up into a weird (invalid) state
that was neither clearly described nor "easy" to cleanup (using standard git clean/checkout/reset commands).

While I cannot explain how we got in this state, here is a small test-case that produce the same results:
------
mkdir folder1
cd folder1
git init
echo "Ooops" > file
git add file
git commit -m "Add file"
cd ..
mkdir folder2
cd folder2
git init
mkdir folder1
echo "Ooops" > folder1/file
git add folder1/file
git commit -m "Add file again"
git checkout -b branch
cp -R ../folder1/.git ./folder1
------
The 'cp' just seems pointless but with the submodule described as above we manage to end up in a similar state.
In this state, when being in folder2, git status reports nothing. Dev branch is checked out and everything looks great.

However if you change dir to folder2/folder1, while still being inside folder2, git thinks (because of the .git dir) that you are actually on master branch of folder1 repository.
Which mean that if you happen to commit from a subdirectory, you may easily end-up committing in another repository than the one expected.

The issue is, there is no way from folder2 to see that something "wrong" is going on inside your tree!
As we manage to reach this state using only standard git commands (I'll try to reproduce it) with submodules, and this being part of an automated flow, it is quite worrying.
We may actually be committing in the wrong repo and pushing the wrong things around.

Is there or should there be a way to look for such issues? And is this an expected behaviour?

Thanks in advance

Nicolas
