From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: On pathnames
Date: Thu, 24 Jan 2008 23:00:44 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801242227250.13593@iabervon.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-407850424-1201233513=:13593"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIFkp-0008HH-Tx
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 05:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbYAYEAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 23:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYAYEAx
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 23:00:53 -0500
Received: from iabervon.org ([66.92.72.58]:45618 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbYAYEAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 23:00:52 -0500
Received: (qmail 1021 invoked by uid 1000); 25 Jan 2008 04:00:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 04:00:44 -0000
In-Reply-To: <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0801242258410.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71677>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-407850424-1201233513=:13593
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0801242258411.13593@iabervon.org>

On Thu, 24 Jan 2008, Junio C Hamano wrote:

> The same thing should apply to two files that cannot be checked
> out at the same time on case insensitive filesystems.  Perhaps
> we could have something like:
> 
> 	$ git show :xt_CONNMARK.c >xt_connmark-1.c
> 	$ edit xt_connmark-1.c
> 	$ git add --as xt_CONNMARK.c xt_connmark-1.c

I think it would be nicer to have:

$ git checkout branch
Warning: xt_CONNMARK.c conflicts with xt_connmark.c; not checking it out
$ git checkout xt_CONNMARK.c --as xt_CONNMARK_caps.c
$ edit xt_CONNMARK_caps.c
$ git add xt_CONNMARK_caps.c

Where the index, when support for filesystems with filename restrictions 
is enabled, keeps track both of the name of the file in the project and 
the name of the file in the filesystem, with this mapping determined 
entirely by the user asking for problem files to be present under 
different names in the working tree.

Of course, you can already do:

$ git update-index --cacheinfo 100644 $(git hash-object -w xt_connmark-1.c) xt_CONNMARK.c

> If it is a new file, we won't find any name that is equivalent
> to $A in the index, and we use the name $A obtained from
> readdir(3).
> 
> BUT with a twist.
> 
> If the filesystem is known to be inconveniently case folding, we
> are better off registering $B instead of $A (assuming we can
> convert from $A to $B).

Is it not the case that, when a user has a file in the filesystem with the 
name Ma"rchen, the user will still type:

$ git add Märchen

and so we see filenames which are convenient, and we don't overly care 
what readdir(3) returns for new filenames? I suppose there is the case of:

$ touch Märchen
$ git add .

Which has to figure out what the files in foo are. But the common case for 
a new filename is that it gets provided by the user in argv, and the right 
file contents come from the one that open(2) returns, and there's no 
obvious way to get the filename that readdir(3) would return for a 
filename in argv anyway.

	-Daniel
*This .sig left intentionally blank*
--1547844168-407850424-1201233513=:13593--
