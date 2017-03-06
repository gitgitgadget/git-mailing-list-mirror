Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389ED20133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932134AbdCFWNo (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 17:13:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932076AbdCFWNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 17:13:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B69406EFC6;
        Mon,  6 Mar 2017 17:13:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DHXOmfmoQT78Sd6+ZtBTmponqtI=; b=hKbOhG
        +3u7XNiJmtolIiylgUhV/zRjZLykxhVCLJ16U7z1MUGGvJpPTeEa/HOXXkCb2FIE
        hXTZd/XnshXSBBras/c8Qqo56W8tiyhC2FdeIzhRpa5xg+jbi/jnRyfaV0fPAzfe
        9HoPGEg0U0DrXEHeMqjvv9c5VAIVvTYCZUkOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZgEYSLiU7EOlxGRGRwj211NHg8Z2z4qC
        qpV6xaIrJ5K/MbcX9B4XfBCdFyH0ZNykU/CwwQwuzsKfy93vMjNrxnYrerTx6bY8
        4PxsZvwp0TUaVgDoH50e2imFhd8BAf0m327+12//hvp+au4pR6RmpzTnGP5sFRo7
        zHNTjCK2WDw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B01D36EFC5;
        Mon,  6 Mar 2017 17:13:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 152866EFC4;
        Mon,  6 Mar 2017 17:13:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
Date:   Mon, 06 Mar 2017 14:13:00 -0800
In-Reply-To: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
        (Stefan Beller's message of "Mon, 6 Mar 2017 11:59:24 -0800")
Message-ID: <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 106F105C-02BA-11E7-B753-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> What is the difference between signed commits and tags?
> (Not from a technical perspective, but for the end user)

When you "commit -s", you are signing the bytes in the commit
object, which means that you are attesting the fact that the tree
you wanted to record is one of the 47 other colliding tree objects
that happen to share that 40-hex hash value, and also the fact that
the commits you wanted to record as its parents have certain SHA-1
hash values.  As you are relying on the resistance to preimage
attack against SHA-1 at least locally around that signed commit,
there wouldn't be meaningful difference between a 50-commit series
each of which is individually signed with "commit -s", such a
50-commit series, only the top of which is signed with "commit -s",
and the same 50-commit series, on the top of which is signed with
"tag -s".

"tag -s" also has the benefit of being retroactive.  You can create
commit, think about it for a week and then later tag it.  And ask
others to also tag the same one.  You cannot do so with "commit -s".

> A signed push can certify that a given payload (consisting
> of multiple commits on possibly multiple branches) was transmitted
> to a remote, which can be recorded by the remote as e.g. a proof
> of work.

A signed push is _NOT_ about certifying the objects in the history
DAG.  It is about certifying the _intent_ of pointing _REFS_ into
points in the object graph.  "This is a commit I made to add feature
frotz" is something you might say with "commit -s" and "these
commits behind this point are for upcoming 2.13 release" is
something you might say with "tag -s v2.13-rc0".  But "I made it"
and "I made it for this purpose" are different things.  I may not
want the "feature frotz" commit included in the maintenance track,
so it would be a mistake for push a history that contains it to
update refs/heads/maint ref.  A push certificate can protect hosting
sites like GitHub, when I complain to them saying "you guys are
pointing at a wrong commit with refs/heads/maint", by allowing them
to respond with "well, you made the push to perform that update and
here is what you GPG signed".

> Off list I was told gpg-signed commits are a "checkbox feature",
> i.e. no real world workflow would actually use it. (That's a bold
> statement, someone has to use it as there was enough interest
> to implement it, no?)

I'd agree with that "checkbox" description, except that you need to
remember that a project can enforce _any_ workflow to its developer,
even if it does not make much sense, and at that point, the workflow
would become a real-world workflow.  The word "real world workflow"
does not make any assurance if that workflow is sensible.

Historically, "tag -s" came a lot earlier.  When a project for
whatever reason wants signature for each and every commit so that
they somehow can feel good, without "commit -s", it would have made
us unnecessary work to scale tag namespace only because there will
be tons of pointless tags.  "commit -s" was a remedy for that.
