Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4621F463
	for <e@80x24.org>; Wed, 18 Sep 2019 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfIRTzX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 15:55:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62543 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbfIRTzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 15:55:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9E7B811C7;
        Wed, 18 Sep 2019 15:55:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ZshfML1Zm4BNkxLSXfVhncLWao=; b=i8Da9O
        JjoNkkwMxx4a1CvLXu49aivFgBmfHLLlvpCOSN4odUPgYi5MGJDeInIoNrsA4S0K
        sDDs0vk67oT3WmiqiAgy0UwkZOdsK4AQOiqFj1f8rjF4dg5IMfbOmNjdKa3PF46G
        G/Cx4XllTJYTrmQjnFOkUoH2A1YsYmXCduflI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlnlRHzc28eVfdTjuUU96Zlcn6qa0rd9
        qG5bij8ZPhNtd4IIV1/z5WRjPa3oCpQZNj9KEHEJqt6Ijlat0a47ITcF93AxndEM
        Be5orGHXsGb/h/WNkbSTFzcr1Gr87ZIt7MYj2QW5B0aEWZo9ILf6uqMEBmZGiGrb
        IoP2sX01wAE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3809811C6;
        Wed, 18 Sep 2019 15:55:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11514811C4;
        Wed, 18 Sep 2019 15:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
References: <cover.1568771073.git.matheus.bernardino@usp.br>
Date:   Wed, 18 Sep 2019 12:55:12 -0700
In-Reply-To: <cover.1568771073.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Tue, 17 Sep 2019 22:56:02 -0300")
Message-ID: <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B6D7A28-DA4E-11E9-95C4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Make git-grep --recurse-submodules stop adding subrepos to the in-memory
> alternates list and, instead, pass a reference to the subrepo struct
> down to the threads.

Nice.  This is done by updating all the codepaths used by grep to
use the lower-level helper functions that can take a repository
instance and/or an object store instance that is not the one tied to
the top-level repository?  Quite nice.

> - textconv cache is written to the_repository's object database even for
>   submodules. Should it perhaps be written to submodules' odb instead?

You mention "is written", but that is what happens upon a cache
miss.  Before the code notices a cache miss, it must be checking if
a cached result is available.  In which odb is it done?  Writing
that follow the miss should happen to the same one, or the cache is
not very effective.

Because you would want the cache to be effective, after running "git
grep --recurse-submodules" from the top-level, when you chdir down
to the submodule and say "git grep" to dig further, the answer to
your question is most likely "yes".

> - Considering the following call chain: grep_source_load_driver() >
>   userdiff_find_by_path() > git_check_attr() > collect_some_attrs() >
>   prepare_attr_stack() > bootstrap_attr_stack():
>
>   * The last function tries to read the attributes from the
>     .gitattributes and .git/info/attributes files of the_repository.
>     However, for paths inside the submodule, shouldn't it try to read
>     these files from the submodule?

Yes, I think all of those would have worked correctly if we forked a
separate "git grep" inside submodule repository, but in the rush to
"do everything in process", many things like these are not done
correctly.  As there is only one attribute cache IIUC, invalidating
the whole cache for the top-level and replacing it with the one for
a submodule, every time we cross the module boundary, would probably
have a negative effect on the performance, and I am not sure what
would happen if you run more than one threads working in different
repositories (i.e. top-level and submodules).

>   * This function will also call: read_attr() > read_attr_from_index() >
>     read_blob_data_from_index() which might, in turn, call
>     read_object_file(). Shouldn't we pass the subrepo to it so that it
>     can call repo_read_object_file()? (Again, for paths inside the
>     submodule, read_object_file() won't be able to find the object as
>     we won't be adding to alternates anymore.)

Ditto.

Thanks.
