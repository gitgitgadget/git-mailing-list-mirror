From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG] git-fetch -k is broken
Date: Thu, 28 Dec 2006 20:41:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612282031390.18171@xanadu.home>
References: <Pine.LNX.4.64.0611301441440.9647@xanadu.home>
 <7vd574iqa0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 02:42:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H06kw-0003uQ-1b
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 02:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbWL2Blz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 20:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755021AbWL2Blz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 20:41:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34871 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbWL2Bly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 20:41:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JB0001SLI1T5J40@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Dec 2006 20:41:53 -0500 (EST)
In-reply-to: <7vd574iqa0.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35572>


[ resuming an old thread ]

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Actually, the .keep file is simply not removed as it should.
> >
> > But first it appears that commit f64d7fd2 added an && on line 431 of 
> > git-fetch.sh and that cannot be right.  There is simply no condition for 
> > not removing the lock file.  It must be removed regardless if the 
> > previous command succeeded or not.  Junio?
> 
> True, but your "echo" patch breaks things even more -- when fast
> forward check fails, it should cause the entire command should
> report that with the exit status.

This "echo" patch was not a fix.  It was only an expeditive hack to 
demonstrate the problem.  Please consider this stripped down test case 
instead:

-------- >8
#!/bin/sh
#

LF='
'
IFS="$LF"

    ( : subshell because we muck with IFS
      pack_lockfile=
      IFS=" 	$LF"
      (
	  echo "keep	123456789abcdef0123456789abcdef012345678"
      ) |
      while read sha1 remote_name
      do
	  case "$sha1" in
	  # special line coming from index-pack with the pack name
	  keep)
		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
		  echo "pack_lockfile set to $pack_lockfile"
		  continue ;;
	  esac
      done &&
      if [ "$pack_lockfile" ]; then echo "rm -f $pack_lockfile"; fi
      echo "pack_lockfile=$pack_lockfile"
    )
-------- >8

The output I get is:

pack_lockfile set to /pack/pack-123456789abcdef0123456789abcdef012345678.keep
pack_lockfile=

In other words the line with the echo "rm -f ..." never shows up and I 
don't know why.

> That suggests that we need to come up with a way to clean up
> these .keep files some other way than just being one of the
> command near the end.  As to the mysterious "echo e <empty>"
> I will not have chance to look at it myself until later today
> (I'm at work now and it is not my git day today).

I hope you (or anyone else) will be able to have a look at this.  My 
shell programming skills are simply not up to it.


Nicolas
