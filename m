Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA72C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065472076E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406796AbgFYTsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:43232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406573AbgFYTsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:03 -0400
Received: (qmail 31311 invoked by uid 109); 25 Jun 2020 19:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jun 2020 19:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19538 invoked by uid 111); 25 Jun 2020 19:48:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jun 2020 15:48:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Jun 2020 15:48:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/11] fast-export: allow seeding the anonymized mapping
Message-ID: <20200625194802.GA4028913@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200622214745.GA3302779@coredump.intra.peff.net>
 <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of the "--seed-anonymize" feature, incorporating
changes from Eric's review.

Here's a summary of the changes. Patches 1-8 are unchanged:

  [01/11]: t9351: derive anonymized tree checks from original repo
  [02/11]: fast-export: use xmemdupz() for anonymizing oids
  [03/11]: fast-export: store anonymized oids as hex strings
  [04/11]: fast-export: tighten anonymize_mem() interface to handle only strings
  [05/11]: fast-export: stop storing lengths in anonymized hashmaps
  [06/11]: fast-export: use a flex array to store anonymized entries
  [07/11]: fast-export: move global "idents" anonymize hashmap into function
  [08/11]: fast-export: add a "data" callback parameter to anonymize_str()

  [09/11]: fast-export: allow seeding the anonymized mapping

    - the option is now called "--anonymize-map", and the word "seed"
      isn't used in any user-facing documentation

    - incorporated Eric's documentation suggestions

    - --anonymize-map without --anonymize now triggers an error

  [10/11]: fast-export: anonymize "master" refname

    - minor adjustments to handle change of option name

  [11/11]: fast-export: use local array to store anonymized oid

    - new in this iteration; this address the gcc-4 warning that Gábor
      mentioned. I prepared it on top since I think we'd eventually want
      to revert it once we decide that compiler is too old (and I'd be
      perfectly fine to declare that it's so now, and just never apply
      it at all).

