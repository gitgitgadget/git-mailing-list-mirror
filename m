From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 18:54:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org, Davide Libenzi <davidel@xmailserver.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS1eh-0001uD-45
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbXCPBym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbXCPBym
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:54:42 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48840 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbXCPByl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:54:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2G1sOcD001083
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Mar 2007 18:54:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2G1sNXU032400;
	Thu, 15 Mar 2007 17:54:24 -0800
In-Reply-To: <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.486 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42314>



On Thu, 15 Mar 2007, Linus Torvalds wrote:
> 
> Same obvious performance problems go for
>
>         case COPY:

As an example, I *think* this patch to zlib-1.2.3 not only generates 
better code, but is (a) shorter and (b) more logical anyway.

Together with Davide's suggestion on using C macro expansion to make most 
of the mode switches simple branches, it might get rid of most of the 
indirect branches (to get rid of them all, you'd have to also find the 
places where we *don't* set a new state, because it stays the same like 
this one, and the ones where we have conditionals on what the mode is 
going to be..

Of course, the zlib sources are pretty horrid for other reasons (K&R 
source code meant to be compiled on 16-bit architectures too). But that's 
a separate issue, and at least shouldn't affect the resulting code 
quality..

		Linus

---
 inflate.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/inflate.c b/inflate.c
index 792fdee..fb26f39 100644
--- a/inflate.c
+++ b/inflate.c
@@ -819,7 +819,7 @@ int flush;
             state->mode = COPY;
         case COPY:
             copy = state->length;
-            if (copy) {
+            while (copy) {
                 if (copy > have) copy = have;
                 if (copy > left) copy = left;
                 if (copy == 0) goto inf_leave;
@@ -829,7 +829,6 @@ int flush;
                 left -= copy;
                 put += copy;
                 state->length -= copy;
-                break;
             }
             Tracev((stderr, "inflate:       stored end\n"));
             state->mode = TYPE;
