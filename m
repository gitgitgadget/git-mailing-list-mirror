Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A19C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 19:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhLNTqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 14:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhLNTqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 14:46:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED058C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 11:46:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so67249284eds.10
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKt8odgH63hyYkY/n/KDncKpXfxmSozNWVH50HFHlwY=;
        b=IOmp2zoNowtjoAv+v2JOtRgYIZW11mjQIH5O4aJp1GQu/lapDBfP+xIt+jV6tW2Lpd
         na2uptwS/A1FFjWsWzdkx5zMceiEf+xNgf3GPYCCornV7fY1H8RzBd7t7bZlswrPzAVY
         dK1fTJ3egRS8eynw1LcnGtHJc7n58VHzu/Mu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKt8odgH63hyYkY/n/KDncKpXfxmSozNWVH50HFHlwY=;
        b=mhYBguW1iO3eDAZjkF7FYXfs6YOFoFeR5o7KdsXS/5u118AYNkLLEP3UzBis7vzGVP
         FWnrisKe5Yw1zh4/AVd8Ibhe13tmkUDncsmqySk5SrCh5dG5I2OKBCUE1EPOeZPlNsKQ
         mf7mJhYJLwNVVeAzwGmNiLjgrALSidZTRGx46EvcZRud0o3PipHgq8455aFTjFCVkaIJ
         vUI+109nkuyIHMqA4dDswSqo54RxnuWRh8bQ3uz3HT5UKBC+/qYcdSckZFWL0krSEYNx
         rIuufl5S5+Sh/HZLU+oY5QuOfN44+jj3+InfGaEk3kgWO86pMEsGhYMTbhXzaL6r8iMy
         gH7Q==
X-Gm-Message-State: AOAM531f7IWd1fqtgo0TnbFi0Bhbrbaw08bhRKArYDIRHtnR26HnTLwH
        n09MylvWVi0GzhKx/+6Irps7H2mbYJjrLw==
X-Google-Smtp-Source: ABdhPJwc4WzR1wKiFxY+y2YV+YRaoq+Kvz6XlWwm0FfdGvmKuRIY0OMn8YoVeqq0/48LMYbeYgrjXA==
X-Received: by 2002:a17:907:c22:: with SMTP id ga34mr7742622ejc.217.1639511211977;
        Tue, 14 Dec 2021 11:46:51 -0800 (PST)
Received: from localhost.localdomain (a164154.upc-a.chello.nl. [62.163.164.154])
        by smtp.gmail.com with ESMTPSA id hz2sm229518ejc.141.2021.12.14.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:46:51 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v2 1/1] upload-pack.c: increase output buffer size
Date:   Tue, 14 Dec 2021 20:46:26 +0100
Message-Id: <20211214194626.33814-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214194626.33814-1-jacob@gitlab.com>
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
 <20211214194626.33814-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When serving a fetch, git upload-pack copies data from a git
pack-objects stdout pipe to its stdout. This commit increases the size
of the buffer used for that copying from 8192 to 65515, the maximum
sideband-64k packet size.

Previously, this buffer was allocated on the stack. Because the new
buffer size is nearly 64KB, we switch this to a heap allocation.

On GitLab.com we use GitLab's pack-objects cache which does writes of
65515 bytes. Because of the default 8KB buffer size, propagating these
cache writes requires 8 pipe reads and 8 pipe writes from
git-upload-pack, and 8 pipe reads from Gitaly (our Git RPC service).
If we increase the size of the buffer to the maximum Git packet size,
we need only 1 pipe read and 1 pipe write in git-upload-pack, and 1
pipe read in Gitaly to transfer the same amount of data. In benchmarks
with a pure fetch and 100% cache hit rate workload we are seeing CPU
utilization reductions of over 30%.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 upload-pack.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index c78d55bc67..3b90fb69e6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -194,7 +194,13 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 }
 
 struct output_state {
-	char buffer[8193];
+	/*
+	 * We do writes no bigger than LARGE_PACKET_DATA_MAX - 1, because with
+	 * sideband-64k the band designator takes up 1 byte of space. Because
+	 * relay_pack_data keeps the last byte to itself, we make the buffer 1
+	 * byte bigger than the intended maximum write size.
+	 */
+	char buffer[(LARGE_PACKET_DATA_MAX - 1) + 1];
 	int used;
 	unsigned packfile_uris_started : 1;
 	unsigned packfile_started : 1;
@@ -269,7 +275,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			     const struct string_list *uri_protocols)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	struct output_state output_state = { { 0 } };
+	struct output_state *output_state = xcalloc(1, sizeof(struct output_state));
 	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
@@ -404,7 +410,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			int result = relay_pack_data(pack_objects.out,
-						     &output_state,
+						     output_state,
 						     pack_data->use_sideband,
 						     !!uri_protocols);
 
@@ -438,11 +444,12 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	}
 
 	/* flush the data */
-	if (output_state.used > 0) {
-		send_client_data(1, output_state.buffer, output_state.used,
+	if (output_state->used > 0) {
+		send_client_data(1, output_state->buffer, output_state->used,
 				 pack_data->use_sideband);
 		fprintf(stderr, "flushed.\n");
 	}
+	free(output_state);
 	if (pack_data->use_sideband)
 		packet_flush(1);
 	return;
-- 
2.33.0

