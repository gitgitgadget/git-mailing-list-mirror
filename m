From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport
Date: Tue, 16 May 2006 11:53:41 -0600
Message-ID: <m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 19:54:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg3kk-0004ve-OF
	for gcvg-git@gmane.org; Tue, 16 May 2006 19:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWEPRye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 13:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWEPRye
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 13:54:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8325 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932330AbWEPRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 13:54:33 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4GHrh2K010660;
	Tue, 16 May 2006 11:53:43 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4GHrgwh010659;
	Tue, 16 May 2006 11:53:42 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605161001190.3866@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 16 May 2006 10:03:19 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20130>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 16 May 2006, Eric W. Biederman wrote:
>>
>> If the --author flag was not given the the author is recorded as 
>> unknown.
>
> Please don't do this. Just error out. It would be horrible to have a quilt 
> import "succeed", and then later notice that some of the patches had 
> incorrect authorship attribution just because the import script didn't 
> check it, but just made it "unknown".
>
> An un-attributed patch is simply not acceptable in any serious project. 
> It's much better to consider it an error than to say "ok".

There are two practical problems with this.
1) quilt does not force any authorship information to be preserved,
   in the description, so this probably a common case.  Although for
   most users just needing to specify --author sounds reasonable.

2) There are currently 84 out of roughly 1322 patches in
   2.6.17-rc4-mm1 that git-mailinfo cannot compute the author for.
   Generally the information is there but in such an irregular form
   that it cannot be automatically detected.

   If we can resolve that problem I am willing to make it an error.
   If we can't then sucking quilt patches into a git tree is much
   less useful.  

   Given the ugliness in -mm making it an error to have an
   non-attributed patch would result in people specifying --author
   when they really don't know who the author is, giving us much
   less reliable information.

   Possibly what we need is an option to not make it an error so that
   people doing this kind of thing in their own trees have useful
   information.


The list of patches that git-mailinfo cannot find authorship
information for from 2.6.17-rc4-mm1 is included below.  Mostly these
are either git trees splatted into a single file, or simply fixes
added by Andrew.  But there are some like: gregkh-usb-usb-gotemp
that have no description at all and only the patch name records who
made the patch.

A really ugly case is acx1xx-wireless-driver patch, which
appears to have multiple authors and a serious history
before Andrew got it.

