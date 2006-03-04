From: Junio C Hamano <junkio@cox.net>
Subject: Re: On recording renames
Date: Sat, 04 Mar 2006 05:19:42 -0800
Message-ID: <7v8xrqqrdd.fsf@assigned-by-dhcp.cox.net>
References: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net>
	<7v64muvin9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paul@hibernia.jakma.org
X-From: git-owner@vger.kernel.org Sat Mar 04 14:19:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFWfk-0005DA-I9
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 14:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWCDNTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 08:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWCDNTp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 08:19:45 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10686 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751863AbWCDNTo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 08:19:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304131656.JDUM17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 08:16:56 -0500
To: git@vger.kernel.org
In-Reply-To: <7v64muvin9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 03 Mar 2006 22:16:58 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17181>

Junio C Hamano <junkio@cox.net> writes:

> A bit more on merges and renames...
> The whole thread is worth reading, but the punch line is:
>
>         The transition happened over time with multiple commits.
>         You cannot record "this is the rename" by attributing that
>         information to one particular commit.

After re-reading that thread, and especially the analysis of the
history of that part of the kernel source I did back then, I am
again convinced that Linus was right when he said "file renames
do not matter".  That real-life example shows how inadequate
file boundaries are when dealing with content changes.

An ideal merge strategy would handle the case where pieces of
code gradually moves around across file boundaries.  I do not
think this is something you can sensibly do by recording file
rename history.  It would not help the situation a bit even if
you gave each file (or content or object or whatever you want to
call it) a persistent ID.

One way (now, it is my turn to handwave) to do such a merge
might be to take the whole tree as if it were a flat single file
(think of it as a concatenation of all files in the tree) with
each line tagged with the pathname.  You and your friend would
start from something like this.  A single file that describe
topics of interest to both of you:

                    notes.txt:Kernel Topics
                    notes.txt: - filesystem
                    notes.txt: - scheduler
                    notes.txt: - devices
                    notes.txt:Cool Git Topics
                    notes.txt: - git-cvsserver
                    notes.txt: - Cogito

And your friend splits this into two files and starts editing,
while you edit the original file:

        your friend                     you

        linux.txt:Kernel Topics         notes.txt:Kernel Topics
        linux.txt: - filesystem         notes.txt: - filesystem
        linux.txt: - scheduler          notes.txt: - scheduler
        linux.txt: - devices            notes.txt: - devices
        linux.txt: - stable driver API  notes.txt: - mm
        git.txt:Cool Git Topics         notes.txt:Cool Git Topics
        git.txt: - git-cvsserver        notes.txt: - git-cvsserver
        git.txt: - Cogito               notes.txt: - gitview
                                        notes.txt: - Cogito
                                        notes.txt: - StGIT
                                        notes.txt: - diff --cc

Now you would want to compare notes and merge them.  When
comparing these two "trees", the clever merge algorithm would
treat this two-column thingy and merge both labels
(i.e. pathnames) and contents:

                    linux.txt:Kernel Topics
                    linux.txt: - filesystem
                    linux.txt: - scheduler
                    linux.txt: - devices
                    linux.txt: - mm
                    linux.txt: - stable driver API
                    git.txt:Cool Git Topics
                    git.txt: - git-cvsserver
                    git.txt: - gitview
                    git.txt: - Cogito
                    git.txt: - StGIT
                    git.txt: - diff --cc

It could even guess that the line you touched are related to the
hunk your friend moved to another file (iow, your friend gave a
new label to the region you touched), and label your new line
with the same pathname as surrounding lines.

I suspect this is weave merge taken to its extreme, but I am
handwaving so please do not ask me how I would propose to
implement it ;-).  The point really is that file is a poor unit
of operation when dealing with changes.
