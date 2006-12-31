From: "Theodore Ts'o" <tytso@mit.edu>
Subject: What commands can and can not be used with bare repositories?
Date: Sat, 30 Dec 2006 20:48:22 -0500
Message-ID: <E1H0poE-0000qd-Ee@candygram.thunk.org>
X-From: git-owner@vger.kernel.org Sun Dec 31 02:48:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0poJ-0007pZ-Vb
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWLaBsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWLaBsZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:48:25 -0500
Received: from thunk.org ([69.25.196.29]:55059 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932616AbWLaBsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:48:24 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H0psY-0008S1-C9; Sat, 30 Dec 2006 20:52:50 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H0poE-0000qd-Ee; Sat, 30 Dec 2006 20:48:22 -0500
To: git@vger.kernel.org
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35645>

In order to minimize the amount of files which need to be backed up, I
decided to create an "upstream" repository which contains nothing but
Linus's tree, which I packed into a single pack file, and which I would
then only update every 3-6 months.

The git tree(s) that I would use for Linux hacking would then use the
upstream repository as an alternate source of objects.  That way the
"git gc" command is much faster, and it doesn't end up thrashing the
main pack file found in the "upstream" repository (which is currently
about 135 megs).  This streamlines my backups a tad (every little bit
helps).

The only real problem with this is that I don't really need to have a
working directory in the "upstream" repository, so I decided to try
using a "bare repository".  This is only barely (sorry) documented in
the git Documentation, where in the git-clone manpage there is a
description of how the administrative files end up in the top-level
directory instead of the .git subdirectory.  

What isn't documented is what commands actually can deal with a bare
repository.  At the moment, it looks like a bare repository can be a
target of a git pull, push, and merge commands, and it can be a source
for a git clone, but that seems to be about it.  All other commands,
such as "git log" blow up with the error message "Not a git repository".
This to me seems a bit lame, since why isn't a "bare repository" also a
"git repository"?  All of the information is there for "git log" to
work.  Commands that require a working directory obviously can't work,
but there are plenty of git commands for which there's no reason why
they shouldn't be able to operate on a bare repository.  For example,
"git repack", "git log", "git fetch", etc.

So as a suggestion, it would be good if exactly what you can and can't
use a "bare repository" for were documented.  If it really is push,
pull, fetch, and clone, I'll happily submit a patch to enhance the
documentation accordingly.   

The next obvious question, though, is *should* that be all that works?
A somewhat squinky hack that works quite nicely is to create a symlink
from . to .git in the bare repository.  At this point "git log", "git
fetch", "git repack", etc., all start working.  Of course, commands such
as "git status" that involve a working directory will be pretty
confused, but maybe we could fix that.  What if we were to change "git
clone --bare" to create the .git -> . symlink, and then add a check to
commands that require a working directory to see if ".git" is a symlink
to ., and if so, give an error message, "operation not supported on bare
repository"?

					- Ted
