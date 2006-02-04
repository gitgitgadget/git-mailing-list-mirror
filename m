From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Fri, 03 Feb 2006 18:35:17 -0800
Message-ID: <7vy80r97h6.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005F34393@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Marco Costalba" <mcostalba@yahoo.it>,
	"Aneesh Kumar" <aneesh.kumar@gmail.com>,
	"Dave Jones" <davej@redhat.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 03:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5DGp-0007Yn-CN
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 03:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946266AbWBDCfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 21:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946267AbWBDCfV
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 21:35:21 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49115 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1946266AbWBDCfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 21:35:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204023235.CRKM17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 21:32:35 -0500
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005F34393@hdsmsx401.amr.corp.intel.com>
	(Len Brown's message of "Fri, 3 Feb 2006 13:34:35 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15564>

"Brown, Len" <len.brown@intel.com> writes:

> Naming the branch is just eye-candy for the merge comment.
> My topic branch labels in refs/my-branch never get to kernel.org, so you're
> not going to see the pretty green tags on topic branches branches that I see.
>
> I include the full-URL of the bug report in the original commit comments
> for those who are interested.  I think this it the important place to put it,
> and in practice I've found it to be extremely useful.

Both excellent points.

If I may digress,...

It appears most of the topic branches in that merge have only
one commit since they forked from trunk (the development track
led to the first parent of that merge), but some seem to have
more than one commits.

It might make sense if we have a tool support to pre-format the
merge messages like this, given set of branch names:

    [ACPI] Merge 3549, 4320, 4485, 4588, 4980, 5483, 5651, acpica, asus, fops and pnpacpi branches into release

    3549: [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops
    4320: [ACPI] fix reboot upon suspend-to-disk
    4485: [ACPI] handle BIOS with implicit C1 in _CST
    4588: [ACPI] fix acpi_os_wait_sempahore() finite timeout case (AE_TIME warning)
    4980 (5 commits): [ACPI] build EC driver on IA64
    5483 (3 commits): [ACPI] fix acpi_cpufreq.c build warrning
    5651: [ACPI] SMP S3 resume: evaluate _WAK after INIT
    acpica (23 commits): [ACPI] ACPICA 20060113
    asus (3 commits): [ACPI_ASUS] fix asus module param description
    fops (2 commits): [ACPI] make two processor functions static
    pnpacpi (3 commits): [PNPACPI] clean excluded_id_list[]

Here I am counting the number of commits on each topic since it
last diverged from trunk (`merge-base release branch`), and
showing the latest commit of the topic.

We could even go further and have "per branch annotation" that
lets you do something like this:

	$ git checkout -b 3549 \
          --description 'http://bugzilla.kernel.org/show_bug.cgi?id=3549'
	$ work work
        $ git commit
	... work on other topics in similar way ...
        ... later, on the 'release' branch ...
        $ git pull . 3549 4320 4485...

With that, we could give a default merge message formatted like this:

    Merge 3549, 4320, 4485, 4588, 4980, 5483, 5651, acpica, asus, fops and pnpacpi branches into release

    3549: http://bugzilla.kernel.org/show_bug.cgi?id=3549
     [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops

    4320: http://bugzilla.kernel.org/show_bug.cgi?id=4320
     [ACPI] fix reboot upon suspend-to-disk

    5483: http://bugzilla.kernel.org/show_bug.cgi?id=5483
     [ACPI] fix acpi_cpufreq.c build warrning
     [ACPI] IA64 ZX1 buildfix for _PDC patch
     [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once

    pnpacpi: work on PNP-ACPI issues
     [PNPACPI] clean excluded_id_list[]
     [PNPACPI] Ignore devices that have no resources
     [ACPI] enable PNPACPI support for resource types used by HP serial ports

This last digression might be too much, though.  It may be
something that is better computed by 'git log' while reviewing
history, except that the description of each branch cannot be
given that way.
