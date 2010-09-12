From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: tgt submodule?
Date: Sun, 12 Sep 2010 13:39:05 +0200
Message-ID: <4C8CBBD9.3090409@panasas.com>
References: <4C459A83.5060304@panasas.com> <4C459B87.1090908@panasas.com> <98e3b9f65ffe7883ced7474859b147f4@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Bryan Smith <bryansmi@umich.edu>, open-osd <osd-dev@open-osd.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 12 13:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouku9-0001tD-KO
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 13:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab0ILLjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 07:39:10 -0400
Received: from daytona.panasas.com ([67.152.220.89]:29629 "EHLO
	daytona.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751902Ab0ILLjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 07:39:09 -0400
Received: from fs2.bhalevy.com ([172.17.33.37]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 12 Sep 2010 07:39:07 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
In-Reply-To: <98e3b9f65ffe7883ced7474859b147f4@umich.edu>
X-OriginalArrivalTime: 12 Sep 2010 11:39:07.0962 (UTC) FILETIME=[1C4989A0:01CB526F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156031>

On 09/09/2010 10:11 PM, Bryan Smith wrote:
> 
> Sorry for being out of touch for so long, things have been hectic. I've
> been trying to get a final testing solution of VMs set up, and now all of a
> sudden the tgt submodule seems to be inaccessible. When I clone the osc-osd
> source, I receive the following:
> 
> remote: Counting objects: 6559, done.
> remote: Compressing objects: 100% (2445/2445), done.
> remote: Total 6559 (delta 4250), reused 6244 (delta 4024)
> Receiving objects: 100% (6559/6559), 1.33 MiB | 258 KiB/s, done.
> Resolving deltas: 100% (4250/4250), done.
> Submodule 'tgt' (git://git.open-osd.org/tgt/.git) registered for path 'tgt'
> Initialized empty Git repository in
> /home/branches/mikesucks/osc-osd/tgt/.git/
> fatal: The remote end hung up unexpectedly
> Clone of 'git://git.open-osd.org/tgt/.git' into submodule path 'tgt' failed
> 
> Trying to receive the submodule through git from within yields the same
> problem:
> 
> $ sudo git submodule update
> Initialized empty Git repository in
> /home/branches/mikesucks/osc-osd/tgt/.git/
> fatal: The remote end hung up unexpectedly
> Clone of 'git://git.open-osd.org/tgt/.git' into submodule path 'tgt' failed
> 
> From what I've researched on the internet, it seems to me that the source
> itself is having the problem. Do you have any further knowledge of this
> problem? Thanks in advance,
> 
> Bryan Smith
> CITI

Ha, that problem. Rrrr sorry about that. I'm in a catch 22 here, since
I enabled support for http:// cloning the git:// people with old trees and
old instructions have problems.

Here is what to do:
- For new trees do
[]$ git clone --recursive git://git.open-osd.org/osc-osd/.git

  Note the "/.git" at the end. If not supplied then the base tree will
  clone but the tgt submodule will fail. This is because for (dumb) http:
  clones you must supply the "/.git" at the end for it to be found and
  then a "./tgt" submodule path will fail. So I had to do a "../tgt" as
  path for submodule. When you clone as above all is fine but if you clone
  with out the "/.git" the server will be smart enough to find your tree
  by automatically appending the "/.git" directory. But the submodule
  command is no as smart and fails to try the silently added "/.git" directory

If you already cloned or you have an old tree. You can manually edit the
osc-osd/.git/config file to:
diff -Nurp .git/config.old .git/config
--- .git/config.old	2010-09-12 13:24:59.218017002 +0200
+++ .git/config	2010-09-12 13:24:44.283784834 +0200
@@ -5,9 +5,9 @@
 	logallrefupdates = true
 [remote "origin"]
 	fetch = +refs/heads/*:refs/remotes/origin/*
-	url = git://git.open-osd.org/osc-osd
+	url = git://git.open-osd.org/osc-osd/.git
 [branch "master"]
 	remote = origin
 	merge = refs/heads/master
 [submodule "tgt"]
-	url = git://git.open-osd.org/tgt/.git
+	url = git://git.open-osd.org/osc-osd/tgt/.git

[If you have an old tree the [submodule "tgt"] url
 will be OK but the [remote "origin"] url should be fixed
]

At the end you will need to do:
[]$ git remote update
[]$ git submodule update

Again Sorry for your trouble. But if I revert to the old way
then http:// access will not work at all. This way, I sacrifice git://
guys a bit but they still have a way to manage. (One solution
I did not try is having bare trees at server but that will change
every one's config files as well)

Boaz
