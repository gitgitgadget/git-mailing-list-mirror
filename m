Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64451F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 19:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbdIFT6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:58:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752306AbdIFT6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:58:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B102A31B2;
        Wed,  6 Sep 2017 15:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=AAr5v6XHSCIhryYwxDCeRl/1MNg=; b=PLePd8mRXPoqAGCkG6E2
        yKDM6Fp5CSOdhuQUedog1UdgYnO1Pm1zLSSIZNKHlzxB/l1+/qxMmNw2HVsf4p9k
        KbOighsRkJB4nn8gIMLqsyN2tBeEaKAEtUEvuuot+DOYS7bxF35pQ2LfbhNoUeXM
        paPO/1kZvazkBnH2mptlcBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=XXZJqFPj2ZEno6Ic2hokHXMsoS1gjLlMC/VxP4dTeCKobN
        tUt+iQo1l4mM0fZMHkuaKqNWDa+NIRtW89Hs0d9o2MWYziaPd4VMzdvnGcMk62i9
        N606g9CjeRMBy7L5ZXUoqwwmfmp9nEfNMoGHNtxPFphBOCeD2frWq9gAxpNBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43460A31B1;
        Wed,  6 Sep 2017 15:58:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1970A31B0;
        Wed,  6 Sep 2017 15:58:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: gitmodules below root directory
References: <CAHd499AuoZ-89mpnVkMhxaDT44SRNT2xWE7sykcaP8n5xTRd-g@mail.gmail.com>
Date:   Thu, 07 Sep 2017 04:58:51 +0900
Message-ID: <xmqqk21b4n0k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEA6C222-933D-11E7-92C1-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> The gitmodules documentation[1] states that the .gitmodules file is at
> the root. However, it would be nice if this could be supported in any
> directory similar to how .gitignore works.

I have a mild suspicion that there would be a huge impedance
mismatch between what gitmodules file is meant to do and the way
ignore/attribute setting is done.

When the mechanism is primarily about expressing a few generic
traits that are shared by things that can be grouped by paths
(e.g. "all paths whose pathnames match '*.py' pattern contain text",
"all paths in sub/ directory are ignored"), it may make sense to
spread the information across multiple .gitignore files and make the
closest one take precedence over the further ones.  Even though
allowing multiple sources of information spread over the tree leads
to end-user confusion (e.g. "why is this path ignored?", which
triggered the debugging aid "git check-ignore"), such a grouping by
pattern matching on paths (which is what makes "closest file take
precedence" meaningful) to assign generic traits (e.g. "it's text")
makes it worthwhile by allowing to express the rules more concisely.

Compared to that, what .gitmodules file expresses is more specific
to each submodule---no two submodules in your single superproject
would share the same URL, unless you are doing something quite
unusual, for example.  Having a single file also means that updating
is much simpler---"git submodule add" and other things do not have
to choose among .gitmodules, a/.gitmodules and a/b/.gitmodules when
they update an entry for the submodule at path "a/b/c".

Having said that, I do not think the current ".gitmodules must be at
the top and nothing else matters" is ideal.  A possible change that
I suspect may make more sense is to get rid of .gitmodules file,
instead of spreading more of them all over the tree.

The current gitlink implementation records only the "what commit
from the subproject history is to be checked out at this path?" and
nothing else, by storing a single SHA-1 that happens to be the name
of the commit object (but the superproject does not even care the
fact that it is a commit or a random string).  We could substitute
that with the name of a blob object that belongs to the superproject
history and records the information about the submodule at the path
(e.g. "which repository the upstream project recommends to clone the
subproject from?", "what commit object is to be checked out").  

When you see a single tree of a superproject, you need to see what
commit is to be checked out from the tree object and everything else
needs to be read from the .gitmodules file in that tree in the
current system, but it does not have to be that way.





