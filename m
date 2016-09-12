Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8977920985
	for <e@80x24.org>; Mon, 12 Sep 2016 19:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756119AbcILTRd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:17:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63918 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753534AbcILTRc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:17:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4849E3DAA3;
        Mon, 12 Sep 2016 15:17:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=43bpVsbIeHKLqZGn2R8ZRMgiBDk=; b=cU4A39
        d1jYgqOXD0ustoO3H6+FaGFFN3y0Edl02wMFfAjJqTtrYs76Eml74tJnxELcESCg
        RF+UOUgzbfEkrAsd1L5B4WpKmt2xe4MMawWUvrygnzoDCQFaHjgyNgJf77KKZK+8
        OtUFZFJlDgSKwfOluYlVJy1NfgpHHDFv/BS3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XzRom42t3roHzLH5NUe4yGeg0hxVVcaB
        c/fDvH8BmQgmzLAb3G0ht28A20R13QIZUVaG1BevsQQAseDrnYRX5I+WP4npQRA6
        fimnby11VIirpjWlOhwgCzsv9qlEU3rfDjytGfm7mAhtf64Ago+RlSELQfsQWXZR
        nYLy5wqOyuo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 407573DAA2;
        Mon, 12 Sep 2016 15:17:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9EC33DAA1;
        Mon, 12 Sep 2016 15:17:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen & friends to build area
References: <20160910150512.19473-1-kirr@nexedi.com>
        <xmqqh99l2aqt.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 12 Sep 2016 12:17:28 -0700
In-Reply-To: <xmqqh99l2aqt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 12 Sep 2016 12:12:26 -0700")
Message-ID: <xmqqd1k92aif.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D06B7C2-791D-11E6-857D-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  build_git_rev () {
>>  	rev=$1
>> -	cp ../../config.mak build/$rev/config.mak
>> +	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}
>
> That unfortunately is a GNUism -t with a bash-ism {a,b,c}; just keep
> it simple and stupid to make sure it is portable.
>
> This is not even a part that we measure the runtime for anyway.

In other words, something along this line, perhaps.

 t/perf/run | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index aa383c2..69a4714 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -30,7 +30,10 @@ unpack_git_rev () {
 }
 build_git_rev () {
 	rev=$1
-	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}
+	for config in config.mak config.mak.autogen config.status
+	do
+		cp "../../$config" "build/$rev/"
+	done
 	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
 	die "failed to build revision '$mydir'"
 }
-- 
2.10.0-342-gc678130

