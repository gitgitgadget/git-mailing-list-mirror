From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid gcc compiler warning
Date: Tue, 9 Dec 2014 10:48:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412091039130.13845@s15462909.onlinehome-server.info>
References: <cover.1418056722.git.johannes.schindelin@gmx.de> <b9e1cb1f858e71b964be4f752fcebc22cd944ebc.1418056722.git.johannes.schindelin@gmx.de> <20141209084728.GA13123@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyHPa-00053e-NG
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 10:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbaLIJst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 04:48:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:57154 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbaLIJsr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 04:48:47 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MX16a-1YRxKK35Qi-00Vwid;
 Tue, 09 Dec 2014 10:48:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141209084728.GA13123@peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:34nWfbhZQRmot+MHEdbfaKWXvhrF1CgTK7UtDWF2JeMvu2bTXoW
 8HiXcHkOKrRwE30GpNHE30m3gDNDENquSTRW6jX27yZ37EepPOc5Vxktv2f0I/xAKXIghn1
 VRCzWkVEyBuZ/Pt/KOdmM4ka1oXvoc3446SOTpgVvGeZNK+vrvwiJB6MAgTDUuURo+moYTF
 36VJFMG/I8KyjNBne5AbQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261116>

Hi Peff,

On Tue, 9 Dec 2014, Jeff King wrote:

> On Mon, Dec 08, 2014 at 05:38:59PM +0100, Johannes Schindelin wrote:
> 
> > At least on this developer's MacOSX (Snow Leopard, gcc-4.2.1), GCC prints
> > a warning that 'hash' may be used uninitialized when compiling
> > test-hashmap that 'hash' may be used uninitialized (but GCC 4.6.3 on this
> > developer's Ubuntu server does not report this problem).
> > 
> > Since hash() is called from perf_hashmap() which accepts an unchecked
> > integer value from the command line, the warning appears to be legitimate,
> > even if the test-hashmap command is only called from the test suite.
> 
> I think the older gcc is wrong;

Thanks for pointing to the older thread. It just happened to make it
inconvenient to develop the rather huge fsck api topic branch I submitted
yesterday because my vi kept jumping to test-hashmap.c because of that
compiler warning (and as you know, not everybody has the luxury of being
able to upgrade their gcc *cough* *Xcode* *cough* *Snow Leopard*).

> we are switching on "method & 3", which must be in the range 0-3 (and we
> cover all cases).

That is of course correct, but still does not address the compiler
warning.

Junio, you said that you would prefer the useless initialization, so here
goes:

-- snipsnap --
Subject: [PATCH] Avoid gcc compiler warning

At least on this developer's MacOSX (Snow Leopard, gcc-4.2.1), GCC prints
a warning that 'hash' may be used uninitialized when compiling
test-hashmap that 'hash' may be used uninitialized (but GCC 4.6.3 on this
developer's Ubuntu server does not report this problem).

The old compiler is wrong, of course, as the switch(method & 3) statement
already handles all the possible cases, but that does not help in a
scenario where it is hard or impossible to upgrade to a newer compiler
(e.g. being stuck on an older MacOSX and having to rely on Xcode).

So let's just initialize the variable and be done with it, it is hardly a
crucial part of the code because it is only used by the test suite and
invisible to the end users.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 test-hashmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-hashmap.c b/test-hashmap.c
index 07aa7ec..cc2891d 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -47,7 +47,7 @@ static struct test_entry *alloc_test_entry(int hash,
char *key, int klen,
 
 static unsigned int hash(unsigned int method, unsigned int i, const char
*key)
 {
-	unsigned int hash;
+	unsigned int hash = 0;
 	switch (method & 3)
 	{
 	case HASH_METHOD_FNV:
-- 
2.0.0.rc3.9669.g840d1f9
