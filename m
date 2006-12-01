X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 01 Dec 2006 03:32:09 -0800
Message-ID: <7v7ixbam2u.fsf@assigned-by-dhcp.cox.net>
References: <200612011106.42272.andyparkins@gmail.com>
	<7vd573amuy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 11:32:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd573amuy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 01 Dec 2006 03:15:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32899>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6cp-00014t-03 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936462AbWLALcM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936464AbWLALcM
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:32:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53500 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S936462AbWLALcK
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:32:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201113209.BOTT18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 06:32:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tPYJ1V00h1kojtg0000000; Fri, 01 Dec 2006
 06:32:19 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I think another exception should be needed.  If the index does
> not match the working tree, it should not default to "-a".
>
> Otherwise,

I think there needs a bit of explanation and additional step
that happened here.  This by the way is not a made-up example.
Everything, including the 20-minute away, were what happened
when I did the latest blame fix you saw a few days ago.

 * I am still futzing with blame from time to time, and have
   this change almost permanently in my working tree.

	$ cat P.diff
        diff --git a/builtin-blame.c b/builtin-blame.c
        index dc3ffea..46ce45c 100644
        --- a/builtin-blame.c
        +++ b/builtin-blame.c
        @@ -38,7 +38,7 @@ static int max_digits;
         static int max_score_digits;

         #ifndef DEBUG
        -#define DEBUG 0
        +#define DEBUG 1
         #endif

 * I also have the GIT-VERSION-GEN change in my working tree.

> I want to fix another thing in pickaxe.
>
> 	$ edit builtin-blame.c
>

 * Of course I did tests here.

> My wife calls me.  Away from desk for 20 minutes.  Later I come
> back.

 * And then reverted the DEBUG back to 0 in preparation for
   "checking into the index"

	$ edit builtin-blame.c

> 	$ git update-index builtin-pickaxe.c

 * And then I reverted it back for later futing.

 	$ git apply P.diff ;# that is a permanent-temporary file.

>
> I am so used to that name and did not realize that typo, and I
> was not paying too much attention.  My wife calls me again.
> Away from desk and back in 20 minutes.
>
> 	$ git commit -m 'git-blame: Another fix.'
>
> Oops.

 * Oops here is not just that builtin-blame.c would have been
   committed; I'd almost never do "commit -a" in this repository,
   because it would take that "DEBUG 1" change _and_
   GIT-VERSION-GEN change into the commit.

> So, please turn this "cleverness" off when the index does not
> match the working tree.
