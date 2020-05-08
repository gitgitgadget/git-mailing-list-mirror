Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A397C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A474206B9
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x4IY/q/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHQR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:17:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51788 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHQR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:17:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF8D4B818;
        Fri,  8 May 2020 12:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xWEcmUrEoPYGtTz50AE1Tv9rOPo=; b=x4IY/q
        /K/XCZeJHYJikwOPBnJ0OjpuF5LgD2PW5dJp8hnBwczWsTU3XKYykDMTClueDl2L
        juyIBbyYog7VhpxBjIm22qC7FGDsjtNZFd1PP3R/6RCHmXSm2SzqHO9AFeT5lmEh
        Amz8hKqyITifqiAfaNy4tPPN207AyFr/AwkSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x2NmXpIjWN1mqsy6T3/rO00moOW7zqGt
        PICQL/4J/zUq21xKrQjD2VCdhDKpE0w4LTd04jpfoKUlXI5kxYEodZBUxMVy3Ena
        MEUAkcYm8bjMof/r0TTPiJC6AFUPMZlgmkntjBKeR5/aeDYSaifCIYmMxIKgWfnq
        uFZjre/mrVA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 453634B817;
        Fri,  8 May 2020 12:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDD254B816;
        Fri,  8 May 2020 12:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <20200508062136.15257-1-shouryashukla.oo@gmail.com>
        <20200508063022.GA18557@generichostname>
Date:   Fri, 08 May 2020 09:17:22 -0700
In-Reply-To: <20200508063022.GA18557@generichostname> (Denton Liu's message of
        "Fri, 8 May 2020 02:30:22 -0400")
Message-ID: <xmqqh7wqz9il.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65FC2F90-9147-11EA-8D7C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> +	if (argc != 2 || !path || !newurl) {
>> +		usage_with_options(usage, options);
>> +		return 1;

It is embarrassing that nobody noticed that usage_with_options() is
NORETURN; return 1 has no effect here.

>> +	}
>> +
>> +	config_name = xstrfmt("submodule.%s.url", path);
>> +
>> +	config_set_in_gitmodules_file_gently(config_name, newurl);
>> +	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
>> +
>> +	free(config_name);
>> +
>> +	return 0;
>> +}
>> +
>>  #define SUPPORT_SUPER_PREFIX (1<<0)
>>  
>>  struct cmd_struct {
