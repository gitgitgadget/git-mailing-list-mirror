From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 14:12:27 -0500
Message-ID: <CWxE18Hq1ro8utv-_dFm1ZaVIKpCDTv-TbEB4u_l84GvbeJh1vKing@cipher.nrlssc.navy.mil>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil> <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 21:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxln6-0004am-Sr
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243Ab0ITTMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 15:12:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56226 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230Ab0ITTMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 15:12:30 -0400
Received: by mail.nrlssc.navy.mil id o8KJCSCD023371; Mon, 20 Sep 2010 14:12:28 -0500
In-Reply-To: <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com>
X-OriginalArrivalTime: 20 Sep 2010 19:12:28.0443 (UTC) FILETIME=[C4578EB0:01CB58F7]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156649>


[We prefer if you hit 'Reply-All' when replying so that all
 commenters are retained on the cc list]

On 09/20/2010 11:56 AM, Andrew Keller wrote:

> This is what it took to compile Git on this server without root privileges (Solaris 8 / Sparc):

I thought it was Solaris 9? :)

> # create a location for apps in my home folder:
> mkdir ~/.local
> export PATH=$PATH:/usr/users/students/ak4390/.local/bin
> export MANPATH=$MANPATH:/usr/users/students/ak4390/.local/share/man

Setting MANPATH is only necessary if you want to be able to type
'man git-add' or something.  Instead, you can use the 'help' subcommand
of git, or the --help option of each command, and it will display
the man page for you.

   $ git help add

> # compile and install git
> $ ln -s /usr/local/bin/tclsh8.4 /usr/users/students/ak4390/.local/bin/tclsh

You can set TCL_PATH instead of creating this symbolic link.

> $ export CC=/usr/local/bin/gcc
> $ cd <path-to-git-src>
> $ ./configure --prefix=/usr/users/students/ak4390/.local --with-python=/usr/local/bin/python --enable-pthreads=no
> $ make NO_PERL_MAKEMAKER=1 all install
> 
> Letting the configure figure out the threading did not seem to work.
> The compile and install worked, with lots of warnings from gcc about not
> recognizing -pthreads, but when you try to do a clone, git complained about
> not being able to fork off the demultiplexer.  So I just turned off threading
> and it works.

Maybe the configure script is broken with respect to detecting threads on
Solaris 8 (or 9)?  You probably don't really need to run the configure
script on your platform.  I don't.  Since you're using gcc to compile, the
default pthread switch '-lpthread' should be appropriate.  You could try
deleting the config.mak.autogen file that configure creates, and just run
make by itself.  Based on what you've describe, it would look something
like this:

   cd <path-to-git-src>
   rm config.mak.autogen
   cat >config.mak <<EOF
CC=/usr/local/bin/gcc
PREFIX=/usr/users/students/ak4390/.local
PYTHON_PATH=/usr/local/bin/python
TCL_PATH=/usr/local/bin/tclsh8.4
NO_PERL_MAKEMAKER=1
EOF
   make

Then add 'install' to the make command line when you are ready.

Notice, I placed all of the make settings in a file named config.mak.  This
file is imported by the main Makefile automatically and is intended to be
used like this for user settings.  If you really need to disable pthreads,
then you can add NO_PTHREADS=1.  Check out the comments at the top of the
Makefile for a list of all variables that can be set.

> The quick-install-man target still failed,

Strange.  You tried _after_ you installed git right?

-Brandon
