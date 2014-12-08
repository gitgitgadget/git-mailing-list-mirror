From: Martin Scherer <m.scherer@fu-berlin.de>
Subject: Blobs not referenced by file (anymore) are not removed by GC
Date: Mon, 08 Dec 2014 17:22:23 +0100
Message-ID: <5485D03F.3060008@fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1Bz-0005YF-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbaLHQ3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:29:43 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57418 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755494AbaLHQ3m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:29:42 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Dec 2014 11:29:42 EST
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.82)
          for git@vger.kernel.org with esmtp
          (envelope-from <m.scherer@fu-berlin.de>)
          id <1Xy14r-001KnO-9D>; Mon, 08 Dec 2014 17:22:25 +0100
Received: from zafc6.pia.fu-berlin.de ([87.77.175.198] helo=[10.175.198.1])
          by inpost2.zedat.fu-berlin.de (Exim 4.82)
          for git@vger.kernel.org with esmtpsa
          (envelope-from <m.scherer@fu-berlin.de>)
          id <1Xy14r-003aFa-7i>; Mon, 08 Dec 2014 17:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
OpenPGP: url=pgp.mit.edu
X-Originating-IP: 87.77.175.198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261076>

Hi,

after using BFG on a repo given certain directory globs, all of those
files(names) are gone from history, but can not be collected by garbage
collection anymore. So the blobs of the underlying files are not deleted
and only the file names are not associated with the blob anymore. I
wonder, if I discovered a bug (at least in bfg). But I expect git to
discover that this blobs are not used in any way (so they have to
associated to something right?)

# invoke bfg --delete-folders something multiple times with different
pattern.

# try to cleanup

git gc --aggressive --prune=now # big blobs still in history
git fsck # no results
git fsck --full  --unreachable --dangling # no results

to verify if the blobs are still there, see the output of

git gc && git verify-pack -v .git/objects/pack/pack-*.idx | egrep "^\w+
blob\W+[0-9]+ [0-9]+ [0-9]+$" | sort -k 3 -n -r > bigobjects
.txt

head bigobjects.txt # outputs 9451427d7335395779b91864418630d2f0af780a
blob   7895212 1869047 7657491


Also if bfg is being told to remove the biggest blob (bfg -B 1) with
no-blob-protection, it does not succeed in removing it.

--- output of bfg -B 1

Found 1 blob ids for large blobs - biggest=7895212 smallest=7895212
....

BFG aborting: No refs to update - no dirty commits found??
---

The repo can be found here.

https://github.com/marscher/stallone_stale_objects

I will restart all over to cleanup the history, but I guess this might
be interesting for git developers.


Best,
Martin
