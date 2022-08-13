Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1DC19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 22:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiHMWRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiHMWRT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 18:17:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946350185
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 15:17:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DE4D144485;
        Sat, 13 Aug 2022 18:17:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IeJqjxNzJI/FiDE2oRr8rk/gdJj6AI7H+zzTO5
        arpeE=; b=u4yAxafptY0HJRSuXkrnamOutdd6+0ypcdZEBRQt+/DCArBi2f9sw4
        Hd3hyZAoKnFbDwtRwaTcOO1GYw6UcQ1i6/q73aYSUHpuXca1UyI/8LfDxcRakH4k
        ZXLP9auKYW+aGC3ChIk31rgaAUYW8SPtEonj7t9fJx1Z8KVbCw4JE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95E87144483;
        Sat, 13 Aug 2022 18:17:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C74A2144482;
        Sat, 13 Aug 2022 18:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 0/8] cat-file: add --batch-command remote-object-info
 command
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
Date:   Sat, 13 Aug 2022 15:17:12 -0700
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 2 May 2022 17:08:56 +0000")
Message-ID: <xmqqlerr94bb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEDEC2C8-1B55-11ED-B39D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Style and coccinelle fixes; please squash in when you reroll.

 * var = xcalloc(count, sizeof(*var)) --> CALLOC_ARRAY(var, count)
   for count != 1

 * sizeof (type) --> sizeof(type)

Thanks.

 builtin/cat-file.c | 2 +-
 transport.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 57c090f249..4afe82322f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -515,7 +515,7 @@ static int get_remote_info(struct batch_options *opt, int argc, const char **arg
 		size_t j;
 		int include_size = 0, include_type = 0;
 
-		remote_object_info = xcalloc(object_info_oids.nr, sizeof(struct object_info));
+		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
 		gtransport->smart_options->object_info = 1;
 		gtransport->smart_options->object_info_oids = &object_info_oids;
 		/**
diff --git a/transport.c b/transport.c
index 64bcc311ff..87197f0ec7 100644
--- a/transport.c
+++ b/transport.c
@@ -442,7 +442,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
-	struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));
+	struct ref *object_info_refs = xcalloc(1, sizeof(struct ref));
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -479,7 +479,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		args.quiet = 1;
 		args.no_progress = 1;
 		for (i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
-			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
+			struct ref *temp_ref = xcalloc(1, sizeof(struct ref));
 			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
 			temp_ref->exact_oid = 1;
 			ref->next = temp_ref;
-- 
2.37.2-479-gedbcd27e9d

