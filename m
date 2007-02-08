From: Jeff King <peff@peff.net>
Subject: Re: git log filtering
Date: Thu, 8 Feb 2007 01:16:54 -0500
Message-ID: <20070208061654.GA8813@coredump.intra.peff.net>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com> <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org> <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 07:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF2ac-00049F-BK
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 07:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422904AbXBHGQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 01:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbXBHGQ5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 01:16:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3813 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422904AbXBHGQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 01:16:56 -0500
Received: (qmail 6250 invoked from network); 8 Feb 2007 01:16:58 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Feb 2007 01:16:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2007 01:16:54 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39032>

On Wed, Feb 07, 2007 at 01:53:18PM -0800, Linus Torvalds wrote:

> What's PCRE performance like? I'd hate to make "git grep" slower, and it 
> would be stupid and confusing to use two different regex libraries..
>
> Maybe somebody could test - afaik, PCRE has a regex-compatible (from a API 
> standpoint, not from a regex standpoint!) wrapper thing, and it might be 
> interesting to hear if doing "git grep" is slower or faster..

The patch is delightfully simple (though a real patch would probably be
conditional):

diff --git a/Makefile b/Makefile
index aca96c8..cf391dc 100644
--- a/Makefile
+++ b/Makefile
@@ -323,7 +323,7 @@ BUILTIN_OBJS = \
 	builtin-pack-refs.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
-EXTLIBS = -lz
+EXTLIBS = -lz -lpcreposix -lpcre
 
 #
 # Platform specific tweaks
diff --git a/git-compat-util.h b/git-compat-util.h
index c1bcb00..a6c77f9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -40,7 +40,7 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <assert.h>
-#include <regex.h>
+#include <pcreposix.h>
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>


A few numbers, all from a fully packed kernel repository:

# glibc, trivial regex
$ /usr/bin/time git grep --cached foo >/dev/null
10.07user 0.15system 0:10.23elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+36617minor)pagefaults 0swaps

# glibc, complex regex
$ /usr/bin/time git grep --cached '[a-z][0-9][a-z][0-9][a-z]'  >/dev/null
24.42user 0.15system 0:24.60elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+36210minor)pagefaults 0swaps

# pcre, trivial regex
$ /usr/bin/time git grep --cached foo >/dev/null
7.82user 0.12system 0:08.00elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+36571minor)pagefaults 0swaps

# pcre, complex regex
$ /usr/bin/time git grep --cached '[a-z][0-9][a-z][0-9][a-z]'  >/dev/null
36.51user 0.13system 0:36.65elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+36583minor)pagefaults 0swaps


So the winner seems to vary based on the complexity of the pattern.
There are some less rudimentary but non-git performance tests here:

  http://www.boost.org/libs/regex/doc/gcc-performance.html

In every case there, pcre has either comparable performance, or simply
blows away glibc.

One final note that caused some confusion during my testing: git-grep
still uses external grep for working tree greps (i.e., 'git grep foo').
This meant that 'git grep' and 'git grep --cached' produced wildly
different results once I was using pcre internally. Something to look
out for if we switch to pcre (or any other library which doesn't exactly
match external grep behavior!).

-Peff
