Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80937203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbcGZNdz (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 09:33:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:20268 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbcGZNdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 09:33:54 -0400
Received: from [10.160.15.137] (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 0BAD184622;
	Tue, 26 Jul 2016 09:33:51 -0400 (EDT)
Subject: Re: [PATCH v2 4/8] status: per-file data collection for
 --porcelain=v2
To:	Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <jeffhost@microsoft.com>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
 <1469474750-49075-5-git-send-email-jeffhost@microsoft.com>
 <xmqq1t2h5vbt.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5797663A.5000507@jeffhostetler.com>
Date:	Tue, 26 Jul 2016 09:31:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1t2h5vbt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/25/2016 04:14 PM, Junio C Hamano wrote:
> Jeff Hostetler <jeffhost@microsoft.com> writes:
>
>> +static void aux_updated_entry_porcelain_v2(
>> +	struct wt_status *s,
>> +	struct wt_status_change_data *d,
>> +	struct diff_filepair *p)
>> +{
>> +	switch (p->status) {
>> +	case DIFF_STATUS_ADDED:
>> +		/* {mode,sha1}_head are zero for an add. */
>> +		d->aux.porcelain_v2.mode_index = p->two->mode;
>
> I doubt that it makes sense in the longer term to have a new "aux"
> field.  Why isn't it part of the wt_status_change_data structure?
> For that matter, why should these new functions have both "aux" and
> "v2" in their names?
>
> Imagine what should happen when somebody wants to add --porcelain=v3
> format in 6 months.  Why must "v3" be treated differently from "v1"
> and in a way close to "v2"?  Why shouldn't all the three be treated
> in a similar way that "v1" has already?

I wasn't sure if we wanted the v2 fields to be isolated
and only filled in for v2 requests or whether we wanted
them to be common going forward.  In the case of the former,
I could see the "aux" struct becoming a union and the various
aux_*() routines only populating one member in that union.
And then the various per-format print routines would know
which aux member to access.  That may be more complicated
that necessary though -- if we assume that any subsequent
formats (and possibly any JSON formats) would always want
to keep these fields and add more.

I'll flatten the fields into the main structure.

>
>> +		oidcpy(&d->aux.porcelain_v2.oid_index, &p->two->oid);
>> +		break;
>> +
>> +	case DIFF_STATUS_DELETED:
>> +		d->aux.porcelain_v2.mode_head = p->one->mode;
>> +		oidcpy(&d->aux.porcelain_v2.oid_head, &p->one->oid);
>> +		/* {mode,oid}_index are zero for a delete. */
>> +		break;
>> +
>> +	case DIFF_STATUS_RENAMED:
>> +		d->aux.porcelain_v2.rename_score = p->score * 100 / MAX_SCORE;
>
> I have a slight aversion against losing the precision in a helper
> function like this that does not do the actual output, but it
> probably is OK.
>
> Don't we have copy detection score that is computed exactly the same
> way for DIFF_STATUS_COPIED case, too?

Yes I believe so.  I'll see about adding that.  Or rather make
the field apply to both.

>
> For readability, unless a case arm is completely empty, we should
> have
> 		/* fallthru */
>
> comment where "break;" would go for a normal case arm.

will do. thanks.
