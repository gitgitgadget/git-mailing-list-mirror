From: alan@clueserver.org
Subject: Rebase bug
Date: Fri, 31 Jul 2015 14:26:26 -0700
Message-ID: <14fe2a0c9b92fc27d3ab5b2083cb16b2.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 23:32:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLHua-0002fO-Au
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946569AbbGaVcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:32:10 -0400
Received: from clueserver.org ([65.102.45.174]:46262 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755209AbbGaVcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 17:32:08 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2015 17:32:08 EDT
Received: from clueserver.org (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 2B7B76008D7
	for <git@vger.kernel.org>; Fri, 31 Jul 2015 14:26:26 -0700 (PDT)
Received: from 192.55.55.41
        (SquirrelMail authenticated user alan)
        by clueserver.org with HTTP;
        Fri, 31 Jul 2015 14:26:26 -0700
User-Agent: SquirrelMail/1.4.22-14.fc20
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275078>

I think I have identified an obscure bug. I have a reproducible test case.
I am trying to come up with enough of a test case that can be used for
finding and fixing the issue.

I have a set of patches. They are diffs. Some have whitespace issues.
(Which I believe triggers the bug.)

The patches go on top of the linux-stable kernel at version 3.12.17. They
apply with no real problems. (There was a minor issue, but I don't believe
it has anything to do with this bug. It was to deal with a patch later on
in the patch set.)

Each patch is added and committed as a separate commit.

I am then doing a fast-forward rebase on the branch to 3.12.45.

The first 24 patches apply cleanly. The 25th has merge conflicts. One of
the files it conflicts on is one that is added by patch 4. That should not
happen.

If I remove the following settings from my ~/.gitconfig, the rebase works
correctly.

[apply]
        whitespace = fix

[core]
        whitespace = trailing-space,space-before-tab,indent-with-non-tab

The diff with the --check option shows the following on the file:

arch/x86/pci/intel_media_proc_gen3.c:427: space before tab in indent.
+               pci_direct_conf1.read(0, 1,
PCI_DEVFN(av_dev_reg_fixups_ce2600[i].dev,
arch/x86/pci/intel_media_proc_gen3.c:428: space before tab in indent.
+               av_dev_reg_fixups_ce2600[i].func),
av_dev_reg_fixups_ce2600[i].reg, 4,
arch/x86/pci/intel_media_proc_gen3.c:914: indent with spaces.
+        *table = flash_layout_table;
arch/x86/pci/intel_media_proc_gen3.c:915: indent with spaces.
+        *len = flash_layout_table_length;
arch/x86/pci/intel_media_proc_gen3.c:916: indent with spaces.
+        return 0;
arch/x86/pci/intel_media_proc_gen3.c:956: space before tab in indent.
+                       raw_pci_ops = &ce_soc_pci_conf;
arch/x86/pci/intel_media_proc_gen3.c:968: space before tab in indent.
+               raw_pci_ops = &ce_soc_pci_conf;
arch/x86/pci/intel_media_proc_gen3.c:984: space before tab in indent.
+               pci_direct_conf1.write(0, 0, 0, 0xd0, 4, 0x060040f0);
arch/x86/pci/intel_media_proc_gen3.c:989: space before tab in indent.
+               raw_pci_ops = &ce_soc_pci_conf;


What I believe is happening is that the patches get readded to the HEAD of
3.12.45 and gets corrected for whitespace. When it gets to the next
occurrence of the file, it is compared before the whitespace gets
corrected. (I don't know if this is the actual cause, but it seems
likely.)

If I comment out the above config lines, the rebase works as expected.

It is only this one file that triggers it. I am trying to figure out a
small test case that triggers it without including all 50+ patches.

Ideas?
