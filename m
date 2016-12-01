Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CF51FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758156AbcLABOQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:14:16 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35489 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbcLABON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:14:13 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so42110840pfk.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJsiKK78prHl4I7h7PM3wI+ywjG4hJLf+NGfwEHA5mo=;
        b=EZoNxWoekzTjCy1R0v+eyoLHlDOUYVG0h9E3mP4aN3bfZzblWsmPlh2dDSjmq9HoWt
         r5iWqG+s6tuc+JLIqN4OH36EIQxRkehiP0aFS83tW1+rRXzcdZ+ldOMCaVkvJfAwejq7
         5OYMqPHPKQwSbcQVng/oHvndMey9LTBTX5OPTanhhjoS3TNjr3bby5o6Qj+VleCz0/Lg
         Q809/p+isr0CXd3PuqtWuHFkIBXwI9fjdNW7wSRIjBmreGWCzOwdcwTnb/Q5SXkv47nq
         0sexd7OXRXEfenMxKCj1d5pWf7hSolQHP6gUaeB5PFuNRnESGhTIJRi3SVi/KtHxXLsc
         y36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJsiKK78prHl4I7h7PM3wI+ywjG4hJLf+NGfwEHA5mo=;
        b=WigkJDV0TL9fk6MWqv3OnQtYDlvB+9toCtooq3VH1/0HRAExrQadrKbIyEhUkfLHAd
         AzaEEAioLysFZUpGv5w2yVgHqPg3yqNnvlxty+J9ZId5IbyIDjnzzsVQ62tq/3EB7L31
         XpI1FkXivVrs3epTdGmnJLos06l3QLRkCB27ZuZPKgblT/39pMXA8XTDxGcq1Nw5Y9eA
         p92fUikIFnUEdLcsrj7OlmX7Upm/xmfAwk4lqF1ZZwi3r0uvPU2iwHtOXVu8R8LyJjh2
         iEQCcPoEGZsZng2USnNWKPSNPpak9el8v0S0FFcIkWldg7jL6BtvN2GYKY0Zb7lkeeHb
         K4hQ==
X-Gm-Message-State: AKaTC00zqYsKcfxQeMlDXik7Aj4nbYI1BzwClh/WRFfWUzWwtjmqHKUUlHc7+pBcxvRJ5N9j
X-Received: by 10.99.112.66 with SMTP id a2mr64392125pgn.43.1480554818316;
        Wed, 30 Nov 2016 17:13:38 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.12])
        by smtp.gmail.com with ESMTPSA id z9sm105543800pfd.29.2016.11.30.17.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:13:37 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, barkalow@iabervon.org
Subject: [PATCH] transport-helper: drop broken "unchanged" feature
Date:   Wed, 30 Nov 2016 17:13:34 -0800
Message-Id: <1480554814-28596-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480553664-12804-1-git-send-email-jonathantanmy@google.com>
References: <1480553664-12804-1-git-send-email-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit f8ec916 ("Allow helpers to report in "list" command that the ref
is unchanged", 2009-11-17) allowed a remote helper to report that a ref
is unchanged even if it did not know the contents of a ref. However,
that commit also made Git wrongly assume that such a remote ref always
has the contents of the local ref of the same name.

(Git also cannot assume that the remote ref has the value of the current
destination local ref, or any other ref, since the previous import/fetch
could have been made using a different refspec.)

Drop that assumption.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Here is a patch that would remove the assumption (if it is indeed
wrong).

 Documentation/gitremote-helpers.txt |  3 +++
 transport-helper.c                  | 43 -------------------------------------
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 9e8681f..c862339 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -393,6 +393,9 @@ attributes are defined.
 'unchanged'::
 	This ref is unchanged since the last import or fetch, although
 	the helper cannot necessarily determine what value that produced.
+	Git may import or fetch this ref anyway, because it does not
+	keep a record of the last values corresponding to the refs of a
+	specific remote.
 
 OPTIONS
 -------
diff --git a/transport-helper.c b/transport-helper.c
index 91aed35..6ab8e2f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -392,9 +392,6 @@ static int fetch_with_fetch(struct transport *transport,
 
 	for (i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
-		if (posn->status & REF_STATUS_UPTODATE)
-			continue;
-
 		strbuf_addf(&buf, "fetch %s %s\n",
 			    oid_to_hex(&posn->old_oid),
 			    posn->symref ? posn->symref : posn->name);
@@ -492,9 +489,6 @@ static int fetch_with_import(struct transport *transport,
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
-		if (posn->status & REF_STATUS_UPTODATE)
-			continue;
-
 		strbuf_addf(&buf, "import %s\n",
 			    posn->symref ? posn->symref : posn->name);
 		sendline(data, &buf);
@@ -531,8 +525,6 @@ static int fetch_with_import(struct transport *transport,
 	for (i = 0; i < nr_heads; i++) {
 		char *private, *name;
 		posn = to_fetch[i];
-		if (posn->status & REF_STATUS_UPTODATE)
-			continue;
 		name = posn->symref ? posn->symref : posn->name;
 		if (data->refspecs)
 			private = apply_refspecs(data->refspecs, data->refspec_nr, name);
@@ -649,21 +641,12 @@ static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
-	int i, count;
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
 		return transport->fetch(transport, nr_heads, to_fetch);
 	}
 
-	count = 0;
-	for (i = 0; i < nr_heads; i++)
-		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
-			count++;
-
-	if (!count)
-		return 0;
-
 	if (data->check_connectivity &&
 	    data->transport_options.check_self_contained_and_connected)
 		set_helper_option(transport, "check-connectivity", "true");
@@ -1009,23 +992,6 @@ static int push_refs(struct transport *transport,
 	return -1;
 }
 
-
-static int has_attribute(const char *attrs, const char *attr) {
-	int len;
-	if (!attrs)
-		return 0;
-
-	len = strlen(attr);
-	for (;;) {
-		const char *space = strchrnul(attrs, ' ');
-		if (len == space - attrs && !strncmp(attrs, attr, len))
-			return 1;
-		if (!*space)
-			return 0;
-		attrs = space + 1;
-	}
-}
-
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
 	struct helper_data *data = transport->data;
@@ -1067,15 +1033,6 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
 			get_oid_hex(buf.buf, &(*tail)->old_oid);
-		if (eon) {
-			if (has_attribute(eon + 1, "unchanged")) {
-				(*tail)->status |= REF_STATUS_UPTODATE;
-				if (read_ref((*tail)->name,
-					     (*tail)->old_oid.hash) < 0)
-					die(_("Could not read ref %s"),
-					    (*tail)->name);
-			}
-		}
 		tail = &((*tail)->next);
 	}
 	if (debug)
-- 
2.8.0.rc3.226.g39d4020

