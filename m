From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/18] http-walker: verify remote packs
Date: Sun, 24 May 2009 22:19:42 +0800
Message-ID: <20090524221942.8093fbe2.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eak-0005ol-VY
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZEXOVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZEXOVf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:35 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbZEXOVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:33 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ZyqN90z5sS6RVXVglVQRw3s8Nvep9SwodDgVhkwkWlQ=;
        b=PPhoXwOTNAzjott+HZabPA33xO1geu+xirB4AvqwkLf+ZUgRtnstusXoSqbMWd0nqx
         6iGn4KGrhUd733uejZhBTBmWlHUDQh1YL8sTYwVd6ft20lmtjeAt6YiIwHF3zm4X1u5v
         g8YrVfiq8WEtdHWJONgaq6SiIQRZDneGic17o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=VFzS55IYA1r1miD3HVk2xoxes1JkwHc4oUTS+Lg3Gp9ZVAlVmhDCfh+FW+NTzg1t9C
         mB5+Zg7HtBydsDKnIaXR7bh3Veo/lnAvIHm70lrip4gbyPodvt4BQa7NxbbJYPB8Q8JL
         pMrwEGGRgjtOyRhsXgbfjlcR/xpyVhGlrzrtU=
Received: by 10.114.152.17 with SMTP id z17mr12605651wad.91.1243174895404;
        Sun, 24 May 2009 07:21:35 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id j34sm6729304waf.64.2009.05.24.07.21.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:34 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119831>

In c17fb6e ("Verify remote packs, speed up pending request queue"),
changes were made to index fetching in http-push.c, particularly the
methods fetch_index and setup_index. Since http-walker.c has similar
code for index fetching, these improvements should apply to
http-walker.c's fetch_index and setup_index.

Invocations of free() of string memory are reproduced as well.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-walker.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index dffb844..13ca934 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -384,24 +384,48 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	struct active_request_slot *slot;
 	struct slot_results results;

-	if (has_pack_index(sha1))
+	/* Don't use the index if the pack isn't there */
+	url = xmalloc(strlen(repo->base) + 64);
+	sprintf(url, "%s/objects/pack/pack-%s.pack", repo->base, hex);
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			free(url);
+			return error("Unable to verify pack %s is available",
+				     hex);
+		}
+	} else {
+		free(url);
+		return error("Unable to start request");
+	}
+
+	if (has_pack_index(sha1)) {
+		free(url);
 		return 0;
+	}

 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);

-	url = xmalloc(strlen(repo->base) + 64);
 	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);

 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
 	indexfile = fopen(tmpfile, "a");
-	if (!indexfile)
+	if (!indexfile) {
+		free(url);
 		return error("Unable to open local file %s for pack index",
 			     tmpfile);
+	}

 	slot = get_active_slot();
 	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -426,15 +450,18 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
+			free(url);
 			fclose(indexfile);
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
+		free(url);
 		fclose(indexfile);
 		return error("Unable to start request");
 	}

+	free(url);
 	fclose(indexfile);

 	return move_temp_to_file(tmpfile, filename);
--
1.6.3.1
