From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 14:17:54 -0800
Message-ID: <7voe3gd6ul.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
	<7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
	<7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
	<68948ca0512161335k50a3ec64lee6f73ea4f8ae23f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 23:19:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNtn-0001tD-76
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 23:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVLPWR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 17:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLPWR4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 17:17:56 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10997 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932526AbVLPWRz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 17:17:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216221702.ELMU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 17:17:02 -0500
To: Don Zickus <dzickus@gmail.com>
In-Reply-To: <68948ca0512161335k50a3ec64lee6f73ea4f8ae23f@mail.gmail.com> (Don
	Zickus's message of "Fri, 16 Dec 2005 16:35:41 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13761>

Don Zickus <dzickus@gmail.com> writes:

>> and then, the digging I suggested yields these:
>>
>> $ ls -l arch/{ppc64,powerpc}/Kconfig
>> -rw-rw-r--  1 junio src 24279 Dec 16 12:55 arch/powerpc/Kconfig
>> -rw-rw-r--  1 junio src 11027 Dec 16 12:58 arch/ppc64/Kconfig
>> $ git ls-files -s arch/ppc64/Kconfig arch/powerpc/Kconfig
>> 100644 bb2efdd566a9d590d64184b10b097e4b7ed17e95 0       arch/powerpc/Kconfig
>> 100644 c658650af429672267409508b02b38754c11a40f 1       arch/ppc64/Kconfig
>> 100644 8abf1118ebbd59954d098d87679114ffda0e75cb 3       arch/ppc64/Kconfig
>> ..
>> The result you want in this case is to merge changes between
>> c65865 (stage1 of old path) and 8abf11 (stage3 of old path) into
>> bb2efd (the latest contents of the new path) and register it as
>> the result of merge for arch/powerpc/Kconfig, and remove
>> arch/ppc64/Kconfig.  So the sequence would be:
>>
>> $ orig=$(git unpack-file c65865)
>> $ from_test=$(git unpack-file 8abf11)
>> $ merge $from_test $orig arch/powerpc/Kconfig
>> merge: warning: conflicts during merge

I suspect there might be a room for improvement to make this
easier with a new command, if this becomes a common pattern.

Something like:

	$ git resolve-renamed-path arch/ppc64/Kconfig arch/powerpc/Kconfig

to mean "I want the result of this merge to rename ppc64/Kconfig
to powerpc/Kconfig", perhaps?  There are three cases: (1) we
renamed they didn't --- this is the case we are looking at and
there will be stage1 and stage3 but not stage2 for the old path,
and stage0 for the new path; (2) they renamed we didn't --- this
would happen if you pulled test2 into test, and there will be
stage1 and stage2 but not stage3 for the old path, and stage0
for the new path; (3) both of us renamed.

The third case is handled by the merge command automatically.
Old path will not remain to bother you even if the merge of the
new path needs hand-resolving, so you do not need
resolve-renamed-path command to deal with that case.

> Now say I didn't know the name of the rename and I had to dig
> that up.  Would the following be the right way or is there
> something easier?
>
> %git log <renamed file>  #grab the last commit id from here
> %git-diff-tree -p <last commit id>  # search for the new file

That would work.

Or an explicit rename detection to see where many of the
neighbouring paths moved (this is very expensive):

	mb=$(git merge-base test test2)
        git diff-tree -r --diff-filter=R -M -l0 --name-status $mb test2

Or the diff-tree between the merge base and your current tree
and perhaps the other tree (this may give a lot of cruft):

	mb=$(git merge-base test test2)
        git diff-tree -r --diff-filter=A --name-status $mb test2
