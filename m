Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37E82070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbcISQTv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:19:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51684 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750801AbcISQTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA6133FFED;
        Mon, 19 Sep 2016 12:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XnFr45cCNpRbpYjWQ5juLOGN+vg=; b=XlMntC
        MnNNDfb0gMavemtanTcfhQuZ2vS2RPXJtxuywTQhhnPzN1oEpjc6YGLCiHaohz2z
        NOjYS0yNk/ygeXRo8Frm2EkQlGRcM4cEge/0kd99GLq91PK24PgOuuRQ7ZvjkyeP
        4o8T9UXOJSSPDx9lYVNPMO2lDsEIAflL7bADw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OtFhGCFxVSbwvlhEj44bI6kmalMMEpnS
        tS98Ow3Dcvi32lvwejyg/QdzJ5CVNiv7bxhQ11WgLd4sPH41K4NpJcYNBvpP3lox
        I0t+sE0VPkew7l3Mu93a1PxNK9X+JyXH7rEoBSZ7RZEAnJvvIuisGLTyYDYGupFb
        gAMWsDBw5Cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E33EE3FFEC;
        Mon, 19 Sep 2016 12:19:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69E183FFEA;
        Mon, 19 Sep 2016 12:19:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>,
        "Michael J Gruber" <git@drmicha.warpmail.net>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
        <033051503D8C4F618B1E4879AFF8C28D@PhilipOakley>
Date:   Mon, 19 Sep 2016 09:19:47 -0700
In-Reply-To: <033051503D8C4F618B1E4879AFF8C28D@PhilipOakley> (Philip Oakley's
        message of "Mon, 19 Sep 2016 15:46:50 +0100")
Message-ID: <xmqq4m5bhnfg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E33B4286-7E84-11E6-831A-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> At the moment the cherry-pick man page's example implies that
> --do-walk is applied from the beginning, rather from the point given
> on the command line.
>
> I had a very quick search of the *.c code for the options but didn't
> get any further. Hopefully the user issue/misunderstanding is
> elsewhere... I'll add this to my little list.

I think the confusion is coming from not understanding that revision
specifiers cannot have position-dependent semantics, because there
is no "union of multiple sets".  You said

	commits in 'master..next' range and the tip of 'maint'

earlier, and that is a prime specimen of that confusion.  That is
asking "things reachable from next excluding things reachable from
master" computed independently from everything else on the command
line (i.e. that is one set), and "the commit at the tip of 'maint'"
(i.e. that is another set, which consists of a singleton element),
and wanting to take a union of it.  But the revision machinery is
not structured to work that way.  It can only do "reachable from one
enumeration of positive tips, excluding ones reachable from another
enumeration of negative tips".  "no-walk" is a cheap hack that tells
the machinery "stop after collecting that 'one enumeration of
positive tips' and do not walk. Make that enumeration the resulting
set".  Having anything negative in the enumeration of starting
points from the command line automatically turns "no-walk" off, even
for commands that default to "no-walk".

We may need further documentation updates to unconfuse readers.
