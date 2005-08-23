From: Junio C Hamano <junkio@cox.net>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 16:58:45 -0700
Message-ID: <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	<7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
	<1124836282.14730.4.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 02:00:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7ifM-0002Ty-Ch
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 01:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVHWX6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 19:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVHWX6s
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 19:58:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59597 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932497AbVHWX6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 19:58:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823235846.ECNU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 19:58:46 -0400
To: Len Brown <len.brown@intel.com>
cc: git@vger.kernel.org
In-Reply-To: <1124836282.14730.4.camel@toshiba> (Len Brown's message of "Tue,
	23 Aug 2005 18:31:22 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7685>

Len Brown <len.brown@intel.com> writes:

>> I could get to 81065e2f415af6... commit (Linus tip at this
>> moment), so if you can tell me where to snarf the other commit
>> (702c7e76....) that would help me diagnose the problem a lot.
>
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-akpm.git

Thanks.

I think merge-base, even though we attempted to fix it recently,
is still confused and that is one of the reasons why you are
getting this.

    prompt$  git-rev-parse origin test-lenb-merge
    81065e2f415af6c028eac13f481fb9e60a0b487b
    702c7e7626deeabb057b6f529167b65ec2eefbdb
    prompt$  git-merge-base origin test-lenb-merge
    30e332f3307e9f7718490a706e5ce99f0d3a7b26
    prompt$  git show-branch origin test-lenb-merge
    ! [origin] zd1201 kmalloc size fix
     * [test-lenb-merge] [ACPI] fix ia64 build issues resulting from L...
    --
    +  [origin] zd1201 kmalloc size fix
    +  [origin~1] md: make sure resync gets started when array starts.
    +  [origin~2] preempt race in getppid
    +  [origin~3] Merge master.kernel.org:/pub/scm/linux/kernel/git/da
    -- >8 -- snip -- >8 --
    +  Merge ../to-linus-stable/
    ++ [ACPI] re-enable platform-specific hotkey drivers by default
    +  ARM: 2851/1: Fix NWFPE extended precision exception handling
    ++ [origin~34] intelfb/fbdev: Save info->flags in a local variable
    prompt$  git-rev-parse origin~34
    3edea4833a1efcd43e1dff082bc8001fdfe74b34

Notice that show-branch, which walks the commit ancestry chain
pretty much the same way merge-base does, notices and stops at
origin~34 (that's 34th generation first parent commit from Linus
tip) that is the common commit between the two heads being
merged?  And that commit, 3edea48... is different from what
merge-base is reporting.

If I maually run merge-cache using origin~34 as the merge base,
only the following two files needs to result in non-simple merge:

    Documentation/acpi-hotkey.txt
    drivers/acpi/osl.c

Do these two files match your expectation?

I'll take a look at merge-base.c next, but just in case I CC:ed
this to Linus, who is more familiar with that code.
