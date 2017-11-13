Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB563201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 01:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdKMBeE (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 20:34:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751100AbdKMBeD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 20:34:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E795E9542B;
        Sun, 12 Nov 2017 20:34:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7WzzDblfHUWh48lx0ucjQprQxPU=; b=ffajOu
        EtzmFp5bVHMTe+pBIgMC0MzHT5fdOC/mGSf+aAn5YeTrhmNt6UmY0t6/2cxe8E30
        BPtsgblKsgK8i5B3XMU6kxa1SSAPADT/TA1kq8CKP6iEyXx7NL67xonrGENZcdYc
        vfwfGRkQNUcexbyHmlz0aS8EBE1gKdUeaLKY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tsI7FYH4wtqjCyNR3kPwhbmKKErXUSEf
        OXWiRb1mkoZttWXpPZ2yY9STSfNtIWh+nWhJGELuWCUKX515Azd7KQ86DHCDcZ+S
        jJqcyrqZLKy4s0fVKWbxk+bD0/JZdkAJHu/hxuOPL7PAKRp2Y0ZaAWj8s11LNEfK
        rZciMkSmaEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B95599542A;
        Sun, 12 Nov 2017 20:34:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A29395429;
        Sun, 12 Nov 2017 20:34:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, philipoakley@iee.org
Subject: Re: [PATCH] builtin/describe.c: describe a blob
References: <xmqqo9obhqo0.fsf@gitster.mtv.corp.google.com>
        <20171110224425.15299-1-sbeller@google.com>
        <20171110224425.15299-2-sbeller@google.com>
Date:   Mon, 13 Nov 2017 10:33:59 +0900
In-Reply-To: <20171110224425.15299-2-sbeller@google.com> (Stefan Beller's
        message of "Fri, 10 Nov 2017 14:44:25 -0800")
Message-ID: <xmqqtvxzarnc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B961409A-C812-11E7-B1AF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Sometimes users are given a hash of an object and they want to
> identify it further (ex.: Use verify-pack to find the largest blobs,
> but what are these? or [1])

Thanks for finishing the topic you started.

> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
>  'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
> +'git describe' <blob>

OK.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 9e9a5ed5d4..acfd853a30 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> ...
>  static void describe(const char *arg, int last_one)
>  {
> ...
> @@ -445,11 +497,18 @@ static void describe(const char *arg, int last_one)
> ...
> +	cmit = lookup_commit_reference_gently(&oid, 1);
> +
> +	if (cmit)
> +		describe_commit(&oid, &sb);
> +	else if (lookup_blob(&oid)) {
> +		if (all || tags || longformat || first_parent ||
> +		    patterns.nr || exclude_patterns.nr ||
> +		    always || dirty || broken)
> +			die(_("options not available for describing blobs"));
> +		describe_blob(oid, &sb);

I am not sure if I agree with some of them.

> +	} else
> +		die(_("%s is neither a commit nor blob"), arg);

This side I would agree with, though.

The caller of the describe() function is either

 * 'git describe<RETURN>' makes a single call to it with "HEAD" and
   exits; or
 * 'git describe A B C...' makes one call to it for each of these
   command line arguments.

And 'git describe <blob>' code is most likely trigger from the latter,
as it is not likely for HEAD to be pointing at a blob.

    $ blob=$(git rev-parse master:Makefile)
    $ git describe --always master $blob

and trigger the above check.  Is the check against "always" useful,
or is it better to simply ignore it while describing $blob, but
still keeping it in effect while describing 'master'?

The 'dirty' and 'broken' check is redundant because we would have
already errored out if either of them is set before calling describe()
on user-supplied object names.

If I understand the way "describe <blob>" works correctly, it
traverses the history with objects, doing a moral equivalent of
"rev-list --objects", stops when it finds the blob object with the
given name, and when it stops, it knows the commit object that
contains the blob and path in that commit to the blob.  Then the
commit is described to be a human-readable string, so that the path
can be concatenated after it.

Aren't these options that affect how a commit object is described in
effect and useful when you do the "internal" describe of the commit
you found the blob object in?  IOW, wouldn't this

    $ git describe --exclude='*-wip' $blob

make sure that in its output $commit:$path, $commit is not described
in terms of any "wip" refs?

