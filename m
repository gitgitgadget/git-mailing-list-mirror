Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE77C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C875D22254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o4H+flgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgJOR3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:29:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58812 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgJOR3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:29:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D734886F22;
        Thu, 15 Oct 2020 13:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wKmH38XKqerSQaOpGbTrxU+ZQc0=; b=o4H+fl
        gzleCnZcpoQV6CsAfxXhLmy2BfH2vAkrpISWfquT5+Y5rtJta9YN2uHUC9PERA7H
        ccUdtcA/EvJ+Jt0+rKYuiTdPSnootU+TflnP6J8xn/UFcUjOs/uNOaPJZVru9Ocq
        c24eZCYPkUzXTpvh5PE/Dqyk3lr9XoM4WUCbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fS69BygiS5t2fAdl17D4l+OyC4yYk8IX
        me2fQgmhuNhdTJE2cmhfvjs+EpzPiuHFT6dETNT5O1/1e1vfkF9rQuODXTsF+Hdr
        hKFQlLXWdRFdXheq2MXCuaDexj3ATxld1vQz+742enGD+54EF0OUM0QI3nmeRpWY
        90D8L4iz5Js=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE8B586F21;
        Thu, 15 Oct 2020 13:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5617F86F20;
        Thu, 15 Oct 2020 13:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
        <20201015012636.GA387901@coredump.intra.peff.net>
        <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
        <20201015153849.GA551964@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 10:29:31 -0700
In-Reply-To: <20201015153849.GA551964@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 11:38:49 -0400")
Message-ID: <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCB4A6A0-0F0B-11EB-BC7D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] fast-import: fix over-allocation of marks storage
>
> Fast-import stores its marks in a trie-like structure made of mark_set
> structs. Each struct has a fixed size (1024). If our id number is too
> large to fit in the struct, then we allocate a new struct which shifts
> the id number by 10 bits. Our original struct becomes a child node
> of this new layer, and the new struct becomes the top level of the trie.
>
> This scheme was broken by ddddf8d7e2 (fast-import: permit reading
> multiple marks files, 2020-02-22). Before then, we had a top-level
> "marks" pointer, and the push-down worked by assigning the new top-level
> struct to "marks". But after that commit, insert_mark() takes a pointer
> to the mark_set, rather than using the global "marks". It continued to
> assign to the global "marks" variable during the push down, which was
> wrong for two reasons:
>
>   - we added a call in option_rewrite_submodules() which uses a separate
>     mark set; pushing down on "marks" is outright wrong here. We'd
>     corrupt the "marks" set, and we'd fail to correctly store any
>     submodule mappings with an id over 1024.
>
>   - the other callers passed "marks", but the push-down was still wrong.
>     In read_mark_file(), we take the pointer to the mark_set as a
>     parameter. So even though insert_mark() was updating the global
>     "marks", the local pointer we had in read_mark_file() was not
>     updated. As a result, we'd add a new level when needed, but then the
>     next call to insert_mark() wouldn't see it! It would then allocate a
>     new layer, which would also not be seen, and so on. Lookups for the
>     lost layers obviously wouldn't work, but before we even hit any
>     lookup stage, we'd generally run out of memory and die.
>
> Our tests didn't notice either of these cases because they didn't have
> enough marks to trigger the push-down behavior. The new tests in t9304
> cover both cases (and fail without this patch).
>
> We can solve the problem by having insert_mark() take a pointer-to-pointer
> of the top-level of the set. Then our push down can assign to it in a
> way that the caller actually sees. Note the subtle reordering in
> option_rewrite_submodules(). Our call to read_mark_file() may modify our
> top-level set pointer, so we have to wait until after it returns to
> assign its value into the string_list.

Nice.

Why does this vaguely look familiar, I wonder.  I can swear that we
saw a breakage due to a similar pattern that attempts to convert a
global to an arg that is passed down to the callchain but not doing
so fully.

Anyway, the diagnoses above look correct and cleanly described.

Will queue.  Thanks.

