From: dev <dev@cor0.com>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Thu, 28 Aug 2014 02:51:40 -0400 (EDT)
Message-ID: <438501037.62058.1409208700534.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827192848.GC7561@peff.net> <805178325.32077.1409168920760.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827200612.GA10469@peff.net> <597210348.36175.1409173228026.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827222803.GZ20185@google.com>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 08:51:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMtYo-0006G8-Sw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 08:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936150AbaH1Gvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 02:51:50 -0400
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:35382 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934798AbaH1Gvt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 02:51:49 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7S6petN008014;
	Thu, 28 Aug 2014 02:51:40 -0400
In-Reply-To: <20140827222803.GZ20185@google.com>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v-
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256075>



On August 27, 2014 at 6:28 PM Jonathan Nieder <jrnieder@gmail.com>
wrote:
> Hi again,
>
> dev wrote:
>
> > So I guess I have to create a config.mak file from somewhere.
>
> Sorry, let's take a step back.

Actually I think we have some real progress to report here.  After
scanning through the various magic incantations in the Makefile and
some trial and error I arrived at this gem :

$ date
Thu Aug 28 06:10:43 GMT 2014

$ ls $SRC/git*
/usr/local/src/git-2.0.4.tar.gz
$ gzip -dc /usr/local/src/git-2.0.4.tar.gz | tar -xf -
$ mv git-2.0.4 git-2.0.4_SunOS5.10_sparcv9.005
$ cd git-2.0.4_SunOS5.10_sparcv9.005

$ gmake CFLAGS="$CFLAGS" LDFLAGS="$LD_OPTIONS" NEEDS_LIBICONV=Yes \
> SHELL_PATH=/usr/local/bin/bash \
> SANE_TOOL_PATH=/usr/local/bin \
> USE_LIBPCRE=1 LIBPCREDIR=/usr/local CURLDIR=/usr/local \
> EXPATDIR=/usr/local NEEDS_LIBINTL_BEFORE_LIBICONV=1 \
> NEEDS_SOCKET=1 NEEDS_RESOLV=1 USE_NSEC=1 \
> PERL_PATH=/usr/local/bin/perl \
> NO_PYTHON=1 DEFAULT_PAGER=/usr/xpg4/bin/more \
> DEFAULT_EDITOR=/usr/local/bin/vim DEFAULT_HELP_FORMAT=man \
> prefix=/usr/local
GIT_VERSION = 2.0.4
    * new build flags
    CC credential-store.o
    * new link flags
    CC abspath.o
    CC advice.o
    CC alias.o
.
.
.
    GEN bin-wrappers/test-wildmatch
    GEN git-remote-testgit
$

A full build.  Furthermore it looks like all the right bits are linked
in and a test clone from a few open source projects works well.

$ file git
git: ELF 64-bit MSB executable, SPARC V9, total store ordering, version
1, dynamically linked (uses shared libs), not stripped
$ ldd git
        libpcre.so.1 =>  /usr/local/lib/libpcre.so.1
        libz.so.1 =>     /usr/local/lib/libz.so.1
        libintl.so.8 =>  /usr/local/lib/libintl.so.8
        libiconv.so.2 =>         /usr/local/lib/libiconv.so.2
        libsocket.so.1 =>        /lib/64/libsocket.so.1
        libnsl.so.1 =>   /lib/64/libnsl.so.1
        libresolv.so.2 =>        /lib/64/libresolv.so.2
        libcrypto.so.1.0.0 =>    /usr/local/ssl/lib/libcrypto.so.1.0.0
        libpthread.so.1 =>       /lib/64/libpthread.so.1
        libc.so.1 =>     /lib/64/libc.so.1
        libmp.so.2 =>    /lib/64/libmp.so.2
        libmd.so.1 =>    /lib/64/libmd.so.1
        libscf.so.1 =>   /lib/64/libscf.so.1
        libdl.so.1 =>    /lib/64/libdl.so.1
        libz.so.1 (SUNW_1.1) =>  (version not found)
        libdoor.so.1 =>  /lib/64/libdoor.so.1
        libuutil.so.1 =>         /lib/64/libuutil.so.1
        libgen.so.1 =>   /lib/64/libgen.so.1
        libm.so.2 =>     /lib/64/libm.so.2
        /platform/SUNW,T5240/lib/sparcv9/libc_psr.so.1
        /platform/SUNW,T5240/lib/sparcv9/libmd_psr.so.1
$

Ignore the misleading libz issue.  I really don't think it is a
problem however I may dig into it. That is libz.so.1 which is needed
by libcrypto.so.1.0.0 from OpenSSL 1.0.1i and I just don't see
an issue given that OpenSSL 1.0.1i passes all its tests.

I did run a few clone tests :

$ pwd
/export/home/dev/git_test
$ $BUILD/git-2.0.4_SunOS5.10_sparcv9.005/git clone --verbose
git://cmake.org/cmake.git
Cloning into 'cmake'...
warning: templates not found /usr/local/share/git-core/templates
remote: Counting objects: 162733, done.
remote: Compressing objects: 100% (41726/41726), done.
remote: Total 162733 (delta 124662), reused 157579 (delta 119831)
Receiving objects: 100% (162733/162733), 37.31 MiB | 1001.00 KiB/s,
done.
Resolving deltas: 100% (124662/124662), done.
Checking connectivity... done.
Checking out files: 100% (7410/7410), done.
$
$ cd cmake/
$ $BUILD/git-2.0.4_SunOS5.10_sparcv9.005/git status
On branch master
Your branch is up-to-date with 'origin/master'.

nothing to commit, working directory clean
$ cd ..

$ $BUILD/git-2.0.4_SunOS5.10_sparcv9.005/git clone --verbose
git://git.apache.org/httpd.git
Cloning into 'httpd'...
warning: templates not found /usr/local/share/git-core/templates
remote: Counting objects: 391450, done.
remote: Compressing objects: 100% (80188/80188), done.
remote: Total 391450 (delta 331921), reused 367848 (delta 309308)
Receiving objects: 100% (391450/391450), 111.46 MiB | 420.00 KiB/s,
done.
Resolving deltas: 100% (331921/331921), done.
Checking connectivity... done.
Checking out files: 100% (3495/3495), done.


So that looks pretty good thus far.

I must say thank you for the guidance.  All I need to do now is figure
out a way to run a test over SSH with a dummy repo of some sort.

dev
