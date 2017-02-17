Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE9120136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbdBQQ7B (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:59:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:50943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdBQQ7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:59:00 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrqNe-1cF5U02Wti-013cVO; Fri, 17
 Feb 2017 17:58:54 +0100
Date:   Fri, 17 Feb 2017 17:58:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 0/2] Fix bugs in rev-parse's output when run in a
 subdirectory
In-Reply-To: <cover.1486740772.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1487350582.git.johannes.schindelin@gmx.de>
References: <cover.1486740772.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TQU7O4tWHwM2Y7MczgD1+SbY/cnRTW2VorPiT43uszFTFqq/9WK
 kTiMpwLJ962FNyuu4qOKGNal1zuSgd8UXUeLj7zowiMf6peEy22cL8x+RLss7UN7dEsgRFp
 PJ5EL8bxOx1yUrSlU6dJYj7rrSF9wxWUmLUvotztpml6WYrTrqQA095AOkxYQlHrEMXAHgV
 KYcwfECoh75lDaSGKbBrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ikJwJSSOn0=:TTbQDspEEoLuLJgAGD5rQx
 0rk0GEvaAWr9OOm7uOFnuBXs6amzgPQZlL37s4qKT+cpepK8dv9ZLMm0dJL50iSVlfOxBUNH4
 sXGsa/RvqQkWVUhlBJVk8/bSPregFqS3dcGNenRwPbB5m8eK3Qp7t/OTRDpVnvbm/9WhuWxjd
 A9CXYTHPI+m4kW5gAybdXh8IaHMcAQUj3E/CBx0uaxnYQU3KngKDxz3rYNyGHIkGksQUXyhnQ
 Jw1knW1mumv8YM2acq0qXdrH1BltiG+O+1cG+Sr4cnyEh5Pt6+Bu+xOvvg5mSIVfKtILwb0he
 nVdIoZ0OBqwrK71XWUjdYqIQ/kQlawk7oqPPBj01+96ERkp1TawB6ekxfECrkt9U2zgWd+SIz
 A5blyXungQomMe7Gs548v/Dg2Tj9WvinmNWbnIxSTSz7SA/AN2E031qYFv1zHmP+w34kpfdaw
 O1VtCp0bcqi9VzKsL3y3c0j96d+5g486r3V4nMbDyyn1sMUzbKjOP66W4+zX/9u7PB7OBAhwi
 BhsASBDk40VARe0y/UjHOX/vPCGpPOJIyu/0g7ClElzMSKcY/HL8jL31dJF5TgI5pTdyg7tTh
 7MlHrkbfYA08p0eiPhbupbgMyYWHetetaSeqaFmVu5pzar3JEZw1qo3kjcddMe61EPH7vvBfG
 XvUg7TX9LXDqNF1JR14b7YMI8lvlMteiGG4P0RpgG1Aj/fkpVQkvYVmvPrKNgHKuFwhRQzQQP
 zEyRkrgEXgZN349r6ncLbwpKnCEkeeau8yQH62uL4cpdWGKxw8h9geL3aZ2YU2EXUH/0DrO4b
 dKkmVBd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bug that bit me (hard!) and that triggered not only a long series of
curses but also my writing a patch and sending it to the list was that
`git rev-parse --git-path HEAD` would give *incorrect* output when run
in a subdirectory of a regular checkout, but *correct* output when run
in a subdirectory of an associated *worktree*.

I had tested the script in question quite a bit, but in a worktree. And
in production, it quietly did exactly the wrong thing.

Changes relative to v2:

- the "iffy" test in t1700 was made "uniffy"

- clarified in the commit message of 2/2 why we can get away with the
  "reset then use" pattern


Johannes Schindelin (1):
  rev-parse: fix several options when running in a subdirectory

Michael Rappazzo (1):
  rev-parse tests: add tests executed from a subdirectory

 builtin/rev-parse.c      | 15 +++++++++++----
 t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 16 ++++++++++++++++
 t/t2027-worktree-list.sh | 10 +++++++++-
 4 files changed, 64 insertions(+), 5 deletions(-)


base-commit: 076c05393a047247ea723896289b48d6549ed7d0
Published-As: https://github.com/dscho/git/releases/tag/git-path-in-subdir-v3
Fetch-It-Via: git fetch https://github.com/dscho/git git-path-in-subdir-v3

Interdiff vs v2:

 diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
 index 84af2802f6f..2cfd8d2aae4 100644
 --- a/builtin/rev-parse.c
 +++ b/builtin/rev-parse.c
 @@ -903,6 +903,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  			continue;
  		verify_filename(prefix, arg, 1);
  	}
 +	strbuf_release(&buf);
  	if (verify) {
  		if (revs_count == 1) {
  			show_rev(type, sha1, name);
 @@ -912,6 +913,5 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  		die_no_single_rev(quiet);
  	} else
  		show_default();
 -	strbuf_release(&buf);
  	return 0;
  }
 diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
 index 446ff34f966..6096f2c6309 100755
 --- a/t/t1700-split-index.sh
 +++ b/t/t1700-split-index.sh
 @@ -201,17 +201,16 @@ EOF
  '
  
  test_expect_success 'rev-parse --shared-index-path' '
 -	rm -rf .git &&
 -	test_create_repo . &&
 -	git update-index --split-index &&
 -	ls -t .git/sharedindex* | tail -n 1 >expect &&
 -	git rev-parse --shared-index-path >actual &&
 -	test_cmp expect actual &&
 -	mkdir work &&
 -	test_when_finished "rm -rf work" &&
 +	test_create_repo split-index &&
  	(
 -		cd work &&
 -		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
 +		cd split-index &&
 +		git update-index --split-index &&
 +		echo .git/sharedindex* >expect &&
 +		git rev-parse --shared-index-path >actual &&
 +		test_cmp expect actual &&
 +		mkdir subdirectory &&
 +		cd subdirectory &&
 +		echo ../.git/sharedindex* >expect &&
  		git rev-parse --shared-index-path >actual &&
  		test_cmp expect actual
  	)

-- 
2.11.1.windows.1.2.g87ad093.dirty

