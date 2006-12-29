From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-fetch -k is broken
Date: Thu, 28 Dec 2006 18:03:46 -0800
Message-ID: <7vlkkrsbjx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611301441440.9647@xanadu.home>
	<7vd574iqa0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612282031390.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 29 03:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0768-0005pC-Ic
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 03:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbWL2CDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 21:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbWL2CDr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 21:03:47 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53259 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbWL2CDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 21:03:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229020346.HMKH19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 21:03:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4S401W0091kojtg0000000; Thu, 28 Dec 2006 21:04:00 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612282031390.18171@xanadu.home> (Nicolas Pitre's
	message of "Thu, 28 Dec 2006 20:41:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35574>

Nicolas Pitre <nico@cam.org> writes:

> [ resuming an old thread ]
>
> On Thu, 30 Nov 2006, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > Actually, the .keep file is simply not removed as it should.
>> >
>> > But first it appears that commit f64d7fd2 added an && on line 431 of 
>> > git-fetch.sh and that cannot be right.  There is simply no condition for 
>> > not removing the lock file.  It must be removed regardless if the 
>> > previous command succeeded or not.  Junio?
>> 
>> True, but your "echo" patch breaks things even more -- when fast
>> forward check fails, it should cause the entire command should
>> report that with the exit status.
>
> This "echo" patch was not a fix.  It was only an expeditive hack to 
> demonstrate the problem.  Please consider this stripped down test case 
> instead:
>
> -------- >8
> #!/bin/sh
> #
>
> LF='
> '
> IFS="$LF"
>
>     ( : subshell because we muck with IFS
>       pack_lockfile=
>       IFS=" 	$LF"
>       (
> 	  echo "keep	123456789abcdef0123456789abcdef012345678"
>       ) |
>       while read sha1 remote_name
>       do
> 	  case "$sha1" in
> 	  # special line coming from index-pack with the pack name
> 	  keep)
> 		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
> 		  echo "pack_lockfile set to $pack_lockfile"
> 		  continue ;;
> 	  esac
>       done &&
>       if [ "$pack_lockfile" ]; then echo "rm -f $pack_lockfile"; fi
>       echo "pack_lockfile=$pack_lockfile"
>     )
> -------- >8
>
> The output I get is:
>
> pack_lockfile set to /pack/pack-123456789abcdef0123456789abcdef012345678.keep
> pack_lockfile=
>
> In other words the line with the echo "rm -f ..." never shows up and I 
> don't know why.

The whole while loop is run in a subshell and the process runs
the last echo "pack_lockfile=$pack_lockfile" is a process
different from the one that did the other echo in the while
loop.
