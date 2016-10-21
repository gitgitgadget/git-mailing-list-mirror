Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF66620229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935305AbcJUWjh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:39:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59179 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935082AbcJUWjg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:39:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 313E14860A;
        Fri, 21 Oct 2016 18:39:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=sdsd
        R0cUfCNj/9EJJgw6mPibcQk=; b=DMBPOJBIjNYR9peeiYKhwKCLQ5TCn3MlGr0p
        cjHJLGMgUkgFof44qfimr47Y1peMB+YyV7k9x9AUj+6kuyz1JemGxuUmiVGzioB3
        WeqHDJfaNn+9ItnqvvYq5CZ2SbtiELJOwpxZsh6mK5hDKgb3iF6Ooww/RJuBUC7C
        XTFDuRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=v4HFCj
        PRXe7S8H1xc+WE/MR7m03nLGf6z65CqE124B4rkJQZU/x+AZkIC8PuLUbvmDJIIr
        L6uq3xto/jTSuLhMgT1gtu6gox/UxxN1XFjBerM47y1wWhCgZf2UUwv/2KfUfUQr
        dP5RZjWhcdwbUNY3WgGaALI2/3QwVjfBnhIDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 292AF48609;
        Fri, 21 Oct 2016 18:39:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BD9948608;
        Fri, 21 Oct 2016 18:39:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] fetch: pass summary_width down the callchain
Date:   Fri, 21 Oct 2016 15:39:26 -0700
Message-Id: <20161021223927.26364-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-723-g2384e83bc3
In-Reply-To: <20161021223927.26364-1-gitster@pobox.com>
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
 <20161021223927.26364-1-gitster@pobox.com>
X-Pobox-Relay-ID: 3D698C68-97DF-11E6-913C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The leaf function on the "fetch" side that uses TRANSPORT_SUMMARY_WIDTH
constant is builtin/fetch.c::format_display() and it has two distinct
callchains.  The one that reports the primary result of fetch originates
at store_updated_refs(); the other one that reports the pruning of
the remote-tracking refs originates at prune_refs().

Teach these two places to pass summary_width down the callchain,
just like we did for the "push" side in the previous commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a9f12cc5cf..40696e5338 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -17,9 +17,6 @@
 #include "argv-array.h"
 #include "utf8.h"
 
-#define TRANSPORT_SUMMARY(x) \
-	(int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
 	N_("git fetch [<options>] <group>"),
@@ -569,9 +566,12 @@ static void print_compact(struct strbuf *display,
 
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
-			   const char *remote, const char *local)
+			   const char *remote, const char *local,
+			   int summary_width)
 {
-	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
+	int width = (summary_width + strlen(summary) - gettext_width(summary));
+
+	strbuf_addf(display, "%c %-*s ", code, width, summary);
 	if (!compact_format)
 		print_remote_to_local(display, remote, local);
 	else
@@ -583,7 +583,8 @@ static void format_display(struct strbuf *display, char code,
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
 			    const struct ref *remote_ref,
-			    struct strbuf *display)
+			    struct strbuf *display,
+			    int summary_width)
 {
 	struct commit *current = NULL, *updated;
 	enum object_type type;
@@ -597,7 +598,7 @@ static int update_local_ref(struct ref *ref,
 	if (!oidcmp(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			format_display(display, '=', _("[up to date]"), NULL,
-				       remote, pretty_ref);
+				       remote, pretty_ref, summary_width);
 		return 0;
 	}
 
@@ -611,7 +612,7 @@ static int update_local_ref(struct ref *ref,
 		 */
 		format_display(display, '!', _("[rejected]"),
 			       _("can't fetch in current branch"),
-			       remote, pretty_ref);
+			       remote, pretty_ref, summary_width);
 		return 1;
 	}
 
@@ -621,7 +622,7 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref("updating tag", ref, 0);
 		format_display(display, r ? '!' : 't', _("[tag update]"),
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref);
+			       remote, pretty_ref, summary_width);
 		return r;
 	}
 
@@ -654,7 +655,7 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref);
+			       remote, pretty_ref, summary_width);
 		return r;
 	}
 
@@ -670,7 +671,7 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref);
+			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -685,12 +686,12 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
-			       remote, pretty_ref);
+			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
 		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
-			       remote, pretty_ref);
+			       remote, pretty_ref, summary_width);
 		return 1;
 	}
 }
@@ -721,6 +722,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	char *url;
 	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
+	int summary_width = TRANSPORT_SUMMARY_WIDTH;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -830,13 +832,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 			strbuf_reset(&note);
 			if (ref) {
-				rc |= update_local_ref(ref, what, rm, &note);
+				rc |= update_local_ref(ref, what, rm, &note,
+						       summary_width);
 				free(ref);
 			} else
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
-					       "FETCH_HEAD");
+					       "FETCH_HEAD", summary_width);
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
@@ -903,6 +906,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 	int url_len, i, result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
 	char *url;
+	int summary_width = TRANSPORT_SUMMARY_WIDTH;
 	const char *dangling_msg = dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
@@ -938,7 +942,8 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 				shown_url = 1;
 			}
 			format_display(&sb, '-', _("[deleted]"), NULL,
-				       _("(none)"), prettify_refname(ref->name));
+				       _("(none)"), prettify_refname(ref->name),
+				       summary_width);
 			fprintf(stderr, " %s\n",sb.buf);
 			strbuf_release(&sb);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
-- 
2.10.1-723-g2384e83bc3

