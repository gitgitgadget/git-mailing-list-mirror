Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7750C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781BC20757
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ulD1M+fX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgD1QyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:54:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57984 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1QyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:54:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FC2A63F05;
        Tue, 28 Apr 2020 12:54:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O+AtaCJeIY28Kr3zBsCzHmyPUSI=; b=ulD1M+
        fXdYFTlciHF6DpJBUVt/ZqMpqs/cZxwBnRPQns3+GdPufcbaOhF59nz0YBAXYJHe
        9E1Mg4ibS6VH+3Jm8meO9npNtyVCYU5sSU4nVlzfEPCGWTGZxPA/0c5qZ+crIqLS
        kmdIaHc9keqUX/ylHC6N3kOfMZOEjbE+vg63I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cVjrMKS1H2JUvJRH16C5x3amSSwISmjW
        nKnBtrgYvpJXD7eq8evSgwQAHD/4CLZzVCATw1xALcrKDkl5Tep8loF/YeNEe3ri
        g+3e/Mwng7ptbJJRB1a5RMFwAQ2aXdfPZIatKh+moKjqhrp+VXXdvsONDLR2Rt8P
        hYkPK8j8tIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2687563F04;
        Tue, 28 Apr 2020 12:54:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1E1263F03;
        Tue, 28 Apr 2020 12:54:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fetch-pack: return enum from process_acks()
References: <cover.1587775989.git.jonathantanmy@google.com>
        <cover.1588031728.git.jonathantanmy@google.com>
        <f0cfbc03c27658e54a73c46570c5153961ed85b6.1588031728.git.jonathantanmy@google.com>
        <20200428005333.GE36078@google.com>
Date:   Tue, 28 Apr 2020 09:54:19 -0700
In-Reply-To: <20200428005333.GE36078@google.com> (Jonathan Nieder's message of
        "Mon, 27 Apr 2020 17:53:33 -0700")
Message-ID: <xmqqftcn4klg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7D0FB88-8970-11EA-B69D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  	/* return 0 if no common, 1 if there are common, or 2 if ready */
>
> This comment can be removed now, which is a nice bonus.
>
>> -	return received_ready ? 2 : (received_ack ? 1 : 0);
>> +	return received_ready ? READY :
>> +		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
>>  }
>>  
>>  static void receive_shallow_info(struct fetch_pack_args *args,
>> @@ -1508,13 +1529,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>>  		case FETCH_PROCESS_ACKS:
>>  			/* Process ACKs/NAKs */
>>  			switch (process_acks(negotiator, &reader, &common)) {
>> -			case 2:
>> +			case READY:
>>  				state = FETCH_GET_PACK;
>>  				break;
>> -			case 1:
>> +			case COMMON_FOUND:
>>  				in_vain = 0;
>>  				/* fallthrough */
>> -			default:
>> +			case NO_COMMON_FOUND:
>>  				state = FETCH_SEND_REQUEST;
>>  				break;
>>  			}
>
> With the extraneous comment removed,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yes, the result reads very clearly.

Locally amended.

Thanks.
