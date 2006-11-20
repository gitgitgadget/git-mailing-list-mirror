X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff opens too many files?
Date: Mon, 20 Nov 2006 11:51:22 -0800
Message-ID: <7vvel928xx.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
	<Pine.LNX.4.64.0611200832450.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 19:51:35 +0000 (UTC)
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611200832450.3692@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 20 Nov 2006 09:00:55 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31931>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmFAz-0000gJ-D5 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966586AbWKTTvY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 14:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966562AbWKTTvY
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 14:51:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22238 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S966586AbWKTTvX
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 14:51:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120195122.GVUG27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 14:51:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id p7qt1V00F1kojtg0000000; Mon, 20 Nov 2006
 14:50:54 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Anyway, there's two possible solutions:
>
>  - simply make sure that you can have that many open files. 
>
>    If it's a Linux system, just increase the value of the file
>    /proc/sys/fs/file-max, and you're done. Of course, if you're not the 
>    admin of the box, you may need to ask somebody else to do it for you..
>
>  - we could try to make git not keep them mmap'ed for the whole time. 
>
> Junio? This is your speciality, I'm not sure how painful it would be to 
> unmap and remap on demand.. (or switch it to some kind of "keep the last 
> <n> mmaps active" kind of thing to avoid having thousands and thousands of 
> mmaps active).

60,000 files 1kB each is 60MB which is a peanuts these days, but
10kB each would be already nontrivial burden on 32-bit (20%
under 3+1 split), so even if we do the "read in small files
instead of mapping" we would need diff_unpopulate_filespec() calls.

I think after diffcore_rename() runs, the data in filespec is
used only once during final textual diff generation.  We would
use once more before diff generation if diffcore_pickaxe() is in
use.  These codepaths begin with diff_populate_filespec(), so if
we unpopulate them after diffcore_rename() runs nobody would
notice (other than performance degradation and strace showing us
reading the same thing twice).

The diffcore_rename() matrix code expects all filespecs involved
can be populated at the same time, but it should not be too hard
to change it to keep one dst and all src candidates populated
but others dropped if space gets tight.  I need to look at the
code for the details.

But Nguyen's command line did not have -M; I think the filespecs
are populated only during the text generation in that case, so
the above would not help him while it would be a worthwhile
change.

Because there is _no_ processing that comes after textual diff
generation that looks at the data, I think diff_flush_patch()
after calling run_diff() can unpopulate the data from the
filepair *p before returning without harming performance.

I think diff_flush_stat() and diff_flush_checkdiff() would have
the same issue, though.  Ideally these should be able to do
their processing while the main textual diff holds the data in
memory for its processing but that is currently not the way the
code is structured.




