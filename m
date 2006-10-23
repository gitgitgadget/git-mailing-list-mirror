From: Matthew Hannigan <mlh@zip.com.au>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 15:19:32 +1000
Message-ID: <20061023051932.GA8625@evofed.localdomain>
References: <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com> <45379A02.1010105@utoronto.ca> <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com> <45384B0F.4040901@utoronto.ca> <20061021123027.GB29843@artax.karlin.mff.cuni.cz> <ehd5u7$c5g$1@sea.gmane.org> <453A513B.1070006@utoronto.ca> <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org> <72877ab10610220049i602ab936m11181f1a2daf2aee@mail.gmail.com> <Pine.LNX.4.64.0610220926170.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Webster <tdwebste@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 23 07:16:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbsAL-0002Xa-Ma
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 07:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWJWFP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 01:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWJWFP6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 01:15:58 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:29057 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751374AbWJWFP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 01:15:57 -0400
Received: from evofed.localdomain (c211-30-60-241.belrs1.nsw.optusnet.com.au [211.30.60.241])
	by mail22.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP id k9N5FZu1018404;
	Mon, 23 Oct 2006 15:15:35 +1000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610220926170.3962@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29818>

On Sun, Oct 22, 2006 at 10:12:00AM -0700, Linus Torvalds wrote:
> [ ... ]
> 
>    Again, the way to solve this would tend to be to have a few helper 
>    scripts that use regular file-contents that _describe_ these things to 
>    do "realdiff" and "install".
> 
> In other words, for at least three _totally_ different reasons, you really 
> don't want to do tracking/development directly in /etc, but you want to 
> have a buffer zone to do it. And once you have that, you might as well do 
> _that_ as the repository, and just add a few specialty commands (let's 
> call them "plugins" to make everybody happy) to do the special things.

Damn you stole my idea!  I had this scheme brewing in my head too,
with some slight variations:

> 	# copy the data, set up a PERMISSIONS file to track extra info
> 	sudo cp /etc/group /etc/passwd /etc/shadow .
> 	sudo chown user:user *
> 	cat <<EOF > PERMISSIONS
> 	group root:root 0644
> 	passwd root:root 0644
> 	shadow root:root 0400
> 	EOF

You may want one perms/metadata file per real file (file.meta?) with contents
like:
	owner root
	group root
	perms u=r,go=

for possibly easier to digest diff output. You could omit "don't care" variables.
You could still have one overarching file (DEFAULT.meta) for defaults.  Also, you
may want to track the implied umask instead of the real perms.

You could also track the pathname, (e.g. path /etc/group, path /etc/inet/hosts) so you
didn't have to match the structure of the working tree to the actual destination.

> And again, I'm not going to even claim that the above two "plugins" are 
> the right ones (maybe you want other operations too to interact with the 
> "real" installed files),  [ ... ]

Yes, there are other very useful transformations possible.  One example is to
split the /etc/group file into a series of files, each named after the group,
with contents the sorted list of members.  Again, this is useful for 'diff' and
any SCM. It's important that it's a lossless transformation in both
directions; you may want to scan the destination and make sure
your base revision matches it before 'git install'.

> Btw: none of this is really "git-specific". The above tells you how to do 
> local "git plugins", and it's obviously fairly trivial, but I suspect any 
> SCM can be used in this manner.

Indeed, the essential thing about this is you're representing any
system modification as a text diff, so it makes sense for any
SCM.  In fact the 'plugin' for any SCM would be 95% the same code.

This might also be useful for SCMs that don't handle symlinks
natively.

--
Matt Hannigan
