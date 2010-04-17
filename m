From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 06/11] http.c: Remove unnecessary strdup of sha1_to_hex result
Date: Sat, 17 Apr 2010 13:07:39 -0700
Message-ID: <1271534864-31944-6-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJn-0005p7-BN
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab0DQUIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:10 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:57482 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab0DQUH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:58 -0400
Received: by gxk9 with SMTP id 9so2216648gxk.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:57 -0700 (PDT)
Received: by 10.101.134.35 with SMTP id l35mr8133583ann.23.1271534877191;
        Sat, 17 Apr 2010 13:07:57 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 26sm26785216anx.3.2010.04.17.13.07.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145184>

Most of the time the dumb HTTP transport is run without the verbose
flag set, so we only need the result of sha1_to_hex(sha1) once, to
construct the pack URL.  Don't bother with an unnecessary malloc,
copy, free chain of this buffer.

If verbose is set, we'll format the SHA-1 twice now.  But this
tiny extra CPU time spent is nothing compared to the slowdown that
is usually imposed by the verbose messages being sent to the tty,
and its entirely trivial compared to the latency involved with the
remote HTTP server sending something as big as a pack file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index c75eb95..1a52740 100644
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
1.7.1.rc1.269.ga27c7
