From: Brad Litterell <brad@evidence.com>
Subject: Question about how git determines the minimum packfile for a push.
Date: Mon, 27 Apr 2015 00:41:28 +0000
Message-ID: <E51394554A503C4E852F9BEE46B03E8D01E4E784@TI-ODIN.tasernet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 02:48:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmXDW-0000cU-P0
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 02:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbbD0ArT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 20:47:19 -0400
Received: from email.taser.com ([74.206.119.92]:44744 "EHLO LOKI.atmoss"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751249AbbD0ArS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 20:47:18 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2015 20:47:18 EDT
Received: from TI-THOR.tasernet.com (172.16.1.113) by email.taser.com
 (10.10.20.113) with Microsoft SMTP Server (TLS) id 14.2.347.0; Sun, 26 Apr
 2015 17:41:30 -0700
Received: from TI-ODIN.tasernet.com ([fe80::64ff:7320:e6e7:27c8]) by
 TI-THOR.tasernet.com ([fe80::7c49:ae21:6650:2789%21]) with mapi id
 14.02.0347.000; Sun, 26 Apr 2015 17:41:29 -0700
Thread-Topic: Question about how git determines the minimum packfile for a
 push.
Thread-Index: AdCAgODnZ9ypwjyVQoKisLxwjX682Q==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.103]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267843>

Hi,

I'm using git with a submodule containing a (large) binary toolchain where I updated the version from GCC-4.7 to 4.8.  When I added 4.8 I deleted 4.7 and now want to add 4.7 back to the HEAD.  As shown in the tree objects below, the 4.7 bits are still in the repository (as expected), but when I try to push a commit and tree object that puts them back, git tries to send all 4000+ objects again, even though the objects are already be on the server from a previous commit. (I have confirmed this with git cat-file on the server.) From my research it seems like git is supposed to identify the common objects and not do this.

For example, consider the last three commits (most recent on top).

$ git log
bb384915e12e925ead5ab8ad5161c84e0ef2b7f7 (HEAD, master) Add GCC-4.7 back to the image for side-by-side testing. Will delete it later.
2dfd226e6d2cc0a1dc58770d1dcaec1ba863df72 (origin/master) Upgrade toolchain to GCC-4.8. (delete GCC-4.7)
816fde0fdec1506600f19de4e3e4e02a6fe08639 (tag: release-1) Compiler toolchain 4.7

Here are the internal tree objects for those 3 commits:

# git cat-file -p 816fde^{tree}
$ cat old.tree
100644 blob 841b8359fce4edaf7549b87e1a81e7091c1dff6c    .arcconfig
100644 blob 21cb788d9f6e99367d96ba19d8c7470164e7d298    .gitmodules
040000 tree 470dfed1791b3ab7b4c731e354fd7685609c057a    arcanist
100644 blob 588866ae2c8a815ff26c5930b98d2a8ac9b934a0    gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2
040000 tree 7a1ae67dd2ff1fd358ad52d25852b340355339fe    gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux

# git cat-file -p 2dfd22^{tree}
$ cat middle.tree
100644 blob 841b8359fce4edaf7549b87e1a81e7091c1dff6c    .arcconfig
100644 blob 21cb788d9f6e99367d96ba19d8c7470164e7d298    .gitmodules
100644 blob 79c4d3271c1177822786f82201c80b928fc35c6e    README
040000 tree 470dfed1791b3ab7b4c731e354fd7685609c057a    arcanist
100644 blob f71d6dd4e13a3de4b0c38dd37e4c2bc94c503f26    gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux.tar.bz2
100644 blob 026e2d232bd7bb1cf0b9efb61c8cd307a52526ec    gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux.tar.bz2.asc
040000 tree d03b4cf20163ca7a0ab5c02365890855146d8e0c    gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux

# git cat-file -p HEAD^{tree}
$ cat new.tree
100644 blob 841b8359fce4edaf7549b87e1a81e7091c1dff6c    .arcconfig
100644 blob 21cb788d9f6e99367d96ba19d8c7470164e7d298    .gitmodules
100644 blob 79c4d3271c1177822786f82201c80b928fc35c6e    README
040000 tree 470dfed1791b3ab7b4c731e354fd7685609c057a    arcanist
100644 blob 588866ae2c8a815ff26c5930b98d2a8ac9b934a0    gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2
040000 tree 7a1ae67dd2ff1fd358ad52d25852b340355339fe    gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux
100644 blob f71d6dd4e13a3de4b0c38dd37e4c2bc94c503f26    gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux.tar.bz2
100644 blob 026e2d232bd7bb1cf0b9efb61c8cd307a52526ec    gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux.tar.bz2.asc
040000 tree d03b4cf20163ca7a0ab5c02365890855146d8e0c    gcc-linaro-arm-linux-gnueabihf-4.8-2013.12_linux

By examining the tree objects with git cat-file -p it is clear that adding back GCC-4.7 added back the same exact blobs, which was expected, namely:

100644 blob 588866ae2c8a815ff26c5930b98d2a8ac9b934a0    gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2
040000 tree 7a1ae67dd2ff1fd358ad52d25852b340355339fe    gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux

But, whenever I try to push, git tries to write 4000+ objects across the wire:

$ git push origin master
Counting objects: 4854, done.
Delta compression using up to 6 threads.
Compressing objects: 100% (2295/2295), done.
Writing objects:   0% (2/4853), 9.26 MiB | 3.08 MiB/s
^C   

All the parts are already on the server so it seems like the only objects to upload would be the commit object and the new associated tree (not the blob (5888) and tree (7a1a) below it).

Further, it seems like my local git client should be able to discern this from its knowledge of the origin/master ref.

I don't want to let this push complete if it will result in duplication on the server because this repo is already 400MB and slow to clone.

Can someone please explain what is happening here? using git push -thin doesn't seem to make a difference.

Is it possible git is not computing the delta correctly?  Or does git only look at the top-level commit objects to figure out what to include in the push packfile?

Will it upload the larger pack only to have the server correctly handle the duplicates?

In case it matters, the server in question is running Atlassian Stash.

Thanks,
Brad
