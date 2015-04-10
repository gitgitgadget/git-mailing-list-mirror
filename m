From: Gianpaolo Macario <gianpaolo_macario@mentor.com>
Subject: Installing git binaries on a non-default directory (Ubuntu)
Date: Fri, 10 Apr 2015 16:34:26 +0000 (UTC)
Message-ID: <loom.20150410T183218-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 18:40:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgbyY-0005t6-Af
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 18:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbbDJQkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 12:40:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:47634 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbbDJQkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 12:40:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YgbyO-0005o8-2u
	for git@vger.kernel.org; Fri, 10 Apr 2015 18:40:04 +0200
Received: from maxlab.polito.it ([130.192.16.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Apr 2015 18:40:04 +0200
Received: from gianpaolo_macario by maxlab.polito.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Apr 2015 18:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 130.192.16.67 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267016>

Hello,

I need to distribute a set of programs - including a recent version of git - 
to a large set of users.

The users are running different versions of Linux (Ubuntu from 10.04 
onwards) and are not supposed to know how to build the programs from 
sources.
Also they should be able to choose where to install the binaries.

My idea was to build git on the oldest supported machine (Ubuntu 10.04.4 32-
bit), then create a tarball incluing the installation directory which was 
created by git "make install":

By some googling and after reading the git sources and the commit logs I 
assumed that the `RUNTIME_PREFIX` option
(see <https://github.com/git/git/blob/master/exec_cmd.c>) was designed for 
that purpose, so I did the following:

    $ mkdir -p ~/tmp
    $ cd ~/tmp
    $ wget http://kernel.org/pub/software/scm/git/git-2.3.5.tar.gz
    $ tar -xvzf git-2.3.5.tar.gz
    $ cd git-2.3.5
    $ ./configure --prefix=$HOME/git-install \
    --with-curl --with-openssl --without-tcltk \
    CFLAGS="${CFLAGS} -DRUNTIME_PREFIX=1 `pkg-config --static --libs 
libcurl`"
    $ make
    $ make install
    $ cd $HOME/git-install
    $ tar -cvzf ~/git-install-2.3.5.tar.gz .
    $ cd
    $ rm -rf ~/tmp/git-2.3.5
    $ rm -rf $HOME/git-install

Everything seems OK as long as the tarball is extracted under the same
directory where the binaries where installed by `make install`
(in my case, `/home/gmacario/git-install`):

    gmacario@alm-gm-oipbuild05:~$ ~/git-install/bin/git --version
    git version 2.3.5
    gmacario@alm-gm-oipbuild05:~$ ~/git-install/bin/git --exec-path
    /home/gmacario/git-install/libexec/git-core
    gmacario@alm-gm-oipbuild05:~$

However if the user chooses to install it somewhere else - for instance

    $ sudo mkdir -p /opt/tools
    $ sudo chown $USER /opt/tools
    $ cd /opt/tools
    $ tar -xvzf ~/git-install-2.3.5.tar.gz

command `git --exec-path` still returns the directory where
the binaries were installed by `make install`:

    gmacario@alm-gm-oipbuild05:~$ /opt/tools/bin/git --exec-path
    /home/gmacario/git-install/libexec/git-core
    gmacario@alm-gm-oipbuild05:~$

As a result non-builtin commands such as "git clone https://xxx" will not 
work.
Also the templates cannot be found as shown below:

    gmacario@alm-gm-oipbuild05:~$ /opt/tools/bin/git clone 
https://github.com/gmacario/hello.git
    Cloning into 'hello'...
    warning: templates not found /home/gmacario/git-install/share/git-
core/templates
    fatal: Unable to find remote helper for 'https'
    gmacario@alm-gm-oipbuild05:~$

Even though it is a nuisance I was able to work around the wrong "--exec-
path"
by setting the "GIT_EXEC_PATH" environment variable, but I still cannot
understand how to have the templates found in the proper directory.

According to 
<https://github.com/git/git/commit/35fb0e8633217f602360a9987af51c4b960e7850>
I am afraid that relocatable binaries is only half-baked in Unix:

  Note that RUNTIME_PREFIX only works on Windows, though adding
  support on Unix should not be too hard.  The implementation
  requires argv0_path to be set to an absolute path.  argv0_path must
  point to the directory of the executable.  We use assert() to
  verify this in debug builds.  On Windows, the wrapper for main()
  (see compat/mingw.h) guarantees that argv0_path is correctly
  initialized.  On Unix, further work is required before
  RUNTIME_PREFIX can be enabled.

Has anybody tried to do the same? Do you have any advices to give me?

Thanks,

Gianpaolo Macario
