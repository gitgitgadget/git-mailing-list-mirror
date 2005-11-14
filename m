From: Andreas Ericsson <ae@op5.se>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 13:18:52 +0100
Message-ID: <437880AC.3040101@op5.se>
References: <43788078.4040403@op5.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020604070003050600050608"
X-From: git-owner@vger.kernel.org Mon Nov 14 13:20:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbdIY-00077h-0u
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 13:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVKNMSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 07:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKNMSz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 07:18:55 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26561 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751101AbVKNMSy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 07:18:54 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 05BBF6BCBE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 13:18:52 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <43788078.4040403@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11794>

This is a multi-part message in MIME format.
--------------020604070003050600050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andreas Ericsson wrote:
> I've started writing up a configuration script to move some of the logic 
> out of the Makefile and make it a bit easier to enable/disable certain 
> stuff.
> 
> I'm not exactly fluent in what sh flavours accept what syntax and the 
> uname -m output is a bit of a mystery for some architectures (PowerPC, 
> notably) so the SHA1 method selection stuff might not work.
> 
> Thoughts? Comments? Patches?
> 

Attachments? ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------020604070003050600050608
Content-Type: text/plain;
 name="configure"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="configure"

#!/bin/sh

# VERSION must be here so we know where to put the git_libexec_dir later on
VERSION=0.99.9.GIT

# some default values
default_prefix=$HOME
enable_http=Yes
enable_expat=Yes
without_openssl=0

tar=$(which gtar 2>/dev/null || which tar 2>/dev/null)
install=$(which ginstall 2>/dev/null || which install 2>/dev/null)

function usage ()
{
cat << EOF
Usage: $0 [VAR=VALUE]...

Installation directories:
 --prefix=PREFIX         files go in directories under PREFIX [$default_prefix]
 --exec-prefix=EPREFIX   executables go in directories under EPREFIX [PREFIX]
 --bindir=DIR            user executables [EPREFIX/bin]
 --datadir=DIR           read-only architecture-independent data [PREFIX/share]
 --mandir=DIR            man-page base directory [\$datadir/man]

git specific stuff and where to install it:
 --git-exec-path=DIR     git executables path [*currently* \$bindir]
 --git-python-dir=DIR    git python scripts [\$datadir/git/python]
 --git-template-dir=DIR  git templates [\$datadir/git/templates]

Other compilation options:
 --disable-http          disable http transport support [enable]
 --without-expat         build without expat (disables http-push) [enable]
 --with-curl=DIR         path to curl installation [/usr]
 --with-expat=DIR        path to libexpat installation [/usr]
 --with-sha1=METHOD      possible options are MOZILLA_SHA1, PPC_SHA1, ARM_SHA1
                         and OPENSSL_SHA1 [autodetect / OPENSSL_SHA1]
 --with-shell=PATH       path to bourne-like shell [/bin/sh]
 --with-perl=PATH        path to perl [/usr/bin/perl]
 --with-python=PATH      path to python [/usr/bin/python]
EOF
	exit 0
}

# for debugging, really
: ${outfile=config.mak}

