Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA9C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BD422261
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I0jenxd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgJOR6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:58:01 -0400
Received: from mout.web.de ([212.227.17.11]:34569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731821AbgJOR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602784666;
        bh=HM4V8R0T/DmQOfsARfRXXkPWc2aL43vo055MU8Ln4v0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I0jenxd9W2ujo0KnJAhoYTQRyD8kY74vYOPo7s/KMusb+K+OqelYvyqitwiX3qZsy
         5WoiizgWHNxYJHSH0OPaFefT4Nuj6V1umlbf5vIcBMoPMh3WHniMhV3pkR/Iza1em/
         Zk/FDm+/mRfC1sTgKHQFIvvKyuk1EBa9pVSIGC/Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.28.94]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0UC-1kz8Ob3iK4-00VzAa; Thu, 15
 Oct 2020 19:57:45 +0200
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
To:     Jeff King <peff@peff.net>,
        "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6606f7fc-763a-d81c-2e14-4c2699f81f88@web.de>
Date:   Thu, 15 Oct 2020 19:57:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015153849.GA551964@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ktmdBIobFflPtrbKvALJvtc9ZHWWwTTFggD2ngv0CcdiQamanqU
 xO/UeYLjKaNTtKbgNdQzTeh1WvH161QLqmfXCiMprz4q0Vy00s3NkppGwvLOcEiJUKB8Ti3
 V7GsjaprixngtyyYv5bNVUTl3WTyX4t4qKTCK++oI55nSGs7IvwOiImCTIgwMIJ7UBc7mgj
 2QaSZgqHZyS7rlB27zCjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FqgbUtpSKsY=:iqKsLwE7vWNTtr7dmLUXkw
 M/AySXeFJC/rDeZbqHWZntQnGMQ8ZH2qirERClF6uxsYrlph1W1Gp4jE+zN99GdQuNVvRXwBh
 gqxAhBMw9IYBVj8Si5j2gfu4JR9vJyv7PZV5gfprUbaRftb3dVzbsVQnEXN6FGcytFnC6uujc
 fv2RaRhaI0v9zhunGtE2Vyx4vSN7QZTf3O352t1h8DE62LmHA8lyEcGoLq/nFXVONd7FwUjmm
 GzXODGTN8BIvg1zNu9rJkGRMJ6XGHwqLV4GOKlHy1gfED3XWetzeXK6/GNy3lflv1cSuU+B+Q
 LnFeXUbqrrqQwaPaRokH71WH1z8cGQXOqP3WFx5e9MQj2S1idRcQwQAI+p8rmY1+14epYG9+N
 g21dFMB7/UxtpgchRcx6DkzSvyDbVRXNcxhuWmpDsAg8owP7KoMhU0aTeWqqOk1JtrIemIRyq
 CPGH+U0aXoVdxlMXmoRDIFoyEBGrsIf62d/HVqN14PQ+rvq4uAqibV5C42lsECgTmjJSpoAlE
 yvRozBsIukhJt1yFvdsZxoCfDGjuuDMI5r1w4lw/TyvMPqeiWI+EIgWe+HLyS0D+OaA9emTYf
 KRysIuBmuJCo2L4Ktgs55/GykrYrLrqERqvVOz47Gj2wiP9s6mkGvZkUyxAuXyqTkKZqMIKjD
 7bUHmGGEsi30CbHBcBYNN1dL+VlJO3NVPzF2bl0U4T1RUMC917CaYGgLw2aQXOYEsF2MGUby1
 OTbf4tHpGhszMEvS4L6CMwsM1aK8j+f+mOyf4kpWdnIUXMNFUvyINPAfDhZZhRfj04HRhSCH0
 EhvlTGwVEkBqKSHB2L9nh2cXBflw5hAd/nAdgoDWQf4of3EQKpMBOibXIBrV3XyiETw8ytCUt
 DlOD43+cfOGorwMRvPNg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.20 um 17:38 schrieb Jeff King:
