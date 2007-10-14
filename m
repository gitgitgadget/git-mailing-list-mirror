From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sat, 13 Oct 2007 22:11:49 -0400
Message-ID: <20071014021149.GO27899@spearce.org>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Oct 14 04:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igsxd-0004wJ-PD
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 04:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbXJNCMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 22:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbXJNCL7
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 22:11:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34623 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbXJNCL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 22:11:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Igsx9-00041r-Rd; Sat, 13 Oct 2007 22:11:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CFF5820FBAE; Sat, 13 Oct 2007 22:11:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60792>

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> here is a series of patches that removes a number fork/exec pairs.
...
> The series consists of 2 parts:
> 
> - The first half replaces a number of fork/exec pairs by start_command/
>   finish_command or run_command.
> 
> - The second half introduces a new framework that runs a function
>   asynchronously. New functions start_async and finish_async are implemented
>   similarly to start_command and run_command. They are used to replace
>   occurrences of fork() that does not exec() in the child. Such code
>   could in principle be run in a thread, and on MinGW port we will go this
>   route, but on Posix we stay with fork().

This series looks pretty good to me.  I like seeing huge blocks
go away only to be replaced with the simple API offered by
run-command.h.  Makes the result much easier to follow.

The async interface is also quite simple.  Unfortunately there
is some risk with the canonical fork() implementation in that the
async routine might attempt to alter global data that the parent
is also using, and folks on a good UNIX that is using the fork()
implementation will not even notice as they are in totally separated
address spaces.  But you'll see it in MSYS Git.

Since builtin-pack-objects now accepts (limited) pthread support,
perhaps this should be implemented in terms of pthread support
when pthreads are available?  Most Linux/BSD/Mac OS X systems do
have pthreads these days and that's the majority of git users and
developers.  This would make it more likely that bugs in this sort
of code would be detected early.  Just a thought.
 
>  13 files changed, 334 insertions(+), 369 deletions(-)

Hard to argue with that final state.  You killed 35 lines and
also made Git easier to port to "that OS unfortunately named after
transparent glass thingies".

-- 
Shawn.
