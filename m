Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EB71F42D
	for <e@80x24.org>; Wed, 23 May 2018 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934771AbeEWTwd (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 15:52:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53282 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbeEWTwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 15:52:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E34DDBADF;
        Wed, 23 May 2018 15:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=4RG
        Vquj44CgGU2rF+C5WxhuUhoA=; b=naAQycZgSam0G0n6qwxANEA8W46JfBl3XPH
        HXCAJ9rhIAHfppGl8OViWrB+exYQVHT6CbpEFzg99xVgksuGr+yMSAW3l20VNkmd
        bLIrGAzk8p+bncu5xlcE/tV4dPfukvYvqLy7iS/sPz2hkSCYYJ40r3kOdJZg6yEe
        vdEgFCeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
        SHAYp3fWGq8T1wLi53mV5tDX0ZtK0jJKTcqMtzhImsUgMwI80uEbNE2zV+hQ00Zm
        4e1kwlMCXYSywjj54F+QYvNhUlFNqp23LdS1Ro6HRtDc61h2sKu1oHH/7+mTrVrA
        AsLip61nYo5q8awRPclXsEQNy4yt3fUI03hA7e7qThE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55FD7DBADC;
        Wed, 23 May 2018 15:52:29 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0C7DDBAD9;
        Wed, 23 May 2018 15:52:28 -0400 (EDT)
Date:   Wed, 23 May 2018 15:52:27 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: BUG: rev-parse segfault with invalid input
Message-ID: <20180523195227.GT26695@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: D2E2DF1E-5EC2-11E8-B803-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Certain invalid input causes git rev-parse to crash rather
than return a 'fatal: ambiguous argument ...' error.

This was reported against the Fedora git package:

    https://bugzilla.redhat.com/1581678

Simple reproduction recipe and analysis, from the bug:

    $ git init
    Initialized empty Git repository in /tmp/t/.git/
    $ git rev-parse ffffffffffffffffffffffffffffffffffffffff^@
    Segmentation fault (core dumped)

    gdb) break lookup_commit_reference
    Breakpoint 1 at 0x555555609f00: lookup_commit_reference. (3 locations)
    (gdb) r
    Starting program: /usr/bin/git rev-parse ffffffffffffffffffffffffffffffffffffffff\^@
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib64/libthread_db.so.1".

    Breakpoint 1, lookup_commit_reference (oid=oid@entry=0x7fffffffd550) at commit.c:34
    34              return lookup_commit_reference_gently(oid, 0);
    (gdb) finish
    Run till exit from #0  lookup_commit_reference (oid=oid@entry=0x7fffffffd550) at commit.c:34
    try_parent_shorthands (arg=0x7fffffffdd44 'f' <repeats 40 times>) at builtin/rev-parse.c:314
    314                     include_parents = 1;
    Value returned is $1 = (struct commit *) 0x0
    (gdb) c

    (gdb) c
    Continuing.

    Program received signal SIGSEGV, Segmentation fault.
    try_parent_shorthands (arg=0x7fffffffdd44 'f' <repeats 40 times>) at builtin/rev-parse.c:345
    345             for (parents = commit->parents, parent_number = 1;
    (gdb) l 336,+15
    336             commit = lookup_commit_reference(&oid);
    337             if (exclude_parent &&
    338                 exclude_parent > commit_list_count(commit->parents)) {
    339                     *dotdot = '^';
    340                     return 0;
    341             }
    342     
    343             if (include_rev)
    344                     show_rev(NORMAL, &oid, arg);
    345             for (parents = commit->parents, parent_number = 1;
    346                  parents;
    347                  parents = parents->next, parent_number++) {
    348                     char *name = NULL;
    349     
    350                     if (exclude_parent && parent_number != exclude_parent)
    351                             continue;

    Looks like a null pointer check is missing.

This occurs on master and as far back as 1.8.3.1 (what's in
RHEL-6, I didn't try to test anything older).  Only a string
with 40 valid hex characters and ^@, @-, of ^!  seems to
trigger it.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I don't mind arguing with myself. It's when I lose that it bothers me.
    -- Richard Powers

