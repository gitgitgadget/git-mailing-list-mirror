Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359441FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932943AbcLGWgU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:36:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58851 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932243AbcLGWgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:36:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A157561C6;
        Wed,  7 Dec 2016 17:35:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y60fqSdWoZFfu1fb5KTVu6PgENQ=; b=saq28y
        AmNBfTv+23bntKdAnBoViYHFMhz/rO89dd09QLbHoUWvGrcafwzlKERp0bf8PHyQ
        Yg5KipT8qm10ycQzyggTmH580rlH1AzVYW6h+xjqhjQXyQqCf3QaAacwDLZQi/IJ
        14PVGF9Uep1PuFVcRwerOMz1wU4miYAcQ4as8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tQDXwL13E6X+wIH8aCc3TVya+QMbEFsN
        jbQu6t/07sE9Xz8bPZMOkr+Cj/zbIQjuYYBm8EDTQXZMfO3mlJ6jIPA9Rcp6BeKe
        +83StHaLP+oju4i1df9zwcQHBL9nlNMD8SPJnslQsw8mlyohHOS6O77Sehl7CPK9
        17MTF03vJLA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40F94561C5;
        Wed,  7 Dec 2016 17:35:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C9FF561C3;
        Wed,  7 Dec 2016 17:35:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCHv5 0/5] submodule embedgitdirs
References: <20161207210157.18932-1-sbeller@google.com>
Date:   Wed, 07 Dec 2016 14:35:16 -0800
In-Reply-To: <20161207210157.18932-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 7 Dec 2016 13:01:52 -0800")
Message-ID: <xmqqzik7v04b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DB96F10-BCCD-11E6-99CD-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> v5:
> * Add another layer of abstraction, i.e. the relocate_git_dir is only about 
>   moving a git dir of one repository. The submodule specific stuff (e.g.
>   recursion into nested submodules) is in submodule.{c,h}
>   
>   This was motivated by reviews on the series of checkout aware of submodules
>   building on top of this series, as we want to directly call the embed-git-dirs
>   function without the overhead of spawning a child process.

OK.  Comparing the last steps between this round and the previous
one, I do think the separation of the responsibility among helpers
is much more reasonable in this version, where:

 - submodule_embed_git_dir() is given a single path and is
   responsible for that submodule itself, which is done by calling
   submodule_embed_git_dir_for_path() on itself, and its
   sub-submodules, which is done by spawning the helper recursively
   with appropriate super-prefix;

 - submodule_embed_git_dir_for_path() computes where the given path
   needs to be moved to using the knowledge specific to the
   submodule subsystem, and asks relocate_gitdir() to perform the
   actual relocation;

 - relocate_gitdir() used to do quite a lot more, but now it is only
   about moving an existing .git directory elsewhere and pointing to
   the new location with .git file placed in the old location.

I would have called the second helper submodule_embed_one_git_dir(),
but that is a minor detail.

Very nicely done.



