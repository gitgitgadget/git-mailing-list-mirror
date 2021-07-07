Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4DC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13CA61C71
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhGGXPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:15:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57362 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhGGXPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:15:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9B64F1F8C6;
        Wed,  7 Jul 2021 23:12:22 +0000 (UTC)
Date:   Wed, 7 Jul 2021 23:12:22 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
Message-ID: <20210707231222.GA27550@dcvr>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <87zgv276lf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgv276lf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Tue, Jun 29 2021, Eric Wong wrote:
> 
> > +struct alloc_state;
> > +struct oidtree {
> > +	struct cb_tree t;
> 
> s/t/tree/? Too short a name for an interface IMO.

Done.  I was keeping `t' to match agl's published version
(and it remains that way in cbtree.[ch])

> > +	struct alloc_state *mempool;
> > +};
> > +
> > +#define OIDTREE_INIT { .t = CBTREE_INIT, .mempool = NULL }
> 
> Let's use designated initilaizers for new code. Just:
> 
> 	#define OIDTREE_init { \
> 		.tere = CBTREE_INIT, \
> 	}
> 
> Will do, no need for the ".mempool = NULL"
 
> > +static inline void oidtree_init(struct oidtree *ot)
> > +{
> > +	cb_init(&ot->t);
> > +	ot->mempool = NULL;
> > +}
> 
> You can use the "memcpy() a blank" trick/idiom here:
> https://lore.kernel.org/git/patch-2.5-955dbd1693d-20210701T104855Z-avarab@gmail.com/
> 
> Also, is this even needed? Why have the "destroy" re-initialize it?

I'm using mem_pool, now.  With the way mem_pool_init works,
I've decided to do away with OIDTREE_INIT and only use
oidtree_init (and lazy-malloc the entire loose_objects_cache)

> > +void oidtree_destroy(struct oidtree *);
> 
> Maybe s/destroy/release/, or if you actually need that reset behavior
> oidtree_reset(). We've got

I'm renaming it oidtree_clear to match oid_array_clear.

> > +void oidtree_insert(struct oidtree *, const struct object_id *);
> > +int oidtree_contains(struct oidtree *, const struct object_id *);
> > +
> > +typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *arg);
> 
> An "arg" name for some arguments, but none for others, if there's a name
> here call it "data" like you do elswhere?

OK, using "data".  To reduce noise, I prefer to only name
variables in prototypes if the usage can't be easily inferred
from its type and function name.

> > +void oidtree_each(struct oidtree *, const struct object_id *,
> > +			size_t oidhexlen, oidtree_iter, void *arg);
> 
> s/oidhexlen/hexsz/, like in git_hash_algo.a

done

> > +++ b/t/helper/test-oidtree.c
> > @@ -0,0 +1,47 @@
> > +#include "test-tool.h"
> > +#include "cache.h"
> > +#include "oidtree.h"
> > +
> > +static enum cb_next print_oid(const struct object_id *oid, void *data)
> > +{
> > +	puts(oid_to_hex(oid));
> > +	return CB_CONTINUE;
> > +}
> > +
> > +int cmd__oidtree(int argc, const char **argv)
> > +{
> > +	struct oidtree ot = OIDTREE_INIT;
> > +	struct strbuf line = STRBUF_INIT;
> > +	int nongit_ok;
> > +	int algo = GIT_HASH_UNKNOWN;
> > +
> > +	setup_git_directory_gently(&nongit_ok);
> > +
> > +	while (strbuf_getline(&line, stdin) != EOF) {
> > +		const char *arg;
> > +		struct object_id oid;
> > +
> > +		if (skip_prefix(line.buf, "insert ", &arg)) {
> > +			if (get_oid_hex_any(arg, &oid) == GIT_HASH_UNKNOWN)
> > +				die("insert not a hexadecimal oid: %s", arg);
> > +			algo = oid.algo;
> > +			oidtree_insert(&ot, &oid);
> > +		} else if (skip_prefix(line.buf, "contains ", &arg)) {
> > +			if (get_oid_hex(arg, &oid))
> > +				die("contains not a hexadecimal oid: %s", arg);
> > +			printf("%d\n", oidtree_contains(&ot, &oid));
> > +		} else if (skip_prefix(line.buf, "each ", &arg)) {
> > +			char buf[GIT_MAX_HEXSZ + 1] = { '0' };
> > +			memset(&oid, 0, sizeof(oid));
> > +			memcpy(buf, arg, strlen(arg));
> > +			buf[hash_algos[algo].hexsz] = 0;
> 
> = '\0' if it's the intent to have a NULL-terminated string is more
> readable.

done

> > +			get_oid_hex_any(buf, &oid);
> > +			oid.algo = algo;
> > +			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
> > +		} else if (!strcmp(line.buf, "destroy"))
> > +			oidtree_destroy(&ot);
> > +		else
> > +			die("unknown command: %s", line.buf);
> 
> Missing braces.

Added.

> > +	}
> > +	return 0;
> > +}
> > diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> > index c5bd0c6d4c..9d37debf28 100644
> > --- a/t/helper/test-tool.c
> > +++ b/t/helper/test-tool.c
> > @@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
> >  	{ "mktemp", cmd__mktemp },
> >  	{ "oid-array", cmd__oid_array },
> >  	{ "oidmap", cmd__oidmap },
> > +	{ "oidtree", cmd__oidtree },
> >  	{ "online-cpus", cmd__online_cpus },
> >  	{ "parse-options", cmd__parse_options },
> >  	{ "parse-pathspec-file", cmd__parse_pathspec_file },
> > diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> > index e8069a3b22..f683a2f59c 100644
> > --- a/t/helper/test-tool.h
> > +++ b/t/helper/test-tool.h
> > @@ -32,6 +32,7 @@ int cmd__match_trees(int argc, const char **argv);
> >  int cmd__mergesort(int argc, const char **argv);
> >  int cmd__mktemp(int argc, const char **argv);
> >  int cmd__oidmap(int argc, const char **argv);
> > +int cmd__oidtree(int argc, const char **argv);
> >  int cmd__online_cpus(int argc, const char **argv);
> >  int cmd__parse_options(int argc, const char **argv);
> >  int cmd__parse_pathspec_file(int argc, const char** argv);
> > diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
> > new file mode 100755
> > index 0000000000..0594f57c81
> > --- /dev/null
> > +++ b/t/t0069-oidtree.sh
> > @@ -0,0 +1,52 @@
> > +#!/bin/sh
> > +
> > +test_description='basic tests for the oidtree implementation'
> > +. ./test-lib.sh
> > +
> > +echoid () {
> > +	prefix="${1:+$1 }"
> > +	shift
> > +	while test $# -gt 0
> > +	do
> > +		echo "$1"
> > +		shift
> > +	done | awk -v prefix="$prefix" -v ZERO_OID=$ZERO_OID '{
> > +		printf("%s%s", prefix, $0);
> > +		need = length(ZERO_OID) - length($0);
> > +		for (i = 0; i < need; i++)
> > +			printf("0");
> > +		printf "\n";
> > +	}'
> > +}
> 
> Looks fairly easy to do in pure-shell, first of all you don't need a
> length() on $ZERO_OID, use $(test_oid hexsz) instead. That applies for
> the awk version too.

Ah, I didn't know about test_oid, using it, now.

> But once you have that and the N arguments just do a wc -c on the
> argument, use $(()) to compute the $difference, and a loop with:
> 
>     printf "%s%s%0${difference}d" "$prefix" "$shortoid" "0"

I also wanted to avoid repeated 'wc -c' and figured awk was
portable enough since we use it elsewhere in tests.  I've now
noticed "${#var}" is portable and we're already relying on it in
packetize(), so I'm using that.

> > +
> > +test_expect_success 'oidtree insert and contains' '
> > +	cat >expect <<EOF &&
> > +0
> > +0
> > +0
> > +1
> > +1
> > +0
> > +EOF
> 
> use "<<-\EOF" and indent it.

done

Thanks all for the reviews.
