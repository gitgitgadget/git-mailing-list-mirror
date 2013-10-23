From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Finding the repository
Date: Wed, 23 Oct 2013 00:52:43 -0700
Message-ID: <5267804b.JaxQnlQ5Cx+By4RS%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 23 10:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYtlG-0006ve-QN
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 10:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab3JWIZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 04:25:45 -0400
Received: from agora.rdrop.com ([199.26.172.34]:3300 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab3JWIZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 04:25:42 -0400
X-Greylist: delayed 875 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 04:25:42 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id r9N8B6FB028266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 23 Oct 2013 01:11:06 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id r9N8B69P028265
	for git@vger.kernel.org; Wed, 23 Oct 2013 01:11:06 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA16627; Wed, 23 Oct 13 00:51:03 PDT
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236501>

At least in version 1.7.0.4, it seems git does not like being run
from outside the repository, even if the file(s) being operated
on are inside the repository, unless it is given a pointer to the
repository via the --git-dir= option or the GIT_DIR enironment
variable.

For example, suppose /foo/bar is a local repository and baz.c is a
file in the outermost directory that I want to remove.  This works:

  $ cd /foo/bar
  $ git rm baz.c

but this, which intuitively should mean exactly the same thing,
fails:

  $ cd /foo
  $ git rm bar/baz.c
  fatal: Not a git repository (or any of the parent directories): .git

I've written a wrapper script that solves this problem, but it is
more an illustration or proof of concept than a real "solution"
-- the command line parsing may well be imperfect, and it would
be semantically incorrect in such cases as committing multiple
(individually specified) files:  it would do a separate commit
of each pathname rather than a single commit of all pathnames.

Has anyone considered enhancing the automatic repository search in
git itself to look in the directory where the specified file(s) is/are
located, as a last resort before failing?  (Yes, this does present
the potential for operating on multiple repositories with a single
invocation of git; would that be a bad thing?)

--------

#!/usr/local/bin/bash

# smarter git:  if the current directory has no .git subdirectory
# (i.e. is not in a repository), try running git in the directory
# where each file is located instead of in the current directory.

[ "$1" == "--version" -o "$1" == "--help" -o "$1" == "--exec-path" \
  -o "x$GIT_DIR" != "x" -o -d .git ] && exec git "$@"

# Set defaults
flags=""
dirSet=0

# Collect flag params
while [[ "$1" == -?* ]] ; do
   case "$1" in
      --git-dir=* )
	dirSet=1
	;;
      * )
   esac
   flags="$flags $1"
   shift
done

[ "$dirSet" == "1" ] && exec git $flags "$@"

# next word must be the command

gitCmd="$1"
shift

# remaining words must be pathnames

for f in "$@"
do
   ( cd $(dirname "$f") && git $flags $gitCmd $(basename "$f") )
done
