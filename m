Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB77207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 04:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbdDUEBS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 00:01:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55717 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750933AbdDUEBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 00:01:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C32ED80878;
        Fri, 21 Apr 2017 00:01:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kx0+LO4UYJnhv0JzvNrTCsjpKwM=; b=mJeKOg
        fMoBQ+2jA/CvpAi0BLPL2nxnJWqfZii/19LUx9b13WzvPU98glhFNWRlCtXIanTh
        YXgaqUBM5OaowJ1a6js86CixVvSYMqP1C7ql0W3PVQHlmtnR6O6QD7FqyWx1td52
        aTU+AoE2dlrJfFkP2Nn6E3STpobSmZ909KL7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gojx6vjEEVuARVuWJqRKoZiPTObX2Tcz
        wAkvff6wrrIlncVhesN/fGRPxy4a2M+/O+CHb/NHcMEYmWrPvVQKpTGwYIrNGO5e
        e1Lcy8sLHY8cm5KgbzuyD3UlNBJKvOeCdyebFEVMrKJicxhZ5v98pO+JAbigncrJ
        heK6apBcVaI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBF7B80877;
        Fri, 21 Apr 2017 00:01:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28E4E80876;
        Fri, 21 Apr 2017 00:01:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
References: <20170420205214.GB4989@hank>
        <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
Date:   Thu, 20 Apr 2017 21:01:04 -0700
In-Reply-To: <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
        (Christian Couder's message of "Thu, 20 Apr 2017 23:03:46 +0200")
Message-ID: <xmqqfuh25rzz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 244F5036-2647-11E7-A085-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Could you try with the following patch:
>
> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/

Ah, this reminds me.  The patch has been in the stalled state for
quite some time due to confusing description.  How about explaining
it like so and merge it to 'next'?

-- >8 --
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Mar 2017 23:03:54 +0200
Subject: [PATCH] read-cache: avoid using git_path() in freshen_shared_index()

When performing an interactive rebase in split-index mode,
the commit message that one should rework when squashing commits
can contain some garbage instead of the usual concatenation of
both of the commit messages.

The code uses git_path() to compute the shared index filename, and
passes it to check_and_freshen_file() as its argument; there is no
guarantee that the rotating pathname buffer passed as argument will
stay valid during the life of this call.  Make our own copy before
calling the function and pass the copy as its argument to avoid this
risky pattern.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 8cf0673adc..0b166c211a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1690,9 +1690,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  */
 static void freshen_shared_index(char *base_sha1_hex, int warn)
 {
-	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
 	if (!check_and_freshen_file(shared_index, 1) && warn)
 		warning("could not freshen shared index '%s'", shared_index);
+	free(shared_index);
 }
 
 int read_index_from(struct index_state *istate, const char *path)
-- 
2.13.0-rc0-176-gf5d713c632

