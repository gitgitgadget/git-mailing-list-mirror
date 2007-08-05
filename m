From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible bug in git apply?
Date: Sun, 5 Aug 2007 11:18:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708051106020.5037@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
 <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
 <7vvebuh8g8.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
 <85hcndj2b5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	git@vger.kernel.org, rob@landley.net
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHkho-0003V3-Ax
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 20:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXHESTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 14:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXHESTl
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 14:19:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46688 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179AbXHESTk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 14:19:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75IIP8D001855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 11:18:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75IIJfP020054;
	Sun, 5 Aug 2007 11:18:20 -0700
In-Reply-To: <85hcndj2b5.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.566 required=5 tests=AWL,BAYES_00,TW_LR,TW_RW,TW_WX,TW_XR
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55051>



On Sun, 5 Aug 2007, David Kastrup wrote:
> 
> Which will let the user sit in an empty directory void of . and ..,
> and a parallel directory with the old name elsewhere.  Unpretty...

It actually depends on the OS. POSIX allows the case of "rmdir()" 
returning EBUSY if the directory is "in use", where "in use" may mean 
being somebodys current working directory.

But yes, most UNIXes (Linux very much included) will just remove the 
directory, and yes, the user ends up sitting in a directory that is empty 
and not reachable from anywhere else.

Easy enough to see:

	[torvalds@woody ~]$ mkdir test-me ; cd test-me ; rmdir $(pwd)
	[torvalds@woody test-me]$ ls -a
	[torvalds@woody test-me]$ pwd
	/home/torvalds/test-me
	[torvalds@woody test-me]$ /bin/pwd
	/bin/pwd: couldn't find directory entry in `..' with matching i-node

(the first "pwd" is a shell built-in, and the shell caches is).

Under Linux, you can also see funky things like this:

	[torvalds@woody test-me]$ ls -l /proc/self/cwd
	lrwxrwxrwx 1 torvalds torvalds 0 2007-08-05 11:09 /proc/self/cwd -> /home/torvalds/test-me (deleted)

ie khe kernel actually shows you that you're in a deleted directory, that 
_used_ to be called "test-me".


> > That said, if we really wanted to get it right, we should do this as
> > a three-phase thing: (1) remove old files (2) create new files (3)
> > for all removals and renames, try to remove source directories that
> > might have become empty.
> >
> > That would fix it properly and for all cases.
> 
> Stupid question from someone without good background: why do we need
> two passes in the first place?

For example, a patch that removes a directory structure "x/..." and then 
creates a file "x" in its place.

In order for the patch ordering to not matter, you want to do the "remove 
old state" in an earlier phase.

And patch order shouldn't matter, since you can have interesting things 
like mixing of renames and creates etc (ie maybe it's not "removing" that 
directory x, it's just moving all the contents somewhere else, and maybe 
the new file "x" is a move from somewhere else).

Criss-crossing renames make it even more interesting.

So git-apply actually does things in more than two phases: there's a whole 
another phase that is the "read the patch and create the in-memory 
result". The "two phases" above are actually just the two phases concerned 
with actually modifying the working tree, there's more phases elsewhere.

			Linus
