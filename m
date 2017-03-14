Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041E020375
	for <e@80x24.org>; Tue, 14 Mar 2017 04:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdCNEOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 00:14:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53871 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751084AbdCNEN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 00:13:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B979164B48;
        Tue, 14 Mar 2017 00:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4oB7sR+Twy9OWZPMDg134KToXVo=; b=uzHtqO
        qQJQNDkI4yUNgVo9e7z73W3jZdH9bKUllz89xJyNokIjQMqFoxvhXtA8N6NsLA3j
        LRyydXCaC5GAy/Mw1MseFnYrcxOavUyuFla9YhZL0VehW3xvvHKQhmu6HFTUon2z
        sx76lyzIzwqKDzUGiWNuwaogCyLXT+HqPpG3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nZcf9LH7MRy9iy/IVIqLQWemM7uhcDUN
        ZXAMjR0mCbq6btB4Wi8lEe7D2AxiuFddtP6YrI7VMWnryw4lho1sil/ff4OUyFHj
        ONIkMyNjQQ2qxFb9i4Rpkm0o1otDNS0R0Ok7RelOqkYIDT6Y9Qk6WMMBjF//hBKa
        Ml2OAk2jrZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B32B864B47;
        Tue, 14 Mar 2017 00:13:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E34764B46;
        Tue, 14 Mar 2017 00:13:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
        <20170313175640.14106-1-davvid@gmail.com>
        <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Mar 2017 21:13:24 -0700
In-Reply-To: <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Mar 2017 11:32:38 -0700")
Message-ID: <xmqq1su0lcm3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91B3201A-086C-11E7-9C82-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	struct strbuf path = STRBUF_INIT;
>> +	struct strbuf link = STRBUF_INIT;
>> +
>> +	int ok = 0;
>> +
>> +	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {
>> +		strbuf_add(&path, state->base_dir, state->base_dir_len);
>> +		strbuf_add(&path, ce->name, ce_namelen(ce));
>> +
>> +		write_file_buf(path.buf, link.buf, link.len);
>
> This does "write content into symlink stand-in file", but why?  A
> symbolic link that is not changed on the right-hand side of the
> comparison (i.e. S_ISLNK(rmode) && !is_null_oid(&roid)) would go to
> checkout_entry() which
>
>  - creates a symbolic link, on a filesystem that supports symlink; or
>  - writes the stand-in file on a filesystem that does not.
>
> which is the right thing.  It seems that the other side of "if (!use_wt_file())"
> if/elseif/... cascade also does the right thing manually.
>
> Shouldn't this helper also do the same (i.e. create symlink and fall
> back to stand-in)?
>
> Also, I am not sure if strbuf_readlink() can unconditionally used
> here.  On a filesystem without symbolic link, the working tree
> entity that corresponds to the ce that represents a symlink is a
> stand-in regular file, so shouldn't we be opening it as a regular
> file and reading its contents in that case?

I _think_ I was mistaken (please correct me again if my reasoning
below is wrong) and unconditional writing of a plain regular file is
what this codepath wants to do, because we are preparing two temporary
directories, to be fed to a Git-unaware tool that knows how to show
a diff of two directories (e.g. "diff -r A B").  Because the tool is
Git-unaware, if a symbolic link appears in either of these temporary
directories, it will try to dereference and show the difference of
the target of the symbolic link, which is not what we want, as the
goal of the dir-diff mode is to produce an output that is logically
equivalent to what "git diff" produces---most importantly, we want
to get textual comparison of the result of the readlink(2).  And
write_file_buf() used here is exactly that---we write the contents
of symlink to a regular file to force the external tool to compare
the readlink(2) result as if it is a text.  Even on a filesystem
that is capable of doing a symbolic link.

The strbuf_readlink() that read the contents of symlink, however,
is wrong on a filesystem that is not capable of a symbolic link; if
core.symlinks is false, we do need to read them as a regular file.

