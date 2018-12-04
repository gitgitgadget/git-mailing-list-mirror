Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FF9211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 03:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLDDd1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 22:33:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58490 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLDDd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 22:33:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A15426580;
        Mon,  3 Dec 2018 22:33:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UZDilCvoIv1FVJuxKysWQmhOG44=; b=ozJzUZ
        a0SOZKKVq2/ob5YuhrSZidDm05QdbNTKayORnDfsqX8IyRRZ2T6qmrQBWw8zhAbW
        Q8xBNKHuRr/q1Ts1vYmJdOMXZ4rknfC8pkDZEDibzvZzzQZoNd/tZiZHe4Rrjhno
        SiQJS+W3wnXb4lJTR38mGa0/9UXksZ4UYEqYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bWQb6UyRsvONNPW6pNPdf1Vlr+slUImZ
        X1+Ndfu7iF/cbn59MYuLF57hPVd6Z7D6I4gjjsnlyuuXiWIt919Mv/xCv5AkI4wO
        0slJf5DF9FTKcktmGeNVosMW0T2rwlK5Vw2kJLxincbI3TIHD9bAv71MsLPJFYVF
        lom978XfYko=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F5702657F;
        Mon,  3 Dec 2018 22:33:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 285A22657E;
        Mon,  3 Dec 2018 22:33:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <20181129215850.7278-8-pclouds@gmail.com>
        <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
Date:   Tue, 04 Dec 2018 12:33:16 +0900
In-Reply-To: <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
        (Elijah Newren's message of "Mon, 3 Dec 2018 16:45:08 -0800")
Message-ID: <xmqq1s6yezk3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57D83912-F775-11E8-B096-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> +Updates files in the working tree to match the version in the index
>> +or the specified tree.
>> +
>> +'git restore-files' [--from=<tree-ish>] <pathspec>...::
>
> <tree-ish> and <pathspec>?  I understand <commit-ish> and <pathspec>,
> or <tree-ish> but have no clue why it'd be okay to specify <tree-ish>
> and <pathspec> together.  What does that even mean?

I have this tree object v2.6.11-tree that is not enclosed in a
commit object.  I want to take the top-level Makefile out of that
tree, stuff it in the index and overwrite the working tree file.

	$ git checkout v2.6.11-tree Makefile
	$ git restore-files --from=v2.6.11-tree Makefile

>> +       Overwrite paths in the working tree by replacing with the
>> +       contents in the index or in the <tree-ish> (most often a
>> +       commit).  When a <tree-ish> is given, the paths that
>> +       match the <pathspec> are updated both in the index and in
>> +       the working tree.
>
> Is that the default we really want for this command?  Why do we
> automatically assume these files are ready for commit?  I understand
> that it's what checkout did, but I'd find it more natural to only
> affect the working tree by default.  We can give it an option for
> affecting the index instead (or perhaps in addition).

Oooah.  Now this is getting juicy.  

I do think supporting "--index" (which would make it more in line
with what Duy wrote), with optionally "--cached" as well, and making
the "working tree only" mode as default may not be a bad idea.  I am
offhand not sure how the "working tree only" mode (similar to the
default mode of "git apply" that mimics the way "patch -p1" works)
should interact with the non-overlay mode of the command, but other
than that, I tend to agree with the idea that restore-files is only
a part of making the contents into committable shape, not exactly
ready for it yet.
