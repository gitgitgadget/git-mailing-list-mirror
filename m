Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0712202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 06:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdIUGZp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:25:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:45724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751669AbdIUGZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:25:44 -0400
Received: (qmail 6150 invoked by uid 109); 21 Sep 2017 06:25:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 06:25:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20074 invoked by uid 111); 21 Sep 2017 06:26:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 02:26:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 02:25:41 -0400
Date:   Thu, 21 Sep 2017 02:25:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] consistently use "fallthrough" comments in switches
Message-ID: <20170921062541.ew67gyvrmb2ot4sf@sigill.intra.peff.net>
References: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gcc 7 adds -Wimplicit-fallthrough, which can warn when a
switch case falls through to the next case. The general idea
is that the compiler can't tell if this was intentional or
not, so you should annotate any intentional fall-throughs as
such, leaving it to complain about any unannotated ones.

There's a GNU __attribute__ which can be used for
annotation, but of course we'd have to #ifdef it away on
non-gcc compilers. Gcc will also recognize
specially-formatted comments, which matches our current
practice. Let's extend that practice to all of the
unannotated sites (which I did look over and verify that
they were behaving as intended).

Ideally in each case we'd actually give some reasons in the
comment about why we're falling through, or what we're
falling through to. And gcc does support that with
-Wimplicit-fallthrough=2, which relaxes the comment pattern
matching to anything that contains "fallthrough" (or a
variety of spelling variants). However, this isn't the
default for -Wimplicit-fallthrough, nor for -Wextra. In the
name of simplicity, it's probably better for us to support
the default level, which requires "fallthrough" to be the
only thing in the comment (modulo some window dressing like
"else" and some punctuation; see the gcc manual for the
complete set of patterns).

This patch suppresses all warnings due to
-Wimplicit-fallthrough. We might eventually want to add that
to the DEVELOPER Makefile knob, but we should probably wait
until gcc 7 is more widely adopted (since earlier versions
will complain about the unknown warning type).

Signed-off-by: Jeff King <peff@peff.net>
---
The cases where I shrunk the comments make me a little sad. Maybe we
should just declare "2" as the right level. Or maybe we should do a
two-comment system, like:

  /* explain why we will fall through */
  /* fallthrough */

But I had trouble finding any meaningful wording for the first comment
in most of the cases.

 apply.c                     | 3 ++-
 builtin/cat-file.c          | 1 +
 builtin/checkout.c          | 1 +
 builtin/remote-ext.c        | 2 +-
 builtin/submodule--helper.c | 1 +
 config.c                    | 1 +
 convert.c                   | 3 ++-
 fsck.c                      | 1 +
 http-push.c                 | 1 +
 mailinfo.c                  | 1 +
 quote.c                     | 1 +
 read-cache.c                | 1 +
 send-pack.c                 | 2 +-
 13 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 71cbbd141c..c022af53a2 100644
