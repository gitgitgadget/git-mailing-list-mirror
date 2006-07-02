From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Git.pm: Avoid ppport.h
Date: Sun, 2 Jul 2006 11:52:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607021141260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060701234832.GD29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 11:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwyco-0005L1-2l
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 11:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWGBJwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 05:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWGBJwT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 05:52:19 -0400
Received: from mail.gmx.de ([213.165.64.21]:7391 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932278AbWGBJwS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 05:52:18 -0400
Received: (qmail invoked by alias); 02 Jul 2006 09:52:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 02 Jul 2006 11:52:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060701234832.GD29115@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23099>

Hi,

On Sun, 2 Jul 2006, Petr Baudis wrote:

>   ow, Devel::PPPort might not be around all the way back to 5.6.0. What
> is your Perl version, BTW?

This is perl, v5.6.0 built for darwin

> This makes us not include ppport.h which seems not to give us anything real
> anyway; it is useful for checking for portability warts but since Devel::PPPort
> is a portability wart itself, we shouldn't require it for build.

Why do people introduce a "portability enhancer" like that? This is soo 
dumb.

Well, your patch helped. Now the error is somewhere else:

mkdir blib
mkdir blib/lib
mkdir blib/arch
mkdir blib/arch/auto
mkdir blib/arch/auto/Git
mkdir blib/lib/auto
mkdir blib/lib/auto/Git
mkdir blib/man3
cp private-Error.pm blib/lib/Error.pm
cp Git.pm blib/lib/Git.pm
/usr/bin/perl -I/System/Library/Perl/darwin -I/System/Library/Perl 
/System/Library/Perl/ExtUtils/xsubpp  -typemap 
/System/Library/Perl/ExtUtils/typemap Git.xs > Git.xsc && mv Git.xsc Git.c
Error: 'const char *' not in typemap in Git.xs, line 69
Error: 'const char *' not in typemap in Git.xs, line 79
make: *** [Git.c] Error 1

It seems like my typemap starts like this:

-- snip --
# $Header: /cvs/Darwin/src/live/perl/perl/lib/ExtUtils/typemap,v 1.2 
2002/03/14 
08:58:22 zarzycki Exp $ 
# basic C types
int                     T_IV
unsigned                T_UV
unsigned int            T_UV
long                    T_IV
unsigned long           T_UV
short                   T_IV
unsigned short          T_UV
char                    T_CHAR
unsigned char           T_U_CHAR
char *                  T_PV
unsigned char *         T_PV
caddr_t                 T_PV
wchar_t *               T_PV
wchar_t                 T_IV
bool_t                  T_IV
size_t                  T_IV
ssize_t                 T_IV
time_t                  T_NV
-- snap --

So, no "const char *". See next mail for a minimal patch. The warning 
(IIRC that was mentioned already on the list) still persists:

cc -c -I. -I.. -g -pipe -pipe -fno-common -no-cpp-precomp -flat_namespace 
-DHAS_TELLDIR_PROTOTYPE -fno-strict-aliasing -Os     -DVERSION=\"0.01\" 
-DXS_VERSION=\"0.01\"  -I/System/Library/Perl/darwin/CORE -I/sw/include 
-DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR -DNO_STRLCPY 
-DGIT_VERSION='"1.4.1.g3b26"' Git.c
In file included from /System/Library/Perl/darwin/CORE/perl.h:500,
                 from Git.xs:15:
/System/Library/Perl/darwin/CORE/embed.h:156:1: warning: "die" redefined
Git.xs:11:1: warning: this is the location of the previous definition

Ciao,
Dscho
