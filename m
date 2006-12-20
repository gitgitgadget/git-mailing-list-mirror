X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	T_TVD_MIME_NO_HEADERS shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 14:46:57 -0800
Message-ID: <86ac1iyyla.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
NNTP-Posting-Date: Wed, 20 Dec 2006 22:47:06 +0000 (UTC)
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <86ejquyz4v.fsf@blue.stonehenge.com>
Original-Lines: 45
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34977>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxADH-000084-27 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030415AbWLTWq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWLTWq7
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:46:59 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:30589 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030409AbWLTWq6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:46:58 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 046E88FA88; Wed, 20 Dec 2006 14:46:58 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 20521-01-87; Wed, 20 Dec 2006 14:46:57 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 6CD858FA8A;
 Wed, 20 Dec 2006 14:46:57 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--=-=-=

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> running "git version 1.4.4.3.g5485" on my openbsd box, but I can't get
Randal> there on my OSX box.

According to my headers, "strncasecmp" is defined in <string.h>,
"NI_MAXSERV" is defined in <netdb.h>, and "initgrps" is defined
in "unistd.h".  So this patch works (just verified on OSX), but I
don't know what damage it does elsehwere:

diff --git a/daemon.c b/daemon.c
index b129b83..5ce73ed 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,7 @@
+#include <string.h>
+#include <netdb.h>
+#include <unistd.h>
+
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"

However, now imap-send.o blows up:

imap-send.c: In function 'imap_open_store':
imap-send.c:908: error: 'AF_LOCAL' undeclared (first use in this function)
imap-send.c:908: error: (Each undeclared identifier is reported only once
imap-send.c:908: error: for each function it appears in.)
imap-send.c:990: warning: implicit declaration of function 'getpass'
imap-send.c:990: warning: assignment makes pointer from integer without a cast
make: *** [imap-send.o] Error 1

and finding "getpass" wants me to add "unistd.h" there too.

Hmm.  Let's see if I can use git-format-patch as Linus intended.


--=-=-=
Content-Disposition: attachment; filename=0001-patch-for-osx.txt
Content-Description: patch for osx

From 1549561dc68a1ea71f137c40109c90d33c0f9887 Mon Sep 17 00:00:00 2001
From: Randal L. Schwartz <merlyn@4.sub-70-192-166.myvzw.com>
Date: Wed, 20 Dec 2006 14:45:49 -0800
Subject: [PATCH] patch for osx

---
 daemon.c    |    4 ++++
 imap-send.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index b129b83..5ce73ed 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,7 @@
+#include <string.h>
+#include <netdb.h>
+#include <unistd.h>
+
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
diff --git a/imap-send.c b/imap-send.c
index 894cbbd..afd7447 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -22,6 +22,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <unistd.h>
+
 #include "cache.h"
 
 typedef struct store_conf {
-- 
1.4.4.3.g5485-dirty


--=-=-=


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!

