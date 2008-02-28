From: Alex Chiang <achiang@hp.com>
Subject: Re: stgit - continue rebase after merge conflict?
Date: Thu, 28 Feb 2008 10:38:30 -0700
Message-ID: <20080228173830.GA16045@ldl.fc.hp.com>
References: <20080226145725.GA24987@ldl.fc.hp.com> <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUmiu-0005ha-9N
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbYB1Ric (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 12:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbYB1Ric
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:38:32 -0500
Received: from g4t0015.houston.hp.com ([15.201.24.18]:48318 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbYB1Rib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 12:38:31 -0500
Received: from g4t0015.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id ACD9B8318;
	Thu, 28 Feb 2008 17:38:30 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 99BAB810C;
	Thu, 28 Feb 2008 17:38:30 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 7627A1E672E;
	Thu, 28 Feb 2008 17:38:30 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id 5BD4A134006; Thu, 28 Feb 2008 10:38:30 -0700 (MST)
Mail-Followup-To: Alex Chiang <achiang@hp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75426>

* Catalin Marinas <catalin.marinas@gmail.com>:
> On 26/02/2008, Alex Chiang <achiang@hp.com> wrote:
> >  How does one do a stg rebase if there are merge conflicts?
> 
> Basically, you solve the conflict, refresh the current patch and
> continue with 'stg push' or 'stg goto <top patch>'. The 'rebase'
> command does 'pop --all', 'git reset', 'push --all'. In your conflict,
> the base of the stack was already changed to the latest and hence only
> push/goto is needed. To fix it:
> 
> $ vi files   # or simply use 'resolved -i' below
> $ stg resolved -a [-i]
> $ stg refresh
> $ stg goto top-patch

That goto command doesn't tell you about merge conflicts:

achiang@blender:~/kernels/linux-2.6$ stg series
+ 0001-Remove-path-attribute-from-sgi_hotplug.patch
> 0002-Construct-one-fakephp-slot-per-pci-slot.patch
- 0003-Introduce-pci_slot.patch
- 0004-ACPI-PCI-slot-detection-driver.patch

achiang@blender:~/kernels/linux-2.6$ stg goto 0004-ACPI-PCI-slot-detection-driver.patch 
Pushed 0003-Introduce-pci_slot.patch (conflict)
Error: Merge conflict
Now at patch "0003-Introduce-pci_slot.patch"

achiang@blender:~/kernels/linux-2.6$ stg series
+ 0001-Remove-path-attribute-from-sgi_hotplug.patch
+ 0002-Construct-one-fakephp-slot-per-pci-slot.patch
> 0003-Introduce-pci_slot.patch
- 0004-ACPI-PCI-slot-detection-driver.patch

Since this patch series is small, I just did a 'stg push' and now
it tells me about the conflicts. But I don't think I'd want to do
that if I was managing tens or hundreds of patches...

achiang@blender:~/kernels/linux-2.6$ stg push --undo
Undoing push of "0003-Introduce-pci_slot.patch" ... done
Now at patch "0002-Construct-one-fakephp-slot-per-pci-slot.patch"
achiang@blender:~/kernels/linux-2.6$ stg push
Checking for changes in the working directory ... done
Pushing patch "0003-Introduce-pci_slot.patch" ... 
  CONFLICT (content): Merge conflict in drivers/pci/hotplug/acpiphp_ibm.c
  CONFLICT (content): Merge conflict in drivers/pci/hotplug/pci_hotplug_core.c
  CONFLICT (content): Merge conflict in drivers/pci/hotplug/rpadlpar_sysfs.c
  CONFLICT (content): Merge conflict in include/linux/pci.h
  CONFLICT (content): Merge conflict in include/linux/pci_hotplug.h
  Error: The merge failed during "push".
         Revert the operation with "push --undo".
  stg push: 5 conflict(s)

Is this pilot error? Or is goto misbehaving?

Thanks.

/ac

