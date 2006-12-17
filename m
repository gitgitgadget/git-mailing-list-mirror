X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 16:46:10 -0800
Message-ID: <7vvekb73jh.fsf@assigned-by-dhcp.cox.net>
References: <458437E0.1050501@midwinter.com> <45843C5A.8020501@gmail.com>
	<45848CF8.4000704@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 00:46:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45848CF8.4000704@midwinter.com> (Steven Grimm's message of "Sat,
	16 Dec 2006 16:19:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34672>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvkAg-0007nu-7j for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751503AbWLQAqT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWLQAqT
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:46:19 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40831 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751503AbWLQAqT (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 19:46:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217004610.KEBF7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 19:46:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zcmN1V00n1kojtg0000000; Sat, 16 Dec 2006
 19:46:22 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> A Large Angry SCM wrote:
>> Did you try "git-update-index --replace dir"?
>
> Turns out that doesn't work. It gives me the same error I get without
> the --replace option:
>
> error: dir: cannot add to the index - missing --add option?
> fatal: Unable to process file dir

"update-index --replace --add" would be the way.

        $ git ls-files -s
        100644 fa457baf8abbf5dd3bb4cbfab0c5a4cf0523d7f8 0	1/2
        100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0	3
        $ ls -F
        ./  ../  1/  3	.git/

There is file 1/2 in directory 1.

        $ mv 1 tmp ; mv 3 1 ; mv tmp 3
        $ ls -F
        ./  ../  1  3/	.git/

I just swapped them.

        $ git update-index --replace --add 1
        $ git ls-files -s
        100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0	1
        100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0	3

You are allowing update-index to 'add' things so you would need
to say --add regardless of --replace (--replace is only to allow
removal of conflicting entries while adding).  In the hindsight,
we could have implied --add with --replace, but that is the way
it is, and update-index is not a Porcelain so there is not much
point fixing it now.

But I think you helped me to spot a bug ;-).

        $ git update-index --replace --add 3/2
        $ git ls-files -s
        100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0	1
	100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0	3
        100644 fa457baf8abbf5dd3bb4cbfab0c5a4cf0523d7f8 0	3/2

The entry '3' should have been removed when we did --replace.
This index cannot be written out as a tree:

	$ git write-tree
        You have both 3 and 3/2
        fatal: git-write-tree: error building trees

Currently we need to remove '3' by hand X-<.

        $ git update-index --remove 3
        $ git ls-files -s
        100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0	1
        100644 fa457baf8abbf5dd3bb4cbfab0c5a4cf0523d7f8 0	3/2
        $ git write-tree
        77be0dd800d74913a90662e35215ee648815fc17

