From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] cygwin: Remove the CYGWIN_V15_WIN32API build variable
Date: Sun, 28 Apr 2013 23:01:24 -0700
Message-ID: <20130429060123.GD8031@elie.Belkin>
References: <517C29F8.7090709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 08:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWh9b-0000Ma-CW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 08:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab3D2GBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 02:01:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48144 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab3D2GBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 02:01:30 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1453651pad.20
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XU9JKZBIeFU+9lck5Y3L0O3TN3p2Z6bvZCi7WTU3R9w=;
        b=AiA196mCjVV+GCORYs4mGZiDZ+7etw8OukKlpx6XlYiVR/XSGeVuvCrIB74k9cuif2
         5AAcBNspOrgTouR8qumIArMQH2ewNpA6qc9yrjgNpjwC9yOOEgxes8gDwN0XduVrhEaW
         eXLZJu3Z3GHXHtCn11NEtn36LwI35xmQgRfBEv0Vj6cHAu8K3a/2DhwZyLizKgqog0m/
         lwFWnii2PAd2HcyAH8LYjcl8YIrvD+hgV3X/U1hsITbZzSglUMq79T7kYylXFxfDJ1Ur
         rG1Br8d947EaFqmdgvZ3/hYrC+AfEQ5+iIRc6ePeVNgrXDemhpsOAMxfbZQPBUIbBkUJ
         VTbA==
X-Received: by 10.66.246.168 with SMTP id xx8mr44745659pac.107.1367215289881;
        Sun, 28 Apr 2013 23:01:29 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id bs3sm22621729pbb.36.2013.04.28.23.01.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 23:01:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517C29F8.7090709@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222778>

Hi,

Ramsay Jones wrote:
 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Let me try to understand this.

Before v1.8.1.1~7^2~2 (Update cygwin.c for new mingw-64 win32 api
headers, 2012-11-11), compat/cygwin.c did

	#define CYGWIN_C
	#define WIN32_LEAN_AND_MEAN
	#include "../git-compat-util.h"
	#include "win32.h"

Afterward, on modern Cygwin it changed to

	#define CYGWIN_C
	#define WIN32_LEAN_AND_MEAN
	#include <sys/stat.h>
	#include <sys/errno.h>
	#include "win32.h"
	#include "../git-compat-util.h"

compat/win32.h does

	#ifndef WIN32         /* Not defined by Cygwin */
	#include <windows.h>
	#endif

and then defines some inline functions relying on the win32 api.

git-compat-util.h defines various feature request macros and includes
many system headers, so that simple swap of lines was a huge change.
It's not obvious to me what part was important for making this work
with modern Cygwin win32api.  Mark or others, do you remember what
went wrong with the original "git-compat-util.h and then
compat/win32.h" order (e.g., did it break the build?  what was the
compiler message?) when upgrading win32api?

Unfortunately this was a breaking change: systems with the *old*
version of win32api would only compile with the old order of header
inclusions.  The new ordering produced the following symptom:

	In file included from compat/../git-compat-util.h:90,
			 from compat/cygwin.c:9:
	/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:103:2: 
	warning: #warning "fd_set and associated macros have been defined in sys/types.      
	This may cause runtime problems with W32 sockets"
	In file included from /usr/include/sys/socket.h:16,
			 from compat/../git-compat-util.h:131,
			 from compat/cygwin.c:9:
	/usr/include/cygwin/socket.h:29: error: redefinition of `struct sockaddr'
 [...]

Alex Riesen (cc-ed) noticed that removing the following lines from
git-compat-util.h alleviated this new symptom:

	#ifdef WIN32 /* Both MinGW and MSVC */
	# if defined (_MSC_VER)
	#  define _WIN32_WINNT 0x0502
	# endif
	#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
	#include <winsock2.h>
	#include <windows.h>
	#endif

After all, on Cygwin there is no reason to include winsock or the
win32api from git-compat-util.h.  Presumably one of <sys/stat.h>,
<sys/errno.h>, and <windows.h> causes the WIN32 macro to be defined on
these systems with old win32api, and chaos ensues.

All in all, it wasn't a bad thing, since it revealed that the WIN32
macro doesn't mean what most of the git codebase assumes it means
(hence patch 1/2, which fixes that).

The reordering made in v1.8.1.1~7^2~2 still seems like voodoo to me,
but at least it works.  This patch applies that same order for
everyone.  Systems that would previously use the "I have old win32api
and don't need that reordering" codepath don't need to be
special-cased any more, since *their* particular brand of trouble is
avoided by being careful about how to use the WIN32 macro.

The upshot:

 - No change on modern setups.  To uninformed people like me I feel
   like there is still something subtle going on that is not well
   understood, but hey, this patch doesn't break it. :)

 - Tested to still work on setups that previously needed
   CYGWIN_V15_WIN32API.  Yay!

 - This drops an #ifdef, which means less code that is never tested
   to keep up to date.

With or without a few words of explanation in the commit message to
save some time for the next confused person looking this over,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
