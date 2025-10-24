Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249CE32A3E1
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325737; cv=none; b=k6WqzhIdfjust+6HJaqUtMVgNbgymB+un+5DtmvQg9/JJuOhErrCyYPETFxw5JmPAONcWzNMyOFsuIGRR/a9GTkio/gzeaCKsEy0hW4zbElDwHJLQXeE1GRcq3wzY13yvaxkL/bcFcAuIC2WdlLtjaZzi4N/UIqj2e6DTXpRmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325737; c=relaxed/simple;
	bh=LiKCHaiublM8I91kcfTFHsixUQbUn5lbsCAYYnxIjvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+veoX0Kkz9V4c2Arq0EsAA4up8C/+mN63cch3XL71JrlzJEtpttEt29SLGG5xjcNUINgrVlJcx4rBBp5o57MpAU7j3jNmJAHUt9qJYvL38xs0RQo5Jaz8Sj/8TYG1KPWjNTqm0ZAZ18rHey/3GnSVlfK7X+txY8HvJqdTgRcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DJDz4wNu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DJDz4wNu"
Received: (qmail 326174 invoked by uid 109); 24 Oct 2025 17:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LiKCHaiublM8I91kcfTFHsixUQbUn5lbsCAYYnxIjvg=; b=DJDz4wNuwayoTKujg6PCUN0hIvwWrxptdkpr7f5uPS5UYAKlYrm4IqjrD230yeV64JIAC3SuMKH2AsrcBQuA6E20sYBjFlAMBvzL+BknTr+Le4nMnpOY5DAgfEuwf1xojr1+DzBnS1s8OhHKyLN8mT/yMw1GyQLEowfgwcHrBeaBofJ1N5lEIMJXTsMNCa16pkkLp3Dq4oHC+I3PeGevPWv82ds6Imw0Gwneta6uQfvlAPFtajKvqFdfljNjGP3Xef4UJxQv0xtBTB8xPffPvZ6d6h8LWDWWZsDsOn9UfendNiDrEu3J2V9QYVGip0Fr5pRB/spggk9guYLKrkRxAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:08:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513229 invoked by uid 111); 24 Oct 2025 17:08:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:08:53 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:08:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] diff: replace diff_options.dry_run flag with NULL file
Message-ID: <20251024170853.GC2345184@coredump.intra.peff.net>
References: <20251024170522.GA2344972@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024170522.GA2344972@coredump.intra.peff.net>

We introduced a dry_run flag to diff_options in b55e6d36eb (diff: ensure
consistent diff behavior with ignore options, 2025-08-08), with the idea
that the lower-level diff code could skip output when it is set.

As we saw with the bugs fixed by 3ed5d8bd73 (diff: stop output garbled
message in dry run mode, 2025-10-20), it is easy to miss spots. In the
end, we located all of them by checking where diff_options.file is used.

That suggests another possible approach: we can replace the dry_run
boolean with a NULL pointer for "file", as we know that using "file" in
dry_run mode would always be an error. This turns any missed spots from
producing extra output[1] into a segfault. Which is less forgiving, but
that is the point: this is indicative of a programming error, and
complaining loudly and immediately is good.

[1] We protect ourselves against garbled output as a separate step,
    courtesy of 623f7af284 (diff: restore redirection to /dev/null for
    diff_from_contents, 2025-10-17). So in that sense this patch can
    only introduce user-visible errors (since any "bugs" were going to
    /dev/null before), but the idea is to catch them rather than quietly
    send garbage to /dev/null.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 16 ++++++++--------
 diff.h |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index d83d898702..a8d50fb1fc 100644
--- a/diff.c
+++ b/diff.c
@@ -1351,7 +1351,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	int len = eds->len;
 	unsigned flags = eds->flags;
 
-	if (o->dry_run)
+	if (!o->file)
 		return;
 
 	switch (s) {
@@ -3765,9 +3765,9 @@ static void builtin_diff(const char *name_a,
 
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
-		if (o->dry_run) {
+		if (!o->file) {
 			/*
-			 * Unlike the !dry_run case, we need to ignore the
+			 * Unlike the normal output case, we need to ignore the
 			 * return value from xdi_diff_outf() here, because
 			 * xdi_diff_outf() takes non-zero return from its
 			 * callback function as a sign of error and returns
@@ -4423,7 +4423,7 @@ static void run_external_diff(const struct external_diff *pgm,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_run;
+	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || !o->file;
 	int rc;
 
 	/*
@@ -4621,7 +4621,7 @@ static void run_diff_cmd(const struct external_diff *pgm,
 		    p->status == DIFF_STATUS_RENAMED)
 			o->found_changes = 1;
 	} else {
-		if (!o->dry_run)
+		if (o->file)
 			fprintf(o->file, "* Unmerged path %s\n", name);
 		o->found_changes = 1;
 	}
@@ -6199,15 +6199,15 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 /* return 1 if any change is found; otherwise, return 0 */
 static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
 {
-	int saved_dry_run = o->dry_run;
+	FILE *saved_file = o->file;
 	int saved_found_changes = o->found_changes;
 	int ret;
 
-	o->dry_run = 1;
+	o->file = NULL;
 	o->found_changes = 0;
 	diff_flush_patch(p, o);
 	ret = o->found_changes;
-	o->dry_run = saved_dry_run;
+	o->file = saved_file;
 	o->found_changes |= saved_found_changes;
 	return ret;
 }
diff --git a/diff.h b/diff.h
index 2fa256c3ef..31eedd5c0c 100644
--- a/diff.h
+++ b/diff.h
@@ -408,8 +408,6 @@ struct diff_options {
 	#define COLOR_MOVED_WS_ERROR (1<<0)
 	unsigned color_moved_ws_handling;
 
-	bool dry_run;
-
 	struct repository *repo;
 	struct strmap *additional_path_headers;
 
-- 
2.51.1.797.g1148beab57

