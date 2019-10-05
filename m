Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BAB1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 22:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfJEWvX (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 18:51:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65349 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEWvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 18:51:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7221319309;
        Sat,  5 Oct 2019 18:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7toR33WMZbv/k/LhD0zlwdmy3JU=; b=LLS7yz
        OaBrSMhc72+SXZHvFKfabSskVdyAGa/c92kfDhKoxMDiNYnhqRmphQ+RPZaKbg9t
        BPFBUqeGj/HjlQwySD/g7ZeGCqBc75aodQQ1sciufBZyTsgSctp3p8BEqrnZzBbM
        iwHeWk8Hvpn7WjW7+HXcfxItmwJ6VSQ5pp4CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RM3+IQSPe5CKo3FPKj7CD37kQ1sWRgou
        8sS+uu7j8JJxVBGch3ZG5Zf6vmViSRuGBPIuFXQowzUCI8SodVXYqj+FE8xZ2kxG
        sm/HOq4Q6fKy400d1G26Cf1DQi5hBZKz8+3Ql+F4Uorg+9u8Z6NsAA0FyCecsZh7
        G8SUztknXfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69E7719308;
        Sat,  5 Oct 2019 18:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D37B419307;
        Sat,  5 Oct 2019 18:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] apply: tell user location of corrupted patch file
References: <20191002184546.GA22174@generichostname>
        <ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com>
        <xmqqv9t37fsw.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 06 Oct 2019 07:51:20 +0900
In-Reply-To: <xmqqv9t37fsw.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 05 Oct 2019 17:33:03 +0900")
Message-ID: <xmqq4l0m7qmv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6C09766-E7C2-11E9-931B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  		if (len <= 0) {
>>  			free(fragment);
>> -			return error(_("corrupt patch at line %d"), state->linenr);
>> +			return error(_("corrupt patch at %s:%d"), state->patch_input_file, state->linenr);
>>  		}
>
> Do not forget that you can run "git apply" and feed the patch from
> its standard input, e.g.
>
> 	$ git apply <patchfile
> 	$ git show -R | git apply
>
> Make sure state->patch_input_file is a reasonable string before
> considering this.

I think what the patch does is safe in this case; callsites of
apply_patch(), which sets the .patch_input_file field, pass the
string "<stdin>", so you'd say

	error: corrupt patch at <stdin>:43

We lost the word "line" in the message, but it would be picked up
rather quickly by users that colon + integer is a line number, so
I think it is OK.

> Also, if you have a mbox file
>
> 	$ cd sub/direc/tory
> 	$ git am -s /var/tmp/mbox
>
> The "git apply" process thatis run inside "git am" would be running
> at the top level of the working tree, so state->patch_input_file may
> say ".git/rebase-apply/patch" (i.e. relative pathname) that is not
> relative to where the end user is in.  I personally do not thinkg it
> matters too much, but some people may complain.
>
> Other than that, looks good.  I am kind-of surprised that there is
> only one place that we report an unusable input with a line number.
> Nicely found.

I still do not know if we have a relative-path problem, how severe
it would be if there is, or if it is fixable if we wanted to and
how, though.


Thanks.

