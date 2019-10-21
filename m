Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9491F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 04:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfJUEem (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 00:34:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62781 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfJUEem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 00:34:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED4069C246;
        Mon, 21 Oct 2019 00:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=573dWdiq/XPTvh+Pa1A8DFvTj8o=; b=bFIRh/
        9MwHfHUpC6G7U/EfNc1LbmNRGxne6YI8tsHeJl1duob0Na8QT6Hm9bJOJUXfriCh
        b+s3FIyd5NFg3SeVC2YYMWIy6gQFbg9cHkVDfZRXY43qpr5iX2z2qICsUcLzEMHw
        RL4Ll90gG1TxfB5bsvj0bueXdHv5kswLVHXEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SHH+14rlHg0qI5FjbsxPHsy8JwU+3Ysf
        OupGKuuuTvbyMzR5LAQ9DWJve0/5khHQghHEpx2HffWG86uBOe8XCEJpnDiiWdzW
        AOESZCoSbeFt1z+875iQ8MJxgiJPMBqfl2S29xh5VHejVBE+GAlKSCCrtKLXYtJl
        FRml5kwtRXs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E60FD9C245;
        Mon, 21 Oct 2019 00:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A5709C243;
        Mon, 21 Oct 2019 00:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, pedro rijo <pedrorijo91@gmail.com>,
        James Ramsay <james@jramsay.com.au>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [Git Developer Blog] [PATCH] post: a tour of git's object types
In-Reply-To: <20191019002045.148579-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 18 Oct 2019 17:20:45 -0700")
References: <20191019002045.148579-1-emilyshaffer@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Mon, 21 Oct 2019 13:34:34 +0900
Message-ID: <xmqqk18ylns5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16AB780C-F3BC-11E9-8A57-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +Under the covers, Git is mostly a directed graph of objects. Those objects come
> +in four flavors; from root to leaf (generally), those flavors are:

Is "acyclic" worth mentioning, I wonder.

> +
> +- Tag
> +- Commit
> +- Tree
> +- Blob
> +
> +We'll take a closer look in the opposite order, though.
> +
> +# Blob
> +
> +Surprise! It's a file. Well, kind of - it can also be a symlink to a file - but
> +this is the most atomic type of object. We'll explore these a little more later,
> +but really, it's just a file.

It may be easier to understand if we said it is "just a stream of
bytes".  And of course the simplest applciation of a stream of bytes
is to store contents of a file, but it also can be used to store the
value of a symbolic file, and also can be used to store the notes.

So, really, it's just a stream of bytes.

> +A tree references zero or more trees or blobs. Said another way, a tree holds
> +one or more trees or files.

That captures only half of a tree.  It is a mapping from names to
objects.  Of course, being a mapping, it references other objects
(by the way, do not limit the contents to "trees or blobs") on the
value side of the mapping.

    A tree gives names to objects within its scope.  It maps names
    to objects, typically a blob or a tree.  Thus, it can be used
    (and it indeed is used) to represent a directory full of files
    by storing mapping from filenames to blob objects that store
    their contents.  A subdirectory can be represented by having a
    mapping from its name to the tree object that represents the
    contents of the subdirectory.

> This sounds familiar - basically, a tree is a
> +directory. (Okay, or a symlink to a directory.) It points to more trees

No, I do not think it is a symlink to a directory.  What makes you
think so?

I'd stop here for now.  I am certain that I haven't read enough to
say things either negative or positive about the "naming is hard,
naming used in the canonical documentation of Git is unnecessary
hard to read and we propose a better wording" premise given by the
introduction, so I won't comment on it yet.

Thanks.


