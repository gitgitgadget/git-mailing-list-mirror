From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC PATCH v2 2/2] MSVC: Fix an "incompatible pointer types"
 compiler warning
Date: Tue, 08 Dec 2009 19:48:42 +0000
Message-ID: <4B1EAD9A.3090205@ramsay1.demon.co.uk>
References: <4B1997A0.9000004@ramsay1.demon.co.uk> <200912051257.21386.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:51:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI66A-0004pd-Ew
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 20:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965918AbZLHTvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965894AbZLHTva
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 14:51:30 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:36607 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965890AbZLHTva (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 14:51:30 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NI65v-00040o-XN; Tue, 08 Dec 2009 19:51:36 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <200912051257.21386.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134905>

Johannes Sixt wrote:
> On Samstag, 5. Dezember 2009, Ramsay Jones wrote:
>> The patch is still marked RFC because:
>>     - I'm still not sure if the flexibility to support both 32- and 64-bit
>>       time_t is required.
>>     - should -D_USE_32BIT_TIME_T be added to the Makefile?
> 
> If *not* using -D_USE_32BIT_TIME_T  produces a build or code base that is in 
> some way superior, why should we require it? For example, its absence could 
> help a 64bit build.

Indeed.

I only added the second bullet because you seemed to be advocating it, in your
last email, so I'm waiting for your answer on that. :-D

Unfortunately the patch can not be a simple as the first version (Dscho was
quite right to complain about adding too much clutter to mingw.h with msvc
related code), but the moral equivalent would have msvc.h look like:

    25	/* Use mingw_lstat() instead of lstat()/stat() and mingw_fstat() instead
    26	 * of fstat(). We add the declaration of these functions here, suppressing
    27	 * the corresponding declarations in mingw.h, so that we can use the
    28	 * appropriate structure type (and function) names from the msvc headers.
    29	 */
    30	#define stat _stat64
    31	int mingw_lstat(const char *file_name, struct stat *buf);
    32	int mingw_fstat(int fd, struct stat *buf);
    33	#define fstat mingw_fstat
    34	#define lstat mingw_lstat
    35	#define _stat64(x,y) mingw_lstat(x,y)
    36	#define ALREADY_DECLARED_STAT_FUNCS
    37	
    38	#include "compat/mingw.h"
    39	
    40	#undef ALREADY_DECLARED_STAT_FUNCS

This works fine, *provided* you do not need to compile with -D_USE_32BIT_TIME_T,
which would produce this warning:

    ...mingw.c(223) : warning C4133: 'function' : incompatible types - \
    from '_stat64 *' to '_stat32i64 *'

This would actually be *worse* than the original code, since the struct _stat64
would not have the same "shape" as the struct _stat32i64; it would not write
outside of the allocated memory, at least, but the time fields would obviously
be written to the wrong offsets etc,. In the original code, the struct _stati64
would have the correct "shape", since the time fields are declared with time_t.

At first I thought there would be no need to set _USE_32BIT_TIME_T.  After some
thought, however, I could not be confident that it would *never* be necessary.
(my only concern was to revert to 32-bit time_t, perhaps only temporarily, while
fixing a breakage; I did not consider wanting to keep "compatibility" with the
MinGW code). This lead to the more complicated/flexible RFC patch.

I was hoping for someone to say: "Hey, we will *never* need to compile with
-D_USE_32BIT_TIME_T, so just get rid of those #if conditionals and simplify
the code ...". :-P

Since nobody has said any such thing, I have to conclude that the extra
flexibility is required. That being the case, I have to be happy with the
patch as-is and propose to remove the RFC.

Before I do that, do you have any further comments or concerns about the
v2 patch that you want me to address?

ATB,
Ramsay Jones
