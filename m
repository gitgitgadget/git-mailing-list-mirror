Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E1C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhLPV0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:26:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55550 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhLPV0a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:26:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03C52178284;
        Thu, 16 Dec 2021 16:26:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eqRgT7DmPaTg/L+ymVPxw6V/H5uhYuE1DTpwIm
        lIv7Q=; b=q5JOz+fHmBhaplZxjUeDayIBh1HY9A7BfFXUbdflIYH7jg0NNOVmdu
        KvCXIMFaZ0iAFiMG6fSMxBuVoqg9gUJl96mKnsSJnzKYIcTFDiU8DsYrbCu3rJp/
        4/oVqFkRCn75O1tc2wFEGqeULBFyEL9uYGwlVvcDI7bcDhOqwy5Ak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F06F2178283;
        Thu, 16 Dec 2021 16:26:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A9D0178282;
        Thu, 16 Dec 2021 16:26:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v5 1/1] ls-tree.c: support `--object-only` option for
 "git-ls-tree"
References: <xmqqk0g5656r.fsf@gitster.g>
        <20211216121630.14553-1-dyroneteng@gmail.com>
Date:   Thu, 16 Dec 2021 13:26:24 -0800
In-Reply-To: <20211216121630.14553-1-dyroneteng@gmail.com> (Teng Long's
        message of "Thu, 16 Dec 2021 20:16:30 +0800")
Message-ID: <xmqq7dc49r7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D34F0B06-5EB6-11EC-AB1A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>> A better name, anybody?
>> 
>> This bit is to keep track of the fact that we made _some_ output
>> already so any further output needs an inter-field space before
>> writing what it wants to write out.
>
> I found a word "interspace", it looks like a little better than the old
> one. I will rename to it in next patch, and If there's a better idea,
> will apply further.

Yeah, it really is needs_inter_field_space but that is way too long.

>> We need to stop using write_name_quoted_relative() in SHOW_FILE_NAME
>> part, because the helper insists that the name written by it must be
>> at the end of the entry, if we go that route, but it may be a good
>> change in the longer term.
>
> Let me try to represent to make sure I understand your suggestion
> sufficiently.
>
> "write_name_quoted_relative" is used to compute the relative file name
> by "prefix" and output the name and a line termination to the given FD.
>
> We do not want use "write_name_quoted_relative" in here because the
> function alway output a line termination after "name", this may bring
> some inconvenience because the "name" may not be the last field in the
> future.
>
> So, instead:
>
> We need to calculate the file name (relative path and quotes if need)
> without "write_name_quoted_relative"  and then output the line
> termination before return.

I think we are on the same page.  We can work backwards, I think.

We have a repetitive

        if (mode should be shown) {
                show mode;
                record that we have already shown something;
        }
        if (type should be shown) {
                give inter-field-space if we have shown something;
                show type;
                record that we have already shown something;
        }
        ...

that ends with

        if (name should be shown) {
                give inter-field-space if we have shown something;
                show name PLUS line termination;
	}

But if we can make the last step to

        if (name should be shown) {
                give inter-field-space if we have shown something;
                show name;
	}

	give line termination;

it gets easier to support a combination that does not show name, and
we can have inter-record separator.

But write_name_quoted_relative() does not give the caller a choice
to have no terminator, so we need to do something like this:

	if (shown_bits & SHOW_FILE_NAME) {
		const char *name;
                struct strbuf name_buf = STRBUF_INIT;

		if (follow)
			printf("\t");
		baselen = base->len;
		strbuf_addstr(base, pathname);
                
		name = relative_path(base->buf, 
				     chomp_prefix ? ls_tree_prefix : NULL,
                                     &name_buf);
		if (line_termination)
			quote_c_style(name, NULL, stdout, 0);
		else
			fputs(name, stdout);
		strbuf_release(&name_buf);
		strbuf_setlen(base, baselen);
	}

I initially thought that extending write_name_quoted() and
write_name_quoted_relative() to accept a special value or two for
terminator to tell it not to add terminator would be sufficient (see
below).  I however think it is way too ugly to have the "add no
terminator and do not quote" option at write_name_quoted() level,
simply because the caller that chooses as-is can simply do fputs()
itself without bothering to use write_name_quoted().  So I am not
convinced that it will a good idea.

If we were to go that "ugly helper" route, the above can become even
simpler and closer to what you originally wrote, e.g.

	if (shown_bits & SHOW_FILE_NAME) {
		if (follow)
			printf("\t");
		baselen = base->len;
		strbuf_addstr(base, pathname);
		write_name_quoted_relative(base->buf,
					   chomp_prefix ? ls_tree_prefix : NULL,
					   stdout,
                                           line_termination 
                                           ? CQ_NO_TERMINATOR_C_QUOTED
                                           : CQ_NO_TERMINATOR_AS_IS);
		strbuf_setlen(base, baselen);
	}


 quote.c |  5 +++--
 quote.h | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git c/quote.c w/quote.c
index 26719d21d1..cbbcd8563f 100644
--- c/quote.c
+++ w/quote.c
@@ -340,12 +340,13 @@ void quote_two_c_style(struct strbuf *sb, const char *prefix, const char *path,
 
 void write_name_quoted(const char *name, FILE *fp, int terminator)
 {
-	if (terminator) {
+	if (0 < terminator || terminator == CQ_NO_TERMINATOR_C_QUOTED) {
 		quote_c_style(name, NULL, fp, 0);
 	} else {
 		fputs(name, fp);
 	}
-	fputc(terminator, fp);
+	if (0 <= terminator)
+		fputc(terminator, fp);
 }
 
 void write_name_quoted_relative(const char *name, const char *prefix,
diff --git c/quote.h w/quote.h
index 87ff458b06..5c8c7cf952 100644
--- c/quote.h
+++ w/quote.h
@@ -85,7 +85,26 @@ int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned);
 void quote_two_c_style(struct strbuf *, const char *, const char *, unsigned);
 
+/*
+ * Write a name, typically a filename, followed by a terminator that
+ * separates it from what comes next.
+ * When terminator is NUL, the name is given as-is.  Otherwise, the
+ * name is c-quoted, suitable for text output.  HT and LF are typical
+ * values used for the terminator, but other positive values are possible.
+ *
+ * In addition to non-negative values two special values in terminator
+ * are possible.
+ * -1: show the name c-quoted, without adding any terminator.
+ * -2: show the name as-is, without adding any terminator.
+ */
+#define CQ_NO_TERMINATOR_C_QUOTED	(-1)
+#define CQ_NO_TERMINATOR_AS_IS		(-2)
 void write_name_quoted(const char *name, FILE *, int terminator);
+
+/*
+ * Similar to the above, but the name is first made relative to the prefix
+ * before being shown.
+ */ 
 void write_name_quoted_relative(const char *name, const char *prefix,
 				FILE *fp, int terminator);
 

