From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Compiler warning under cygwin/mingw
Date: Thu, 3 Mar 2016 05:25:36 +0000
Message-ID: <56D7CAD0.8030405@ramsayjones.plus.com>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net> <56D415C6.2040203@web.de>
 <20160229100258.GC2950@sigill.intra.peff.net> <56D4203B.1030708@web.de>
 <56D43A61.3090503@ramsayjones.plus.com>
 <56D7B07F.4010001@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040309090402020601090702"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	adam@dinwoodie.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 06:25:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abLlo-0002JG-9W
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 06:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbcCCFZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 00:25:47 -0500
Received: from avasout02.plus.net ([212.159.14.17]:54891 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbcCCFZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 00:25:46 -0500
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout02 with smtp
	id RHRi1s0031BQLD401HRjaT; Thu, 03 Mar 2016 05:25:44 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=COHXJkfD c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10
 a=r77TgQKjGQsHNAKrUKIA:9 a=sBD57J7yAJ5yii4SKpAA:9 a=QEXdDO2ut3YA:10
 a=VFFg-YE9klhcHlzGgkIA:9
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56D7B07F.4010001@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288166>

This is a multi-part message in MIME format.
--------------040309090402020601090702
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 03/03/16 03:33, Ramsay Jones wrote:
> 
> 
> On 29/02/16 12:32, Ramsay Jones wrote:
>>
>>
>> On 29/02/16 10:40, Torsten Bögershausen wrote:
>>> That compiles OK, thanks.
>>>
>>>
>>> Sorry for high-jacking this thread, but while compiling under CYGWIN,
>>> found one warning:
>>>
>>>    LINK git-credential-store.exe
>>>     CC daemon.o
>>> daemon.c: In function ‘drop_privileges’:
>>> daemon.c:1136:15: warning: implicit declaration of function ‘initgroups’ [-Wimplicit-function-declaration]
>>>   if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
>>
>> Yeah, this has been there for a while - except it depends on which version
>> of the header files you have. (Some may not see the warning).
>>
>> I have 'fixed' this twice before, then updated my installation and
>> a change to the system headers broke it again! (The headers are
>> currently 'broken'). So, I got tired of fixing it up and have left
>> it a while - you never know a new update may fix it! ;-)
>>
>> [I personally don't use the git daemon on cygwin, so I don't know
>> if this a problem in practice.]
> 
> BTW, I forgot to mention that I have had a patch in my local repo for
> ages which addresses this issue. However, although this patch fixes
> the problem for me, with the header files I currently have installed, it
> would just as easily _introduce_ this warning for those that don't
> currently see it! ;-)
> 
> I suppose that I could send a patch which sets NO_INITGROUPS in the
> Makefile, until the system header files are fixed. What do you think?
> 
> The correct solution is to fix the <grp.h> header file. I have been
> a bit reluctant to tackle that, because I'm not familiar with the
> cygwin project development process. Since Newlib is an upstream
> project to cygwin, should I go there first/instead?
> 
> Anyway, I had a quick squint at the header and I think it needs to
> be changed something like the diff below. (I've also attached the
> new grp.h file).
> 

And, of course, I made a mess of it! It was only supposed to be a
'something like this' patch, but still ... :-D

> [Note: I didn't know what to do about _PATH_GROUP, setgrfile(),
> group_from_gid() and setgroupent(), so I punted on those!]

Also, the comments on setgrfile() and setgroupent() were just notes
to myself, which I didn't intend to send ...

So, more like the diff below.

ATB,
Ramsay Jones

-- >8 --
diff --git a/usr/include/grp.h b/grp.h
index c3a5a67..c04fd63 100644
--- a/usr/include/grp.h
+++ b/grp.h
@@ -67,25 +67,25 @@ extern "C" {
 #ifndef __INSIDE_CYGWIN__
 struct group	*getgrgid (gid_t);
 struct group	*getgrnam (const char *);
+#if defined __POSIX_VISIBLE || defined __BSD_VISIBLE
 int		 getgrnam_r (const char *, struct group *,
 			char *, size_t, struct group **);
 int		 getgrgid_r (gid_t, struct group *,
 			char *, size_t, struct group **);
-#ifndef _POSIX_SOURCE
-struct group	*getgrent (void);
+#endif
+#if defined __BSD_VISIBLE || defined __XSI_VISIBLE
 void		 setgrent (void);
+struct group	*getgrent (void);
 void		 endgrent (void);
+#endif
+#if defined __BSD_VISIBLE
+int		 initgroups (const char *, gid_t);
+#endif
 #ifndef __CYGWIN__
 void		 setgrfile (const char *);
-#endif /* !__CYGWIN__ */
-#ifndef _XOPEN_SOURCE
-#ifndef __CYGWIN__
 char		*group_from_gid (gid_t, int);
 int		 setgroupent (int);
 #endif /* !__CYGWIN__ */
-int		 initgroups (const char *, gid_t);
-#endif /* !_XOPEN_SOURCE */
-#endif /* !_POSIX_SOURCE */
 #endif /* !__INSIDE_CYGWIN__ */
 
 #ifdef __cplusplus

--------------040309090402020601090702
Content-Type: text/x-chdr;
 name="grp.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="grp.h"

/*	$NetBSD: grp.h,v 1.7 1995/04/29 05:30:40 cgd Exp $	*/

/*-
 * Copyright (c) 1989, 1993
 *	The Regents of the University of California.  All rights reserved.
 * (c) UNIX System Laboratories, Inc.
 * All or some portions of this file are derived from material licensed
 * to the University of California by American Telephone and Telegraph
 * Co. or Unix System Laboratories, Inc. and are reproduced herein with
 * the permission of UNIX System Laboratories, Inc.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *	@(#)grp.h	8.2 (Berkeley) 1/21/94
 */

#ifndef _GRP_H_
#define	_GRP_H_

#include <sys/cdefs.h>
#include <sys/types.h>
#ifdef __CYGWIN__
#include <cygwin/grp.h>
#endif

#if !defined(_POSIX_SOURCE) && !defined(_XOPEN_SOURCE)
#define	_PATH_GROUP		"/etc/group"
#endif

struct group {
	char	*gr_name;		/* group name */
	char	*gr_passwd;		/* group password */
	gid_t	gr_gid;			/* group id */
	char	**gr_mem;		/* group members */
};

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __INSIDE_CYGWIN__
struct group	*getgrgid (gid_t);
struct group	*getgrnam (const char *);
#if defined __POSIX_VISIBLE || defined __BSD_VISIBLE
int		 getgrnam_r (const char *, struct group *,
			char *, size_t, struct group **);
int		 getgrgid_r (gid_t, struct group *,
			char *, size_t, struct group **);
#endif
#if defined __BSD_VISIBLE || defined __XSI_VISIBLE
void		 setgrent (void);
struct group	*getgrent (void);
void		 endgrent (void);
#endif
#if defined __BSD_VISIBLE
int		 initgroups (const char *, gid_t);
#endif
#ifndef __CYGWIN__
void		 setgrfile (const char *);
char		*group_from_gid (gid_t, int);
int		 setgroupent (int);
#endif /* !__CYGWIN__ */
#endif /* !__INSIDE_CYGWIN__ */

#ifdef __cplusplus
}
#endif

#endif /* !_GRP_H_ */

--------------040309090402020601090702--
