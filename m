From: Juergen Kosel <juergen.kosel@gmx.de>
Subject: git merge failed to detect conflict
Date: Sun, 19 Jun 2011 17:51:29 +0200
Message-ID: <4DFE1B01.8050107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 17:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYKHt-0007Y1-Ak
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1FSPvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:51:35 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:44813 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754151Ab1FSPvd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:51:33 -0400
Received: (qmail invoked by alias); 19 Jun 2011 15:51:30 -0000
Received: from nrbg-4d0765ea.pool.mediaWays.net (EHLO [192.168.178.3]) [77.7.101.234]
  by mail.gmx.net (mp057) with SMTP; 19 Jun 2011 17:51:30 +0200
X-Authenticated: #4222805
X-Provags-ID: V01U2FsdGVkX198Y4JvSbh8l00QbNevg6P1aBI3IIryVJAR9z3PLX
	9CbVAyPd0uLji6
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110505 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176024>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have just steped into a boarder case, where git merge fails to detect
a merge conflict:

The commit A in the remote branch was the following:

diff --git a/LoWPAN.c b/LoWPAN.c
index 3e929e5..1b768e2 100644 (file)
- --- a/LoWPAN.c
+++ b/LoWPAN.c
@@ -431,12 +431,16 @@ int main (int argc, char **argv)
       }
       printf("\n");
 #endif
- -      // forward into kernel/tap device
- -      retval=lowpan_writeout(&rx_packet,tap_fd);
- -      if(retval<0) {
- -       ERROR_OUTPUT("Failed to forward datagram into tap device: %s",
- -                    strerror(errno));
- -       break; // leave the while loop
+      // ensure that we haven't got our own multicast
+      if((rx_packet.source.pan_id != own_802154_addr.pan_id)
+        || (rx_packet.source.short_addr != own_802154_addr.short_addr)) {
+       // forward into kernel/tap device
+       retval=lowpan_writeout(&rx_packet,tap_fd);
+       if(retval<0) {
+         ERROR_OUTPUT("Failed to forward datagram into tap device: %s",
+                      strerror(errno));
+         break; // leave the while loop
+       }
       }
     }
   }

The commit B in the local branch was:
diff --git a/LoWPAN.c b/LoWPAN.c
index 3e929e5..a7c65e3 100644 (file)
- --- a/LoWPAN.c
+++ b/LoWPAN.c
@@ -438,6 +438,8 @@ int main (int argc, char **argv)
                     strerror(errno));
        break; // leave the while loop
       }
+      DEBUG_OUTPUT("Successfully forwarded %d bytes into the tap device",
+                  retval);
     }
   }

The resulting merge commit AB is:
diff --cc LoWPAN.c
index a7c65e3,1b768e2..92ec5f7
- --- 1/LoWPAN.c
- --- 2/LoWPAN.c
+++ b/LoWPAN.c
@@@ -431,15 -431,17 +431,19 @@@ int main (int argc, char **argv
        }
        printf("\n");
  #endif
- -       // forward into kernel/tap device
- -       retval=lowpan_writeout(&rx_packet,tap_fd);
- -       if(retval<0) {
- -       ERROR_OUTPUT("Failed to forward datagram into tap device: %s",
- -                    strerror(errno));
- -       break; // leave the while loop
+       // ensure that we haven't got our own multicast
+       if((rx_packet.source.pan_id != own_802154_addr.pan_id)
+        || (rx_packet.source.short_addr != own_802154_addr.short_addr)) {
+       // forward into kernel/tap device
+       retval=lowpan_writeout(&rx_packet,tap_fd);
+       if(retval<0) {
+         ERROR_OUTPUT("Failed to forward datagram into tap device: %s",
+                      strerror(errno));
+         break; // leave the while loop
+       }
        }
 +      DEBUG_OUTPUT("Successfully forwarded %d bytes into the tap device",
 +                 retval);
      }
    }

If you just look at the diff output, it is difficult to see the problem.
But if you look at the corresponding code sections, than you see that
diff has splitted the conflictiong section into two none conflicting
sections.

Code A:

 434       // ensure that we haven't got our own multicast
 435       if((rx_packet.source.pan_id != own_802154_addr.pan_id)
 436          || (rx_packet.source.short_addr !=
own_802154_addr.short_addr)) {
 437         // forward into kernel/tap device
 438         retval=lowpan_writeout(&rx_packet,tap_fd);
 439         if(retval<0) {
 440           ERROR_OUTPUT("Failed to forward datagram into tap device:
%s",
 441                        strerror(errno));
 442           break; // leave the while loop
 443         }
 444       }

Code B:

 434       // forward into kernel/tap device
 435       retval=lowpan_writeout(&rx_packet,tap_fd);
 436       if(retval<0) {
 437         ERROR_OUTPUT("Failed to forward datagram into tap device: %s",
 438                      strerror(errno));
 439         break; // leave the while loop
 440       }
 441       DEBUG_OUTPUT("Successfully forwarded %d bytes into the tap
device",
 442                    retval);
 443     }

Code AB:

 434       // ensure that we haven't got our own multicast
 435       if((rx_packet.source.pan_id != own_802154_addr.pan_id)
 436          || (rx_packet.source.short_addr !=
own_802154_addr.short_addr)) {
 437         // forward into kernel/tap device
 438         retval=lowpan_writeout(&rx_packet,tap_fd);
 439         if(retval<0) {
 440           ERROR_OUTPUT("Failed to forward datagram into tap device:
%s",
 441                        strerror(errno));
 442           break; // leave the while loop
 443         }
 444       }
 445       DEBUG_OUTPUT("Successfully forwarded %d bytes into the tap
device",
 446                    retval);
 447     }

Obviously git/diff has failed to detect that human intervention is
required here. One _workaround_ would be, to demand in the coding style,
that closing braces get unique comments.
But what would be the solution of this problem?


Greetings
	Juergen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFN/hr95JgLPmj5988RAvEZAJ0R23PMc5xXfbKPCYnw3s8FGkqBqACgtpgV
96GejSM+XaPgg9p4XMpuF/k=
=zjX3
-----END PGP SIGNATURE-----
