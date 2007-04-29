From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] http.c: Fix problem with repeated calls of http_init
Date: Sun, 29 Apr 2007 03:46:42 +0100
Message-ID: <20070429025059.2315.98407.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 04:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhzdD-0003uz-R7
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 04:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbXD2C7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 22:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbXD2C7U
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 22:59:20 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:35877 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754246AbXD2C7U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Apr 2007 22:59:20 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6EE01C60F1
	for <git@vger.kernel.org>; Sun, 29 Apr 2007 03:59:18 +0100 (BST)
Received: (qmail 27423 invoked by uid 103); 29 Apr 2007 03:58:08 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3177. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024268 secs); 29 Apr 2007 02:58:08 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 29 Apr 2007 03:58:08 +0100
X-git-sha1: 80e79444ab90c51d72bf80485fceb06fd2cb8c38 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45809>

Calling http_init after calling http_cleanup causes a segfault.  This
is due to the pragma_header curl_slist being freed but not being set
to NULL.  The subsequent call to http_init tries to setup the slist
again, but it now points to an invalid memory location.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

This doesn't cause any problems in current git as far as I know.  It does however break my C fetch when using http.

 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 576740f..ae27e0c 100644
--- a/http.c
+++ b/http.c
@@ -300,6 +300,7 @@ void http_cleanup(void)
 	curl_global_cleanup();
 
 	curl_slist_free_all(pragma_header);
+        pragma_header = NULL;
 }
 
 struct active_request_slot *get_active_slot(void)
-- 
1.5.1.2
