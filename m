Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F17C7EE32
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 19:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCCTZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjCCTY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 14:24:56 -0500
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5424C85
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 11:24:37 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1677871034;
        bh=eF/C1bN7nfwEoy4dhgOTAOV1DiygdvQPhCYtiV0+G9Y=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=pcAXdsQzieGIFrDk5ih276ABFqze6WbTS+uilxpbqiMaHB5xoKFVV/GaXrDnhQKFU
         kBgsurcTARD0kl2hr7FGJqlGTx9Zqo/2E4Ziw8+aCWY0b5wWKwoNoTKLSBnss3nhNB
         HspwqUdryWd7YMyRVv3+mjMDUjqJvWAgETsBX9cKUvLbexAx6XisP5vtKQut/x25rj
         RAQ4+jqLFPTU6LKSQkxI0YtK1qjUuSyUzlxZC141WFoUUqiQPFUm/FHC/cAuc6GEZ0
         LmvIiv3zYgwT75MLDjxnu562Ht0vtQTAYXQ1xmZK1FvRM7ACfxYbI5K9wDG3jdKKji
         SOPsPufPjzMLA==
To:     toon@iotcl.com
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: [PATCH v4 0/2] cat-file: quote-format name in error when using -z
Date:   Fri,  3 Mar 2023 20:17:06 +0100
Message-Id: <20230303191708.77894-1-toon@iotcl.com>
In-Reply-To: <20230116190749.4141516-1-toon@iotcl.com>
References: <20230116190749.4141516-1-toon@iotcl.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is the fourth revision of my patch to fix the error message for
git-cat-file(1) when using --batch and -z.

I was asked to provide test coverage for both code paths that produce this kind
of error message. Instead I've decided to extract the error formatting into a
separate function. For two reasons:

 * It deduplicates code.

 * The code path that was not tested is hit by --batch-all-objects. I was not
  able to set up a test that hits that code. I'm happy to write that test, if
  anyone can give me a pointer how to produce a "missing" error with that
  option.


Toon



Toon Claes (2):
  cat-file: extract printing batch error message into function
  cat-file: quote-format name in error when using -z

 builtin/cat-file.c  | 71 +++++++++++++++++++++++++++------------------
 t/t1006-cat-file.sh |  8 +++++
 2 files changed, 51 insertions(+), 28 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  b2f4ce88f2 cat-file: extract printing batch error message into function
1:  a56932572c ! 2:  9e31796dc1 cat-file: quote-format name in error when using -z
    @@ builtin/cat-file.c
      #include "object-store.h"
      #include "promisor-remote.h"
      #include "mailmap.h"
    -@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    - 						       &data->oid, &data->info,
    - 						       OBJECT_INFO_LOOKUP_REPLACE);
    - 		if (ret < 0) {
    -+			struct strbuf quoted = STRBUF_INIT;
    -+
    -+			if (opt->nul_terminated &&
    -+			    obj_name) {
    -+				quote_c_style(obj_name, &quoted, NULL, 0);
    -+				obj_name = quoted.buf;
    -+			}
    -+
    - 			printf("%s missing\n",
    - 			       obj_name ? obj_name : oid_to_hex(&data->oid));
    -+			strbuf_release(&quoted);
    - 			fflush(stdout);
    - 			return;
    - 		}
    -@@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
    - 	result = get_oid_with_context(the_repository, obj_name,
    - 				      flags, &data->oid, &ctx);
    - 	if (result != FOUND) {
    +@@ builtin/cat-file.c: static void batch_print_error(const char *obj_name,
    + 			      enum get_oid_result result,
    + 			      struct batch_options* opt)
    + {
     +		struct strbuf quoted = STRBUF_INIT;
     +
    -+		if (opt->nul_terminated) {
    ++		if (opt->nul_terminated &&
    ++		    obj_name) {
     +			quote_c_style(obj_name, &quoted, NULL, 0);
     +			obj_name = quoted.buf;
     +		}
    @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
      		switch (result) {
      		case MISSING_OBJECT:
      			printf("%s missing\n", obj_name);
    -@@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
    - 			       result);
    +@@ builtin/cat-file.c: static void batch_print_error(const char *obj_name,
      			break;
      		}
    -+
    -+		strbuf_release(&quoted);
      		fflush(stdout);
    - 		return;
    - 	}
    ++		strbuf_release(&quoted);
    + }
    +
    + /*

      ## t/t1006-cat-file.sh ##
     @@ t/t1006-cat-file.sh: test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
--
2.39.2
