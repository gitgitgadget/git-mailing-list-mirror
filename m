From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 08/23] http-walker: verify remote packs
Date: Sat, 6 Jun 2009 00:04:43 +0800
Message-ID: <20090606000443.cb6cc2ad.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzD-00053w-SJ
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZFEQIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbZFEQIi
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:38 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:50429 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbZFEQIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:38 -0400
Received: by mail-px0-f202.google.com with SMTP id 40so80522pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ZdhmepjALGcaJF5K2YLjKb2yDprHQgmOtu+uGTLNdgU=;
        b=Z0/Zzsku5+wI2yZso1mtnr0tYF61YdgBxY3qpZK2O9PGHYhw5OIVZhSCe7I8rhd0FL
         rQ/YXKxGzHXAbE1hK7Ebn/Rehzbb2qJQeL1Uwh66/LLiLwFSwREjOANLttMGcQSpiJvi
         GggjP/7xHh/g/Qq7iHe2syyKVd88wRts65aOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=FTSKlze8UBLbyoUG/eNMdGDgXLkeeLxg5J/h7ti+TsYAe1kWzrRTbBvMP+EtcdkkSc
         2EVZiVja2KgaUEssNmGn4LRJcx8xaRivkMdK/cU78EYor13jzm4Rz4OvwD4mCLN4RUT+
         yGEETyWkMSEn55VWliPPWWzlJdSMzcRYpdWGg=
Received: by 10.142.226.7 with SMTP id y7mr192313wfg.180.1244218118847;
        Fri, 05 Jun 2009 09:08:38 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm409050wfg.30.2009.06.05.09.08.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:38 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120787>

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
index 6ac1783..bbc3023 100644
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
@@ -426,17 +450,20 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
+			free(url);
 			fclose(indexfile);
 			slot->local = NULL;
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
+		free(url);
 		fclose(indexfile);
 		slot->local = NULL;
 		return error("Unable to start request");
 	}

+	free(url);
 	fclose(indexfile);
 	slot->local = NULL;

--
1.6.3.1
