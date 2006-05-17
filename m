From: Pavel Roskin <proski@gnu.org>
Subject: Re: 1.3.2 git-clone segfaults
Date: Wed, 17 May 2006 19:52:00 -0400
Message-ID: <1147909920.32050.29.camel@dv>
References: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu>
	 <1147894165.16654.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Thu May 18 01:52:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgVoJ-0004s2-2p
	for gcvg-git@gmane.org; Thu, 18 May 2006 01:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWEQXwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 19:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWEQXwH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 19:52:07 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:43184 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750766AbWEQXwG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 19:52:06 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgVoD-00067V-ID
	for git@vger.kernel.org; Wed, 17 May 2006 19:52:05 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgVo9-00008V-0l; Wed, 17 May 2006 19:52:01 -0400
To: Bill Yoder <byoder@cs.utexas.edu>
In-Reply-To: <1147894165.16654.10.camel@dv>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20253>

On Wed, 2006-05-17 at 15:29 -0400, Pavel Roskin wrote:
> On Wed, 2006-05-17 at 13:32 -0500, Bill Yoder wrote:
> > /usr/local/downloads/git-1.3.2/git-clone: line 323: 25972  
> > Segmentation fault      git-http-fetch -v -a -w "$tname" "$name" "$1/"
> 
> I've seen git-http-fetch segfaults many times when cloning qgit, but
> it's hard to reproduce on demand.
> 
> I think you should compile git without optimizations and allow coredumps
> (ulimit -c  unlimited), then load git-http-fetch in gdb with the core
> (gdb --core=core git-http-fetch) and run bt to see the backtrace.

Also comment out both "trap" invocations in git-clone, or the coredump
will be deleted.

That's what I've got on Fedora Core 5 x86_64 with glibc and curl debug
info installed:

#0  __strncasecmp (s1=Variable "s1" is not available.
) at strncase.c:68
68        while ((result = TOLOWER (*p1) - TOLOWER (*p2++)) == 0)
(gdb) where
#0  __strncasecmp (s1=Variable "s1" is not available.
) at strncase.c:68
#1  0x00000031f3e26c09 in curl_strnequal (first=Variable "first" is not available.
) at strequal.c:60
#2  0x00000031f3e0f43a in checkheaders (data=Variable "data" is not available.
) at http.c:119
#3  0x00000031f3e10cf9 in Curl_http (conn=0x1c421c0, done=Variable "done" is not available.
) at http.c:1580
#4  0x00000031f3e1a858 in Curl_do (connp=0x83af88, done=0x7fff29c97ebb "\001\001")
    at url.c:3841
#5  0x00000031f3e28f22 in curl_multi_perform (multi_handle=0x53b590, 
    running_handles=0x7fff29c97ef8) at multi.c:526
#6  0x00000000004040c0 in step_active_slots () at http.c:376
#7  0x000000000040412c in run_active_slot (slot=0x546690) at http.c:400
#8  0x0000000000403e44 in http_cleanup () at http.c:275
#9  0x00000000004077d7 in main (argc=7, argv=0x7fff29c98258) at http-fetch.c:1274
(gdb) p p1
$1 = (const unsigned char *) 0x0
(gdb) p p2
$2 = (const unsigned char *) 0x31f3e2e817 "User-Agent:"
(gdb)

Looks like a curl bug to me.  curl 7.15.1, glibc 2.4, git master branch.

-- 
Regards,
Pavel Roskin
