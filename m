From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Converting commits to patch files?  HEAD vs HEAD^
Date: Sat, 09 Jul 2005 12:10:26 +0100
Message-ID: <tnxhdf48cbh.fsf@arm.com>
References: <20050709013859.GA11947@buici.com>
	<7vvf3k1z28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 13:12:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrDFx-0007v9-G0
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 13:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVGILLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 07:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVGILLr
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 07:11:47 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45040 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261201AbVGILLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 07:11:04 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j69BAC7b015399;
	Sat, 9 Jul 2005 12:10:12 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id MAA22973;
	Sat, 9 Jul 2005 12:10:45 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sat, 9 Jul 2005 12:10:43 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf3k1z28.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 08 Jul 2005 19:41:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 09 Jul 2005 11:10:43.0829 (UTC) FILETIME=[D9663A50:01C58476]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
>>>>>> "MS" == Marc Singer <elf@buici.com> writes:
> MS> If I've made several commits, I'd like to be able to gather several
> MS> together and produce a patch file.  Better still, I'd like to be able
> MS> to pick a set of discontiguous commits an bundle them into a single
> MS> patch.  Ought I be using tags?
>
> Although I have not looked at it myself, you may want to take a
> look at StGIT.

I still haven't found time to write a tutorial for StGIT (it has a
README but I haven't updated it for some time) but I will try to give
a short description. People familiar with Quilt should not have any
problem with using this tool (it is safer than quilt).

StGIT is well suited for working on trees you do not control (you send
patches and wait for them to be merged and eventually get them from
the remote repository when pulling the latest changes). The advantage
over quilt is that it uses three-way merging and also informs you when
your local patch is empty (i.e., after the patch was fully merged
upstream, quilt just failing to push the patch in this case because of
conflicts).

In general, you clone a repository (Linus' for example) and run
'stg init' to initialise the StGIT specific files.

There is no 'commit' command in StGIT. To make changes, create a patch
with 'stg new <name>' and add some description (can be modified at any
time with the 'refresh --edit' command). You make changes to the files
(or add/rm files) and save them (can be done for an indefinite number
of times) into the current patch with 'stg refresh'. This last command
creates a GIT commit object for the changes between the working tree
and the bottom of the patch (which can be the upstream HEAD if this is
the first patch).

You can create several patches with 'stg new'. A 'git log' command
would show the patches as individual commits. The advantage over a
normal SCM is that you can modify the patch and replace the commit
object with a new one.

To work on a given patch, make it current via the 'stg push/pop'
commands. Note that 'stg push' also allows patch re-ordering.

To pull the latest changes from the upstream respository, do a 'stg
pop -a' (at this point the tree is the same as the one when you last
pulled the remote changes), 'git pull', 'stg push -a'. You can get
conflicts for the latter command if there are overlapping changes or
the patch was modified by the gatekeeper before being merged. Fix the
conflicts, run 'stg resolved/stg refresh' and re-run 'stg push -a' for
the rest of the patches. The 'push' and the 'series' commands notify
you if the patch is empty so that it can safely be removed ('stg
delete <name>').

To send patches upstream (the 'mail' command is not available yet),
you can export the patches with 'stg export' and e-mail manually. You
can create your own template for the exported patch (to include
description, diffstats etc.). An temlate example is given in the
archive, just copy it to the .git/ directory.

Another way to send patches is to ask the gatekeeper to pull from your
tree. Run 'stg push' for all the patches you want to be merged and the
HEAD of your tree would contain the commit objects.

-- 
Catalin
