From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 2/6] transport_get(): Don't SEGFAULT on missing url
Date: Tue, 11 Aug 2009 12:10:22 +0200
Message-ID: <1249985426-13726-3-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar9A-0008GJ-8O
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbZHKNLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbZHKNLL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:11 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40825 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751683AbZHKNLD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:03 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO700LE5IYALEC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:10:58 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:10:58 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125547>

Signed-off-by: Johan Herland <johan@herland.net>
---
 transport.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/transport.c b/transport.c
index 19f330a..26d9999 100644
--- a/transport.c
+++ b/transport.c
@@ -820,14 +820,15 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		return ret;
 	}
 
-	if (!prefixcmp(url, "rsync:")) {
+	if (url && !prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 
-	} else if (!prefixcmp(url, "http://")
-	        || !prefixcmp(url, "https://")
-	        || !prefixcmp(url, "ftp://")) {
+	} else if (url
+	        && (!prefixcmp(url, "http://")
+	         || !prefixcmp(url, "https://")
+	         || !prefixcmp(url, "ftp://"))) {
 		transport_helper_init(ret);
 #ifdef NO_CURL
 		error("git was compiled without libcurl support.");
@@ -835,7 +836,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->push = curl_transport_push;
 #endif
 
-	} else if (is_local(url) && is_file(url)) {
+	} else if (url && is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
-- 
1.6.4.rc3.138.ga6b98.dirty
