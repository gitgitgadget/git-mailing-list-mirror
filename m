Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9031C20229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935544AbcJUWjl (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:39:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935125AbcJUWjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:39:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCE4A48E70;
        Fri, 21 Oct 2016 18:39:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=AgDT
        FROk3EzIesFcGLyeDdHUClQ=; b=yksyMfjGZPBLesG+d474tp//JcfHwgeKtq6n
        Xqx26wbveosEbLcUBue5hLwjOmpUdmEd6+gSoOhpl2hpmpFfj74QKhozqLqkdPzR
        GHJe2XHphHkyI65CNWzWh+2wbC3ScAE6La2o0OeEvib0O72qi6Q4XQnTyU4HB4PT
        9iuxEy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=UmvZgo
        Ck2QIzRWMwjt3JT6he3S7RtiyNz1sEMa3QKYmiwQ+5uwuAqbxffyoMywr9kbGAQE
        9P4ay/olFQzb1fyKPZBdn1OwD2536fw+pazLBydTdw70oxKXBnooc2DVMnxK2C9z
        Esi1PvTaC+DJR0OgvqtHE8GFLIHwzcuqrgjDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C112C48E6F;
        Fri, 21 Oct 2016 18:39:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16AA848E6C;
        Fri, 21 Oct 2016 18:39:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] transport: pass summary_width down the callchain
Date:   Fri, 21 Oct 2016 15:39:25 -0700
Message-Id: <20161021223927.26364-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-723-g2384e83bc3
In-Reply-To: <20161021223927.26364-1-gitster@pobox.com>
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
 <20161021223927.26364-1-gitster@pobox.com>
X-Pobox-Relay-ID: 3BF8FC92-97DF-11E6-AB5C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callchain that originates at transport_print_push_status()
eventually hits a single leaf function, print_ref_status(), that is
used to show from what old object to what new object a ref got
updated, and the width of the part that shows old and new object
names used a constant TRANSPORT_SUMMARY_WIDTH.

Teach the callchain to pass the width down from the top instead.
This allows a future enhancement to compute the necessary display
width before calling down this callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport.c | 63 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/transport.c b/transport.c
index 94d6dc3725..ec02b78924 100644
--- a/transport.c
+++ b/transport.c
@@ -295,7 +295,9 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 	}
 }
 
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg, int porcelain)
+static void print_ref_status(char flag, const char *summary,
+			     struct ref *to, struct ref *from, const char *msg,
+			     int porcelain, int summary_width)
 {
 	if (porcelain) {
 		if (from)
@@ -307,7 +309,7 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summary);
+		fprintf(stderr, " %c %-*s ", flag, summary_width, summary);
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 		else
@@ -321,15 +323,16 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 	}
 }
 
-static void print_ok_ref_status(struct ref *ref, int porcelain)
+static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
 {
 	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
+		print_ref_status('-', "[deleted]", ref, NULL, NULL,
+				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
 			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
 			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain);
+			ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
@@ -349,12 +352,14 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash,
 					 DEFAULT_ABBREV);
 
-		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg, porcelain);
+		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
+				 porcelain, summary_width);
 		strbuf_release(&quickref);
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
+static int print_one_push_status(struct ref *ref, const char *dest, int count,
+				 int porcelain, int summary_width)
 {
 	if (!count) {
 		char *url = transport_anonymize_url(dest);
@@ -364,56 +369,60 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL, porcelain);
+		print_ref_status('X', "[no match]", ref, NULL, NULL,
+				 porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
 		print_ref_status('!', "[rejected]", ref, NULL,
-						 "remote does not support deleting refs", porcelain);
+				 "remote does not support deleting refs",
+				 porcelain, summary_width);
 		break;
 	case REF_STATUS_UPTODATE:
 		print_ref_status('=', "[up to date]", ref,
-						 ref->peer_ref, NULL, porcelain);
+				 ref->peer_ref, NULL, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "non-fast-forward", porcelain);
+				 "non-fast-forward", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_ALREADY_EXISTS:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "already exists", porcelain);
+				 "already exists", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_FETCH_FIRST:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "fetch first", porcelain);
+				 "fetch first", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "needs force", porcelain);
+				 "needs force", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_STALE:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "stale info", porcelain);
+				 "stale info", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "new shallow roots not allowed", porcelain);
+				 "new shallow roots not allowed",
+				 porcelain, summary_width);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
-						 ref->deletion ? NULL : ref->peer_ref,
-						 ref->remote_status, porcelain);
+				 ref->deletion ? NULL : ref->peer_ref,
+				 ref->remote_status, porcelain, summary_width);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
 		print_ref_status('!', "[remote failure]", ref,
-						 ref->deletion ? NULL : ref->peer_ref,
-						 "remote failed to report status", porcelain);
+				 ref->deletion ? NULL : ref->peer_ref,
+				 "remote failed to report status",
+				 porcelain, summary_width);
 		break;
 	case REF_STATUS_ATOMIC_PUSH_FAILED:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "atomic push failed", porcelain);
+				 "atomic push failed", porcelain, summary_width);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain);
+		print_ok_ref_status(ref, porcelain, summary_width);
 		break;
 	}
 
@@ -427,25 +436,29 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	int n = 0;
 	unsigned char head_sha1[20];
 	char *head;
+	int summary_width = TRANSPORT_SUMMARY_WIDTH;
 
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n, porcelain);
+				n += print_one_push_status(ref, dest, n,
+							   porcelain, summary_width);
 	}
 
 	for (ref = refs; ref; ref = ref->next)
 		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n,
+						   porcelain, summary_width);
 
 	*reject_reasons = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n,
+						   porcelain, summary_width);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
 			if (head != NULL && !strcmp(head, ref->name))
 				*reject_reasons |= REJECT_NON_FF_HEAD;
-- 
2.10.1-723-g2384e83bc3

