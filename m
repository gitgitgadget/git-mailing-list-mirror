From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Expected Behavior?
Date: Wed, 09 Nov 2005 07:38:54 -0600
Message-ID: <E1EZqAA-0002B0-Un@jdl.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 14:41:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZqAY-0001m3-Tj
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 14:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKINjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 08:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKINjD
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 08:39:03 -0500
Received: from jdl.com ([66.118.10.122]:61647 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750753AbVKINjC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 08:39:02 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZqAA-0002B0-Un
	for git@vger.kernel.org; Wed, 09 Nov 2005 07:38:56 -0600
To: git@vger.kernel.org
In-Reply-To: 7vslu6mj2m.fsf@assigned-by-dhcp.cox.net
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11400>

> Could you check diff between /usr/bin/git-merge-recursive and
> git-merge-recursive.py in your source tree and see if the
> appending to sys.path points at the right place (i.e. where the
> make installs gitMergeCommon.py)?

    jdl.com 211 % diff /usr/src/git-core/git-merge-recursive /usr/bin/git-merge-recursive
    jdl.com 212 %

    jdl.com 213 % ll  /usr/src/git-core/git-merge-recursive /usr/bin/git-merge-recursive
    32 -rwxr-xr-x  1 root root 29181 Nov  8 20:17 /usr/bin/git-merge-recursive
    32 -rwxr-xr-x  1 jdl  src  29181 Nov  8 08:36 /usr/src/git-core/git-merge-recursive

This would be a problem, though:

    jdl.com 216 % head -15 /usr/bin/git-merge-recursive
    #!/usr/bin/python

    import sys, math, random, os, re, signal, tempfile, stat, errno, traceback
    from heapq import heappush, heappop
    from sets import Set

    sys.path.append('''/home/jdl/share/git-core/python''')
    from gitMergeCommon import *

    originalIndexFile = os.environ.get('GIT_INDEX_FILE',
				       os.environ.get('GIT_DIR', '.git') + '/index')temporaryIndexFile = os.environ.get('GIT_DIR', '.git') + \
			 '/merge-recursive-tmp-index'
    def setupIndex(temporary):
	try:


Looks like /home/jdl/share got left instead of /usr/share.

So.  The root of the problem is that I followed the INSTALL
instructions:

		    Git installation

    Normally you can just do "make" followed by "make install", and that
    will install the git programs in your own ~/bin/ directory.  If you want
    to do a global install, you can do

	    make prefix=/usr install

I ran "make" as myself, and then later
I ran "make prefix=/usr install" as root.


However, the path substitution happened as part of the
"all" target and not as part of the "install" target:

    SCRIPT_PYTHON = \
	    git-merge-recursive.py

    SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
	      $(patsubst %.perl,%,$(SCRIPT_PERL)) \
	      $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
	      gitk git-cherry-pick

    all: $(PROGRAMS) $(SCRIPTS)

    $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
	    rm -f $@
	    sed -e '1s|#!.*python|#!$(call shq,$(PYTHON_PATH))|' \
		-e 's|@@GIT_PYTHON_PATH@@|$(call shq,$(GIT_PYTHON_DIR))|g' \
		-e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
		$@.py >$@
	    chmod +x $@


So, It looks like either:

    1) Change the INSTALL documentation and process
       to require "make prefix=/...." also during the build,
or
    2) Change the Makefile to do install-related path
       substitutions at "make install" time.

My preference would be the latter (ie, take $(SCRIPTS) off
the "all: " line), but you may have better notions here.
Like, do people run stuff out of the build directory between
a "make" and a "make install"?  Dunno.

jdl
