Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54E31F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEPBqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35696 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfEPAhk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:37:40 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1hR4Ou-0006ek-3w; Thu, 16 May 2019 09:37:36 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 1/2] dup() the input fd for fast-import used for remote helpers
Date:   Thu, 16 May 2019 09:37:35 +0900
Message-Id: <20190516003736.25544-1-mh@glandium.org>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190516003130.racexnofe7cxra3t@glandium.org>
References: <20190516003130.racexnofe7cxra3t@glandium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote helper exposes the "import" capability, stdout of the
helper is sent to stdin of a new fast-import process. This is done by
setting the corresponding child_process's in field to the value of the
out field of the helper child_process.

The child_process API is defined to close the file descriptors it's
given when calling start_command. This means when start_command is
called for the fast-import process, its input fd (the output fd of the
helper), is closed.

But when the transport helper is later destroyed, in disconnect_helper,
its input and output are closed, which means close() is called with
an invalid fd (since it was already closed as per above). Or worse, with
a valid fd owned by something else (since fd numbers can be reused).

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 1f52c95fd8..29787b749e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -421,7 +421,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	struct helper_data *data = transport->data;
 	int cat_blob_fd, code;
 	child_process_init(fastimport);
-	fastimport->in = helper->out;
+	fastimport->in = xdup(helper->out);
 	argv_array_push(&fastimport->args, "fast-import");
 	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
 
-- 
2.21.0.dirty

