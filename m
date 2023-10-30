Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F041655
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZCkxO5y"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56364BD
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 18:33:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EFA2719CCE;
	Sun, 29 Oct 2023 21:33:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4ko8r1haXuH0DMA63Of7fGpuHo/Tdx1I4oteOC
	AxtLY=; b=oZCkxO5yQNYQFt0cG3FNf8sZIaVNXaHnxmZOYoQlhOnpoqFP5jOaRv
	FBKmm7YrbM4jfV2npC2ny90lsw+7Eex4VttAcNG3MT5qW1mNzlxjuc/cnsNoSJfF
	TgZnj5GWTbGqr31ZpW1Vt/0Toe4s6kgU0+zozFuTvOeVZYRPf6TBw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E933D19CCD;
	Sun, 29 Oct 2023 21:33:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EC4B19CCA;
	Sun, 29 Oct 2023 21:32:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] status: add noob format from status.noob config
In-Reply-To: <20231026224615.675172-2-jacob@initialcommit.io> (Jacob Stopak's
	message of "Thu, 26 Oct 2023 15:46:10 -0700")
References: <20231020183947.463882-1-jacob@initialcommit.io>
	<20231026224615.675172-1-jacob@initialcommit.io>
	<20231026224615.675172-2-jacob@initialcommit.io>
Date: Mon, 30 Oct 2023 10:32:57 +0900
Message-ID: <xmqqjzr4gaie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 426F99A2-76C4-11EE-A2B7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jacob Stopak <jacob@initialcommit.io> writes:

> diff --git a/table.c b/table.c
> new file mode 100644
> index 0000000000..15600e117f
> --- /dev/null
> +++ b/table.c

Yuck, do we need an entirely new file?  What trait are the things
that are thrown into this file together supposed to share [*]?  It
is not very clear to me what the focus of this file is.

	Side note: for example, stuff in wt-status.c are to compute
	per-path status of the working tree and in-index files.

> @@ -0,0 +1,117 @@
> +#define USE_THE_INDEX_VARIABLE

I personally do not mind, but I suspect many people hate to see this
compatibility set of macros used in a newly written source file.

> +static const char *color(int slot, struct wt_status *s)
> +{
> +	const char *c = "";
> +	if (want_color(s->use_color))
> +		c = s->color_palette[slot];
> +	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
> +		c = s->color_palette[WT_STATUS_HEADER];
> +	return c;
> +}

Do we need to duplicate this from other files?  If this is about
"git status", perhaps some parts of this patch, the truly new things
(rather than what was copied, like this one) can be added to
wt-status.c instead of adding a new file with unclear focus?

> +static void build_table_border(struct strbuf *buf, int cols)
> +{
> +	strbuf_reset(buf);
> +	strbuf_addchars(buf, '-', cols);
> +}

This seems to be horizontal border; do we need a separate vertical
border?

> +static void build_table_entry(struct strbuf *buf, char *entry, int cols)
> +{
> +	strbuf_reset(buf);
> +	strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
> +	strbuf_addstr(buf, entry);
> +
> +	/* Bump right padding if entry length is odd */
> +	if (!(strlen(entry) % 2))
> +		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2 + 1);
> +	else
> +		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
> +}

The code assumes that one byte in string "entry" occupies one and
only one display columns, which is so 20th centry assumption that
does not care about i18n.  Often what takes 3 bytes in a UTF-8
string occupies 2 display columns, for example.  In addition, if you
plan to color entries in the table, some substring would end up to
be 0-width.  Your pathname may be so long that 1/3 of a window
width may not be sufficient to show it in its entirety, you might
need to show it truncated in the middle.

utf8.c has support for measuring the display width of UTF-8 string,
which is used elsewhere in our code.  You may want to study it if
you want to do a "tabular" output.  The code in diff.c that shows
diffstat has many gems to help what this code wants to do, including
measuring display columns of a string, chomping a long string to fit
in a desired display columns, etc., by using helpers defined in
utf8.c

A potential excuse I can think of to have these outside wt-status.c
and in a separate new file is to have a generic "table" layout
machinery that is independent from "git status" or what each column
of the table is showing (in other words, they may not be pathnames),
and reusable by other subcommands that want to show things in the
"table" layout.  But even as a candidate for such a generic table
mechanism, the above falls far short by hardcoding that it can only
show 3-col table whose columns are evenly distributed and nothing
else.

> +static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
> +{
> +	printf(_("|"));
> +	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
> +	printf(_("|"));
> +	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
> +	printf(_("|"));
> +	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
> +	printf(_("|\n"));
> +}

How does the code deal with unknown display width of translated
version of "|" emitted here?  Are you assuming that no matter how
these are translated, they will always occupy one display column
each?

> +void print_noob_status(struct wt_status *s)
> +{
> +	struct winsize w;
> +	int cols;
> +	struct strbuf table_border = STRBUF_INIT;
> +	struct strbuf table_col_entry_1 = STRBUF_INIT;
> +	struct strbuf table_col_entry_2 = STRBUF_INIT;
> +	struct strbuf table_col_entry_3 = STRBUF_INIT;
> +	struct string_list_item *item;
> +
> +	/* Get terminal width */
> +	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
> +	cols = w.ws_col;

Let's not reinvent an incomplete solution before studying and
finding out what we already have in our codebase.  Immediately after
you got tempted to type TIOCGWINSZ, you can "git grep" the codebase
for that particular constant to see if we already use it, as that is
one very reasonable way to achieve what this piece of code wants to
do (i.e. find out what the display width would be).  You'd find
pager.c:term_columns() and also learned that we want to prepare for
the case where the ioctl() is not available.

> +	build_table_entry(&table_col_entry_1, "Untracked files", cols);
> +	build_table_entry(&table_col_entry_2, "Unstaged changes", cols);
> +	build_table_entry(&table_col_entry_3, "Staging area", cols);

Shouldn't these three strings be translatable?

What shoudl happen when these labels are wider than cols/3?

> diff --git a/table.h b/table.h
> new file mode 100644
> index 0000000000..c9e8c386de
> --- /dev/null
> +++ b/table.h
> @@ -0,0 +1,6 @@
> +#ifndef TABLE_H
> +#define TABLE_H
> +
> +void print_noob_status(struct wt_status *s);
> +
> +#endif /* TABLE_H */

I am guessing that your plan is to add other "distim_noob_add()" and
other "noob" variant of operations for various Git subcommands here,
but I really do not think you want to add table.[ch] that has logic
for such random set of Git subcommands copied and tweaked from all
over the place, as the only trait being shared among them will
become "they are written by Jacob Stopak", that is not a very useful
grouping of the functions.  It is not even "this file collects all
the code that produce tabular output from Git"---"git status -s"
already gives tabular output, for example, without using any of the
"I only want to draw a table with three columns of equal width"
logic.  Adding code that are necessary to add yet another output
mode for "git status" directly to where various output modes of "git
status" are implemented, i.e. wt-status.c, and do similar changes for
each command would make more sense, I would think.

Thanks.