>From acx1xx-wireless-driver.patch
> acx100.sourceforge.net (Andreas Mohr <andi@rhlx01.fht-esslingen.de>) ->
>   -> Denis Vlasenko <vda@ilport.com.ua>
>      -> Jeff Garzik <jgarzik@pobox.com>
>         -> me
> 
> DESC
> acx1xx-wireless-driver-usb-is-bust
> EDESC
> From: Andrew Morton <akpm@osdl.org>
> 
> drivers/net/wireless/tiacx/usb.c:1116: `URB_ASYNC_UNLINK' undeclared (first use in this function)
> 
> Cc: Denis Vlasenko <vda@ilport.com.ua>
> DESC
> acx1xx-allow-modular-build
> EDESC
> From: Andrew Morton <akpm@osdl.org>
> DESC
> acx1xx-wireless-driver-spy_offset-went-away
> EDESC
> From: Andrew Morton <akpm@osdl.org>
> 
> Cc: Denis Vlasenko <vda@ilport.com.ua>
> DESC
> acx update
> EDESC
> From: Denis Vlasenko <vda@ilport.com.ua>
> 
> > > Attached is a patch which updates acx. All your changes are
> > > included too. allyesconfig build is fixed by unifying
> > > PCI and USB modules into one. 'acx_debug' parameter is renamed back
> > > to just 'debug' (because all previous versions used it and
> > > we don't want to add to user confusion).
> > >
> > > Please apply.
> > >
> > > Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
> >
> > I missed a spy_offset fix. Updated patch is attached.
> > Also it is at
> > http://195.66.192.167/linux/acx_patches/linux-2.6.13-mm2acx-2.patch.bz2
> 
> Oh no. Yes. I forgot to remove some standalone build aids.
> 
> DESC
> acx-update 2
> EDESC
> From: Denis Vlasenko <vda@ilport.com.ua>
> 
> [20051016] 0.3.13
> * Revert 20051013 fix, we have one which actually works.
>   Thanks Jacek Jablonski <yacek87@gmail.com> for testing!
> 
> [20051013]
> * trying to fix "yet another similar bug"
> * usb fix by Carlos Martin
> 
> [20051012] 0.3.12
> * acx_l_clean_tx_desc bug fixed - was stopping tx completely
>   at high load. (It seems there exists yet another similar bug!)
> * "unknown IE" dump was 2 bytes too short - fixed
> * DUP logging made less noisy
> * another usb fix by Carlos Martin <carlosmn@gmail.com>
> 
> [20051003]
> * several usb fixes by Carlos Martin <carlosmn@gmail.com> - thanks!
> * unknown IE logging made less noisy
> * few unknown IEs added to the growing collection
> * version bump to 0.3.11
> 
> [20050916]
> * fix bogus MTU handling, add ability to change MTU
> * fix WLAN_DATA_MAXLEN: 2312 -> 2304
> * version bump to 0.3.10
> 
> [20050915]
> * by popular request default mode is 'managed'
> * empty handler for EID 7 (country info) is added
> * fix 'timer not started - iface is not up'
> * tx[host]desc micro optimizations
> * version bump to 0.3.9
> 
> [20050914]
> * tx[host]desc ring workings brought a bit back to two-hostdesc
>   scheme. This is an attempt to fix weird WG311v2 bug.
>   I still fail to understand how same chip with same fw can
>   work for me but do not work for a WG311v2 owner. Mystery.
> * README updated
> * version bump to 0.3.8
> 
> [20050913]
> * variable and fields with awful names renamed
> * a few fields dropped (they had constant values)
> * small optimization to acx_l_clean_tx_desc()
> * version bump to 0.3.7

      origin
      git-acpi
      git-agpgart
      git-alsa
      git-block
      git-cfq
      git-cifs
      git-dvb
      git-gfs2
      git-ia64
      git-ieee1394
      git-infiniband
      git-intelfb
      sane-menuconfig-colours
      git-klibc
      git-hdrcleanup
      git-hdrinstall
      git-libata-all
      libata_resume_fix
      git-mips
      git-mtd
      git-netdev-all
      git-nfs
      git-ocfs2
      git-powerpc
      git-rbtree
      git-sas
      gregkh-pci-acpiphp-configure-_prt-v3
      gregkh-pci-acpiphp-hotplug-slot-hotplug
      gregkh-pci-acpiphp-host-and-p2p-hotplug
      gregkh-pci-acpiphp-turn-off-slot-power-at-error-case
      gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code
      gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt
      gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free
      gregkh-pci-pci-64-bit-resources-drivers-pci-changes
      gregkh-pci-pci-64-bit-resources-drivers-media-changes
      gregkh-pci-pci-64-bit-resources-drivers-net-changes
      gregkh-pci-pci-64-bit-resources-drivers-pcmcia-changes
      gregkh-pci-pci-64-bit-resources-drivers-others-changes
      gregkh-pci-pci-msi-abstractions-and-support-for-altix
      git-pcmcia
      git-scsi-target
      gregkh-usb-usb-gotemp
      git-supertrak
      git-watchdog
      x86_64-mm-defconfig-update
      x86_64-mm-memset-always-inline
      x86_64-mm-amd-core-cpuid
      x86_64-mm-amd-cpuid4
      x86_64-mm-alternatives
      x86_64-mm-ia32-unistd-cleanup
      x86_64-mm-topology-comment
      x86_64-mm-new-compat-ptrace
      x86_64-mm-disable-agp-resource-check
      x86_64-mm-new-northbridge
      x86_64-mm-iommu-warning
      x86_64-mm-i386-up-generic-arch
      x86_64-mm-iommu-enodev
      x86_64-mm-compat-printk
      x86_64-mm-i386-numa-summit-check
      x86_64-mm-fix-b44-checks
      x86_64-mm-nommu-warning
      git-cryptodev
      mm
      acx1xx-wireless-driver
      reiser4-export-find_get_pages
      kgdb-core-lite
      kgdb-8250
      kgdb-netpoll_pass_skb_to_rx_hook
      kgdb-eth
      kgdb-i386-lite
      kgdb-cfi_annotations
      kgdb-sysrq_bugfix
      kgdb-module
      kgdb-core
      kgdb-i386
      journal_add_journal_head-debug
      list_del-debug
      unplug-can-sleep
      firestream-warnings
      git-viro-bird-m32r
      git-viro-bird-m68k
      git-viro-bird-frv
      git-viro-bird-upf
      git-viro-bird-volatile

Eric
