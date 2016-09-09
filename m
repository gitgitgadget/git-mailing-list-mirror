Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BEC1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbcIIUkc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:40:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63558 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752299AbcIIUkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:40:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AEE23A85B;
        Fri,  9 Sep 2016 16:40:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aMdPQnpXhyE9Fpmo1fjKv5S3KMY=; b=gCXj/V
        q+2JnpZGaqtIpfJZIbVNw9MvNBlLktfX4hTbusUneObmuIOQYHsCJBXQi0Dvqpne
        d0LtOUjc8fLisDvCxJg2irdyIT4IOeHCpABaLGJ1yUKHGOrddaUXu0ya9C/TZOJC
        SEDWUxvPFsvrbVuHPvmYn1EyrTpHRP0jkzbLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TU0IZlT3TKZoZ6tJA+iRtVbjKPP4jcvr
        jxd+N4sO7c0k+ts2MiPunCRJ+K2T3PHIzX5bqR544DZB9DLD4OQezAW0nKOLck3a
        7jw0Ck3UNTLkUXweZX48BFKyq7JnFAS/FeiShR8lxMJGpj5hsUcAsDuZk3KfnT83
        44O2wTUrmYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 020663A85A;
        Fri,  9 Sep 2016 16:40:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71E783A859;
        Fri,  9 Sep 2016 16:40:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v4 3/3] connect: advertized capability is not a ref
References: <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1473441620.git.jonathantanmy@google.com>
        <ac55dc281e6875df8abcc6ed06d5f258a53dd251.1473441620.git.jonathantanmy@google.com>
        <20160909194037.GG25016@google.com>
Date:   Fri, 09 Sep 2016 13:40:27 -0700
In-Reply-To: <20160909194037.GG25016@google.com> (Jonathan Nieder's message of
        "Fri, 9 Sep 2016 12:40:37 -0700")
Message-ID: <xmqqtwdoajt0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A552B7B0-76CD-11E6-97FF-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Tan wrote:
>
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -172,8 +173,24 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>>  			continue;
>>  		}
>>  
>> +		if (!strcmp(name, "capabilities^{}")) {
>> +			if (saw_response)
>> +				warning("protocol error: unexpected capabilities^{}, "
>> +					"continuing anyway");
>
> Please use die() for these.
> ...
> The rest looks good.

Will squash this in, then.

 connect.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index df25d21..5ccbd10 100644
--- a/connect.c
+++ b/connect.c
@@ -175,11 +175,9 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 
 		if (!strcmp(name, "capabilities^{}")) {
 			if (saw_response)
-				warning("protocol error: unexpected capabilities^{}, "
-					"continuing anyway");
+				die("protocol error: unexpected capabilities^{}");
 			if (got_dummy_ref_with_capabilities_declaration)
-				warning("protocol error: multiple capabilities^{}, "
-					"continuing anyway");
+				die("protocol error: multiple capabilities^{}");
 			got_dummy_ref_with_capabilities_declaration = 1;
 			continue;
 		}
@@ -188,8 +186,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 
 		if (got_dummy_ref_with_capabilities_declaration)
-			warning("protocol error: unexpected ref after capabilities^{}, "
-				"using this ref and continuing anyway");
+			die("protocol error: unexpected ref after capabilities^{}");
 
 		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
 		oidcpy(&ref->old_oid, &old_oid);