>
> Reported-by: Sergey Brester <serg.brester@sebres.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Two additional notes:
>
>   - we could rename the global to "marks_toplevel" or something to make
>     sure we got all references to it. But it makes the lookup code much
>     uglier (it has to use the new name, and otherwise doesn't need
>     touched by this patch). I actually did that temporarily to make sure
>     there weren't any other lingering references, but it was too ugly to
>     keep.
>
>   - there's another global in insert_mark(), which is marks_set_count.
>     We increment it once for each mark. We use the same counter whether
>     we're adding a real mark, or a submodule-rewrite mark. Since it's
>     not used for anything except reporting statistics at the end of the
>     program, I think it's fine (it's not clear whether somebody would
>     want the set of actual marks, or to know how often we had to call
>     into the mark-insertion code).
>
>  builtin/fast-import.c        | 31 ++++++++++++----------
>  t/t9304-fast-import-marks.sh | 51 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 14 deletions(-)
>  create mode 100755 t/t9304-fast-import-marks.sh
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 1bf50a73dc..70d7d25eed 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -150,7 +150,7 @@ struct recent_command {
>  	char *buf;
>  };
>  
> -typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_id *oid, uintmax_t mark);
> +typedef void (*mark_set_inserter_t)(struct mark_set **s, struct object_id *oid, uintmax_t mark);
>  typedef void (*each_mark_fn_t)(uintmax_t mark, void *obj, void *cbp);
>  
>  /* Configured limits on output */
> @@ -526,13 +526,15 @@ static unsigned int hc_str(const char *s, size_t len)
>  	return r;
>  }
>  
> -static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry *oe)
> +static void insert_mark(struct mark_set **top, uintmax_t idnum, struct object_entry *oe)
>  {
> +	struct mark_set *s = *top;
> +
>  	while ((idnum >> s->shift) >= 1024) {
>  		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
> -		s->shift = marks->shift + 10;
> -		s->data.sets[0] = marks;
> -		marks = s;
> +		s->shift = (*top)->shift + 10;
> +		s->data.sets[0] = *top;
> +		*top = s;
>  	}
>  	while (s->shift) {
>  		uintmax_t i = idnum >> s->shift;
> @@ -944,7 +946,7 @@ static int store_object(
>  
>  	e = insert_object(&oid);
>  	if (mark)
> -		insert_mark(marks, mark, e);
> +		insert_mark(&marks, mark, e);
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[type]++;
>  		return 1;
> @@ -1142,7 +1144,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  	e = insert_object(&oid);
>  
>  	if (mark)
> -		insert_mark(marks, mark, e);
> +		insert_mark(&marks, mark, e);
>  
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[OBJ_BLOB]++;
> @@ -1717,7 +1719,7 @@ static void dump_marks(void)
>  	}
>  }
>  
> -static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
> +static void insert_object_entry(struct mark_set **s, struct object_id *oid, uintmax_t mark)
>  {
>  	struct object_entry *e;
>  	e = find_object(oid);
> @@ -1734,12 +1736,12 @@ static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintm
>  	insert_mark(s, mark, e);
>  }
>  
> -static void insert_oid_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
> +static void insert_oid_entry(struct mark_set **s, struct object_id *oid, uintmax_t mark)
>  {
>  	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
>  }
>  
> -static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inserter)
> +static void read_mark_file(struct mark_set **s, FILE *f, mark_set_inserter_t inserter)
>  {
>  	char line[512];
>  	while (fgets(line, sizeof(line), f)) {
> @@ -1772,7 +1774,7 @@ static void read_marks(void)
>  		goto done; /* Marks file does not exist */
>  	else
>  		die_errno("cannot read '%s'", import_marks_file);
> -	read_mark_file(marks, f, insert_object_entry);
> +	read_mark_file(&marks, f, insert_object_entry);
>  	fclose(f);
>  done:
>  	import_marks_file_done = 1;
> @@ -3228,7 +3230,7 @@ static void parse_alias(void)
>  		die(_("Expected 'to' command, got %s"), command_buf.buf);
>  	e = find_object(&b.oid);
>  	assert(e);
> -	insert_mark(marks, next_mark, e);
> +	insert_mark(&marks, next_mark, e);
>  }
>  
>  static char* make_fast_import_path(const char *path)
> @@ -3321,13 +3323,14 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
>  	*f = '\0';
>  	f++;
>  	ms = xcalloc(1, sizeof(*ms));
> -	string_list_insert(list, s)->util = ms;
>  
>  	fp = fopen(f, "r");
>  	if (!fp)
>  		die_errno("cannot read '%s'", f);
> -	read_mark_file(ms, fp, insert_oid_entry);
> +	read_mark_file(&ms, fp, insert_oid_entry);
>  	fclose(fp);
> +
> +	string_list_insert(list, s)->util = ms;
>  }
>  
>  static int parse_one_option(const char *option)
> diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
> new file mode 100755
> index 0000000000..d4359dba21
> --- /dev/null
> +++ b/t/t9304-fast-import-marks.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +
> +test_description='test exotic situations with marks'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup dump of basic history' '
> +	test_commit one &&
> +	git fast-export --export-marks=marks HEAD >dump
> +'
> +
> +test_expect_success 'setup large marks file' '
> +	# normally a marks file would have a lot of useful, unique
> +	# marks. But for our purposes, just having a lot of nonsense
> +	# ones is fine. Start at 1024 to avoid clashing with marks
> +	# legitimately used in our tiny dump.
> +	blob=$(git rev-parse HEAD:one.t) &&
> +	for i in $(test_seq 1024 16384)
> +	do
> +		echo ":$i $blob"
> +	done >>marks
> +'
> +
> +test_expect_success 'import with large marks file' '
> +	git fast-import --import-marks=marks <dump
> +'
> +
> +test_expect_success 'setup dump with submodule' '
> +	git submodule add "$PWD" sub &&
> +	git commit -m "add submodule" &&
> +	git fast-export HEAD >dump
> +'
> +
> +test_expect_success 'setup submodule mapping with large id' '
> +	old=$(git rev-parse HEAD:sub) &&
> +	new=$(echo $old | sed s/./a/g) &&
> +	echo ":12345 $old" >from &&
> +	echo ":12345 $new" >to
> +'
> +
> +test_expect_success 'import with submodule mapping' '
> +	git init dst &&
> +	git -C dst fast-import \
> +		--rewrite-submodules-from=sub:../from \
> +		--rewrite-submodules-to=sub:../to \
> +		<dump &&
> +	git -C dst rev-parse HEAD:sub >actual &&
> +	echo "$new" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_done
