From: Pavel Roskin <proski@gnu.org>
Subject: Re: cvsimport weird
Date: Thu, 18 May 2006 01:44:54 -0400
Message-ID: <1147931094.32050.51.camel@dv>
References: <4fb292fa0605171800n4f041dd2l8af06d82bdbe6bff@mail.gmail.com>
	 <46a038f90605171954n7e75ee64t412b22e8d405d909@mail.gmail.com>
	 <1147924771.32050.40.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bertrand Jacquin <beber.mailing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 18 07:45:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgbJt-0002pB-SO
	for gcvg-git@gmane.org; Thu, 18 May 2006 07:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWERFpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 01:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWERFpA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 01:45:00 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:26272 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751217AbWERFo7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 01:44:59 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgbJi-0002C1-6i
	for git@vger.kernel.org; Thu, 18 May 2006 01:44:58 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgbJf-0004dQ-9J; Thu, 18 May 2006 01:44:55 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <1147924771.32050.40.camel@dv>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20261>

On Wed, 2006-05-17 at 23:59 -0400, Pavel Roskin wrote:
> I'm quite sure that it's a bug in cvsps.  It displays such things on
> x86_64, but works properly on 32-bit PowerPC.

Address resolution is broken in cvsps on 64-bit machines.  This patch to
cvsps is needed:

--- cbtcommon/tcpsocket.c
+++ cbtcommon/tcpsocket.c
@@ -198,7 +198,7 @@ convert_address(long *dest, const char *
     memcpy(dest, &ip.s_addr, sizeof(ip.s_addr));
   }
 #else
-  if ( (*dest = inet_addr(addr_str)) != -1)
+  if ( (*dest = inet_addr(addr_str)) != INADDR_NONE)
   {
     /* nothing */
   }


However, it's not sufficient to fix the original problem of empty CVS
server version string.  For some reason cvsps fails to authenticate with
pserver.  The ext protocol is working.

It's interesting that both git-cvsimport and cvsps have code to
authenticate over the pserver protocol.  I think maybe git-cvsimport
shouldn't do it, or maybe it should close some sockets before running
cvsps.

-- 
Regards,
Pavel Roskin
