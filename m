From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 06/11] http.c: Remove unnecessary strdup of sha1_to_hex result
Date: Mon, 19 Apr 2010 07:23:05 -0700
Message-ID: <1271686990-16363-2-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:27:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rwR-0003Yd-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab0DSO0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:26:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:56900 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab0DSO0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:26:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2004854fgg.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:26:49 -0700 (PDT)
Received: by 10.223.67.144 with SMTP id r16mr160803fai.102.1271687000805;
        Mon, 19 Apr 2010 07:23:20 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id f31sm10718552fkf.18.2010.04.19.07.23.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145304>

Most of the time the dumb HTTP transport is run without the verbose
flag set, so we only need the result of sha1_to_hex(sha1) once, to
construct the pack URL.  Don't bother with an unnecessary malloc,
copy, free chain of this buffer.

If verbose is set, we'll format the SHA-1 twice now.  But this
tiny extra CPU time spent is nothing compared to the slowdown that
is usually imposed by the verbose messages being sent to the tty,
and is entirely trivial compared to the latency involved with the
remote HTTP server sending something as big as a pack file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Acked-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Message fixed, Acked-by added.
 
 No code change from v3.

 http.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 7ee1ba5..95e3b8b 100644
--- a/http.c
+++ b/http.c
@@ -899,7 +899,6 @@ int http_fetch_ref(const char *base, struct ref *ref)
 static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 {
 	int ret = 0;
-	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url = NULL;
 	struct strbuf buf = STRBUF_INIT;
@@ -910,10 +909,10 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	}
 
 	if (http_is_verbose)
-		fprintf(stderr, "Getting index for pack %s\n", hex);
+		fprintf(stderr, "Getting index for pack %s\n", sha1_to_hex(sha1));
 
 	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hex);
+	strbuf_addf(&buf, "objects/pack/pack-%s.idx", sha1_to_hex(sha1));
 	url = strbuf_detach(&buf, NULL);
 
 	filename = sha1_pack_index_name(sha1);
@@ -921,7 +920,6 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 		ret = error("Unable to get pack index %s\n", url);
 
 cleanup:
-	free(hex);
 	free(url);
 	return ret;
 }
-- 
1.7.1.rc1.279.g22727
