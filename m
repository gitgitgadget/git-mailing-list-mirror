Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F26D1FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 07:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbdCLHJe (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 03:09:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52136 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932223AbdCLHJd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 03:09:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2588C7C517;
        Sun, 12 Mar 2017 03:09:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ptda/EZjvfYgLdTfyJqX6pgvp04=; b=lvt+yM
        gsxpT+TeUENHfuMVkAFVjVy1bdMWr/NiU6/J5Y3Lw4Q0B4RxQ5Pjw255CzsLebwe
        Jm8IzF5hbUS+zfFJZWQSGKo5uQlz4lW3DfKGK3JgknPqwey0oZzm0hve7mM8U/bK
        PafTTi/LMiwDwzj1cQwa2D/JZScw2aMWbFEts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o12uOjcQGdG9xEwB2Q3/312u3IS6muvk
        TPuRic+LPLuofajayhFgc1sMrvWN9rOXbVRVQj0EMkNSf/WS/aopFNtNnEM9WGuq
        OMN5U/zxf508rFFIC34W9WU9NZsz3gt2l+7v5J1IbkWHeHC/a/1pBskyMHy/jJ44
        mcOhgbc8rcc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F2B97C516;
        Sun, 12 Mar 2017 03:09:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 812167C515;
        Sun, 12 Mar 2017 03:09:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        novalis@novalis.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 12/17] update submodules: add submodule_move_head
References: <20170306205919.9713-1-sbeller@google.com>
        <20170309221543.15897-1-sbeller@google.com>
        <20170309221543.15897-13-sbeller@google.com>
        <20170309233709.GD52558@google.com>
Date:   Sat, 11 Mar 2017 23:09:24 -0800
In-Reply-To: <20170309233709.GD52558@google.com> (Brandon Williams's message
        of "Thu, 9 Mar 2017 15:37:09 -0800")
Message-ID: <xmqqo9x7ug2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D35D2CC0-06F2-11E7-AED8-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> diff --git a/submodule.c b/submodule.c
>> index 0b2596e88a..bc5fecf8c5 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>>  	return ret;
>>  }
>>  
>> +static int submodule_has_dirty_index(const struct submodule *sub)
>> +{
>> +	struct child_process cp = CHILD_PROCESS_INIT;
>> +
>> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
>> +
>> +	cp.git_cmd = 1;
>> +	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
>> +					"--cached", "HEAD", NULL);
>
> The formatting of this line is a little odd.  Also you can drop the
> backslash.

Heh.  I think I saw and pointed out the same during the review of
the previous round X-<.  It is a bit disappointing.

>> +static void submodule_reset_index(const char *path)
>> +{
>> +	struct child_process cp = CHILD_PROCESS_INIT;
>> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
>> +
>> +	cp.git_cmd = 1;
>> +	cp.no_stdin = 1;
>> +	cp.dir = path;
>> +
>> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
>> +	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
>> +
>> +	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);

Somewhat related; will this use of --super-prefix be affected when
we split it into two for "adjust pathspec" prefix and "adjust
output" prefix?
