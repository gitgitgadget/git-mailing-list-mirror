From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 13:05:39 +0100
Message-ID: <20090129120539.GA26975@elte.hu>
References: <49814BA4.6030705@zytor.com> <7vr62mha7a.fsf@gitster.siamese.dyndns.org> <20090129113846.GA10645@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 13:07:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVfz-0002hn-V6
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 13:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbZA2MF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 07:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbZA2MFz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 07:05:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40247 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbZA2MFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 07:05:54 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LSVeT-0003pt-PL
	from <mingo@elte.hu>; Thu, 29 Jan 2009 13:05:52 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 7E1B53E21AA; Thu, 29 Jan 2009 13:05:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090129113846.GA10645@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107666>


* Ingo Molnar <mingo@elte.hu> wrote:

> a simple 'git fsck' still reports a ton of dangling and missing objects. 
> (see it below)
> 
> amongst them is the object above:
> 
>   missing blob af0e01d4c663a101f48614e40d006ed6272d5c36
> 
> but this does not seem to cause problems with git version 1.6.0.6 that 
> i'm using now.

hm - maybe it's unrelated, but yesterday, a few hours before the incident 
i did a higher-order Octopus merge with 1.6.1, that segfaulted.

I didnt think much of it - git often crashes with our crazy -tip tree when 
i get above the magic 20 branches limit. The crash left a .git/index.lock 
file around which i removed - and then forgot about the incident. I wanted 
to report those crashes before but procrastinated it.

I used git/maint snapshots because new versions of Git are much better at 
doing Octopus merges.

I've written a reproducer for git-1.6.1.1-1.fc11.i386. See the crash log 
below.

To reproduce, pick up the -tip tree as a remote:

   http://people.redhat.com/mingo/tip.git/README

(you can run the README file as a script)

Then do this:

   git checkout -b tmp.crash v2.6.29-rc3

   git merge  tip/x86/asm        tip/x86/cleanups     tip/x86/cpudetect    \
              tip/x86/debug      tip/x86/doc          tip/x86/header-fixes \
              tip/x86/mm         tip/x86/paravirt     tip/x86/pat          \
              tip/x86/setup-v2   tip/x86/subarch      tip/x86/uaccess      \
              tip/x86/urgent     tip/core/percpu

and you should see the segfault.

interestingly i did not reproduce with the sha1's hardcoded:

  git checkout -b tmp.crash 18e352e4a73465349711a9324767e1b2453383e2

 git merge 2d4d57db692ea790e185656516e6ebe8791f1788 a448720ca3248e8a7a426336885549d6e923fd8e b38b0665905538e76e26f2a4c686179abb1f69f6 d5e397cb49b53381e4c99a064ca733c665646de8 e56d0cfe7790fd3218ae4f6aae1335547fea8763 dbca1df48e89d8aa59254fdc10ef16c16e73d94e fb746d0e1365b7472ccc4c3d5b0672b34a092d0b 6522869c34664dd5f05a0a327e93915b1281c90d d639bab8da86d330493487e8c0fea8ca31f53427 042cbaf88ab48e11afb725541e3c2cbf5b483680 5662a2f8e7313f78d6b17ab383f3e4f04971c335 3b4b75700a245d0d48fc52a4d2f67d3155812aba bf3647c44bc76c43c4b2ebb4c37a559e899ac70e 4369f1fb7cd4cf777312f43e1cb9aa5504fc4125

	Ingo

-------------------->
earth4:~/tip> git merge x86/asm x86/cleanups x86/cpudetect x86/debug 
x86/doc x86/header-fixes x86/mm x86/paravirt x86/pat x86/setup-v2 
x86/subarch x86/uaccess x86/urgent core/percpu
Trying simple merge with 2d4d57db692ea790e185656516e6ebe8791f1788
Trying simple merge with a448720ca3248e8a7a426336885549d6e923fd8e
Simple merge did not work, trying automatic merge.
Auto-merging arch/x86/include/asm/io.h
Auto-merging arch/x86/include/asm/spinlock.h
Auto-merging arch/x86/kernel/mpparse.c
Auto-merging arch/x86/kernel/setup_percpu.c
Auto-merging arch/x86/mm/init_32.c
Trying simple merge with b38b0665905538e76e26f2a4c686179abb1f69f6
Simple merge did not work, trying automatic merge.
Auto-merging arch/x86/kernel/cpu/common.c
Auto-merging arch/x86/kernel/cpu/intel.c
Auto-merging arch/x86/mm/pat.c
Trying simple merge with d5e397cb49b53381e4c99a064ca733c665646de8
Trying simple merge with e56d0cfe7790fd3218ae4f6aae1335547fea8763
Trying simple merge with dbca1df48e89d8aa59254fdc10ef16c16e73d94e
Trying simple merge with fb746d0e1365b7472ccc4c3d5b0672b34a092d0b
Trying simple merge with 6522869c34664dd5f05a0a327e93915b1281c90d
Simple merge did not work, trying automatic merge.
Auto-merging arch/x86/include/asm/paravirt.h
Trying simple merge with d639bab8da86d330493487e8c0fea8ca31f53427
Simple merge did not work, trying automatic merge.
Auto-merging arch/x86/include/asm/io.h
Auto-merging arch/x86/mm/ioremap.c
Trying simple merge with 042cbaf88ab48e11afb725541e3c2cbf5b483680
Trying simple merge with 5662a2f8e7313f78d6b17ab383f3e4f04971c335
Trying simple merge with 3b4b75700a245d0d48fc52a4d2f67d3155812aba
Simple merge did not work, trying automatic merge.
Auto-merging arch/x86/kernel/signal.c
Trying simple merge with bf3647c44bc76c43c4b2ebb4c37a559e899ac70e
Simple merge did not work, trying automatic merge.
Auto-merging arch/x86/kernel/cpu/intel.c
Trying simple merge with 4369f1fb7cd4cf777312f43e1cb9aa5504fc4125
/usr/libexec/git-core/git-merge-octopus: line 52: 26758 Segmentation fault      
git read-tree -u -m --aggressive $common $MRT $SHA1
Merge with strategy octopus failed.
earth4:~/tip> 