Full range diff is below.

 1:  65dca0c684 =  1:  dd2668d7fe t9351: derive anonymized tree checks from original repo
 2:  bc79b92850 =  2:  46a07c62e1 fast-export: use xmemdupz() for anonymizing oids
 3:  f5b34b3730 =  3:  a7be6c4703 fast-export: store anonymized oids as hex strings
 4:  5982a5c764 =  4:  712e481e4e fast-export: tighten anonymize_mem() interface to handle only strings
 5:  d6b7a75a13 =  5:  1ad28f560a fast-export: stop storing lengths in anonymized hashmaps
 6:  f897a949b1 =  6:  b6456c0c7b fast-export: use a flex array to store anonymized entries
 7:  e5465fb8d8 =  7:  81d478c12b fast-export: move global "idents" anonymize hashmap into function
 8:  8dd74b95b7 =  8:  0d34f57a94 fast-export: add a "data" callback parameter to anonymize_str()
 9:  c7aec82ba5 !  9:  64e3afe46f fast-export: allow seeding the anonymized mapping
    @@ Commit message
         does work, but it's a bit awkward to use (you have to manually dig the
         items you care about out of the mapping).
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## Documentation/git-fast-export.txt ##
     @@ Documentation/git-fast-export.txt: by keeping the marks the same across runs.
      	the shape of the history and stored tree.  See the section on
      	`ANONYMIZING` below.
      
    -+--seed-anonymized=<from>[:<to>]::
    ++--anonymize-map=<from>[:<to>]::
     +	Convert token `<from>` to `<to>` in the anonymized output. If
     +	`<to>` is omitted, map `<from>` to itself (i.e., do not
     +	anonymize it). See the section on `ANONYMIZING` below.
    @@ Documentation/git-fast-export.txt: collapse "User 0", "User 1", etc into "User X
     +paths, which becomes challenging after refnames and paths have been
     +anonymized. You can ask for a particular token to be left as-is or
     +mapped to a new value. For example, if you have a bug which reproduces
    -+with `git rev-list mybranch -- foo.c`, you can run:
    ++with `git rev-list sensitive -- secret.c`, you can run:
     +
     +---------------------------------------------------
     +$ git fast-export --anonymize --all \
    -+      --seed-anonymized=foo.c:secret.c \
    -+      --seed-anonymized=mybranch \
    ++      --anonymize-map=sensitive:foo \
    ++      --anonymize-map=secret.c:bar.c \
     +      >stream
     +---------------------------------------------------
     +
    -+After importing the stream, you can then run `git rev-list mybranch --
    -+secret.c` in the anonymized repository.
    ++After importing the stream, you can then run `git rev-list foo -- bar.c`
    ++in the anonymized repository.
     +
     +Note that paths and refnames are split into tokens at slash boundaries.
    -+The command above would anonymize `subdir/foo.c` as something like
    -+`path123/secret.c`.
    ++The command above would anonymize `subdir/secret.c` as something like
    ++`path123/bar.c`; you could then search for `bar.c` in the anonymized
    ++repository to determine the final pathname.
    ++
    ++To make referencing the final pathname simpler, you can map each path
    ++component; so if you also anonymize `subdir` to `publicdir`, then the
    ++final pathname would be `publicdir/bar.c`.
      
      LIMITATIONS
      -----------
    @@ builtin/fast-export.c: static void handle_deletes(void)
     +	return xstrdup(data);
     +}
     +
    -+static int parse_opt_seed_anonymized(const struct option *opt,
    -+				     const char *arg, int unset)
    ++static int parse_opt_anonymize_map(const struct option *opt,
    ++				   const char *arg, int unset)
     +{
     +	struct hashmap *map = opt->value;
     +	const char *delim, *value;
    @@ builtin/fast-export.c: static void handle_deletes(void)
     +	}
     +
     +	if (!keylen || !*value)
    -+		return error(_("--seed-anonymized token cannot be empty"));
    ++		return error(_("--anonymize-map token cannot be empty"));
     +
     +	anonymize_str(map, anonymize_seed, arg, keylen, (void *)value);
     +
    @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
      		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
      			     N_("Apply refspec to exported refs")),
      		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
    -+		OPT_CALLBACK_F(0, "seed-anonymized", &anonymized_seeds, N_("from:to"),
    ++		OPT_CALLBACK_F(0, "anonymize-map", &anonymized_seeds, N_("from:to"),
     +			       N_("convert <from> to <to> in anonymized output"),
    -+			       PARSE_OPT_NONEG, parse_opt_seed_anonymized),
    ++			       PARSE_OPT_NONEG, parse_opt_anonymize_map),
      		OPT_BOOL(0, "reference-excluded-parents",
      			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
      		OPT_BOOL(0, "show-original-ids", &show_original_ids,
    +@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
    + 	if (argc > 1)
    + 		usage_with_options (fast_export_usage, options);
    + 
    ++	if (anonymized_seeds.cmpfn && !anonymize)
    ++		die(_("--anonymize-map without --anonymize does not make sense"));
    ++
    + 	if (refspecs_list.nr) {
    + 		int i;
    + 
     
      ## t/t9351-fast-export-anonymize.sh ##
     @@ t/t9351-fast-export-anonymize.sh: test_description='basic tests for fast-export --anonymize'
    @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'setup simple repo' '
      test_expect_success 'export anonymized stream' '
     -	git fast-export --anonymize --all >stream
     +	git fast-export --anonymize --all \
    -+		--seed-anonymized=retain-me \
    -+		--seed-anonymized=xyzzy:custom-name \
    ++		--anonymize-map=retain-me \
    ++		--anonymize-map=xyzzy:custom-name \
     +		>stream
      '
      
10:  59737b97de ! 10:  103f5bcd65 fast-export: anonymize "master" refname
    @@ Commit message
     
         Note that we have to adjust the test a bit, since it relied on using the
         name "master" in the anonymized repos. We could just use
    -    --seed-anonymized=master to keep the same output, but then we wouldn't
    +    --anonymize-map=master to keep the same output, but then we wouldn't
         know if it works because of our hard-coded master or because of the
    -    seeding.
    +    explicit map.
     
         So let's flip the test a bit, and confirm that we anonymize "master",
         but keep "other" in the output.
    @@ builtin/fast-export.c: static const char *anonymize_refname(const char *refname)
      ## t/t9351-fast-export-anonymize.sh ##
     @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'export anonymized stream' '
      	git fast-export --anonymize --all \
    - 		--seed-anonymized=retain-me \
    - 		--seed-anonymized=xyzzy:custom-name \
    -+		--seed-anonymized=other \
    + 		--anonymize-map=retain-me \
    + 		--anonymize-map=xyzzy:custom-name \
    ++		--anonymize-map=other \
      		>stream
      '
      
 -:  ---------- > 11:  f2640407c5 fast-export: use local array to store anonymized oid
