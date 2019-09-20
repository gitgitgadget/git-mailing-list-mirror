Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358EF1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391955AbfITQ0d (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:26:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55649 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbfITQ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:26:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E06662CF92;
        Fri, 20 Sep 2019 12:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMPNEOP3DmyMJN+bAYxrNfsKftU=; b=DQ3hy7
        ZgVSIqKlMICZbJmlT+98W0K1bYLVfdyB9rkMOye+dJxM8Q2aGUOlkluIi7U7mFiS
        oq+46Aeal+QL9ohUNNGHzr/KogvuW9tp+ZNFNJuy4r5u88HaHPxbuGXHaUbqttGa
        BnIZJGAlGz7FnX1UqUiftQA22/R210H0xzFr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvNGoQSkdJC0xCcY2qx1t4nrIHlGhEws
        LFQecxkKSfmt34IjvEWPID6OVsF2dGP4RyBoxWNvRW9cQ0DC9VQ4PTmnLdk3XVyn
        Gf8yQ4E2xcW5Nefp2LZqubp9SQZv1Aa0eaMkW112ZNmmLXEekM5sOLH6miusugdh
        o3p0mbhRZZ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7C572CF90;
        Fri, 20 Sep 2019 12:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0ED8C2CF8F;
        Fri, 20 Sep 2019 12:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
References: <cover.1568771073.git.matheus.bernardino@usp.br>
        <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW4u+iPFMvSGNvSJxfPLE34dQQ3x5_aQ-Y4Pd99FXR1p7Q@mail.gmail.com>
Date:   Fri, 20 Sep 2019 09:26:28 -0700
In-Reply-To: <CAHd-oW4u+iPFMvSGNvSJxfPLE34dQQ3x5_aQ-Y4Pd99FXR1p7Q@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 19 Sep 2019 02:18:57
        -0300")
Message-ID: <xmqqh857vsqz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66C62154-DBC3-11E9-AD57-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hmm, I may have gotten a little confused here. Are you talking
> about the attributes stack (which contains .gitattributes and
> info/attributes)?  If so, isn't this stack already rebuild for
> every path? I mean, by the previous call chain it seems to me that
> at least these two files are reread for every path.

Yes, but for the switch that happens when coming out of a normal
directory and then descending into another normal directory is just
to pop the entries from the directory hierarchy we are getting out
of, and then pushing the entries from the new directory hierarchy.
We would not be discarding and rereading $GIT_DIR/info/ or the
.gitattribute file from the top-level of the working tree.

Descending into a submodule is fundamentally and completely
different.  None of the attributes defined in the superproject
should affect the paths in the submodule, as it is a totally
separate project, oblivious to the existence of enclosing the
superproject. 

Every time we look up attributes for a path in a project (either the
superproject or a submodule) that is different from the one we did a
look-up the last time, we'd not just need to pop a handful and push
a handful, but need to rebuild the stack completely from scratch,
no?
