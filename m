From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom
	SHA1 implementations
Date: Tue, 30 Sep 2008 13:39:28 -0700
Message-ID: <20080930203928.GN21310@spearce.org>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:40:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkm1R-0008Cp-4P
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYI3Uja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYI3Uj3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:39:29 -0400
Received: from george.spearce.org ([209.20.77.23]:54364 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYI3Uj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:39:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EB16238360; Tue, 30 Sep 2008 20:39:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0809301621091.3635@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97159>

Nicolas Pitre <nico@cam.org> wrote:
> On ARM I have the following compilation errors:
...
> This is a bit ugly but given the rat nest of system includes we have I 
> don't know how to solve this any better.

Hmm.  On Linux x86 with your change:

In file included from imap-send.c:32:
cache.h: In function 'create_ce_mode':
cache.h:186: error: 'S_IFLNK' undeclared (first use in this function)

I think that last hunk which moved the openssl includes to be before
cache.h is the problem.  This squashed in seems to make it my build
work again:

diff --git a/imap-send.c b/imap-send.c
index 01f1c9a..6b8c66e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -22,6 +22,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include "cache.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
@@ -29,8 +30,6 @@ typedef void *SSL;
 #include <openssl/err.h>
 #endif
 
-#include "cache.h"
-
 struct store_conf {
 	char *name;
 	const char *path; /* should this be here? its interpretation is driver-specific */

-- 
Shawn.
