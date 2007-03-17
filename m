From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 17:01:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 01:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSMMZ-0002DF-RQ
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 01:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992469AbXCQABd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 20:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992464AbXCQABc
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 20:01:32 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43263 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992477AbXCQABb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 20:01:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2H01GcD011389
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 17:01:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2H01E9j024874;
	Fri, 16 Mar 2007 16:01:15 -0800
In-Reply-To: <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-3.48 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42412>



On Fri, 16 Mar 2007, Davide Libenzi wrote:
>
> I cannot measure any sensible difference between the two.

I'm using your previous patch (is it the same?) along with the additional 
patch appended.

And yes, it's not hugely faster, but I seem to see *some* difference: this 
is the real-time of ten runs of 

	time git log drivers/usb/ > /dev/null

Before:

	0m2.673s
	0m2.476s
	0m2.603s
	0m2.576s
	0m2.625s
	0m2.628s
	0m2.493s
	0m2.696s
	0m2.525s
	0m2.575s

After:

	0m2.639s
	0m2.519s
	0m2.454s
	0m2.604s
	0m2.499s
	0m2.497s
	0m2.506s
	0m2.394s
	0m2.409s
	0m2.562s

ie after I actually get under 2.4s once, and under 2.5s most of the time, 
while before it was under 2.5s just twice, and mostly in the 2.6s..

(I did end up adding the "-g", but I trust that doesn't make things 
*faster*. Generally gcc is good at not actually changing code generation 
based on -g)

But yeah, not very impressive changes. We're talking *maybe* 0.1s out of 
2.5, so potentially about 4% of total time but more likely about 2-3%, and 
it's clearly mostly in the noise. And inflate() is still at 16%, and 
inflate_fast obviously got no faster.

The nice part is that the instruction-level profile for inflate() got more 
interesting. Instead of clearly peaking at the silly indirect jump, the 
peak now seems to be a specific path through the thing. I've not decoded 
it fully yet, but it seems to be mostly the LEN/LIT cases:

 file inflate.c, line 942.
 file inflate.c, line 942.
 file inflate.c, line 949.
 file inflate.c, line 949.
 file inflate.c, line 949.
 file inflate.c, line 949.
 file inflate.c, line 949.
 file inflate.c, line 950.
 file inflate.c, line 950.
 file inflate.c, line 951.
 file inflate.c, line 951.
 file inflate.c, line 951.
 file inflate.c, line 951.
 file inflate.c, line 951.
 file inflate.c, line 949.
 file inflate.c, line 949.
 file inflate.c, line 950.
 file inflate.c, line 950.
 file inflate.c, line 953.
 file inflate.c, line 953.
 file inflate.c, line 953.
 file inflate.c, line 969.
 file inflate.c, line 1058.
 file inflate.c, line 1059.
 file inflate.c, line 1061.
 file inflate.c, line 884.
 file inflate.c, line 963.
 file inflate.c, line 964.

(those are the line numbers *after* applying my patch for where the 
hotpoints are: the same line-number showing up multiple times is just 
because several hot instructions came from there and got spread out)

			Linus

---
diff --git a/Makefile b/Makefile
index 2fd6e45..d8e9ff4 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,7 @@
 
 CC=cc
 
-CFLAGS=-O
+CFLAGS=-O -g
 #CFLAGS=-O -DMAX_WBITS=14 -DMAX_MEM_LEVEL=7
 #CFLAGS=-g -DDEBUG
 #CFLAGS=-O3 -Wall -Wwrite-strings -Wpointer-arith -Wconversion \
diff --git a/inflate.c b/inflate.c
index 190c642..3d41d6f 100644
--- a/inflate.c
+++ b/inflate.c
@@ -568,7 +568,7 @@ int flush;
     unsigned char FAR *next;    /* next input */
     unsigned char FAR *put;     /* next output */
     unsigned have, left;        /* available input and output */
-    unsigned long hold;         /* bit buffer */
+    unsigned long hold, old_hold;/* bit buffer */
     unsigned bits;              /* bits in bit buffer */
     unsigned in, out;           /* save starting available input and output */
     unsigned copy;              /* number of stored or match bytes to copy */
@@ -631,8 +631,11 @@ int flush;
             state->dmax = 1U << len;
             Tracev((stderr, "inflate:   zlib header ok\n"));
             strm->adler = state->check = adler32(0L, Z_NULL, 0);
-            state->mode = hold & 0x200 ? DICTID : TYPE;
+            old_hold = hold;
             INITBITS();
+            if (old_hold & 0x200)
+            	STATE_CHANGE(DICTID);
+            STATE_CHANGE(TYPE);
             break;
 #ifdef GUNZIP
         CASE_DECL(FLAGS)
@@ -817,7 +820,7 @@ int flush;
             state->mode = COPY;
         CASE_DECL(COPY)
             copy = state->length;
-            if (copy) {
+            while (copy) {
                 if (copy > have) copy = have;
                 if (copy > left) copy = left;
                 if (copy == 0) goto inf_leave;
@@ -826,8 +829,8 @@ int flush;
                 next += copy;
                 left -= copy;
                 put += copy;
-                state->length -= copy;
-                break;
+                copy = state->length - copy;
+                state->length = copy;
             }
             Tracev((stderr, "inflate:       stored end\n"));
 	    STATE_CHANGE(TYPE);
