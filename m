From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom SHA1
 implementations
Date: Tue, 30 Sep 2008 16:46:56 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0809301645340.3635@xanadu.home>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home>
 <20080930203928.GN21310@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:48:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkm8q-0002cA-6u
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYI3UrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYI3UrJ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:47:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49438 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYI3UrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:47:08 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K81007QA0D9SDU0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Sep 2008 16:46:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080930203928.GN21310@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97160>

On Tue, 30 Sep 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On ARM I have the following compilation errors:
> ...
> > This is a bit ugly but given the rat nest of system includes we have I 
> > don't know how to solve this any better.
> 
> Hmm.  On Linux x86 with your change:
> 
> In file included from imap-send.c:32:
> cache.h: In function 'create_ce_mode':
> cache.h:186: error: 'S_IFLNK' undeclared (first use in this function)
> 
> I think that last hunk which moved the openssl includes to be before
> cache.h is the problem.  This squashed in seems to make it my build
> work again:
> 
> diff --git a/imap-send.c b/imap-send.c
> index 01f1c9a..6b8c66e 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -22,6 +22,7 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> +#include "cache.h"
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #else
> @@ -29,8 +30,6 @@ typedef void *SSL;
>  #include <openssl/err.h>
>  #endif
>  
> -#include "cache.h"
> -
>  struct store_conf {
>  	char *name;
>  	const char *path; /* should this be here? its interpretation is driver-specific */

With that, my build on ARM bombs out with:

    CC imap-send.o
In file included from /usr/include/openssl/kssl.h:71,
                 from /usr/include/openssl/ssl.h:191,
                 from imap-send.c:30:
/usr/include/ctype.h:102: error: expected expression before ']' token
/usr/include/ctype.h:102: error: expected ')' before '!=' token
/usr/include/ctype.h:103: error: expected expression before ']' token
/usr/include/ctype.h:103: error: expected ')' before '!=' token
/usr/include/ctype.h:105: error: expected expression before ']' token
/usr/include/ctype.h:105: error: expected ')' before '!=' token
/usr/include/ctype.h:110: error: expected expression before ']' token
/usr/include/ctype.h:110: error: expected ')' before '!=' token
/usr/include/ctype.h:116: error: expected declaration specifiers or '...' before '(' token
/usr/include/ctype.h:116: error: expected declaration specifiers or '...' before numeric constant
/usr/include/ctype.h:119: error: expected declaration specifiers or '...' before '(' token
/usr/include/ctype.h:119: error: expected declaration specifiers or '...' before numeric constant
/usr/include/ctype.h:191: error: expected declaration specifiers or '...' before '(' token
/usr/include/ctype.h:191: error: expected declaration specifiers or '...' before numeric constant
/usr/include/ctype.h:192: error: redefinition of 'sane_case'
git-compat-util.h:338: error: previous definition of 'sane_case' was here
/usr/include/ctype.h: In function 'sane_case':
/usr/include/ctype.h:192: error: number of arguments doesn't match prototype
git-compat-util.h:338: error: prototype declaration
/usr/include/ctype.h:193: error: '__c' undeclared (first use in this function)
/usr/include/ctype.h:193: error: (Each undeclared identifier is reported only once
/usr/include/ctype.h:193: error: for each function it appears in.)
/usr/include/ctype.h: At top level:
/usr/include/ctype.h:197: error: expected declaration specifiers or '...' before '(' token
/usr/include/ctype.h:197: error: expected declaration specifiers or '...' before numeric constant
/usr/include/ctype.h:198: error: redefinition of 'sane_case'
/usr/include/ctype.h:192: error: previous definition of 'sane_case' was here
/usr/include/ctype.h: In function 'sane_case':
/usr/include/ctype.h:198: error: number of arguments doesn't match prototype
/usr/include/ctype.h:192: error: prototype declaration
/usr/include/ctype.h:199: error: '__c' undeclared (first use in this function)
make: *** [imap-send.o] Error 1


Nicolas
