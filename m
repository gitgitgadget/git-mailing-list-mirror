Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8932095B
	for <e@80x24.org>; Thu, 23 Mar 2017 07:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbdCWHjI (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 03:39:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64377 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932484AbdCWHjH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 03:39:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D620810B6;
        Thu, 23 Mar 2017 01:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E99qQjZLGsZ7dgLzpse62X+49TM=; b=SeKCfL
        IKLgZy7Am7ScDn0XT5jpR3nmwqWHdCbCXn+rKSCjuxsZ9/276ZowoNAgmdkqIdIr
        uCKBDWKJZfnhW+qxSImxQd0bUoed8JWgxDGfFvVJl7relBuO45kneheFx0TOF9lf
        3uHtP/ZWWMlJZfXiPJuPzObPZgPDM0+aKrnNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WYmrz2Vp/FKOd+jRw8+LpcH1OKSpr5GB
        WYlF7cBG9MWNxMWeAalnaLkfmpDmysSqp4KNLvHqQKoJYq+xRkUulFOZJWM641ah
        pi8zfQFszdb/BatV95Eb3KRUt26zdX07dns2SvK23qY+5jJHvmZQ28zOQptvjgGs
        jDoFkkR0czs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 161B6810B4;
        Thu, 23 Mar 2017 01:43:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74863810B3;
        Thu, 23 Mar 2017 01:43:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2] tests: lint for run-away here-doc
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <xmqq7f3ghhc7.fsf_-_@gitster.mtv.corp.google.com>
Date:   Wed, 22 Mar 2017 22:43:18 -0700
In-Reply-To: <xmqq7f3ghhc7.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Wed, 22 Mar 2017 19:12:08 -0700")
Message-ID: <xmqqshm4fszt.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EA9BB46-0F8B-11E7-A402-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We found a few run-away here documents that are started with an
end-of-here-doc marker that is incorrectly spelled, e.g.

	git some command >actual &&
	cat <<EOF >expect
	...
	EOF &&
	test_cmp expect actual

which ends up slurping the entire remainder of the script as if it
were the data.  Often the command that gets misused like this exits
without failure (e.g. "cat" in the above example), which makes the
command appear to work, without eve executing the remainder of the
test.

Piggy-back on the test that catches &&-chain breakage to detect this
case as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The previous one was simply buggy; I forgot that there was an
   interesting redirection going on inside test_eval_.  Sorry for
   the noise.

   Also we could do this in the same test_eval_ without adding
   another one, which is how this version does it.

 t/test-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 86d77c16dd..d5f2b70bce 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -624,9 +624,9 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		test_eval_ "(exit 117) && $1"
-		if test "$?" != 117; then
-			error "bug in the test script: broken &&-chain: $1"
+		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		then
+			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
 		fi
 		trace=$trace_tmp
 	fi


