Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672A9201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758611AbdKOWcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 17:32:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756140AbdKOWcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 17:32:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBE5BB13BE;
        Wed, 15 Nov 2017 17:32:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tJMw+qFVKGYSd2DoUw0uqhElBZo=; b=Eq2DX1
        /NFY27kMUFzjYtDRZ9nRBFBN5EL10Gp5MRZXhSxlyqDffX3JXn2aH6+iTSehNBv1
        jxphfCIHt3hArfeDQJrQvNsWIqNfLCHv8obPhpVt+FbWiDF0iYXy10VIHfkjflIK
        S2fVU4MT8l/UIJ++7DCxtBKUrhPx5Do/jqSb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AKrxN1PjgOmq8tbsaDGGO8XPD1ubaKBo
        443bj/crqGUMjGZ5h2h/QgiC1oEFJu1wv6o8+o1uIs83f5KlZbiBHU1FEIfU+24r
        QTChQWfaT+bncZmSemThd9nvX/lz436LtdUBds2VygQyR+8j9WXa1+VpKFVABq3J
        +2HXKaVSZIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B45CBB13BC;
        Wed, 15 Nov 2017 17:32:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F269B13BB;
        Wed, 15 Nov 2017 17:32:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
Date:   Thu, 16 Nov 2017 07:32:12 +0900
In-Reply-To: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com> (Lars
        Schneider's message of "Wed, 15 Nov 2017 16:08:23 +0100")
Message-ID: <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D37969D2-CA54-11E7-A670-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> However, if you configure an editor that runs outside your terminal window then
> you might run into the following problem: 
> Git opens the editor but the editor is the background or on another screen and 
> consequently you don't see the editor. You only see the Git command line 
> interface which appears to hang.
>
> I wonder if would make sense to print "Opening editor for user input..." or
> something to the screen to make the user aware of the action. Does this sound
> sensible to you? Am I missing an existing solution to this problem?

My knee-jerk reaction was: for such a user who has EDITOR set to a
program that pops under, wouldn't any program, not just Git, that
uses the editor to open a file for editing/viewing look broken?
Would we care if we are called "broken" by such a clueless user who
cannot tell a (non-)broken caller of an editor and a broken editor?

But that is true only when the user does realize/expect that the
program s/he is running _will_ open an editor at the point of the
workflow.  If s/he types "git merge" or "git rebase -i @{u}", for
example, it is true that the world would be a better place if s/he
knows that would ask a file to be edited with an editor, but it is
unrealisic to expect that everybody knows how to operate these
commands.  Everybody is a newbie at least once.

I wonder if we can do something like

	git_spawn_editor()
	{
		const char *EL = "\033[K"; /* Erase in Line */

		/* notice the lack of terminating LF */
		fprintf(stderr, "Launching your editor...");
		fflush(stderr);

		if (!run_command(... spawn the editor ...)) {
			/* Success! - go back and erase the whole line */
			fprintf(stderr, "\r%s", EL);
		} else {
			fprintf(stderr, "failed (%s)\n", strerror(errno));
		}
		fflush(stderr);
	}

to tentatively give a message without permanently wasting the
vertical space.
