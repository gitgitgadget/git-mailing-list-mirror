From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http-push.c: get_remote_object_url() is only used under
 USE_CURL_MULTI
Date: Mon, 02 Feb 2009 22:45:56 -0800
Message-ID: <7v8woodnmj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 07:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUF4I-0006OE-JE
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZBCGqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZBCGqF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:46:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZBCGqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:46:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D82202A533;
	Tue,  3 Feb 2009 01:46:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ADCFF2A545; Tue, 
 3 Feb 2009 01:45:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51C177CC-F1BE-11DD-B85D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108155>

Otherwise -Wunused-function (which is implied by -Wall) triggers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

I think this patch is probably a bit on the wrong side of the borderline,
in that it *happens to be* that get_remote_object_url() is used by nobody
in non-multi codepath right now, but it is entirely possible that future
code clean-up can benefit from its use.  But without this patch,, the file
does not compile for me (I compile everything with "-Werror -Wall").

 http-push.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/http-push.c b/http-push.c
index ba5cc32..203c075 100644
--- a/http-push.c
+++ b/http-push.c
@@ -218,13 +218,6 @@ static void append_remote_object_url(struct strbuf *buf, const char *url,
 		strbuf_addf(buf, "%s", hex+2);
 }
 
-static char *get_remote_object_url(const char *url, const char *hex, int only_two_digit_prefix)
-{
-	struct strbuf buf = STRBUF_INIT;
-	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
-	return strbuf_detach(&buf, NULL);
-}
-
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);
 
@@ -237,6 +230,14 @@ static void process_response(void *callback_data)
 }
 
 #ifdef USE_CURL_MULTI
+
+static char *get_remote_object_url(const char *url, const char *hex, int only_two_digit_prefix)
+{
+	struct strbuf buf = STRBUF_INIT;
+	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
+	return strbuf_detach(&buf, NULL);
+}
+
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
-- 
1.6.1.2.343.g53117
