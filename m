From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 00:36:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801250007490.5731@racer.site>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 01:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JICZM-00053r-Ho
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 01:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYAYAgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 19:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbYAYAgo
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 19:36:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:37439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751740AbYAYAgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 19:36:42 -0500
Received: (qmail invoked by alias); 25 Jan 2008 00:36:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp051) with SMTP; 25 Jan 2008 01:36:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dXI9ujNAdRLFV1CUYGllfXu+KKzwnQq6LFBoe8y
	gLyLIpv/G4wV+3
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71672>

Hi,

On Thu, 24 Jan 2008, Junio C Hamano wrote:

> [A nice, concise, well written and obviously thought-through summary of 
>  the case sensitivity and UTF-8 file name issues.]

Thank you Junio.  It must have taken much more time than just sitting 
down and hacking into the keyboard.  By this thinking before writing, you 
invested some time that you save all the readers, including me.  I 
appreciate that very much.

> [Goes on to describe what we do with symlinks when the filesystem is not 
>  capable of representing symlinks; compares that situation to the 
>  filenames situation.]

There is a fundamental difference between the symlinks situation and the 
filename situation that you should keep in mind:  even if the filesystem 
cannot create symlinks, the nature of filenames as unique keys is not 
changed.  You cannot have a symlink and a file of the same name.  In a 
way, it takes away a degree of freedom of the _values_ that the _keys_ 
point to.

The same is not true for the case-challenged filesystems; they change the 
nature from unique keys to semi-unique keys.  So while other filesystems 
can discern all different keys, these challenged filesystems cannot; they 
take away a degree of freedom of the _keys_.

It is much easier to cope with the lack of degree of freedom in values; 
you have to store the metadata somewhere else -- in this case the index -- 
but it is still easily accessible by the key.

But that is not possible if two different _keys_ are not accepted as 
different by the filesystem.  You can still store the different metadata 
in the index, but the _content_ cannot be in the filesystem under the 
desired keys; not at the same time, anyway.

> Perhaps we could have something like:
> 
> 	$ git show :xt_CONNMARK.c >xt_connmark-1.c
>         $ edit xt_connmark-1.c
> 	$ git add --as xt_CONNMARK.c xt_connmark-1.c

Something similar is already possible:

	$ git checkout xt_CONNMARK.c
	$ edit xt_CONNMARK.c
	$ git add xt_CONNMARK.c

but you have to keep in mind that

	- "git add -u" or "git commit -a" is a no-no-no, and
	- the system will not build, no matter what you change in git

on those filesystems.

Having said that, I think that a config variable/commit hooks for those 
repositories which _happen_ to live on sane filesystems, but have to be 
checked out on challenged ones, makes absolute sense.  (The commit hook is 
possible already, but less efficient than the config variable.)

> If it is a new file, we won't find any name that is equivalent to $A in 
> the index, and we use the name $A obtained from readdir(3).
> 
> BUT with a twist.
> 
> If the filesystem is known to be inconveniently case folding, we are 
> better off registering $B instead of $A (assuming we can convert from $A 
> to $B).

I tend to agree with Nico.  We should not "learn" from the challenged 
filesystems.

> Tasks
> -----
> 
>  - Identify which case folding filesystems need to be supported,
>    and make sure somebody understands its folding logic;
> 
>  - For each supported case folding logic, these are needed:
> 
>    - a hash function that throws "equivalent" names in the same
>      bucket, to be used in Linus's patch;

AFAIR Linus wanted to have one has function to rule them all.  That would 
be way cool, since it means fewer possibilities for bugs to go undetected.

>    - a compare function to determine equivalent names;

AFAICT we need three functions: strcasecmp(), utf8_strcmp() and 
utf8_strcasecmp().  Although I might be wrong, and the second is not 
needed.

Probably the answer for this has been buried in many, many lines that I 
decided not to read.  Maybe I'll ask Randal on IRC, he's usually very 
quick to give me reasonable and concise answers.  And then we trash-talk a 
little, just for fun.

Ciao,
Dscho
