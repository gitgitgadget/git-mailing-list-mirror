From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/3] index-helper: fix UNIX_PATH_MAX redefinition error on
 cygwin
Date: Sun, 10 Apr 2016 23:57:31 +0100
Message-ID: <570ADA5B.5030408@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:57:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apOId-0006ur-PX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 00:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbcDJW5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 18:57:38 -0400
Received: from avasout08.plus.net ([212.159.14.20]:48926 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbcDJW5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 18:57:37 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id gmxZ1s0052D2Veb01mxao9; Sun, 10 Apr 2016 23:57:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=fcqvxSm0mxQJinIY44MA:9 a=-y9P8EcKiikbrn2j:21 a=Bu_D0iKzc5SAFjOz:21
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291190>


Hi David, Duy,

If you need to re-roll your 'dt/index-helper' branch, could you please
consider squashing these patches into the relevant patch (equivalent to
commit 12909da4 ("index-helper: new daemon for caching index and related
stuff", 06-04-2016)).

The above commit causes the cygwin build to throw a warning (many times)
about the redefinition of the UNIX_PATH_MAX macro, viz:

      CC credential-store.o
  In file included from cache.h:4:0,
                   from credential-store.c:1:
  git-compat-util.h:1060:0: warning: "UNIX_PATH_MAX" redefined
   #define UNIX_PATH_MAX 92
   ^
  In file included from git-compat-util.h:212:0,
                   from cache.h:4,
                   from credential-store.c:1:
  /usr/include/sys/un.h:18:0: note: this is the location of the previous definition
   #define UNIX_PATH_MAX   108
   ^

Which is quite easy to confirm:

  $ find /usr/include -iname '*.h' | xargs grep -n UNIX_PATH_MAX
  /usr/include/sys/un.h:18:#define UNIX_PATH_MAX   108
  /usr/include/sys/un.h:22:  char	         sun_path[UNIX_PATH_MAX]; /* 108 bytes of socket address     */

  $ gcc -dD -E git-compat-util.h 2>/dev/null | grep -n 'un\.h'
  8716:# 1 "/usr/include/sys/un.h" 1 3 4
  8717:# 12 "/usr/include/sys/un.h" 3 4

  $ gcc -dD -E git-compat-util.h 2>/dev/null | grep -n 'UNIX_PATH_MAX'
  8724:#define UNIX_PATH_MAX 108
  32675:#define UNIX_PATH_MAX 92

  $ 

So, a simple fix would look like:

  diff --git a/git-compat-util.h b/git-compat-util.h
  index 0e35c13..6d65132 100644
  --- a/git-compat-util.h
  +++ b/git-compat-util.h
  @@ -1043,7 +1043,7 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
   #define getc_unlocked(fh) getc(fh)
   #endif
 
  -#ifdef __linux__
  +#if defined(__linux__) || defined(__CYGWIN__)
   #define UNIX_PATH_MAX 108
   #elif defined(__APPLE__) || defined(BSD)
   #define UNIX_PATH_MAX 104

... since you are allowed to redefine a macro to the same token sequence
(modulo some strange whitespace rules).

However, assuming the <sys/un.h> header is defining the UNIX_PATH_MAX
macro, why even try to #define it again. So, maybe put an

  #ifndef UNIX_PATH_MAX
  ...
  #endif

around the entire block. But then, why on earth are you doing this at all?

Let's look on linux:

  $ find /usr/include -iname '*.h' | xargs grep -n UNIX_PATH_MAX
  /usr/include/valgrind/vki/vki-linux.h:754:#define VKI_UNIX_PATH_MAX	108
  /usr/include/valgrind/vki/vki-linux.h:758:	char sun_path[VKI_UNIX_PATH_MAX];	/* pathname */
  /usr/include/linux/un.h:6:#define UNIX_PATH_MAX	108
  /usr/include/linux/un.h:10:	char sun_path[UNIX_PATH_MAX];	/* pathname */

  $ gcc -dD -E git-compat-util.h | grep -n 'un\.h'
  14119:# 1 "/usr/include/x86_64-linux-gnu/sys/un.h" 1 3 4
  14120:# 19 "/usr/include/x86_64-linux-gnu/sys/un.h" 3 4

  $ gcc -dD -E git-compat-util.h | grep -n 'UNIX_PATH_MAX'
  36788:#define UNIX_PATH_MAX 108

  $ 

Ah, interesting, ... despite having a header that does indeed define the
UNIX_PATH_MAX macro, the compiler is not using that header, but another
one which doesn't. Well, blow me down. ;-)

So, the approach taken by patch #1 is to forget about UNIX_PATH_MAX and
simply use sizeof(address.sun_path) instead!

The second and third patches are simply 'mild suggestions' for other
minor issues I noticed while looking into these warnings.

ATB,
Ramsay Jones

Ramsay Jones (3):
  index-helper: fix UNIX_PATH_MAX redefinition error on cygwin
  index-helper: convert strncpy to memcpy
  index-helper: take extra care with readlink

 git-compat-util.h | 17 -----------------
 index-helper.c    |  4 ++--
 read-cache.c      | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.8.0
