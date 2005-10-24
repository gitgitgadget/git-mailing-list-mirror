From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] GIT paths
Date: Mon, 24 Oct 2005 01:50:48 -0700
Message-ID: <7vhdb7qown.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 24 10:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETy3y-0007It-4j
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 10:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJXIux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJXIux
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 04:50:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44203 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750801AbVJXIuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 04:50:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024085009.YMVH24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 04:50:09 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10536>

Our networking commands can take either URL or non URL to
specify remote repository.  This note first attempts to clarify
what <path> means in the current implementation, and then
discusses two possible enhancements.

A non URL always refers to the pack protocol going over an SSH
connection:

	<host> ':' <path>

	. path that starts with a slash '/' is absolute path on
	  the remote site.

	. path that does not start with a slash '/' is relative
	  to the home directory of the incoming user.

However, note that the administrator could futz with the login
shell of the user to give restricted access (chroot to change
the former).  The latter can be made different from the home
directory, if git-shell is changed to chdir() to somewhere else
first.  I am not suggesting this as a best practice -- just
mentioning the possibility for completeness.

A URL form is:

	<proto> ':' <host> ( ':' <port> ) '/' <rest-of-path> 

and <proto> is either 'git', or 'ssh' (also spelled as 'ssh+git'
or 'git+ssh').  In addition, you can use 'http' or 'rsync', but
these transports are not discussed further here.  They already
have established semantics for <path> = '/' + <rest-of-path>.

For connections over plain TCP talking with git-daemon, or over
SSH in this form, path is always relative to the root directory
on the remote site, because '/' that terminate either <host> or
<port> starts the <path> = '/' + <rest-of-path>.

There are two things I would like to discuss here.

 - It might make sense to have SERVER_ROOT (similar to
   DOCUMENT_ROOT in Apache) for git-daemon, so <path> does not
   have to be relative to the true filesystem root.  Note that
   this is not a security measure, but meant for administration
   convenience [*1*].

 - Over a git-daemon connection, supporting ~user expansion
   makes sense.  E.g git://host.xz/~junio/ refers to my home
   directory on that machine.  It would make it impossible to
   have a directory literally named '~junio' directly underneath
   the root directory, but that is a good limitation anyway.

The above enhancements, especially SERVER_ROOT, however make
paths inconsistent between non URL form and URL form.  This
probably is OK -- people are used to using different paths when
uploading to HTTP server and testing a download from it.  That
leaves one issue.  Do we want to support ~user expansion, and if
so how, on non git-daemon connections?

I would propose that

	git fetch host.xz:~junio/repo
	git fetch ssh://host.xz/~junio/repo

mean the same thing (i.e. both understand ~user expansion).
Also these are equivalent (i.e. no ~user expansion; both mean
absolute filesystem path without SERVER_ROOT prefixing):

	git fetch host.xz:/frotz/repo
	git fetch ssh://host.xz/frotz/repo

While these two might not mean the same thing (the former is
prefixed with SERVER_ROOT, but not the latter):

	git fetch git://host.xz/frotz/repo
	git fetch ssh://host.xz/frotz/repo

There are small technical issues.

 - connect.c should not be affected at all, since it does not
   know how the remote site arranges SERVER_ROOT (if we support
   it) or user home directories.

 - ssh://host.xz/path and host.xz:path connections spawn
   upload-pack or receive-pack directly, without being mediated
   by git-daemon.  This means that ~user expansion, if we want
   to support it, needs to be done by these programs themselves.

 - git-daemon needs to validate the incoming requested path and
   in order to avoid aliasing issues, we should resolve ~user
   expansion and SERVER_ROOT prefixing first, then validate the
   resulting path against white/black list, before calling
   upload-pack or receive-pack.  However, after git-daemon
   decides to run these programs, they could find out some
   problems with the specified repository and may need to report
   them.  Arguably, this reporting should not reveal the real
   path used to address the repository [*2*].

Although we _could_ forget about the "error reporting exposing
real path" issue for now, I think we should at least have a plan
to make things consistent and well defined.  Here is a strawman:

 - Have a common library code that takes user supplied path and
   does SERVER_ROOT prefixing and ~user expansion.

 - Have git-daemon use it to canonicalize the requested path
   before validating.  Make it invoke the programs with the path
   received from the other end (before SERVER_ROOT prefixing, or
   ~user expansion).

 - Give --server-root=/path/to/root flag to programs that can be
   called by git-daemon, and have git-daemon run them with this
   flag.  Have them use the same library to canonicalize the
   requested path to the real path.  When these programs are run
   via direct SSH connection (i.e. ssh://host/path and
   host:path), this flag is not given so they see filesystem
   path as-is, but make the ~user expansion still available.


[Footnote]

*1* You do not want to advertise your repo is at /mnt/disk1/repo
and find out that you need to move the disks around next day.
Of course you could plan ahead and have a symlink hanging below
the root directory (e.g. '/pub -> /mnt/disk1/git'), but it is so
much more convenient if you can just tell git-daemon that the
root level used to be /mnt/disk1/git but it is now somewhere
else.

*2* This is theoretical right now, since packed transfer
protocols cannot report errors back, but Andreas' patch
addresses this issue by dying carefully in srvside_chdir().  It
falls into security-by-obscurity category, so we may choose not
to worry about it, though.
