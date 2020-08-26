Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1176AC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD34D2087D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 21:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HExYyPgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHZVhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:37:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63155 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZVhm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 17:37:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C6A87FB0F;
        Wed, 26 Aug 2020 17:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:cc:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eCMO6rKSlsX+LyNj6fUSRcEpMjg=; b=HExYyP
        gPDCQoz2Xx7Gz8MRy2L7BlbclVBRwhttf8DTsVUNBQ+V5eGoi7ECRfvTtdOEXO15
        h5quRYOUYgwe9/cCGnEMBWNGqYSPNQjQdwvgIkoGbqoKXWtVFXruO/Ni+d3vD0IZ
        a+Nlz4RrPDS/+g7/fKDuSaDf/+YdDiSy0a3UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:cc:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nzdgE4bUPs7iOoUYkFA4gHa//HJJCcNn
        nDrS5DWBkwdUpUyvIVdMd7vb0mRetuW+8v6LFoQQ+W1pgh5BtAPcXmVHdPCjDOC8
        J6I8nSfBdeUPWN/Qb4RTNAUszpuM18US95/OwciQKVEJ31eItJ9c0wGsTuHl8dAH
        7eSoLZcCshw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 750EE7FB0E;
        Wed, 26 Aug 2020 17:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0204F7FB0D;
        Wed, 26 Aug 2020 17:37:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/2] credential-cache: use child_process.args
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <20200826194650.4031087-3-gitster@pobox.com>
cc:     Jeff King <peff@peff.net>
Date:   Wed, 26 Aug 2020 14:37:39 -0700
In-Reply-To: <20200826194650.4031087-3-gitster@pobox.com> (Junio C. Hamano's
        message of "Wed, 26 Aug 2020 12:46:50 -0700")
Message-ID: <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DC9648E-E7E4-11EA-90C3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As child_process structure has an embedded strvec args for
formulating the command line, let's use it instead of using
an out-of-line argv[] whose length needs to be maintained
correctly. 

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/credential-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index d0fafdeb9e..195335a783 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -42,13 +42,13 @@ static int send_request(const char *socket, const struct strbuf *out)
 static void spawn_daemon(const char *socket)
 {
 	struct child_process daemon = CHILD_PROCESS_INIT;
-	const char *argv[] = { NULL, NULL, NULL };
 	char buf[128];
 	int r;
 
-	argv[0] = "git-credential-cache--daemon";
-	argv[1] = socket;
-	daemon.argv = argv;
+	strvec_pushl(&daemon.args, 
+		     "credential-cache--daemon", socket,
+		     NULL);
+	daemon.git_cmd = 1;
 	daemon.no_stdin = 1;
 	daemon.out = -1;
 
