Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD141F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeKZRtj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:49:39 -0500
Received: from 0x63.nu ([109.74.10.199]:58728 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeKZRtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:49:39 -0500
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gRAok-0006yz-IS; Mon, 26 Nov 2018 07:56:27 +0100
References: <20181104152232.20671-1-anders@0x63.nu> <20181118114427.1397-1-anders@0x63.nu> <20181118114427.1397-3-anders@0x63.nu> <xmqqy39o9tmq.fsf@gitster-ct.c.googlers.com> <87a7lw7oct.fsf@0x63.nu> <xmqqva4kzg23.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: allow showing specific trailers
In-reply-to: <xmqqva4kzg23.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Nov 2018 07:56:25 +0100
Message-ID: <878t1g72ee.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:
> I was confused by the "only" stuff.
>
> When you give a key (or two), they cannot possibly name non-trailer
> lines, so while it may be possible to ask "oh, by the way, I also
> want non-trailer lines in addition to signed-off-by and cc lines",
> the value of being able to make such a request is dubious.
>
> The value is dubious, but logically it makes it more consistent with
> the current %(trailers) that lack 'only', which is "oh by the way, I
> also want non-trailer lines in addition to the trailers with
> keyword", to allow a way to countermand the 'only' you flip on by
> default when keywords are given.


Would it feel less inconsistent if it did not set the 'only_trailers'
option?

Now that I look at it again setting 'only_trailers' is more of an
implementation trick/hack to make sure it doesn't take the fast-path in
format_trailer_info (and by documenting it it justifies that hack). If
instead the 'filter' option is checked in the relevant places there
would be no need to mix up 'only' with 'filter'.

That is, do you think something like this should be squashed in?

diff --git a/pretty.c b/pretty.c
index 302e67fa8..f45ccaf51 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1360,7 +1360,6 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */

                                        opts.filter = format_trailer_match_cb;
                                        opts.filter_data = &filter_list;
-                                       opts.only_trailers = 1;
                                } else
                                        break;
                        }
diff --git a/trailer.c b/trailer.c
index 97c8f2762..07ca2b2c6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1132,7 +1132,7 @@ static void format_trailer_info(struct strbuf *out,
        size_t i;

        /* If we want the whole block untouched, we can take the fast path. */
-       if (!opts->only_trailers && !opts->unfold) {
+       if (!opts->only_trailers && !opts->unfold && !opts->filter) {
                strbuf_add(out, info->trailer_start,
                           info->trailer_end - info->trailer_start);
                return;
@@ -1156,7 +1156,7 @@ static void format_trailer_info(struct strbuf *out,
                        strbuf_release(&tok);
                        strbuf_release(&val);

-               } else if (!opts->only_trailers) {
+               } else if (!opts->only_trailers && !opts->filter) {
                        strbuf_addstr(out, trailer);
                }
        }
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 7548e1d38..ea3cd5b28 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -228,9 +228,9 @@ endif::git-rev-list[]
 ** 'key=<K>': only show trailers with specified key. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
-   shown. Non-trailer lines in the trailer block are also hidden
-   (i.e. 'key' implies 'only'). E.g., `%(trailers:key=Reviewed-by)`
-   shows trailer lines with key `Reviewed-by`.
+   shown. Non-trailer lines in the trailer block are also hidden.
+   E.g., `%(trailers:key=Reviewed-by)` shows trailer lines with key
+   `Reviewed-by`.
 ** 'only': omit non-trailer lines from the trailer block.
 ** 'unfold': make it behave as if interpret-trailer's `--unfold`
    option was given. E.g., `%(trailers:only,unfold)` unfolds and