> On Thu, Oct 15, 2020 at 01:50:30PM +0200, Dipl. Ing. Sergey Brester wrot=
e:
>
>> well, I don't know how you were trying to reproduce it.
>>
>> My first attempt with a git-repository (cloned from
>> https://github.com/git/git.git) showed that immediately to me.
>> Here you go (I used git bash here):
>> [...]
>
> Thanks for this recipe. The key thing I was missing was having a
> reasonably large number of marks to be imported.
>
> The problem bisects to ddddf8d7e2 (fast-import: permit reading multiple
> marks files, 2020-02-22), which is in v2.27.0. The fix is below. Since
> we're entering the -rc2 period for v2.29 today and this isn't a
> regression since v2.28, it probably won't make it into v2.29. But it's a
> pretty serious bug (I'm actually surprised it took this long for anyone
> to notice, as mark importing of any decent size is basically broken),
> so I hope it will make it onto the maint branch soon after release.
>
> -- >8 --
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
> We can solve the problem by having insert_mark() take a pointer-to-point=
er
> of the top-level of the set. Then our push down can assign to it in a
> way that the caller actually sees. Note the subtle reordering in
> option_rewrite_submodules(). Our call to read_mark_file() may modify our
> top-level set pointer, so we have to wait until after it returns to
> assign its value into the string_list.

Looks good to me, and FWIW it fixes Sergey's test case for me as well.
(I wish I'd seen it before I hit send on my other reply..)

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

Semi-related: We should turn the struct object_entry pointers in
insert_mark() and find_mark() into void pointers, since they are
used "generically".  Perhaps struct mark_set would benefit from a
type member to implement our own type checks.

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
> -typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_i=
d *oid, uintmax_t mark);
> +typedef void (*mark_set_inserter_t)(struct mark_set **s, struct object_=
id *oid, uintmax_t mark);
>  typedef void (*each_mark_fn_t)(uintmax_t mark, void *obj, void *cbp);
>
>  /* Configured limits on output */
> @@ -526,13 +526,15 @@ static unsigned int hc_str(const char *s, size_t l=
en)
>  	return r;
>  }
>
> -static void insert_mark(struct mark_set *s, uintmax_t idnum, struct obj=
ect_entry *oe)
> +static void insert_mark(struct mark_set **top, uintmax_t idnum, struct =
object_entry *oe)
>  {
> +	struct mark_set *s =3D *top;
> +
>  	while ((idnum >> s->shift) >=3D 1024) {
>  		s =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
> -		s->shift =3D marks->shift + 10;
> -		s->data.sets[0] =3D marks;
> -		marks =3D s;
> +		s->shift =3D (*top)->shift + 10;
> +		s->data.sets[0] =3D *top;
> +		*top =3D s;
>  	}
>  	while (s->shift) {
>  		uintmax_t i =3D idnum >> s->shift;
> @@ -944,7 +946,7 @@ static int store_object(
>
>  	e =3D insert_object(&oid);
>  	if (mark)
> -		insert_mark(marks, mark, e);
> +		insert_mark(&marks, mark, e);
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[type]++;
>  		return 1;
> @@ -1142,7 +1144,7 @@ static void stream_blob(uintmax_t len, struct obje=
ct_id *oidout, uintmax_t mark)
>  	e =3D insert_object(&oid);
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
> -static void insert_object_entry(struct mark_set *s, struct object_id *o=
id, uintmax_t mark)
> +static void insert_object_entry(struct mark_set **s, struct object_id *=
oid, uintmax_t mark)
>  {
>  	struct object_entry *e;
>  	e =3D find_object(oid);
> @@ -1734,12 +1736,12 @@ static void insert_object_entry(struct mark_set =
*s, struct object_id *oid, uintm
>  	insert_mark(s, mark, e);
>  }
>
> -static void insert_oid_entry(struct mark_set *s, struct object_id *oid,=
 uintmax_t mark)
> +static void insert_oid_entry(struct mark_set **s, struct object_id *oid=
, uintmax_t mark)
>  {
>  	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
>  }
>
> -static void read_mark_file(struct mark_set *s, FILE *f, mark_set_insert=
er_t inserter)
> +static void read_mark_file(struct mark_set **s, FILE *f, mark_set_inser=
ter_t inserter)
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
>  	import_marks_file_done =3D 1;
> @@ -3228,7 +3230,7 @@ static void parse_alias(void)
>  		die(_("Expected 'to' command, got %s"), command_buf.buf);
>  	e =3D find_object(&b.oid);
>  	assert(e);
> -	insert_mark(marks, next_mark, e);
> +	insert_mark(&marks, next_mark, e);
>  }
>
>  static char* make_fast_import_path(const char *path)
> @@ -3321,13 +3323,14 @@ static void option_rewrite_submodules(const char=
 *arg, struct string_list *list)
>  	*f =3D '\0';
>  	f++;
>  	ms =3D xcalloc(1, sizeof(*ms));
> -	string_list_insert(list, s)->util =3D ms;
>
>  	fp =3D fopen(f, "r");
>  	if (!fp)
>  		die_errno("cannot read '%s'", f);
> -	read_mark_file(ms, fp, insert_oid_entry);
> +	read_mark_file(&ms, fp, insert_oid_entry);
>  	fclose(fp);
> +
> +	string_list_insert(list, s)->util =3D ms;
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
> +test_description=3D'test exotic situations with marks'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup dump of basic history' '
> +	test_commit one &&
> +	git fast-export --export-marks=3Dmarks HEAD >dump
> +'
> +
> +test_expect_success 'setup large marks file' '
> +	# normally a marks file would have a lot of useful, unique
> +	# marks. But for our purposes, just having a lot of nonsense
> +	# ones is fine. Start at 1024 to avoid clashing with marks
> +	# legitimately used in our tiny dump.
> +	blob=3D$(git rev-parse HEAD:one.t) &&
> +	for i in $(test_seq 1024 16384)
> +	do
> +		echo ":$i $blob"
> +	done >>marks
> +'
> +
> +test_expect_success 'import with large marks file' '
> +	git fast-import --import-marks=3Dmarks <dump
> +'
> +
> +test_expect_success 'setup dump with submodule' '
> +	git submodule add "$PWD" sub &&
> +	git commit -m "add submodule" &&
> +	git fast-export HEAD >dump
> +'
> +
> +test_expect_success 'setup submodule mapping with large id' '
> +	old=3D$(git rev-parse HEAD:sub) &&
> +	new=3D$(echo $old | sed s/./a/g) &&
> +	echo ":12345 $old" >from &&
> +	echo ":12345 $new" >to
> +'
> +
> +test_expect_success 'import with submodule mapping' '
> +	git init dst &&
> +	git -C dst fast-import \
> +		--rewrite-submodules-from=3Dsub:../from \
> +		--rewrite-submodules-to=3Dsub:../to \
> +		<dump &&
> +	git -C dst rev-parse HEAD:sub >actual &&
> +	echo "$new" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_done
>

