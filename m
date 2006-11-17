X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb TODO
Date: Fri, 17 Nov 2006 11:22:42 -0800
Message-ID: <7vwt5tlvy5.fsf@assigned-by-dhcp.cox.net>
References: <200611171901.40839.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 19:23:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611171901.40839.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 17 Nov 2006 19:01:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31723>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl9Im-000283-Qr for gcvg-git@gmane.org; Fri, 17 Nov
 2006 20:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752807AbWKQTWq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 14:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWKQTWq
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 14:22:46 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20874 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1752807AbWKQTWo
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 14:22:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117192243.LJWQ97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 14:22:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nvNq1V0041kojtg0000000; Fri, 17 Nov 2006
 14:22:50 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> These are a few gitweb issues and features I'm currently working on 
> (or plan working on).
>
> 1. New patchset view (commitdiff, blobdiff)
>
>  c. "Cache" git diff header, or the whole patch, or the whole patchset.
>     It is enough to cache (write lines to "buffer"/"cache" array) up to
>     the extended header "^index" line, which can be used to check if to
>     go to the next dofftree "raw" line (or wven which of "raw" difftree
>     lines this particular patch corresponds to). Does not require
>     changes in diff core, and is less fragile, less susceptible to
>     breakage.

This is the most appropriate.  Right now it is not independently
controllable but it is not so inplausible for somebody to want
to get non recursive view of 'raw' part along with textual diffs
when running "--raw -p" diff and your solution c. is robust
against even such changes.

I would probably not call that "caching" but keeping track of
where you are, and you would need to know in which filepair you
are in anyway when you want to implement links to blob view from
the hunk header lines.

> 2. Difftree combined diff gitweb "raw" format
>...
> I have though about using one of the combined diff outputs for merge 
> commits. The problem is how to represent the whatchanged part. Which 
> parts of gitweb difftree output to leave? And what about the fact that 
> we have raw output for -c/--combined diff format, but not for chunk 
> simplifying --cc (compact combined) output?

I am not sure what's more useful to show there.  The part of the
output shows "the list of files that have changed by this
commit" for non-merge commits, so "the list of files that have
changed in this merge" is what you would want to show, but there
are three ways you can define "what changed" for a merge (see
the message that explains --cc to linux@horizontal I sent
yesterday).  I find "diff --name-status $it^1 $it" the most
natural semantics for the most of the time, and that is what we
do for --stat output.

If you want to treat all the parents equally, you could read
from "diff-tree -c --raw $it" which would show list of files
that needed file-level merges, along with the blob object names
from all parents.

We might want to give that when "diff-tree --cc --patch-with-raw
$it" is asked for in the "raw" part.  I dunno.

> 3. Committags support (and implementation)
>...
> Which of those would be better to implement?

I think that is a minor implementation detail; I think the
latter is probably less painful to maintain in the longer run
because if you encode things in earlier stages, postprocessing
stages need to know which part of the result from the earlier
processing needs decoding before further processing, but I
suspect you will be the one primarily hacking on that part, so
it is not my preference, but just a suggestion to make your life
less painful.