--- a/apply.c
+++ b/apply.c
@@ -2920,6 +2920,7 @@ static int apply_one_fragment(struct apply_state *state,
 			if (plen && (ws_rule & WS_BLANK_AT_EOF) &&
 			    ws_blank_line(patch + 1, plen, ws_rule))
 				is_blank_context = 1;
+			/* fallthrough */
 		case '-':
 			memcpy(old, patch + 1, plen);
 			add_line_info(&preimage, old, plen,
@@ -2927,7 +2928,7 @@ static int apply_one_fragment(struct apply_state *state,
 			old += plen;
 			if (first == '-')
 				break;
-		/* Fall-through for ' ' */
+			/* fallthrough */
 		case '+':
 			/* --no-add does not add new lines */
 			if (first == '+' && state->no_add)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1ea25331d3..f5fa4fd75a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -113,6 +113,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 		if (textconv_object(path, obj_context.mode, &oid, 1, &buf, &size))
 			break;
+		/* else fallthrough */
 
 	case 'p':
 		type = sha1_object_info(oid.hash, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5c202b7af5..d091f06274 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -436,6 +436,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 		 * update paths in the work tree, and we cannot revert
 		 * them.
 		 */
+		/* fallthrough */
 	case 0:
 		return 0;
 	default:
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index bfb21ba7d2..6a9127a33c 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -57,7 +57,7 @@ static char *strip_escapes(const char *str, const char *service,
 				special = str[rpos];
 				if (rpos == 1)
 					break;
-				/* Fall-through to error. */
+				/* fallthrough */
 			default:
 				die("Bad remote-ext placeholder '%%%c'.",
 					str[rpos]);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818fe74f0a..f6a5e1af5d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1189,6 +1189,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 						break;
 					die("HEAD does not match the named branch in the superproject");
 				}
+				/* fallthrough */
 			default:
 				die("src refspec '%s' must name a ref",
 				    rs->src);
diff --git a/config.c b/config.c
index cd5a69e630..08490dfe81 100644
--- a/config.c
+++ b/config.c
@@ -2353,6 +2353,7 @@ static int store_write_pair(int fd, const char *key, const char *value)
 		case '"':
 		case '\\':
 			strbuf_addch(&sb, '\\');
+			/* fallthrough */
 		default:
 			strbuf_addch(&sb, value[i]);
 			break;
diff --git a/convert.c b/convert.c
index a09935cb81..20d7ab67bd 100644
--- a/convert.c
+++ b/convert.c
@@ -1545,8 +1545,9 @@ static int ident_filter_fn(struct stream_filter *filter,
 		switch (ident->state) {
 		default:
 			strbuf_add(&ident->left, head, ident->state);
+			/* fallthrough */
 		case IDENT_SKIPPING:
-			/* fallthru */
+			/* fallthrough */
 		case IDENT_DRAINING:
 			ident_drain(ident, &output, osize_p);
 		}
diff --git a/fsck.c b/fsck.c
index 2d2d2e9432..2ad00fc4d0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -588,6 +588,7 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 		case S_IFREG | 0664:
 			if (!options->strict)
 				break;
+			/* fallthrough */
 		default:
 			has_bad_modes = 1;
 		}
diff --git a/http-push.c b/http-push.c
index e4c9b065ce..d860c477c6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1523,6 +1523,7 @@ static int remote_exists(const char *path)
 		break;
 	case HTTP_ERROR:
 		error("unable to access '%s': %s", url, curl_errorstr);
+		/* fallthrough */
 	default:
 		ret = -1;
 	}
diff --git a/mailinfo.c b/mailinfo.c
index f2387a3267..bcdbf98de5 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -822,6 +822,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 		if (!handle_commit_msg(mi, line))
 			break;
 		mi->filter_stage++;
+		/* fallthrough */
 	case 1:
 		handle_patch(mi, line);
 		break;
diff --git a/quote.c b/quote.c
index 53b98a5b84..de2922ddd6 100644
--- a/quote.c
+++ b/quote.c
@@ -431,6 +431,7 @@ void tcl_quote_buf(struct strbuf *sb, const char *src)
 		case '{': case '}':
 		case '$': case '\\': case '"':
 			strbuf_addch(sb, '\\');
+			/* fallthrough */
 		default:
 			strbuf_addch(sb, c);
 			break;
diff --git a/read-cache.c b/read-cache.c
index b211c57af6..a051567610 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -220,6 +220,7 @@ static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
 	case S_IFDIR:
 		if (S_ISGITLINK(ce->ce_mode))
 			return ce_compare_gitlink(ce) ? DATA_CHANGED : 0;
+		/* else fallthrough */
 	default:
 		return TYPE_CHANGED;
 	}
diff --git a/send-pack.c b/send-pack.c
index b865f662e4..a8cc6b266e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -497,7 +497,7 @@ int send_pack(struct send_pack_args *args,
 				strbuf_release(&cap_buf);
 				return atomic_push_failure(args, remote_refs, ref);
 			}
-			/* Fallthrough for non atomic case. */
+			/* else fallthrough */
 		default:
 			continue;
 		}
-- 
2.14.1.1051.g8c9143ec35
