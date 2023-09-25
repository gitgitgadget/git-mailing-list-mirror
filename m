Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3428CE79A1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 21:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjIYVeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjIYVeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 17:34:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10F116
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 14:34:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F37571B981F;
        Mon, 25 Sep 2023 17:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=e6FfpmMygHzjY1zGNqf5D9+5ceMgEfoQAIURlZ
        YHZHc=; b=QYDAR8LoIB62Gk7xV8MdiosJuENWJpfWgRbfOzs9jAlYAvUy0VxLn9
        sLfcdPSsSmSZoAcFlL+wE9rYyTK0LiC9I/ERIgKVqsacy4a8y2ZQSGcbHsUVm+eE
        TJ1xLIpFGLeM/jEqKfH+RYDiDTu4aL5fzji1HdmTzHkrHHPO/to2E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBC0D1B981E;
        Mon, 25 Sep 2023 17:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 587511B981D;
        Mon, 25 Sep 2023 17:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 2/3] transport-helper: run do_take_over in
 connect_helper
In-Reply-To: <20230923152201.14741-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 23 Sep 2023 23:22:00 +0800")
References: <xmqqy1h2f5dv.fsf@gitster.g>
        <20230923152201.14741-3-worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 14:34:35 -0700
Message-ID: <xmqqil7yq6ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 530C3746-5BEB-11EE-BFB4-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> After successfully connecting to the smart transport by calling
> "process_connect_service()" in "connect_helper()", run "do_take_over()"
> to replace the old vtable with a new one which has methods ready for
> the smart transport connection.

The existing pattern among all callers of process_connect() seems to
be

	if (process_connect(...)) {
		do_take_over();
		... dispatch to the underlying method ...
	}
	... otherwise implement the fallback ...

where the return value from process_connect() is the return value of
the call it makes to process_connect_service().

And the only other caller of process_connect_service() is
connect_helper(), so in that sense, making a call to do_take_over()
when process_connect_service() succeeds in the helper does make
things consistent.  The connect_helper() function being static, the
helper transport is the only transport that gets affected, but how
has it been working without having this do_take_over() step?  An
obvious related question is if it has been working so far, would it
break if we have do_take_over() added here?


In any case, this makes me wonder if we should do the following
patch to help developers who may want to add new callers to
process_connect_service() by adding calls to process_connect().

 transport-helper.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git c/transport-helper.c w/transport-helper.c
index 91381be622..566f7473df 100644
--- c/transport-helper.c
+++ w/transport-helper.c
@@ -646,6 +646,7 @@ static int process_connect(struct transport *transport,
 	struct helper_data *data = transport->data;
 	const char *name;
 	const char *exec;
+	int ret;
 
 	name = for_push ? "git-receive-pack" : "git-upload-pack";
 	if (for_push)
@@ -653,7 +654,10 @@ static int process_connect(struct transport *transport,
 	else
 		exec = data->transport_options.uploadpack;
 
-	return process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, name, exec);
+	if (ret)
+		do_take_over(transport);
+	return ret;
 }
 
 static int connect_helper(struct transport *transport, const char *name,
@@ -685,10 +689,8 @@ static int fetch_refs(struct transport *transport,
 
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->fetch_refs(transport, nr_heads, to_fetch);
-	}
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
@@ -1145,10 +1147,8 @@ static int push_refs(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 
-	if (process_connect(transport, 1)) {
-		do_take_over(transport);
+	if (process_connect(transport, 1))
 		return transport->vtable->push_refs(transport, remote_refs, flags);
-	}
 
 	if (!remote_refs) {
 		fprintf(stderr,
@@ -1189,11 +1189,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 {
 	get_helper(transport);
 
-	if (process_connect(transport, for_push)) {
-		do_take_over(transport);
+	if (process_connect(transport, for_push))
 		return transport->vtable->get_refs_list(transport, for_push,
 							transport_options);
-	}
 
 	return get_refs_list_using_list(transport, for_push);
 }
@@ -1277,10 +1275,8 @@ static int get_bundle_uri(struct transport *transport)
 {
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->get_bundle_uri(transport);
-	}
 
 	return -1;
 }

