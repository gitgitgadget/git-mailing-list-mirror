From: Ronan Bignaux <r.bignaux@scourge.biz>
Subject: Discussion around a --bindtodev option for git-daemon
Date: Wed, 26 Sep 2012 18:36:37 +0200
Message-ID: <50632F15.1030908@scourge.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020402010902020401000802"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 19:57:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGvrh-0003jt-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748Ab2IZR5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 13:57:31 -0400
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:48617 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757192Ab2IZR5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 13:57:30 -0400
X-Greylist: delayed 4584 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2012 13:57:29 EDT
Received: from mail607.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 48384FFB82B
	for <git@vger.kernel.org>; Wed, 26 Sep 2012 18:49:34 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Sep 2012 18:41:03 +0200
Received: from lya14-1-82-67-101-94.fbx.proxad.net (HELO ?192.168.1.35?) (r.bignaux@scourge.biz@82.67.101.94)
  by ns0.ovh.net with SMTP; 26 Sep 2012 18:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120612 Thunderbird/13.0
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Enigmail-Version: 1.5pre
X-Ovh-Tracer-Id: 3466927289239796190
X-Ovh-Remote: 82.67.101.94 (lya14-1-82-67-101-94.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeehtddrledtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecunecuhfhrohhmpeftohhnrghnuceuihhgnhgruhiguceorhdrsghighhnrghugiesshgtohhurhhgvgdrsghiiieqnecujfgurhepkfffhfgfggfvufgtsehmtdgrrgdtfedu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeehtddrledtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecunecuhfhrohhmpeftohhnrghnuceuihhgnhgruhiguceorhdrsghighhnrghugiesshgtohhurhhgvgdrsghiiieqnecujfgurhepkfffhfgfggfvufgtsehmtdgrrgdtfedu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206424>

This is a multi-part message in MIME format.
--------------020402010902020401000802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

I wrote this little patch to add a restrict option to bind only to a
specific network interface.

I'd not deal with --inetd since there are some bugs in xinetd with ipv6
( and no more maintener ) , systemd/upstart are also Linux centric and
subject to controversy...

"listen" option was not more useful in my case because it need ip as
parameter (you need fix ip or custom script for example).

It's not ready for inclusion but ready for discussion.

PROS :
* Do the job

CONS :
* Linux only
* root only

What do you think about such option/implementation ?
-- 
Ronan Bignaux
Entrepreneur indépendant
Consultant informatique

ScourGE SARL
136 rue Branville
14000 CAEN
06.47.75.44.81


--------------020402010902020401000802
Content-Type: text/x-patch;
 name="0001-add-option-to-bind-to-a-specific-interface.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-add-option-to-bind-to-a-specific-interface.patch"

>From bfebe7fc838f83065fea04cf27613fe89e962a3a Mon Sep 17 00:00:00 2001
From: Bignaux Ronan <ronan@aimao.org>
Date: Thu, 20 Sep 2012 15:09:31 +0200
Subject: [PATCH] add option to bind to a specific interface


Signed-off-by: Bignaux Ronan <ronan@aimao.org>
---
 daemon.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 4602b46..755fbd3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -5,6 +5,10 @@
 #include "strbuf.h"
 #include "string-list.h"
 
+#ifdef SO_BINDTODEVICE
+#include <net/if.h>
+#endif
+
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
@@ -31,7 +35,7 @@ static const char daemon_usage[] =
 "           [--reuseaddr] [--pid-file=<file>]\n"
 "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
 "           [--access-hook=<path>]\n"
-"           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
+"           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--bindtodev=<interface>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
 "           [<directory>...]";
 
@@ -64,6 +68,7 @@ static char *hostname;
 static char *canon_hostname;
 static char *ip_address;
 static char *tcp_port;
+static struct ifreq ifr;
 
 static void logreport(int priority, const char *err, va_list params)
 {
@@ -875,6 +880,15 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 			continue;
 		}
 
+		if (ifr.ifr_name) {
+			if (setsockopt(sockfd, SOL_SOCKET, SO_BINDTODEVICE, (void *) &ifr,
+					sizeof(ifr)) < 0) {
+				logerror("Could not set SO_BINDTODEVICE: %s", strerror(errno));
+				close(sockfd);
+				continue;
+			}
+		}
+
 #ifdef IPV6_V6ONLY
 		if (ai->ai_family == AF_INET6) {
 			int on = 1;
@@ -1194,6 +1208,11 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
+		if (!prefixcmp(arg, "--bindtodev=")) {
+			memset(&ifr, 0, sizeof(ifr));
+			strncpy (ifr.ifr_name, arg + 12 ,IFNAMSIZ);
+			continue;
+		}
 		if (!strcmp(arg, "--serve")) {
 			serve_mode = 1;
 			continue;
-- 
1.7.12


--------------020402010902020401000802
Content-Type: text/x-vcard; charset=utf-8;
 name="r_bignaux.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="r_bignaux.vcf"

begin:vcard
fn:Ronan Bignaux
n:Bignaux;Ronan
org:ScourGE SARL
adr;dom:;;136 rue Branville ;CAEN ;;14000 
email;internet:r.bignaux@scourge.biz
title;quoted-printable:Entrepreneur ind=C3=A9pendant ,Consultant informatique
tel;cell:06.47.75.44.81
version:2.1
end:vcard


--------------020402010902020401000802--
