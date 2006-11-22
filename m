X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Adding glob support to remotes
Date: Wed, 22 Nov 2006 04:56:34 -0800
Message-ID: <7v7ixnskql.fsf@assigned-by-dhcp.cox.net>
References: <200611220904.21850.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 12:56:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611220904.21850.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 22 Nov 2006 09:04:20 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32084>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmreZ-0004VW-PT for gcvg-git@gmane.org; Wed, 22 Nov
 2006 13:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755698AbWKVM4g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755701AbWKVM4g
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 07:56:36 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9403 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1755693AbWKVM4g
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 07:56:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122125635.MPGW5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 07:56:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id powi1V00U1kojtg0000000; Wed, 22 Nov 2006
 07:56:43 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I started to add code to git-parse-remote.sh:canon_refs_list_for_fetch() to 
> preprocess the reflist to catch lines with a "*" in them then use the remote 
> pattern to filter the output of from "git-ls-remote -h", blah, blah, you get 
> the idea...
>
> However, git-ls-remote needs the name of the remote repository (of course), 
> but that isn't directly available in git-parse-remote.sh.  

Is it really the case?  I do not remember the details offhand,
but I do not think canon_refs_list_for_fetch is the function you
should be messing with to implement the remote."origin".fetch
stuff.  It should be get_remote_default_refs_for_fetch().  The
function returns the list based on which remote, so it surely
knows which remote the caller is talking about.

However, I would recommend against actually running ls-remote to
help "git-fetch" inside git-parse-remote.sh.  I think you should
run ls-remote upfront early in git-fetch because there are at
least two other parts in git-fetch that wants the same ls-remote
output:

 (1) dumb protocols currently cannot deal with a remote that has
     run "packed-ref --prune" because git-fetch.sh first uses
     curl executable to download the loose ref, read it and then
     use the object name read from that to drive git-http-fetch.
     We can and should get rid of the /max_depth=5/,/done/ loop
     there and replace it with a grep of ls-remote output to
     make them work against such a remote.  When tracking many
     branches from the remote, this would reduce the number of
     http requests (one per branch vs a ls-remote which is just
     a single download of info/refs).

 (2) when doing a fetch with tracking branches (which is what
     your change is about), we would need to run ls-remote to
     find out the remote tags for tag following purposes anyway.
     Running "ls-remote -h" once for your purpose and then
     "ls-remote -t" for tag following later is obviously very
     wasteful.

