Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D14202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 11:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbdI0LXk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 07:23:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751671AbdI0LXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 07:23:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0D6DA30EE;
        Wed, 27 Sep 2017 07:23:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVAkyvtepfJPrpQws7WwunmHdfk=; b=I5hngG
        jTdFJ7iaShnc/5t0JFHlY8TIeMH80Zd16OvP8T88NrfmHTnA8cxB+KzApl+OOaMG
        TnMQwLouYnEoRKDnKXEyPs2sq1cigf4g6+zS49eWMcbgcrmv6w/wCvh2Qyv4xXR8
        FomlLzo1ehiIBq3qhjYXN34oFue+qOiBLJcH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=orsQbot7apmDKXSbIdk4GCm5WL+WHkxi
        MKkxOyVVXZrxDFx5MiqnPaYJhE5TnLAzwyrkiMpDGQPAOX6PJBJQAK+4jEDAL/FC
        IBHZpfQoO/lpZmXsUXg4RPGpwwIPDvsWqhOEcKr05IwdrQJey0W7kz3GgAdgQ2ma
        ATmsQCxU1Bk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97C88A30ED;
        Wed, 27 Sep 2017 07:23:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAE97A30EC;
        Wed, 27 Sep 2017 07:23:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-4-bmwill@google.com>
        <xmqq4lro7mab.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 27 Sep 2017 20:23:28 +0900
In-Reply-To: <xmqq4lro7mab.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 27 Sep 2017 14:17:32 +0900")
Message-ID: <xmqqvak42xn3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49EC44D2-A376-11E7-99A9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +enum protocol_version determine_protocol_version_server(void)
>> +{
>> +	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
>> +	enum protocol_version version = protocol_v0;
>> +
>> +	if (git_protocol) {
>> +		struct string_list list = STRING_LIST_INIT_DUP;
>> +		const struct string_list_item *item;
>> +		string_list_split(&list, git_protocol, ':', -1);
>> +
>> +		for_each_string_list_item(item, &list) {
>> +			const char *value;
>> +			enum protocol_version v;
>> +
>> +			if (skip_prefix(item->string, "version=", &value)) {
>> +				v = parse_protocol_version(value);
>> +				if (v > version)
>> +					version = v;
>> +			}
>> +		}
>> +
>> +		string_list_clear(&list, 0);
>> +	}
>> +
>> +	return version;
>> +}
>
> This implements "the largest one wins", not "the last one wins".  Is
> there a particular reason why the former is chosen?

Let me give my version of why the usual "the last one wins" would
not necessarily a good idea.  I would imagine that a client
contacting the server may want to say "I understand v3, v2 (but not
v1 nor v0)" and in order to influence the server's choice between
the available two, it may want to somehow say it prefers v3 over v2
(or v2 over v3).  

One way to implement such a behaviour would be "the first one that
is understood is used", i.e. something along this line:

        enum protocol_version version = protocol_unknown;

	for_each_string_list_item(item, &list) {
		const char *value;
		enum protocol_version v;
		if (skip_prefix(item->string, "version=", &value)) {
                	if (version == protocol_unknown) {
                        	v = parse_protocol_version(value);
			        if (v != protocol_unknown)
					version = v;
			}
		}
	}

	if (version == protocol_unknown)
		version = protocol_v0;

and not "the largest one wins" nor "the last one wins".

I am not saying your code or the choice of "the largest one wins" is
necessarily wrong.  I am just illlustrating the way to explain
"because I want to support a usecase like _this_, I define the way
in which multiple values to the version variable is parsed like so,
hence this code".  IOW, I think this commit should mention how the
"largest one wins" rule would be useful to the clients and the
servers when they want to achieve X---and that X is left unexplained.



