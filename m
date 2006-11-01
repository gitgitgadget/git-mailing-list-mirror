X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 14:08:40 -0800
Message-ID: <7vodrq251z.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<200611012029.41869.andyparkins@gmail.com>
	<7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
	<200611012118.11558.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 22:08:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611012118.11558.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 1 Nov 2006 21:18:10 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30668>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOGL-0005wT-OP for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752518AbWKAWIm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbWKAWIm
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:08:42 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2529 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1752518AbWKAWIl
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:08:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101220841.CFNX22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 17:08:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ha8l1V00A1kojtg0000000 Wed, 01 Nov 2006
 17:08:45 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006, November 01 20:49, Junio C Hamano wrote:
>
>> >> 	git-reset [--hard | --mixed] HEAD^ oops/file1
>> While that perfect makes sense from mechanical point of view, I
>> am not sure what it _means_ to keep some paths from now
>> abandoned future while having some other paths reset to the
>> rewound commit, from the point of view of end-user operation.
>
> Isn't that exactly what the user would be asking for when they are doing a 
> per-file reset?  This is a contrived example as git makes it easier to do it 
> in far more sensible ways; but I've done this before now in subversion...  
> What if I want to try out some radical change?  It goes like this:
>
> x --- y --- z

I assume when you do the following operation your .git/HEAD
points at 'y' which is already committed, and 'z' does not exist
yet (it does not come into the scenario you describe below).

> Where x is some stable commit; y is a load of crazy changes;
> we discover that the crazy changes are all fine except for
> one, and so want to rollback one file, without yet commiting:
>
>  git-reset --hard HEAD^ frotz
>
> Git would get frotz from HEAD^ and write it to the working directory and the 
> index (or just index with --mixed).

You forgot to mention at the same time it makes .git/HEAD point
at 'x'.  That's the part I am not so sure about.

Ah (lightbulb goes on).  So after the above reset, you would do
a "git commit" with or without -a to create a fixed-up 'y' that
does not have changes to 'frotz'?

Then it sort of makes sense.  --soft with paths specifier does
not make much sense (paths specifier is a no-op in that case
because --soft does not touch index nor working tree), but I
wonder what workflow --mixed would help.  It resets the index
for frotz from 'x', while your crazy changes of 'y' is still in
the working tree.  You can "git commit" without -a to create the
same fixed-up 'y' that does not have changes to 'frotz', and
then keep working on 'y' to make it into less crazy.

Ok, that workflow certainly makes sense.

>> In other words, I do not have a good explanation on what "git
>> reset [--hard|--mixed] <commit> <path>..." does that I can write
>> in the documentation.
>
>  --mixed
>    Resets the index but not the working tree (i.e., the changed files are
>    preserved but not marked for commit) and reports what has not been
>    updated. This is the default action.  If <path> is given then only that
>    path will be reset to the state that <path> had in <commit-ish>.  The
>    working tree will be untouched.
>
>  --hard
>    Matches the working tree and index to that of the tree being switched to.
>    Any changes to tracked files in the working tree since <commit-ish> are
>    lost.  If <path> is given then only that path will be reset in both the
>    working tree and the index to the state that <path> had in <commit-ish>.

That's the "mechanical point of view only" description I was
afraid of having.  While I think I now see why they can be
useful, we would need to extend the examples section to
demonstrate how they help workflows to readers.

