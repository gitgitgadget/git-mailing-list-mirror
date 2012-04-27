From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Compiling git with -Werror
Date: Fri, 27 Apr 2012 11:45:20 +0200
Message-ID: <4F9A6AB0.1050504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNhjy-0001oF-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 11:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab2D0JpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 05:45:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51368 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab2D0JpV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 05:45:21 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3R9jKSG031213
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 27 Apr 2012 11:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196462>

I like to develop with errors and warnings turned up as strict as 
possible.  For example, I would like to use

     CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"

I thought this would be as simple as

     git clean -fdx
     make configure
     ./configure CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"
     make
     # hack
     make
     # hack
     # etc.

but the "make" step results in an error:

> $ make
>     * new build flags or prefix
>     CC daemon.o
> In file included from cache.h:4:0,
>                  from daemon.c:1:
> git-compat-util.h:359:0: error: "strtok_r" redefined [-Werror]
> /usr/include/x86_64-linux-gnu/bits/string2.h:1196:0: note: this is the location of the previous definition
> cc1: all warnings being treated as errors
> make: *** [daemon.o] Error 1

The cause of the problem is that the CFLAGS variable is used by 
./configure when it is running its tests, and some of the tests don't 
work correctly (they produce results that are not correct for the 
platform) when run with the strict CFLAGS.  For example, in the broken 
case config.log contains

> configure:4592: cc -o conftest -g -O2 -Wall -Werror -Wdeclaration-after-statement   conftest.c -lc   >&5
> conftest.c:16:6: error: conflicting types for built-in function 'gettext' [-Werror]
> cc1: all warnings being treated as errors
> configure:4592: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "git"
> | #define PACKAGE_TARNAME "git"
> | #define PACKAGE_VERSION "1.7.10.362.g010b2"
> | #define PACKAGE_STRING "git 1.7.10.362.g010b2"
> | #define PACKAGE_BUGREPORT "git@vger.kernel.org"
> | #define PACKAGE_URL ""
> | /* end confdefs.h.  */
> |
> | /* Override any GCC internal prototype to avoid an error.
> |    Use char because int might match the return type of a GCC
> |    builtin and then its argument prototype would still apply.  */
> | #ifdef __cplusplus
> | extern "C"
> | #endif
> | char gettext ();
> | int
> | main ()
> | {
> | return gettext ();
> |   ;
> |   return 0;
> | }
> configure:4601: result: no

It is possible to work around this problem by passing the CFLAGS value 
to make rather than configure:

     git clean -fdx
     make configure
     ./configure
     make CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"
     # hack
     make CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"
     # hack
     # etc.

but it is annoying to need such a long command line for "make" (not to 
mention that I run make from the command line, from emacs, etc. and 
would have to adjust the command line everywhere).  Or the CFLAGS could 
be put into an environment variable, but this again would have to be set 
up separately (and consistently!) for every terminal and emacs sessions 
that is in use.

Is there some other mechanism to set strict CFLAGS parameters for the 
build without confusing ./configure?

Is this a bug in how the git project is using autoconf?

Is it a bug in autoconf itself?

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
