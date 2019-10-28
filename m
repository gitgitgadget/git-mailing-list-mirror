Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74DE1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 02:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfJ1C4S (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 22:56:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55366 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJ1C4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 22:56:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 013102729E;
        Sun, 27 Oct 2019 22:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5JSvfhGfIQFPGdLEgjWHoeAw82E=; b=kADdd3
        wvFKlU8+i/MfuugpOyc1AZcTsW9GLPfCNqGS8QejhB97JxBNPkXceyHtfspxm73k
        29LP3lv7FvGqA/G89OzOJ3B4oqvDxxNCB7V7OfB6hTdM6HunBfUTqQfClV8PysNF
        hWhDIA7OhW1vMtWp6nstZl0LOBgPBCgDr+Quw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GybasH8Xv0qJbtKwTyaUnFFWYpbTRGaa
        IZC52XPFyV4cwpWo4jv5Y1kvWH43IOuHdWr/zOjcDfQTUYVQVGp3APcL7GNeQmJ/
        7/GnGHlUUCB4wBYn+7fVtzd0+LUSdD7eF9MPJdUnRqIjpEPnJDsf4dQJxrI84TVu
        wHC5Z04V8H4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAE432729C;
        Sun, 27 Oct 2019 22:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32AC02729A;
        Sun, 27 Oct 2019 22:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/15] t4011: abstract away SHA-1-specific constants
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
        <20191028005907.24985-8-sandals@crustytoothpaste.net>
Date:   Mon, 28 Oct 2019 11:56:14 +0900
In-Reply-To: <20191028005907.24985-8-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 28 Oct 2019 00:58:59 +0000")
Message-ID: <xmqqk18pa88h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81C16A62-F92E-11E9-B213-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

It does make sense to introduce these two additional helpers, one
that takes the contents to be hashed, and the other that takes the
name of the file that stores the contents to be hashed.  The former
is handy when you need to compute an object name for a symbolic
link, and the latter is handy when you have contents already stored
in a file.  But if you have a short contents in a variable, nothing
prevents you from using the former to compute an object name for a
file that would have the contents you have in the variable without
having to first create a temporary file.

It crossed my mind that it may make more logical sense to call the
former "oid_from_contents" and the latter "oid_from_file", but I'll
shortly change my position ;-)

> +# Print the short OID of a symlink with the given name.
> +symlink_oid () {
> +	local oid=$(printf "%s" "$1" | git hash-object --stdin) &&
> +	git rev-parse --short "$oid"
> +}

This is good.

> +# Print the short OID of the given file.

To contrast with the above, s/given/contents of the/ may make the
distinction clearer, I think.

> +short_oid () {
> +	local oid=$(git hash-object "$1") &&
> +	git rev-parse --short "$oid"
> +}

Given that we do not use the former helper to compute a regular
file object name without having a concrete file on the filesystem,
I do not mind calling it symlink_oid at all.  But then this may want
to be called file_oid to make the contrast better, and it would
match the use of these two in a test near the end of this patch.

>  test_expect_success 'diff new symlink and file' '
> -	cat >expected <<-\EOF &&
> +	symlink=$(symlink_oid xyzzy) &&
> +	cat >expected <<-EOF &&
>  	diff --git a/frotz b/frotz
>  	new file mode 120000
> -	index 0000000..7c465af
> +	index 0000000..$symlink

It is a mistake to name the variable "symlink", even though
symlink_oid is a good name for this helper function.  

If you were showing a change that updates the symlink RelNotes from
pointing at Documentation/RelNotes/2.0.0.txt to
Documentation/RelNotes/2.1.0.txt, for example, you would say

	old=$(symlink_oid Documentation/RelNotes/2.0.0.txt) &&
	new=$(symlink_oid Documentation/RelNotes/2.1.0.txt) &&
	cat expect <<-EOF &&
	diff --git a/RelNotes b/RelNotes
	index $old..$new
	...
	EOF

so I'd expect $new (on the right hand side of ..) would read more
natural.

> @@ -137,14 +151,16 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
>  '
>  
>  test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
> -	cat >expect <<-\EOF &&
> +	file=$(short_oid file.bin) &&
> +	link=$(symlink_oid file.bin) &&

Here, I do think $file and $link are good names, and that leads me
to say s/short_oid/file_oid/ would be a good idea.

> +	cat >expect <<-EOF &&
>  	diff --git a/file.bin b/file.bin
>  	new file mode 100644
> -	index 0000000..d95f3ad
> +	index 0000000..$file
>  	Binary files /dev/null and b/file.bin differ
>  	diff --git a/link.bin b/link.bin
>  	new file mode 120000
> -	index 0000000..dce41ec
> +	index 0000000..$link
>  	--- /dev/null
>  	+++ b/link.bin
>  	@@ -0,0 +1 @@
