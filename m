From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] fetch: work around "transport-take-over" hack
Date: Wed,  7 Aug 2013 16:30:42 -0700
Message-ID: <1375918242-4655-6-git-send-email-gitster@pobox.com>
References: <1375918242-4655-1-git-send-email-gitster@pobox.com>
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:31:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7DCG-0005Nz-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933722Ab3HGXa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 19:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933609Ab3HGXa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 19:30:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9793F37FAB;
	Wed,  7 Aug 2013 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Z0kP
	3Rr3ITONpu8b1++pung7rI4=; b=pI2G922Gm84Bo6qWg+JILSC9GHi78ftdet1X
	6GQFy1TMKJXi+UcAlqlhUtF5O/6GoEQziTYaukWygz87dN4IQrOMtbOmdsvdAmcf
	ceP3NV5q1RLWtebFdm0cMoyt4fM+p6ROyTUEygnpZ4Fa1A+n85U5Ftoqqqd81HGm
	pXQaDjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	EIYYFP3/SQfp3swr1Gl1C18/Xq9ZzPE5A7Eykllta1HjEprBtvh6hDPyruEdtixL
	xpViLOTOxcTT0t9nU84i0QfQq9OD0vsCwyo8B/kBprO1BrdP5O7Kmx7H1CRaIQyS
	+UWd1LsaUU+Bl1cEJbMEOCTr6Rbhpq5GlEQIiiwTsz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE4337FAA;
	Wed,  7 Aug 2013 23:30:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9700437FA8;
	Wed,  7 Aug 2013 23:30:55 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375918242-4655-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 682B83BE-FFB9-11E2-9E0F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231851>

A Git-aware "connect" transport allows the "transport_take_over" to
redirect generic transport requests like fetch(), push_refs() and
get_refs_list() to the native Git transport handling methods.  The
take-over process replaces transport->data with a fake data that
these method implementations understand.

While this hack works OK for a single request, it breaks when the
transport needs to make more than one requests.  transport->data
that used to hold necessary information for the specific helper to
work correctly is destroyed during the take-over process.

One codepath that this matters is "git fetch" in auto-follow mode;
when it does not get all the tags that ought to point at the history
it got (which can be determined by looking at the peeled tags in the
initial advertisement) from the primary transfer, it internally
makes a second request to complete the fetch.  Because "take-over"
hack has already destroyed the data necessary to talk to the
transport helper by the time this happens, the second request cannot
make a request to the helper to make another connection to fetch
these additional tags.

Mark such a transport as "cannot_reuse", and use a separate
transport to perform the backfill fetch in order to work around
this breakage.

Note that this problem does not manifest itself when running t5802,
because our upload-pack gives you all the necessary auto-followed
tags during the primary transfer.  You would need to step through
"git fetch" in a debugger, stop immediately after the primary
transfer finishes and writes these auto-followed tags, remove the
tag references and repack/prune the repository to convince the
"find-non-local-tags" procedure that the primary transfer failed to
give us all the necessary tags, and then let it continue, in order
to trigger the bug in the secondary transfer this patch fixes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 13 +++++++++++++
 transport.c     |  2 ++
 transport.h     |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0b21f07..57ab7e4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
+static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 
@@ -97,6 +98,8 @@ static void unlock_pack(void)
 {
 	if (gtransport)
 		transport_unlock_pack(gtransport);
+	if (gsecondary)
+		transport_unlock_pack(gsecondary);
 }
 
 static void unlock_pack_on_signal(int signo)
@@ -747,9 +750,19 @@ struct transport *prepare_transport(struct remote *remote)
 
 static void backfill_tags(struct transport *transport, struct ref *ref_map)
 {
+	if (transport->cannot_reuse) {
+		gsecondary = prepare_transport(transport->remote);
+		transport = gsecondary;
+	}
+
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	fetch_refs(transport, ref_map);
+
+	if (gsecondary) {
+		transport_disconnect(gsecondary);
+		gsecondary = NULL;
+	}
 }
 
 static int do_fetch(struct transport *transport,
diff --git a/transport.c b/transport.c
index e15db98..de25588 100644
--- a/transport.c
+++ b/transport.c
@@ -875,6 +875,8 @@ void transport_take_over(struct transport *transport,
 	transport->push_refs = git_transport_push;
 	transport->disconnect = disconnect_git;
 	transport->smart_options = &(data->options);
+
+	transport->cannot_reuse = 1;
 }
 
 static int is_local(const char *url)
diff --git a/transport.h b/transport.h
index ea70ea7..96e0ede 100644
--- a/transport.h
+++ b/transport.h
@@ -27,6 +27,12 @@ struct transport {
 	 */
 	unsigned got_remote_refs : 1;
 
+	/*
+	 * Transports that call take-over destroys the data specific to
+	 * the transport type while doing so, and cannot be reused.
+	 */
+	unsigned cannot_reuse : 1;
+
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
-- 
1.8.4-rc1-210-gf6d87e2
