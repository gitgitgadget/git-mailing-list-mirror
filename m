Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3161F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbcIGSXn (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:23:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751147AbcIGSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B86773C153;
        Wed,  7 Sep 2016 14:23:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D+iLZyYpdIRQJmmMG91ZDnypUiQ=; b=T6NGFb
        dksVEUG3V85c+VfeuJ2AwDdFWO8gQRi7ApT4Cy652xiDuaV868kj3k8IJWpIAqhj
        96mNSvIHG+4GGDj+Bg0mX72joYDXAo8YI6NLPlIO1xyQtL4+RPUwnVQg5F0oBH8C
        x5QvJXr7dEKVrs95eDW95RxPPpJPLmnD2W9bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l8LAeHVvS5E17LmiAC16Lp9N/hia8Zbh
        Pykpiyxe4XFKEIc17+hm4mcs+GSxm8/FcUA8dLQhVHRkzgJIcNaPkqPzE5D6ztnf
        bah9bBvCfE0GSJtXMf9JC8BsGmrdwDBi4aWBFIwW3LhPClAvxz5gFg7QqAnlnd8u
        Do0o2Z1zGyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0C663C152;
        Wed,  7 Sep 2016 14:23:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3149C3C150;
        Wed,  7 Sep 2016 14:23:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, tboegi@web.de,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 2/2] read-cache: make sure file handles are not inherited by child processes
References: <20160905211111.72956-1-larsxschneider@gmail.com>
        <20160905211111.72956-3-larsxschneider@gmail.com>
        <20160906210632.GA28263@starla>
        <7B903664-0324-4375-A81C-1317020CBE9B@gmail.com>
        <20160907181036.GA14931@starla>
Date:   Wed, 07 Sep 2016 11:23:39 -0700
In-Reply-To: <20160907181036.GA14931@starla> (Eric Wong's message of "Wed, 7
        Sep 2016 18:10:36 +0000")
Message-ID: <xmqqtwdrmuvo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33FD779A-7528-11E6-90E4-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> We probably should be using O_NOATIME for all O_RDONLY cases
> to get the last bit of performance out (especially since
> non-modern-Linux systems probably still lack relatime).

No, please do not go there.

The user can read from a file in a working tree using "less",
"grep", etc., and they all update the atime, so should "git grep".
We do not use atime ourselves on these files but we should let
outside tools rely on the validity of atime (e.g. "what are the
files that were looked at yesterday?").

If you grep for noatime in our current codebase, you'd notice that
we use it only for files in objects/ hierarchy, and that makes very
good sense.  These files are what we create for our _sole_ use and
no other tools can peek at them and expect to get any useful
information out of them (we hear from time to time that virus
scanners leaving open file descriptors on them causing trouble, but
that is an example of a useless access), and that makes a file in
objects/ hierarchy a fair game for noatime optimization.
