X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 08 Dec 2006 16:59:50 -0800
Message-ID: <7vfybpg9yx.fsf@assigned-by-dhcp.cox.net>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<200612082310.24140.Josef.Weidendorfer@gmx.de>
	<m2lkli9bwv.fsf@ziti.local> <elcujo$g61$1@sea.gmane.org>
	<m2d56taoqu.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 00:59:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <m2d56taoqu.fsf@ziti.local> (Seth Falcon's message of "Fri, 08
	Dec 2006 16:37:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33783>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsqZI-0006I7-JL for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947611AbWLIA7w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947612AbWLIA7w
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:59:52 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49136 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1947611AbWLIA7v (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 19:59:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209005950.IHWJ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 19:59:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wQzD1V00s1kojtg0000000; Fri, 08 Dec 2006
 19:59:14 -0500
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> writes:

> I don't think I understand what an --exclude=<pattern> option would
> do, but I'm pretty sure it doesn't help the use case I'm thinking of:
>
>    Editing away, you've made changes in 8 files.
>
>    Reviewing diff, you want to commit 6 of those and continue working
>    on the other two.
>
>    It seems that there could be a less manual way than 
>    git update-index f1 f2 ... f6
>
>
> Hmm, maybe I could do:
>
>    git diff --name-only > changed
>    ## edit changed
>    cat changed|xargs git update-index
>
> I suppose this could be wrapped in a simple way to bring up an editor.

Note that output of cat piped to anything is almost always a bad
programming ;-)

Maybe the "git add --interactive" would give you a transcript
like this:

        $ git add --interactive '*.c' '*.h'
	showing list of modified files...
         1) bozbar.c 2) filfre.c 3) frotz.h 4) nitfol.c 5) rezrov.h
         6) xyzzy.c  7) yomin.h  8) z.c
        choice> 2 3 5 6 7
	showing list of modified files...
         1) bozbar.c 2* filfre.c 3* frotz.h 4) nitfol.c 5* rezrov.h
         6* xyzzy.c  7* yomin.h  8) z.c
        choice> 4+
	showing "git diff -- nitfol.c"...
        diff --git a/nitfol.c b/nitfol.c
        @@ -22,x +22,y @@
         {
        -	int i;
        +	long i;
        +	i = 314;
	 
        stage this hunk [Yes/No/All/Done]? y
        ...
 
The latter half is to come up with a subset of diff and then run
"git-apply --cached" to update only the index with the chosen
hunks.
