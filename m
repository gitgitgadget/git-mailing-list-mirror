Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026AF20323
	for <e@80x24.org>; Wed, 22 Mar 2017 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbdCVUyl (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:54:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59073 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932208AbdCVUyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:54:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14D4A7C2C7;
        Wed, 22 Mar 2017 16:54:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kf35cNFD7S++RRklbKnobLSqwIo=; b=U1/Qrd
        UJiyTZ7t2YpLxgNzkYtMYlVMNvET08zZ7U2699bUK00mAatMbRcA4Wpk0xTRte+m
        caiATGH/aqGOE8HiRNpJnhg5PmUa2PPHAA1lHP0p+Di1eVjuIF90zggBTtY/M1cs
        LJaVOKB8OyGdD4l+KfgbLvZ/vxqyZcIUAEYRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UWm1e1ObtzXcdqJA4PNv9UeYXxMJfHY0
        Hpb+36JVcyo9WyTU2uiU4ZtjogWFwWInie6PycuxJwToecwxJHozRuu/vbtCalsM
        eXZllpuYUKxJorgoud3yA0HDrvdaFlyNMWi8NbPv5RCCs4hAJYiFSCF9FOnhNvj1
        Vz6Ba89jkEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C94B7C2C6;
        Wed, 22 Mar 2017 16:54:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7526D7C2C5;
        Wed, 22 Mar 2017 16:54:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
        <xmqqshm5je4d.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Mar 2017 13:54:36 -0700
In-Reply-To: <xmqqshm5je4d.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 22 Mar 2017 12:38:42 -0700")
Message-ID: <xmqq60j1jalv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2E1225A-0F41-11E7-977C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> This patch series replaces my earlier
>>      * jh/memihash-opt (2017-02-17) 5 commits
>> patch series.
>
> Ahh.  I was scratching my head trying to remember why some of these
> look so familiar.  [PATCH v2 ...] would have helped.
>
> Thank you for an update.

One notable difference I noticed since the previous round is that
this no longer adds precomputed hash to "struct cache_entry".  As
you are aiming to manage an index with a large number of entries,
this is a welcome change that makes sense.

$ make NO_PTHREADS=NoThanks name-hash.o
    CC name-hash.o
name-hash.c: In function 'lazy_init_name_hash':
name-hash.c:573:3: error: implicit declaration of function 'threaded_lazy_init_name_hash' [-Werror=implicit-function-declaration]
   threaded_lazy_init_name_hash(istate);
   ^
name-hash.c: In function 'test_lazy_init_name_hash':
name-hash.c:595:2: error: 'lazy_nr_dir_threads' undeclared (first use in this function)
  lazy_nr_dir_threads = 0;
  ^
name-hash.c:595:2: note: each undeclared identifier is reported only once for each function it appears in
name-hash.c:596:2: error: 'lazy_try_threaded' undeclared (first use in this function)
  lazy_try_threaded = try_threaded;
  ^
name-hash.c:601:1: error: control reaches end of non-void function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors
make: *** [name-hash.o] Error 1

still has to be addressed.  Perhaps squash pieces of these into
appropriate patches in the series?

 name-hash.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index a5826505e0..725ac22886 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -118,9 +118,16 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 	return remove ? !(ce1 == ce2) : 0;
 }
 
+static int lazy_try_threaded = 1;
+static int lazy_nr_dir_threads = 0;
 
 #ifdef NO_PTHREADS
 
+static void threaded_lazy_init_name_hash(struct index_state *istate)
+{
+	; /* nothing */
+}
+
 static int lookup_lazy_params(struct index_state *istate)
 {
 	return 0;
@@ -153,8 +160,6 @@ static int lookup_lazy_params(struct index_state *istate)
  */
 #define LAZY_MAX_MUTEX   (32)
 
-static int lazy_try_threaded = 1;
-static int lazy_nr_dir_threads = 0;
 static pthread_mutex_t *lazy_dir_mutex_array;
 
 /*
