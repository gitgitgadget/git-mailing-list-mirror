Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA5C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701F72192A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DYL0qcsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgIHRlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:41:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58447 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbgIHRjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 13:39:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 174BE89956;
        Tue,  8 Sep 2020 13:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cKuFtVGuubWda16SOHJt2RE46Cs=; b=DYL0qc
        sjLsD1eX9Xew2XhIeUJGCdloWXhRZ9ONZiOtsr+m0yTRK/ISbePHurjQcDlfoddI
        o92Hnqrjf4UUyTg9Rf2MwEVu5/CVDHdDfqJ0duBljQDvNkgDW/OE0t2k59VmqYU8
        kZw/nRQR3FcP9RFsx+RvxjpPRe9uP5KUtPxqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j2frVWAIu9CBVWkzHzC6jKty974fXx9C
        YO2DCHhnvtjxacvIzJeJGL/2RWO7ah0FTKrqTBQTqMps1y4flDh5H3eCgrF0r76x
        vIqYaIfw5VU3i9hVJj321j1c8/+c8j1nn2QsuUyOxjcqOrtU9/EzykDXDgxvHP6X
        tTGycsGEfCo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E49E89955;
        Tue,  8 Sep 2020 13:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7586489954;
        Tue,  8 Sep 2020 13:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
        <20200908011756.GG241078@camp.crustytoothpaste.net>
        <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
Date:   Tue, 08 Sep 2020 10:39:46 -0700
In-Reply-To: <xmqq5z8p12ds.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 07 Sep 2020 18:30:23 -0700")
Message-ID: <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A117FB0-F1FA-11EA-A865-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I agree with your "the special case handling needs to be taught to
> the wt_shortstatus_other()"; a refactored helper function called
> by both places would help.

I came up with this.

 - I very much like the fact that I got rid of the "directly print
   dq and then feed the remainder of (un)quoted path plus trailing
   dq to the normal printing logic" from print_cquoted(), even
   though strbuf_insertstr() a single byte to the beginning of the
   buffer feels a bit wasteful.

 - I think the short status output for unmerged paths deserve the
   same quoting treatment, so an extra helper function pays off even
   better than our plan to fix "untracked/ignored".

 - I am undecided if I like that the helper formats and also prints;
   I was hoping I can come up with a pure formatting helper that
   does not do I/O but it seems to be hard to arrange for the
   current callers.

It seems to pass your tests, but I am not sure how good our test
coverage is around this area.

I see some mixed use of stdout and s->fp in the vicinity together
with "fprintf(stdout, ...)". We may want to clean them up someday,
by the way.

 wt-status.c | 56 ++++++++++++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git c/wt-status.c w/wt-status.c
index bb0f9120de..ff43932402 100644
--- c/wt-status.c
+++ w/wt-status.c
@@ -1829,6 +1829,21 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_stash_summary(s);
 }
 
+static void print_cquoted(const char *fmt, const char *path, const char *prefix)
+{
+	struct strbuf onebuf = STRBUF_INIT;
+	const char *one;
+
+	one = quote_path(path, prefix, &onebuf);
+	if (*one != '"' && strchr(one, ' ')) {
+		strbuf_insertstr(&onebuf, 0, "\"");
+		strbuf_addch(&onebuf, '"');
+		one = onebuf.buf;
+	}
+	printf(fmt, one);
+	strbuf_release(&onebuf);
+}
+
 static void wt_shortstatus_unmerged(struct string_list_item *it,
 			   struct wt_status *s)
 {
@@ -1845,15 +1860,10 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 	case 7: how = "UU"; break; /* both modified */
 	}
 	color_fprintf(s->fp, color(WT_STATUS_UNMERGED, s), "%s", how);
-	if (s->null_termination) {
+	if (s->null_termination)
 		fprintf(stdout, " %s%c", it->string, 0);
-	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
-		one = quote_path(it->string, s->prefix, &onebuf);
-		printf(" %s\n", one);
-		strbuf_release(&onebuf);
-	}
+	else
+		print_cquoted(" %s\n", it->string, s->prefix);
 }
 
 static void wt_shortstatus_status(struct string_list_item *it,
@@ -1875,27 +1885,9 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		if (d->rename_source)
 			fprintf(stdout, "%s%c", d->rename_source, 0);
 	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
-
-		if (d->rename_source) {
-			one = quote_path(d->rename_source, s->prefix, &onebuf);
-			if (*one != '"' && strchr(one, ' ') != NULL) {
-				putchar('"');
-				strbuf_addch(&onebuf, '"');
-				one = onebuf.buf;
-			}
-			printf("%s -> ", one);
-			strbuf_release(&onebuf);
-		}
-		one = quote_path(it->string, s->prefix, &onebuf);
-		if (*one != '"' && strchr(one, ' ') != NULL) {
-			putchar('"');
-			strbuf_addch(&onebuf, '"');
-			one = onebuf.buf;
-		}
-		printf("%s\n", one);
-		strbuf_release(&onebuf);
+		if (d->rename_source)
+			print_cquoted("%s -> ", d->rename_source, s->prefix);
+		print_cquoted("%s\n", it->string, s->prefix);
 	}
 }
 
@@ -1905,12 +1897,8 @@ static void wt_shortstatus_other(struct string_list_item *it,
 	if (s->null_termination) {
 		fprintf(stdout, "%s %s%c", sign, it->string, 0);
 	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
-		one = quote_path(it->string, s->prefix, &onebuf);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
-		printf(" %s\n", one);
-		strbuf_release(&onebuf);
+		print_cquoted(" %s\n", it->string, s->prefix);
 	}
 }
 
