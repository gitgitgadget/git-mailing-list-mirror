Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62DC202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 02:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdJWCEx (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 22:04:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54703 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750736AbdJWCEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 22:04:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8003AC71B;
        Sun, 22 Oct 2017 22:04:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yFsUG3nR8/bI8N0oToEB9oTk4SM=; b=LXDrJVP4KeiOY18sC1/6
        4v2gZSvSCqVVjuidQ8hnUAECu4vBQQBqbpdsT+XTLTHT93d4PLawUzQgSw4hCfIE
        Y4mjKzZYXPzYczH8rorJ63lYNvwqahvJa/uQ/mOJht20Gak4Xv2pqijvx5yOLafE
        V2gBoETUU8k4oACLOsWwWjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=uwS7JZjLYHeFwYga1fYbvj7DVLWvlCU4hoPfaBukoEUSKt
        GqM5FiONGEfUebjqpTqTsnVbK4ckLoDsmc9JDQFvY2+nhHFBCuAZuhgG7NB+z/LH
        Au1mbabIr1l+7qJoxqf1gC11Oc7d+IqER2ZIlPoI/cZVczmlT1MLtYGzqqDmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F951AC71A;
        Sun, 22 Oct 2017 22:04:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FF20AC719;
        Sun, 22 Oct 2017 22:04:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     git@vger.kernel.org
Subject: Re: Ascertaining amount of "original" code across files/repo
References: <20171022212505.wxdpfaevxw7fsn7e@laptop.local>
Date:   Mon, 23 Oct 2017 11:04:49 +0900
Message-ID: <xmqqbmkyd3ge.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DE1D02E-B796-11E7-863A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Adam <thomas@xteddy.org> writes:

> What I did was first of all ascertain the number of original lines in each of
> the files I was interested in:
>
> 	for i in *.[ch]
> 	do
> 		c="$(git --no-pager blame "$i" | grep -c '^\^')"
> 		[ $c -gt 0 ] && echo "$i:$c"
> 	done | sort -t':' -k2 -nr

Another approach I've used when I was curious how many among 1244
lines Linus originally wrote for Git in 2005 remains in today's
codebase goes the other way [*1*].

The "reverse" approach makes use of the -S option of blame to
fabricate a hypothetical history where the very initial version of
Git is today's version, and then there is another version that was
built on it (eh, rather reduced out of it) which is Linus's
original.

	$ git tag initial e83c5163316f89
	$ cat >fake-history <<EOF
	$(git rev-parse initial) $(git rev-parse master)
	$(git rev-parse master)
	EOF

The list of files that Linus had in his original can befound out
with:

	$ git ls-tree -r --name-only initial

and you can iterate over them with a command like this:

	$ git blame -Sfake-history -s -b initial -- cache.h

a brief commentary of the options:

 * "-Sfake-history" option points at a fake-history file, which uses
   the same format as the "graft" file, to establish the fake
   ancestry.  The first line claims that the Linus's 'initial'
   version has only one parent, which is our current version
   'master' (in reality, Linus's 'initial' version did not have any
   parent, of course).  The second line claims that our current
   version 'master' is a root commit without any parent.

 * "-s" squelches all metainformation other than commit object name
   from the prefix of each line; "-b" further blanks out the commit
   object name of the "root" commit---note that in this fake
   history, our current state in 'master' is what is blanked out.

The output may start like so:

                     1) #ifndef CACHE_H
                     2) #define CACHE_H
                     3) 
        e83c5163316  4) #include <stdio.h>
        e83c5163316  5) #include <sys/stat.h>
        e83c5163316  6) #include <fcntl.h>
        e83c5163316  7) #include <stddef.h>

The idea is that a line that is blamed to the "root" commit
(i.e. blank prefix) is what survived since Linus's version down to
our current version.  In the fake world, Linus started from our
today's version and ended up with the same result in his version for
these lines.  A line that is blamed to e83c516 is something we do
not have in our today's version that is "added" by Linus in this
fake world---that in reality is what we "lost" from Linus's original
over time.

By adding -M and -C on "git blame" command line, you'll find more
lines that survived over time from Linus's original by getting moved
around inside the same file and across file boundaries.  By adding -w,
indentation-only changes would also be ignored.

I am not judging which is more correct to go in the forward
direction like your approach does or to go in the reverse, as I
haven't thought about it deeply enough.


[Reference]

*1* https://docs.google.com/file/d/0Bw3FApcOlPDhMFR3UldGSHFGcjQ/view

    Slide #11 was created using the above method.