# Try to keep these in the same order as the help output above.
while [ $# -gt 0 ]; do
	case "$1" in
		--help*)
			usage
		;;
		--prefix=*)
			prefix=${1##*=}
		;;
		--exec-prefix=*)
			exec_prefix=${1##*=}
		;;
		--bindir=*)
			bindir=${1##*=}
		;;
		--datadir=*)
			datadir=${1##*=}
		;;
		--mandir=*)
			mandir=${1##*=}
		;;
		--git-exec-path=*)
			git_exec_path=${1##*=}
		;;
		--git-python-dir=*)
			git_python_dir=${1##*=}
		;;
		--git-template-dir=*)
			git_template_dir=${1##*=}
		;;
		--disable-http*)
			enable_http=No
			enable_expat=No
		;;
		--without-expat*)
			enable_expat=No
		;;
		--with-curl=*)
			curl_dir=${1##*=}
		;;
		--with-expat=*)
			expat_dir=${1##*=}
		;;
		--with-sha1=*)
			sha1=${1##*=}
		;;
		--with-shell=*)
			shell=${1##*=}
		;;
		--with-perl=*)
			perl=${1##*=}
		;;
		--with-python=*)
			python=${1##*=}
		;;
	esac
	shift
done

[ "$prefix" ] || prefix="$HOME"
[ "$libdir" ] || libdir="$prefix/lib"
[ "$bindir" ] || bindir="$prefix/bin"
[ "$datadir" ] || datadir="$prefix/share"
[ "$mandir" ] || mandir="$datadir/man"
[ "$git_exec_path" ] || git_exec_path="$bindir"
[ "$git_python_dir"] || git_python_dir=$datadir/git/python
[ "$git_template_dir" ] || git_template_dir=$datadir/git/templates

[ "$shell" ] || shell=/bin/sh
if [ -z "$perl" ]; then
	perl=$(which perl 2>/dev/null || perl=/usr/bin/perl)
fi
if [ -z "$python" ]; then
	python=$(which python 2>/dev/null || python=/usr/bin/python)
fi

function need () {
	echo "Need $@"
	for n in "$@"; do
		echo "NEEDS_$n = YesPlease" >> $outfile
	done
}

function no () {
	echo "Working around missing $@"
	for n in "$@"; do
		echo "NO_$n = YesPlease" >> $outfile
	done
}

function cflag () {
	echo "ALL_CFLAGS += $@" >> $outfile
}

# for now this is just an alias
alias ldflag=cflag

#function ldflag () {
#	echo "ALL_LDFLAGS += $@" >> $outfile
#}

sys=$(uname -s)
case $sys in
	Darwin)
		need SSL_WITH_CRYPTO LIBICONV
		## fink
		cflag -I/sw/include
		ldflag -L/sw/lib
		## darwinports
		cflag -I/opt/local/include
		ldflag -L/opt/local/lib
	;;
	SunOS)
		need SOCKET NSL LIBICONV
		no STRCASESTR
		cflag -D__EXTENSIONS__
		[ "$shell" = /bin/sh -a -x /bin/bash ] && shell=/bin/bash
	;;
	OpenBSD)
		need LIBICONV
		no STRCASESTR
		cflag -I/usr/local/include
		ldflag -L/usr/local/lib
	;;
esac

os=$(uname -o)
case $os in
	Cygwin)
		need LIBICONV
		no STRCASESTR IPV6
		cflag -DUSE_SYMLINK_HEAD=0
		echo "X = .exe" >> $outfile
	;;
esac

if [ -z "$sha1" ]; then
	mach=$(uname -m)
	case $mach in
		*arm*)
			sha1=ARM_SHA1
		;;
		i*86)
			sha1=OPENSSL_SHA1
		;;
		# Is this uname -m output for PPC??
		PPC|PowerPC)
			sha1=PPC_SHA1
		;;
		*)
			sha1=MOZILLA_SHA1
		;;
	esac
fi

cat << EOF > $outfile
GIT_VERSION := $VERSION

# Installation destinations
prefix = $prefix
bindir = $bindir
template_dir = $git_template_dir
GIT_EXEC_PATH = $git_exec_path
CFG_GIT_EXEC_PATH := $git_exec_path
GIT_PYTHON_DIR = $git_python_dir

# SHA1 method
$sha1 = YesPlease

# paths to system tools
SHELL_PATH = $shell
PERL_PATH = $perl
PYTHON_PATH = $python
TAR = $tar
INSTALL = $install

# Compilation options, library paths etc. etc.
EOF


# http transport support
if [ "$enable_http" = Yes ]; then
	echo "# HTTP transport is enabled" >> $outfile
	echo 'PROGRAMS += git-http-fetch$X' >> $outfile
	if [ "$curl_dir" ]; then
		cflag -I$curl_dir/include
		echo "CURL_LIBCURL = -L$curl_dir/lib"
	fi
	echo "CURL_LIBCURL += -lcurl" >> $outfile

	if [ "$enable_expat" = Yes ]; then
		echo "# expat (push over http) is enabled" >> $outfile
		echo 'PROGRAMS += git-http-push$X' >> $outfile

		if [ "$expat_dir" ]; then
			cflag -I$expat_dir/include
			echo "EXPAT_LIBEXPAT = -L$expat_dir/lib" >> $outfile
		fi
		echo "EXPAT_LIBEXPAT += -lexpat" >> $outfile
	fi
fi

cat << EOF

Configuration summary:
----------------------

  Compilation options:
    SHA1 method       : $sha1
    HTTP transport    : $enable_http
    HTTP push support : $enable_expat

  System tools locations:
    shell   : $shell
    Perl    : $perl
    Python  : $python
    tar     : $tar
    install : $install

  Installation paths:
    bindir utilities : $bindir
    templates        : $git_template_dir
    python scripts   : $git_python_dir
    Everything else  : $git_exec_path

Please see config.mak and top of Makefile for ways to tweak the build further.
EOF

--------------020604070003050600050608--
