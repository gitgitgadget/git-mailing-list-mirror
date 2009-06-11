From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6
Date: Thu, 11 Jun 2009 17:06:00 +0200
Message-ID: <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MElrS-0006KT-JA
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 17:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbZFKPG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 11:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbZFKPG0
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 11:06:26 -0400
Received: from office.neopsis.com ([78.46.209.98]:51246 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbZFKPGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 11:06:25 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Thu, 11 Jun 2009 17:06:25 +0200
In-Reply-To: <1243106697-6424-2-git-send-email-gitster@pobox.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121342>


On May 23, 2009, at 9:24 PM, Junio C Hamano wrote:

> In git-compat-util.h, we do
>
>    #define _XOPEN_SOURCE 600
>    #define _XOPEN_SOURCE_EXTENDED 1
>
> unless we are on BSD or SCO.
>
> On OpenSolaris (200811), /usr/include/sys/feature_tests.h has this  
> nice
> table:
>
>    Feature Test Macro				     Specification
>    ------------------------------------------------  -------------
>    _XOPEN_SOURCE                                         XPG3
>    _XOPEN_SOURCE && _XOPEN_VERSION = 4                   XPG4
>    _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED = 1           XPG4v2
>    _XOPEN_SOURCE = 500                                   XPG5
>    _XOPEN_SOURCE = 600  (or POSIX_C_SOURCE=200112L)      XPG6
>
> Later in the same header, compilation with -c99 is made to fail if  
> _XPG6 is
> not set, like this:
>
>    #if defined(_STDC_C99) && (defined(__XOPEN_OR_POSIX) && ! 
> defined(_XPG6))
>    #error "Compiler or options invalid for pre-UNIX 03 X/Open  
> applications \
>            and pre-2001 POSIX applications"
>    #elif ...
>
> The problem is that they check things in an order that is  
> inconvenient for
> us.  When they see _XOPEN_SOURCE_EXTENDED, they declare that we are  
> XPG4v2,
> regardless of the value of _XOPEN_SOURCE.
>
> To work around this problem, do not define _XOPEN_SOURCE_EXTENDED on
> Sun's.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> git-compat-util.h |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c7cf2d5..4236647 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -41,8 +41,10 @@
>
> #if !defined(__APPLE__) && !defined(__FreeBSD__)  && ! 
> defined(__USLC__) && !defined(_M_UNIX)
> #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD  
> needs 600 for S_ISLNK() */
> +#ifndef __sun__
> #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> #endif
> +#endif
> #define _ALL_SOURCE 1
> #define _GNU_SOURCE 1
> #define _BSD_SOURCE 1
> -- 
> 1.6.3.1.145.gb74d77
>

Until this commit a simple 'make prefix=...' worked just fine. Now I  
have to explicitly add '-std=c99' to the gcc commandline. Is there a  
reason why the makefile doesn't add this switch automatically?

tom
