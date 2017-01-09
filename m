Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3A41FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 15:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034367AbdAIPCG (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 10:02:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62227 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S967851AbdAIPBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 10:01:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FF765D884;
        Mon,  9 Jan 2017 10:01:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eYdX+cHUMYKisqsOlv5qybw38ls=; b=UR0usp
        Ghc1ieJg2cNDVIswXi8uSdPCXVqkWsp0giHt4lPHraDXfcp7CM//ZhlHaPLXYCW1
        +d5mgbJwOqDAm1xWVR7/WmxbfGuPTHYaYOSLzURsnRgDmotT6X6bh04aeLg5wn9P
        X8PsYHugVV7bxEICOlT5osySaEdjsEm9yMy74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j9jgS7RElvRUxJIeWqd+rB1fnHE4Q+3D
        V6Sr/5OInBW8tyqJ5juiWYv52BKwJ0GjdlixbtYnCwiFS2yc4PW50fmcgrQFfmqb
        cEHdojtFiqz82wCIJEs83a71XQD3w79h9w8anYdfmlpg7M+JmTvpqBCbTYgZRrJV
        xa4ho+uM4bk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 962575D883;
        Mon,  9 Jan 2017 10:01:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02F255D882;
        Mon,  9 Jan 2017 10:01:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Refreshing index timestamps without reading content
References: <20170105112359.GN8116@chrystal.oracle.com>
        <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
Date:   Mon, 09 Jan 2017 07:01:36 -0800
In-Reply-To: <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 9 Jan 2017 19:02:45 +0700")
Message-ID: <xmqqr34cuvjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 853238D4-D67C-11E6-85FD-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 5, 2017 at 6:23 PM, Quentin Casasnovas
> <quentin.casasnovas@oracle.com> wrote:
>> Is there any way to tell git, after the git ls-tree command above, to
>> refresh its stat cache information and trust us that the file content has
>> not changed, as to avoid any useless file read (though it will obviously
>> will have to stat all of them, but that's not something we can really
>> avoid)
>
> I don't think there's any way to do that, unfortunately.

Lose "unfortunately".

>> If not, I am willing to implement a --assume-content-unchanged to the git
>> update-index if you guys don't see something fundamentally wrong with this
>> approach.
>
> If you do that, I think you should go with either of the following options
>
> - Extend git-update-index --index-info to take stat info as well (or
> maybe make a new option instead). Then you can feed stat info directly
> to git without a use-case-specific "assume-content-unchanged".
>
> - Add "git update-index --touch" that does what "touch" does. In this
> case, it blindly updates stat info to latest. But like touch, we can
> also specify  mtime from command line if we need to. It's a bit less
> generic than the above option, but easier to use.

Even if we assume that it is a good idea to let people muck with the
index like this, either of the above would be a usable addition,
because the cached stat information does not consist solely of
mtime.

"git update-index --index-info" was invented for the case where a
user or a script _knows_ the object ID of the blob that _would_
result if a contents of a file on the filesystem were run through
hash-object.  So from the interface's point of view, it may make
sense to teach it to take an extra/optional argument that is the
path to the file and take the stat info out of the named file when
the extra/optional argument was given.

But that assumes that it is a good idea to do this in the first
place.  It was deliberate design decision that setting the cached
stat info for the entry was protected behind actual content
comparison, and removing that protection will open the index to
abuse.

The userbase of Git has grown wide enough that it is harder to say
"If you lie that a file whose contents does not match the index is
up to date using this mechanism, you will lose data and all bad
things happen---you can keep both halves".  Once we release a
version of Git with such a "feature", the first bug report will be
"I did not want to run 'update-index --refresh' because it takes
time, and some index entries apparently did not match what is on the
filesystem, and I got a corrupt working file after a merge.  Git
should make sure that the contents match when using the new 'path to
the file' argument when updating the cached stat info!".  I do not
have a good answer to such a bug report.

So...
