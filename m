Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15091203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbcGYUOg (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:14:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752487AbcGYUOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 16:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 074CC3149B;
	Mon, 25 Jul 2016 16:14:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/LysXxyY+I9wQ6avrr66OhQfr5g=; b=sTPWs6
	+/fU21MQHf8K9wdQ1PG+cbcyr4KqecfHtEmD+ooAeqOqj94Y+n2vHGLPSguDzTnl
	zR/POBq5FSZwsUTKB6P6UbVAWo+lVKySWS6CETJy5xrzNlCRBVn96V7UXfLf52Eu
	MC6EVVUnQRkTi7eVMNaT48yFxaGkkiPX3BNFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pP86hX+0MutEGlVEtw9aGPc1GMHZlBfZ
	TWIwqzMOKzPli8UMpHMUc8Sw/qPkUeRoZSt7rzNSARtjtVW+sh6lyeipLukopl0C
	ic8kmcNoNe1ClTLsKqKx+PyW2bg2UmTsNBXL7PLu+ny31s9DaFHJGj2ymdrukMzk
	EP/LmB9+Pak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F320D3149A;
	Mon, 25 Jul 2016 16:14:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7962B31499;
	Mon, 25 Jul 2016 16:14:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 4/8] status: per-file data collection for --porcelain=v2
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
	<1469474750-49075-5-git-send-email-jeffhost@microsoft.com>
Date:	Mon, 25 Jul 2016 13:14:30 -0700
In-Reply-To: <1469474750-49075-5-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Mon, 25 Jul 2016 15:25:46 -0400")
Message-ID: <xmqq1t2h5vbt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 664214E6-52A4-11E6-B931-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> +static void aux_updated_entry_porcelain_v2(
> +	struct wt_status *s,
> +	struct wt_status_change_data *d,
> +	struct diff_filepair *p)
> +{
> +	switch (p->status) {
> +	case DIFF_STATUS_ADDED:
> +		/* {mode,sha1}_head are zero for an add. */
> +		d->aux.porcelain_v2.mode_index = p->two->mode;

I doubt that it makes sense in the longer term to have a new "aux"
field.  Why isn't it part of the wt_status_change_data structure?
For that matter, why should these new functions have both "aux" and
"v2" in their names?

Imagine what should happen when somebody wants to add --porcelain=v3
format in 6 months.  Why must "v3" be treated differently from "v1"
and in a way close to "v2"?  Why shouldn't all the three be treated
in a similar way that "v1" has already?

> +		oidcpy(&d->aux.porcelain_v2.oid_index, &p->two->oid);
> +		break;
> +
> +	case DIFF_STATUS_DELETED:
> +		d->aux.porcelain_v2.mode_head = p->one->mode;
> +		oidcpy(&d->aux.porcelain_v2.oid_head, &p->one->oid);
> +		/* {mode,oid}_index are zero for a delete. */
> +		break;
> +
> +	case DIFF_STATUS_RENAMED:
> +		d->aux.porcelain_v2.rename_score = p->score * 100 / MAX_SCORE;

I have a slight aversion against losing the precision in a helper
function like this that does not do the actual output, but it
probably is OK.

Don't we have copy detection score that is computed exactly the same
way for DIFF_STATUS_COPIED case, too?

For readability, unless a case arm is completely empty, we should
have
		/* fallthru */

comment where "break;" would go for a normal case arm.

> +	case DIFF_STATUS_COPIED:
> +	case DIFF_STATUS_MODIFIED:
> +	case DIFF_STATUS_TYPE_CHANGED:
> +	case DIFF_STATUS_UNMERGED:
> +		d->aux.porcelain_v2.mode_head = p->one->mode;
> +		d->aux.porcelain_v2.mode_index = p->two->mode;
> +		oidcpy(&d->aux.porcelain_v2.oid_head, &p->one->oid);
> +		oidcpy(&d->aux.porcelain_v2.oid_index, &p->two->oid);
> +		break;
