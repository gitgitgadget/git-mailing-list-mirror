From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] zlib: refactor error message formatter
Date: Fri, 10 Jun 2011 13:15:43 -0700
Message-ID: <1307736948-16956-2-git-send-email-gitster@pobox.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:16:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87a-00061E-CE
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab1FJUPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:15:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758034Ab1FJUPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:15:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F455424A
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Encu
	fp1zscT3Wx7ePoyuLKoP9ws=; b=WI1wiqGlChxdJY0Xb98X4BTtmVNCH89vdZTh
	fA3TZKwPiBa0vUcw9apKQ+6Sjszgq+0ymo6Tz0Go3Bu4hCnvOOMJHT5GwHuHJ934
	fF8C/IdXHrnhYllUf/ixHnX25ZfnB4zlLSwYICE3YPtMlYVuYRDVFncD0qWDNZqU
	fV28jVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MtHoww
	+KM37l2OjnrdHpsQZX7cBF1h19vHbC7+sw18lBmQ2rY8tM8aOIH5tPHamxuZDGLC
	2kEjGqqRFQkehg3j7hM8mi9T77XAiR/xFomqlsXuVdMq9Qbrc5GZco8tWWpJG59d
	qA+ALvNzz6iyY3p6XenFufkI4CWGgHclW6wRo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B9924249
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 400A7423F for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BDCA3DBC-939E-11E0-8091-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175619>

Before refactoring the main part of the wrappers, first move the
logic to convert error status that come back from zlib to string
to a helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 zlib.c |   73 +++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/zlib.c b/zlib.c
index c4d58da..be9d7e9 100644
--- a/zlib.c
+++ b/zlib.c
@@ -4,58 +4,61 @@
  */
 #include "cache.h"
 
-void git_inflate_init(z_streamp strm)
+static const char *zerr_to_string(int status)
 {
-	const char *err;
-
-	switch (inflateInit(strm)) {
-	case Z_OK:
-		return;
-
+	switch (status) {
 	case Z_MEM_ERROR:
-		err = "out of memory";
-		break;
+		return "out of memory";
 	case Z_VERSION_ERROR:
-		err = "wrong version";
-		break;
+		return "wrong version";
+	case Z_NEED_DICT:
+		return "needs dictionary";
+	case Z_DATA_ERROR:
+		return "data stream error";
+	case Z_STREAM_ERROR:
+		return "stream consistency error";
 	default:
-		err = "error";
+		return "unknown error";
 	}
-	die("inflateInit: %s (%s)", err, strm->msg ? strm->msg : "no message");
 }
 
-void git_inflate_end(z_streamp strm)
+void git_inflate_init(z_streamp strm)
 {
-	if (inflateEnd(strm) != Z_OK)
-		error("inflateEnd: %s", strm->msg ? strm->msg : "failed");
+	int status = inflateInit(strm);
+
+	if (status == Z_OK)
+		return;
+	die("inflateInit: %s (%s)", zerr_to_string(status),
+	    strm->msg ? strm->msg : "no message");
 }
 
-int git_inflate(z_streamp strm, int flush)
+void git_inflate_end(z_streamp strm)
 {
-	int ret = inflate(strm, flush);
-	const char *err;
+	int status = inflateEnd(strm);
 
-	switch (ret) {
-	/* Out of memory is fatal. */
-	case Z_MEM_ERROR:
-		die("inflate: out of memory");
+	if (status == Z_OK)
+		return;
+	error("inflateEnd: %s (%s)", zerr_to_string(status),
+	      strm->msg ? strm->msg : "no message");
+}
 
-	/* Data corruption errors: we may want to recover from them (fsck) */
-	case Z_NEED_DICT:
-		err = "needs dictionary"; break;
-	case Z_DATA_ERROR:
-		err = "data stream error"; break;
-	case Z_STREAM_ERROR:
-		err = "stream consistency error"; break;
-	default:
-		err = "unknown error"; break;
+int git_inflate(z_streamp strm, int flush)
+{
+	int status = inflate(strm, flush);
 
+	switch (status) {
 	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
 	case Z_BUF_ERROR:
 	case Z_OK:
 	case Z_STREAM_END:
-		return ret;
+		return status;
+
+	case Z_MEM_ERROR:
+		die("inflate: out of memory");
+	default:
+		break;
 	}
-	error("inflate: %s (%s)", err, strm->msg ? strm->msg : "no message");
-	return ret;
+	error("inflate: %s (%s)", zerr_to_string(status),
+	      strm->msg ? strm->msg : "no message");
+	return status;
 }
-- 
1.7.6.rc1.118.ge175b4a
