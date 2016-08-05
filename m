Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1952018E
	for <e@80x24.org>; Fri,  5 Aug 2016 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423908AbcHETrf (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 15:47:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S941599AbcHETra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 15:47:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3B2E311A1;
	Fri,  5 Aug 2016 15:47:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MNFxXJKhe8SpLC2ZRyDaRXddqfU=; b=fhHKUf
	rZV2LQZOQ8OkXlY5HuKLPvfpjntdQMceN+/3GDFGzYSKbbsrmaY9Rntl3t4qf70Z
	ujHsJSmdURUzb6/gpAH45fzgbne/HAwwcmjZxhO4d5hpzSiPDzSJkP4cZBOjBJFE
	Efg1XrcTqO7jtuDt2Y0TeRksHHs2W0hB6WjF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mtFgCLeLAMNhg+fTN9TjSAPRcYvx0K67
	ZW1Aq+bQs7asoogx5STTbu9eTOgM79RMhUbSBIPjtGsQsw37jRJQq78GbUCLgc/2
	qkQFy0Gw6afqCv230dVwbJsAVX49RL99MBaKODHPpZN4TKTDK+8JTKpwwRlLXrph
	rAvCCRBWrUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95FD33119F;
	Fri,  5 Aug 2016 15:47:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C5E23119E;
	Fri,  5 Aug 2016 15:47:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de
Subject: Re: [PATCH 0/6] git clone: Marry --recursive and --reference
References: <20160804195159.7788-1-sbeller@google.com>
Date:	Fri, 05 Aug 2016 12:47:26 -0700
In-Reply-To: <20160804195159.7788-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 4 Aug 2016 12:51:53 -0700")
Message-ID: <xmqqoa57vvzl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 709816A8-5B45-11E6-8825-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  Currently when cloning a superproject with --recursive and --reference
>  only the superproject learns about its alternates. The submodules are
>  cloned independently, which may incur lots of network costs.
>  
>  Assume that the reference repository has the submodules at the same
>  paths as the to-be-cloned submodule and try to setup alternates from
>  there.

I am a bit fuzzy about what scenario you are trying to help.  Is it
something like this? [*1*]

 * The superproject is at git://frotz.xz/super.git but you locally
   have a mirror at /var/cache/super.git (bare) repository.

 * "git clone --refererence /var/cache/super.git git://frotz.xz/super.git"
   would borrow that existing local mirror to cut down the traffic.

 * The super.git project uses git://nitfol.xz/xyzzy.git as its
   submodule.  You locally have a mirror of it at
   /var/cache/xyzzy.git (bare) repository.

 * The xyzzy submodule is bound at libs/xyzzy in the superproject
   tree.

 * You want the "clone" command above with "--recursive" to do "the
   right thing".  That is, the clone of the superproject borrows
   from /var/cache/super.git local mirror, and the clone of xyzzy
   that would be made at .git/modules/xyzzy in the superproject
   would borrow from /var/cache/xyzzy.git local mirror.

What I am not sure about is how /var/cache/xyzzy.git should be
automatically derived from the information given from the command
line of "clone" and what the clone of the superproject contains.
You'd need to make certain assumptions, like

 - The parent directory of the --reference for superproject,
   i.e. /var/cache/, is the directry that has many other mirrors;

 - The .gitmodules file in superproject says a "xyzzy" project from
   git://nitfol.xz/xyzzy.git must be checked out at "libs/xyzzy",
   and it is a reasonable assumption that we would find a local
   mirror at /var/cache/xyzzy.git (the /var/cache prefix comes from
   the above assumptino).

There may be some other assumptions you are making.  I am wondering
if your specific assumption is applicable generally.


[Footnote]

*1* Another common arrangement could be that you have one full clone
    of the superproject at /var/cache/super.git and its submodule
    xyzzy in /var/cache/super.git/modules/xyzzy and assuming that
    would allow you to guess where to borrow submodules from.  But
    the result of assuming this layout would already be different
    from the scenario I gave the above.  If the organization uses
    the xyzzy project only in the context of the frotz superproject,
    "borrow from submodule repository inside $GIT_DIR/modules/ of
    the superproject" may be sensible, but that makes use of "xyzzy"
    as an independent project quite awkward (also you may have
    another superproject that is unrelated to super.git that uses
    the same "xyzzy" project as its submodule).  The more "xyzzy"
    project is suitable to be used as "submodule", the more it makes
    sense to have its mirror independent from the superprojects that
    use it, by using /var/cache/{super,xyzzy}.git layout.

    IOW, both layouts are equally sensible; what layout (either one
    of the above two, or something entirely different) is your "at
    the same paths" assumption meant to serve well, and what is the
    plan to serve other layouts?



