From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4] Work around curl-gnutls not liking to be reinitialized
Date: Sat,  9 Feb 2008 10:41:36 +0100
Message-ID: <1202550096-13233-1-git-send-email-mh@glandium.org>
References: <1202512124-28669-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 09 10:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNmDw-0008IA-7G
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 10:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbYBIJlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 04:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756077AbYBIJlO
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 04:41:14 -0500
Received: from vuizook.err.no ([85.19.215.103]:39446 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbYBIJlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 04:41:09 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNmDj-0001tc-3g; Sat, 09 Feb 2008 10:42:09 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNmDI-0003Rt-Gc; Sat, 09 Feb 2008 10:41:36 +0100
X-Mailer: git-send-email 1.5.4.35.gb88c
In-Reply-To: <1202512124-28669-1-git-send-email-mh@glandium.org>
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73203>

curl versions 7.16.3 to 7.18.0 included had a regression in which https
requests following curl_global_cleanup/init sequence would fail with ASN1
parser errors with curl-gnutls. Such sequences happen in some cases such
as git fetch.

We work around this by removing the http_init and http_cleanup calls from
get_refs_via_curl, replacing them with a transport->data initialization
with the http_walker (which does http_init).

While the http_walker is not currently used in get_refs_via_curl, http
and walker code refactor will make it use it.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 FWIW, the previous patch lacked an initialization for pragma_header. But I
 actually got a better idea ; a more long-term one.

 transport.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index babaa21..497f853 100644
--- a/transport.c
+++ b/transport.c
@@ -441,11 +441,12 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
 
+	if (!transport->data)
+		transport->data = get_http_walker(transport->url);
+
 	refs_url = xmalloc(strlen(transport->url) + 11);
 	sprintf(refs_url, "%s/info/refs", transport->url);
 
-	http_init();
-
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
@@ -473,8 +474,6 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		return NULL;
 	}
 
-	http_cleanup();
-
 	data = buffer.buf;
 	start = NULL;
 	mid = data;
-- 
1.5.4.35.gb88c
