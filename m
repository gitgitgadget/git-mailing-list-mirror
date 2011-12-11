From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Breakage (?) in configure and git_vsnprintf()
Date: Sun, 11 Dec 2011 19:42:03 +0100
Message-ID: <4EE4F97B.9000202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 11 19:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZoLr-0008AC-Gq
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 19:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab1LKSmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 13:42:15 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57465 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab1LKSmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 13:42:14 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED680.dip.t-dialin.net [84.190.214.128])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBBIg4dI016730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 11 Dec 2011 19:42:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186806>

I found a mysterious bunch of test suite failures when I compiled git on
a 64-bit Linux 3.0.0 using gcc 4.6.1:

    git clean -f -x -d
    make clean
    make configure
    ./configure --prefix=$HOME CFLAGS='-g -O0 -std=c89 -Wall -Werror'
    make test

The failure unexpectedly depended on the presence of all three compiler
options "-std=c89 -Wall -Werror".  There is no difference between -O0
and -O2.  The breakage is in v1.7.7, v1.7.8, and master (I didn't try
older versions).

I have been using "-std=c89" when compiling to avoid accidentally using
newer C features.  Perhaps that is unwise :-)

The same test succeeds on 32-bit Linux 2.6.32 using gcc 4.4.3.

There seem to be two levels to the problem:


1. With this choice of compiler options, configure incorrectly convinces
itself that the system's snprintf() is broken and sets
SNPRINTF_RETURNS_BOGUS.  From config.log:

configure:5368: checking whether snprintf() and/or vsnprintf() return
bogus value
configure:5406: cc -o conftest -g -O0 --std=c89 -Wall -Werror
conftest.c  >&5
conftest.c: In function 'test_vsnprintf':
conftest.c:62:5: error: implicit declaration of function 'vsnprintf'
[-Werror=implicit-function-declaration]
conftest.c: In function 'main':
conftest.c:72:5: error: implicit declaration of function 'snprintf'
[-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors

configure:5406: $? = 1
configure: program exited with status 1

According to the manpage, snprintf() and vsnprintf() are truly not
supported for "-std=c89" and indeed they are not declared by any of the
files included by the test program that configure is using.  (Oddly,
although they are nominally not supported, vsnprintf() is used anyway in
the definition of git_vsnprintf().)

If I leave off any of the compilation options "-std=c89 -Wall -Werror"
or if I toggle the "#ifdef SNPRINTF_RETURNS_BOGUS" line in
git-compat-util.h off, the problem goes away.


2. The configure problem causes git_vsnprintf() to be wrapped around the
C library version.  This leads to many failures in the test suite.  I
suppose that git_vsnprintf() is broken in some way.


I'm kindof busy with my ref-api patch series so I won't have time to
look further into this problem in the near future.  But perhaps somebody
with experience with the configuration system and/or git_vsnprintf() is
interested.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
