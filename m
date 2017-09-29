Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EF820A10
	for <e@80x24.org>; Fri, 29 Sep 2017 03:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdI2D6l (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 23:58:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751241AbdI2D6k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 23:58:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D61E9A889;
        Thu, 28 Sep 2017 23:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BT0yR4cuN+V8GrMTbiIZvRsPL4E=; b=d7D4Xs
        RKXoDq6EmwIbvBzNLhIQ6UOZptIKiCHiRG3GQqYb09AGhKTh7AUJsJxf9eAJkZ5U
        oL8JlO7ZjmzGHF43kZdUdbSLPW0pfAvIpJPR4gWEwRSxkUMAIDEjQhVJObJoxJkt
        RsGqdFxEtYZqR7iBW6iejjh3xD7I/YV3/gyjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZhDEhyghWBvfFxqRUI6bM+PQM7TTZvYC
        J5xMTEc7/MBygKP+bN5re4FwXU4Syp+BFshA1FsUztY/YQM1gobLG01wD7ooL/4X
        GF2RYWEJVuannYqizTgfnIJr283X03hUathTGhFrHgF88n1kKsiO3x5n3SnttQO8
        VhCGxaLCBtQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 153AB9A888;
        Thu, 28 Sep 2017 23:58:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C1E89A886;
        Thu, 28 Sep 2017 23:58:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Dridi Boukelmoune <dridi.boukelmoune@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-sh: Avoid sourcing scripts with git --exec-path
References: <20170928223134.GA30744@varnish>
        <20170929034856.GB28303@aiede.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 12:58:38 +0900
In-Reply-To: <20170929034856.GB28303@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 28 Sep 2017 20:48:56 -0700")
Message-ID: <xmqqtvzmxij5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79FFDF26-A4CA-11E7-8C59-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This has been broken for a while, but better late than never to
> address it.

I am not sure if this is broken in the first place.  We do want to
make sure that the scripted porcelains will source the shell helper
library from matching Git release.  The proposed patch goes directly
against that and I do not see how it could be an improvement.

>> --- a/contrib/rerere-train.sh
>> +++ b/contrib/rerere-train.sh
>> @@ -7,7 +7,8 @@ USAGE="$me rev-list-args"
>>  
>>  SUBDIRECTORY_OK=Yes
>>  OPTIONS_SPEC=
>> -. "$(git --exec-path)/git-sh-setup"
>> +PATH="$(git --exec-path):$PATH"
>> +. git-sh-setup
>
> This makes me similarly unhappy about PATH pollution, but it may be
> that there's nothing to be done about that.

To me, all the instances of the unhappiness in your review seem to
be caused by the unjustified declaration that it is bad to source
from the directory "gti --exec-path" reports.  If a user wants to
tweak things Git does, why should the user futz with his own copy
of sh-setup and force scripted Porcelains to read from it, which
would only affect the scripted Porcelains and have no chance of
affecting compiled commands?  Is building from the source so bad for
an open source tool?
