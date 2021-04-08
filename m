Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F36C43470
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14B461107
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhDHOvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:51:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:44622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhDHOvg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 10:51:36 -0400
Received: (qmail 23177 invoked by uid 109); 8 Apr 2021 14:51:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Apr 2021 14:51:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32552 invoked by uid 111); 8 Apr 2021 14:51:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Apr 2021 10:51:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Apr 2021 10:51:23 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
Message-ID: <YG8Ya3Z0FGBm1vwf@coredump.intra.peff.net>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com>
 <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
 <CAOLTT8QvdLeWz=cDOoVFV8Lrk2QL2wf_jwDc6oK5j+6gup+Png@mail.gmail.com>
 <YG8UD7c4lChOQM5a@coredump.intra.peff.net>
 <CAOLTT8STy3Y_pLf0PDs-Uj1dXJYSjPD3FbKrUiSM4Uz-F7etSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8STy3Y_pLf0PDs-Uj1dXJYSjPD3FbKrUiSM4Uz-F7etSA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 10:43:54PM +0800, ZheNing Hu wrote:

> > What I meant was that we should get rid of show_ref_array_items(), as
> > well, and just use format_ref_array_item() everywhere. This whole
> > wrapper is only saving us a few lines, and it makes it harder to see
> > what the function is doing. Likewise for pretty-print ref. But I dunno.
> > Maybe that is all going too far.
> >
> 
> Ok... so you mean we just use a loop like in branch.c, and get rid of
> show_ref_array_items() and show_ref_array_item().
> (We can still use the optimization of reuse bufs)

Yes, something like this:

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cb9c81a046..55297fe297 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -80,8 +82,16 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
-	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], &format);
+
+	for (i = 0; i < maxcount; i++) {
+		strbuf_reset(&output);
+		if (format_ref_array_item(array.items[i], &format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+	}
+
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	return 0;
 }

It is dropping a few lines by assuming that the error buf is only
touched when we return an error (which IMHO is a reasonable assumption
to make).

-Peff
