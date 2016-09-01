Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298ED1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbcIAWcw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:32:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60801 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754099AbcIAWbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:31:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 273A239EDA;
        Thu,  1 Sep 2016 18:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Egv7KVNQeIFKNJt4f1/PXUi505I=; b=nMs9Yv
        gCMI+5Nrx+8lvd9erfuXx6A5l73HY4iEHFxvmj1GYGE+1MW4wIg7cx7owiJ2n1yt
        A7VhJMGtNpYqTOuP9fs2PlKXVGteOaq9uNLW3G++WCLRQU5cNOdKEgJKIfnX4SOV
        bMHnpxb7Fry6vX7FHd2mTSq5GyplcJ5V7sWz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P9aTtE6GEriIu+oXY4eLxD+0jJWZ1d4z
        7A+vIGhNWEIJU3pX9wb0zjZPlKtzcj9u8YdVldI29w+vFBvnagpLcRxemHw1t1ex
        DmbbPzEIKvO6Frj15coFlTT4Rjw1URs4eUSAwHliBIJbVBruayGlQpxvBHzdDJHK
        w/zzGHPQ4YY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2087039ED9;
        Thu,  1 Sep 2016 18:31:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B151439ED8;
        Thu,  1 Sep 2016 18:31:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Should "git symbolic-ref -d HEAD" be forbidden?
References: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com>
        <20160901211907.iivokwu3yjuxz3qf@sigill.intra.peff.net>
Date:   Thu, 01 Sep 2016 15:31:28 -0700
In-Reply-To: <20160901211907.iivokwu3yjuxz3qf@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Sep 2016 17:19:07 -0400")
Message-ID: <xmqq8tvbuu9r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D466B1D6-7093-11E6-94E8-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 01, 2016 at 02:08:08PM -0700, Junio C Hamano wrote:
>
>> I think we should.
>> 
>> t1401 expects to be able to, but if you really do it:
>> 
>> 	$ cd /tmp
>> 	$ git init throwaway
>>         $ cd throwaway
>>         $ git symbolic-ref -d HEAD
>> 
>> the setup machinery considers that you are no longer in a working
>> tree that is controlled by a repository at .git/ because .git/ is
>> no longer a valid repository, so you cannot even do
>> 
>> 	$ git symbolic-ref HEAD refs/heads/master
>> 
>> to recover.
>
> Yes, I think we should, too. The same reasoning from afe5d3d (symbolic
> ref: refuse non-ref targets in HEAD, 2009-01-29) applies.

-- >8 --
Subject: symbolic-ref -d: do not allow removal of HEAD

If you delete the symbolic-ref HEAD from a repository, Git no longer
considers it valid, and even "git symbolic-ref HEAD refs/heads/master"
would not be able to recover from that state.

In the spirit similar to afe5d3d5 ("symbolic ref: refuse non-ref
targets in HEAD", 2009-01-29), forbid removal of HEAD.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I decided against it for now for no good reason, other than I am a
 bit superstitious, but it may be a good idea to move these safety
 checks to delete_ref() and create_symref() in the longer term.

 builtin/symbolic-ref.c  |  2 ++
 t/t1401-symbolic-ref.sh | 19 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 9c29a64..96eed94 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -56,6 +56,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		ret = check_symref(argv[0], 1, 0, 0);
 		if (ret)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
+		if (!strcmp(argv[0], "HEAD"))
+			die("deleting '%s' is not allowed", argv[0]);
 		return delete_ref(argv[0], NULL, REF_NODEREF);
 	}
 
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index ca3fa40..5c30f94 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -33,18 +33,23 @@ test_expect_success 'symbolic-ref refuses bare sha1' '
 '
 reset_to_sane
 
-test_expect_success 'symbolic-ref deletes HEAD' '
-	git symbolic-ref -d HEAD &&
+test_expect_success 'HEAD cannot be removed' '
+	test_must_fail git symbolic-ref -d HEAD
+'
+
+test_expect_success 'symbolic-ref can be deleted' '
+	git symbolic-ref NOTHEAD refs/heads/foo &&
+	git symbolic-ref -d NOTHEAD &&
 	test_path_is_file .git/refs/heads/foo &&
-	test_path_is_missing .git/HEAD
+	test_path_is_missing .git/NOTHEAD
 '
 reset_to_sane
 
-test_expect_success 'symbolic-ref deletes dangling HEAD' '
-	git symbolic-ref HEAD refs/heads/missing &&
-	git symbolic-ref -d HEAD &&
+test_expect_success 'symbolic-ref can delete dangling symref' '
+	git symbolic-ref NOTHEAD refs/heads/missing &&
+	git symbolic-ref -d NOTHEAD &&
 	test_path_is_missing .git/refs/heads/missing &&
-	test_path_is_missing .git/HEAD
+	test_path_is_missing .git/NOTHEAD
 '
 reset_to_sane
 
