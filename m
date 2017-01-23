Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122B120A17
	for <e@80x24.org>; Mon, 23 Jan 2017 21:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdAWVQt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 16:16:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50253 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750723AbdAWVQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 16:16:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20CF662231;
        Mon, 23 Jan 2017 16:11:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zV3OWoNrwE/1Ptr8JifC6vkC2/Q=; b=pJMjWj
        7ECidXIEXGuydOtZ+ycF67W/kN7DAFIg8BRCwNnXUmItWNiY4VdJMJRAia9n2dlg
        kD+kNGZ2frEZMRJzKSf+dYY4EcDD0EfkJosbQZyRIGmRobi3dRRaE7+W/XnvmA16
        StlhrhasauOGEnXi+wRmwS2nQ6IDwzu3mzA74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MdAj8fZsGpitphsoguM7qYV1j8IUtkvV
        KQT2nfgwU+kotWuFBApAb7IoKG4t9SkbqPP9kLm9efqYamMsOVPPVI7ZUSlcWOHf
        aEHTkJx8nklkQ3wR/f1QAXoqNBpJL6X2bndWixg6fimJg52ikLSVdkn9P+j9Nbb9
        O8XuObITYHg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18EFC62230;
        Mon, 23 Jan 2017 16:11:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76E366222F;
        Mon, 23 Jan 2017 16:11:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 22/27] attr: eliminate global check_all_attr array
References: <20170112235354.153403-1-bmwill@google.com>
        <20170123203525.185058-1-bmwill@google.com>
        <20170123203525.185058-23-bmwill@google.com>
Date:   Mon, 23 Jan 2017 13:11:48 -0800
In-Reply-To: <20170123203525.185058-23-bmwill@google.com> (Brandon Williams's
        message of "Mon, 23 Jan 2017 12:35:20 -0800")
Message-ID: <xmqq7f5lqy5n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E0BD64C-E1B0-11E6-AC71-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Currently there is a reliance on 'check_all_attr' which is a global
> array of 'attr_check_item' items which is used to store the value of
> each attribute during the collection process.
>
> This patch eliminates this global and instead creates an array per
> 'attr_check' instance which is then used in the attribute collection
> process.  This brings the attribute system one step closer to being
> thread-safe.

Hmph, how close is "closer"?  

My understanding of this is that a codepath that has a single
"attr_check" can be executing simultaneously by multiple threads,
and "attr_check" is meant to contain read-only stuff sharable by
them.  Unless this check_all_attr is tied to the attr_result (which
in turn is tied to each invocation and typically is on stack), the
resulting code would not be safe, right?

