Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06FB2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 16:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbcGHQg6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 12:36:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932412AbcGHQgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2016 12:36:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3C61277FA;
	Fri,  8 Jul 2016 12:36:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=upM9xvZ9WuL0
	sUQQo3Oe4tziMaM=; b=Moa+wtgnRYqZnvBPFhsUx5HBwGAwy5aENP8CJ6+X4z+Q
	Rq5qpIieGl9iVy3DUHzT2Ga0ekG92ZtL99tnhM5PzaF1kGAtIm1o6iAtlebIctiy
	mLOWg4GTyXcLQI9UkA+a3xZolXi+VACtWji6yEc5vN2ngewGTGgQQ79FT3GugpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UlDz8S
	R6ObXIFgI+gwkS77/nU/2llIlh8xIn31ieClPcUj+ID9im0cuR9PQo+avHm7h8b8
	xVuji4fO9uCKqV4baz98ilRYdR0huh9/azCTxp0B2e1dXPMh1VQTtPNs9+uxIJWF
	zhC2JpfE4dDZmCdX6TcUr9hPhW+Tq8o22yZVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB356277F9;
	Fri,  8 Jul 2016 12:36:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F6E3277F8;
	Fri,  8 Jul 2016 12:36:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
	<xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
	<2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
Date:	Fri, 08 Jul 2016 09:36:45 -0700
In-Reply-To: <2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 8 Jul 2016 09:52:30
 +0200")
Message-ID: <xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29D379E6-452A-11E6-A6EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> I dunno.  I really do not like that extra sha1 argument added all
>> over the callchain by this patch.
>>
>> Or did you mean other calls to add_cacheinfo()?
>
> I didn't mean too much - the whole call chain touches code where I
> am not able to comment on details.
> I'm happy to test other implementations, if someone suggests a
> path, so to say.

I did a bit of experiment.

When 1/3 alone is applied, and then only changes for t/t6038 from
3/3 is picked, (i.e. we do not add the extra "don't look at index,
check this contents"), your "Merge addition of text=auto eol=CRLF"
test would fail.

And then with this further on top:

diff --git a/merge-recursive.c b/merge-recursive.c
index b880ae5..628c8ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -202,6 +202,9 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
+
+	if (!stage)
+		remove_file_from_cache(path);
 	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
 			      (refresh ? (CE_MATCH_REFRESH |
 					  CE_MATCH_IGNORE_MISSING) : 0 ));

I get the renomalized result registered to the index.

The root cause of the "bug", I think, is that the "safer crlf" is
fundamentally a flawed mechanism and does not mesh well with the
rest of the system.  If you start from an index without the path and
add a CRLF file in the working tree, you get LF blob (as expected),
but if you happen to already have CRLF file for the path in the
index, you get CRLF blob (as claimed to be "safer"), which
essentially means that with that mechanism in place, you do not know
blob with what object name you would get, given the same working
tree file with the same configuration setting.

In this codepath, we already have three stages in the index, and the
stage #2 happens to be a CRLF blob in your test.  make_cache_entry()
wants to refresh, which involves comparing the working tree file to
see if it hashes down to the same object name as ce->sha1, which is
the result of the "normalizing" merge that uses LF.  But if you
merge the other way, the stage #2 would have LF blob, and that would
not prevent the working tree file with CRLF written from the result
of the "normalizing" merge to be cleaned again to LF blob to
round-trip.

The "this is a minimum workaround" patch above disables the "safer
crlf" conversion by removing the stages that will get in the way.
When we are recording the cleanly resolved result of a merge, we
know what the resulting ce->sha1 should be, and we also know the
higher stages for the path will be removed, so there is no point
keeping the higher stages in the index and get them looked at by the
"safer crlf" codepath.

