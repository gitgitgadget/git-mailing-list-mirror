Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450BB207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755557AbcIIXB3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:01:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65145 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755338AbcIIXB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:01:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91E5D3CAB5;
        Fri,  9 Sep 2016 19:01:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qr+IiKGY0UKsyRkAR0EVGDVoYsU=; b=dohLgx
        pfWlvXTCxAiYMauEKhdeIxG13K/R3kMEGJcqGQwFF81nNMcIPJ0TkItdqpbQO13a
        F3lO/hpz2AYSV3HNT5AnzFOBeB5iaWkaSx4JRdfdzeLiciQmfRg/eFUtCWOi+bxp
        9oVwhLc0htBWgnKJjOm+8/28DCi6e+ioMemSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fegA61FyhjaQeucUYNYLUx2dbPqPULVW
        EWMrw4o7k4qNX1strzi0fK+26giTNjLCcFiLBWTWGjXtEl0RCx1S4zfjGjRkGH+G
        sONIonFsBNDldu33ekAayPJt0x1YyX4Vnd6V0p3e0DXAT0UbiEdQLyWyFIDgMJbd
        4hCEkYQ4y+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ABB53CAB4;
        Fri,  9 Sep 2016 19:01:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 103CF3CAB3;
        Fri,  9 Sep 2016 19:01:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
Date:   Fri, 09 Sep 2016 16:01:25 -0700
In-Reply-To: <1473458004-41460-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 9 Sep 2016 14:53:24 -0700")
Message-ID: <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56690938-76E1-11E6-857A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Allow ls-files to recognize submodules in order to retrieve a list of
> files from a repository's submodules.  This is done by forking off a
> process to recursively call ls-files on all submodules.

While I see why "ls-files --recurse-submodules" sounds nice ("hey, I
can get list of _all_ the files here"), and I am quite happy with
the quality of implementation (not just the code but its
documentation and test) especially from a first-time contributor, I
am not quite sure what the utility of this new feature would be,
especially given that the command is a plumbing, i.e. meant to be a
useful building block for scripts.

If I get

	$ git ls-files --recurse-submodules
	Makefile
        lib/Makefile
        lib/hello.py
	main.py
	goodbye.py

out of the command, what can I do with it without knowing where the
submodule boundaries are?  It's not like I can just do

	git ls-files --recurse-submodule |
        while read path
        do
        	git update-index --add "$path"
	done

when "lib/" is a submodule.  Instead, I'd need to go to "lib/" and
then add "Makefile" and "hello.py" from there.

> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
> new file mode 100644
> index 0000000..78deded
> --- /dev/null
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -0,0 +1,103 @@
> +...
> +test_expect_success 'setup directory structure and submodules' '
> +...
> +'
> +
> +cat >expect <<EOF
> +.gitmodules
> +a
> +b/b
> +submodule/c
> +EOF

We used to do that when we didn't know better.

Please don't do things outside test_expect_* block, especially in a
new script.
