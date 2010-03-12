From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Fri, 12 Mar 2010 04:56:54 +0000
Message-ID: <20100312045654.GH7877@thor.il.thewrittenword.com>
References: <20100311163715.GE7877@thor.il.thewrittenword.com>
 <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 05:57:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npwvn-0004Th-07
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 05:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab0CLE45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 23:56:57 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:58074 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab0CLE44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 23:56:56 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id E43EE5C21
	for <git@vger.kernel.org>; Fri, 12 Mar 2010 05:16:06 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com E43EE5C21
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 0EEB3D26
	for <git@vger.kernel.org>; Fri, 12 Mar 2010 04:56:55 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 00007BAB0; Fri, 12 Mar 2010 04:56:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142015>

On Thu, Mar 11, 2010 at 06:40:37PM +0200, Martin Storsj? wrote:
> On Thu, 11 Mar 2010, Gary V. Vaughan wrote:
> 
> > Many of our supported platforms do not have this declaration, for
> > example solaris2.6 thru 2.7.  Lack of ss_family implies no IPV6
> > support, so we can wrap all the ss_family references in an ifndef
> > NO_IPV6, and assume sockaddr_in otherwise.
> 
> While this probably is ok as such, you can actually do the same without 
> accessing the sockaddr_storage->ss_family; just cast it to (const struct 
> sockaddr*) and use ->sa_family instead, that should work just as well, as 
> far as I know.

At least on aix-5.2 it won't be reliable unless you juggle compiler
switches just right (I didn't check anywhere else, but the precedent
for the bit ordering of the struct members being different is already
set):

#if defined(COMPAT_43) && !defined(_KERNEL)
struct sockaddr {
        ushort_t        sa_family;      /* address family */
        char            sa_data[14];    /* up to 14 bytes of direct
address */
};


#else
struct sockaddr {
        uchar_t         sa_len;         /* total length */
        sa_family_t     sa_family;      /* address family */
        char            sa_data[14];    /* actually longer; address value */
};
#endif

Cheers,
   Gary
-- 
Gary V. Vaughan (gary@thewrittenword.com)
