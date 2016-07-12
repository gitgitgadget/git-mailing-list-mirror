Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2C71FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbcGLTGh (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:06:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750808AbcGLTGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 15:06:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A88732A4FF;
	Tue, 12 Jul 2016 15:06:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bf69qSq8oJcf2jC59Tw2GXEso1M=; b=pi7mHX
	sRuQ2xej0mta+4GDYSq325utlVEzEzibwQm8uJ2WSHo2QZhcMdCDOC9thlrGHQE9
	McLbi/yWasdUeYN0VGEqNsyjOB+ibZfkdoNmD8R6rtPqrHvfpH0Xf3Qvc3f73IXZ
	cBLY9hJ19MNHowSDAMprJHw+n26ihJT19Wcbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dYuzi/gsSQCZA9narad9VvKu5Ib0K/wr
	587GEszMmpo2EkmoMahSzB650QffCGoEhNVYh717CfplTFmVs14MV2tKaFtW0YIL
	3XyfF320lneC0vxoHPJ/WvvX4z4KKg4bbdPv2z6wCHszayvyWPxdWRBbrW7tAMeD
	BealO16kfDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A10D62A4FE;
	Tue, 12 Jul 2016 15:06:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24F452A4FC;
	Tue, 12 Jul 2016 15:06:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 7/5] fsck: use streaming interface for large blobs in pack
References: <20160705170558.10906-1-pclouds@gmail.com>
	<20160710104555.27478-1-pclouds@gmail.com>
	<xmqq7fcq66q6.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 12 Jul 2016 12:06:32 -0700
In-Reply-To: <xmqq7fcq66q6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Jul 2016 11:39:45 -0700")
Message-ID: <xmqqvb0a4qx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C000A074-4863-11E6-8356-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +		if (type != OBJ_BLOB || size < big_file_threshold) {
>> +			data = unpack_entry(p, entries[i].offset, &type, &size);
>> +			data_valid = 1;
>
> This codepath slurps the data in-core to hash and data is later
> freed, i.e. non-blob objects and small ones are handled as before.
>
>> +		}
>> +
>> +		if (data_valid && !data)
>>  			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
>>  				    sha1_to_hex(entries[i].sha1), p->pack_name,
>>  				    (uintmax_t)entries[i].offset);
>
> Otherwise, we'd go to check_sha1_signature() with map==NULL.  And
> that is exactly what we want---map==NULL is the way we tell the
> function to use the streaming interface to check.
>
> Good.

But not quite correct yet ;-)

Here is what I'd propose to squash in.  Even though data_valid
protects the above if() condition from accessing an otherwise
uninitialized "data", the call to check_sha1_signature() we have
later will get noticed by the compiler that "data" is passed
uninitialized.

More importantly, uninitialized data passed may be non-NULL, in
which case it would not trigger the streaming interface.

 pack-check.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/pack-check.c b/pack-check.c
index 0777766..ac263fd 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -123,7 +123,14 @@ static int verify_packfile(struct packed_git *p,
 		type = unpack_object_header(p, w_curs, &curpos, &size);
 		unuse_pack(w_curs);
 
-		if (type != OBJ_BLOB || size < big_file_threshold) {
+		if (type == OBJ_BLOB && big_file_threshold <= size) {
+			/*
+			 * Let check_sha1_signature() to check it with
+			 * the streaming interface; no point slurping
+			 * the data in-core only to discard.
+			 */
+			data = NULL;
+		} else {
 			data = unpack_entry(p, entries[i].offset, &type, &size);
 			data_valid = 1;
 		}
