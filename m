From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH/RFC] work around recent curl/gcc warnings
Date: Thu, 03 Jul 2008 21:38:07 -0700
Message-ID: <7vhcb6w9g0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 06:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEd4m-0008M2-1N
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 06:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYGDEiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 00:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbYGDEiR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 00:38:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYGDEiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 00:38:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A53A13BEB;
	Fri,  4 Jul 2008 00:38:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 73E1A13BE8; Fri,  4 Jul 2008 00:38:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0450A44C-4983-11DD-96F7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87359>

After master.k.org upgrade, I started seeing these warning messages:

    transport.c: In function 'get_refs_via_curl':
    transport.c:458: error: call to '_curl_easy_setopt_err_write_callback' declared with attribute warning: curl_easy_setopt expects a curl_write_callback argument for this option

It appears that the header wants to enforce the function signature for
fwrite_buffer to be compatible with that of fwrite() or
(*curl_write_callback).

This patch seems to work the issue around.

---
 http.c |   13 +++++++------
 http.h |    9 +++------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/http.c b/http.c
index 105dc93..ad14640 100644
--- a/http.c
+++ b/http.c
@@ -30,10 +30,11 @@ static struct curl_slist *pragma_header;
 
 static struct active_request_slot *active_queue_head = NULL;
 
-size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
-			   struct buffer *buffer)
+size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
+	struct buffer *buffer = buffer_;
+
 	if (size > buffer->buf.len - buffer->posn)
 		size = buffer->buf.len - buffer->posn;
 	memcpy(ptr, buffer->buf.buf + buffer->posn, size);
@@ -42,17 +43,17 @@ size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
 	return size;
 }
 
-size_t fwrite_buffer(const void *ptr, size_t eltsize,
-			    size_t nmemb, struct strbuf *buffer)
+size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
+	struct strbuf *buffer = buffer_;
+
 	strbuf_add(buffer, ptr, size);
 	data_received++;
 	return size;
 }
 
-size_t fwrite_null(const void *ptr, size_t eltsize,
-			  size_t nmemb, struct strbuf *buffer)
+size_t fwrite_null(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
 	data_received++;
 	return eltsize * nmemb;
diff --git a/http.h b/http.h
index a04fc6a..905b462 100644
--- a/http.h
+++ b/http.h
@@ -64,12 +64,9 @@ struct buffer
 };
 
 /* Curl request read/write callbacks */
-extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb,
-			   struct buffer *buffer);
-extern size_t fwrite_buffer(const void *ptr, size_t eltsize,
-			    size_t nmemb, struct strbuf *buffer);
-extern size_t fwrite_null(const void *ptr, size_t eltsize,
-			  size_t nmemb, struct strbuf *buffer);
+extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+extern size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+extern size_t fwrite_null(const void *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 
 /* Slot lifecycle functions */
 extern struct active_request_slot *get_active_slot(void);
