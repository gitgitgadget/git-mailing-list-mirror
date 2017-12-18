Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62FD1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760204AbdLRSyx (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:54:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61407 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760199AbdLRSyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:54:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBFC0C402E;
        Mon, 18 Dec 2017 13:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PYMmZaW/AhgYrYAMpADnvEYa+Hc=; b=g4Y8Rq
        zoQd/T+eqR6kzo1KUe0V0bp5t0j1D+bcNAmNMc2DXEZAthMrdbBY5egfaREFfzgG
        YERxFRwa8Ri9fqcNREEg8D7UyVbEsCKaVO6eO2i8lZmcNU3LGQxltNfay/HnfaD4
        qGPGPD8mZxJqIqxk/SBCAmPlJjaFavT3NFEHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vdkq+M85hqVlchMVWkks7aT3OsB3YdNP
        9g2ONCy57XG3N67yOjUsWt1dRr8VWIllLCexRMz3sd215LSeSu4I8FxW7t/qdA3S
        mbzGJF65nkoQj7OPkM+nWAHxbVc25QPR75P1rKUs6O5L2N2iKDIaGY8AEq5si8Ib
        6D5qiUNc1eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2766C402D;
        Mon, 18 Dec 2017 13:54:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60410C402C;
        Mon, 18 Dec 2017 13:54:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Usability issue with rebase fork-point option
References: <CAHd499BwrEAxoGX++xRJz_p-_7Uh7vm=+FstRbCv1+wqeCiYbw@mail.gmail.com>
Date:   Mon, 18 Dec 2017 10:54:50 -0800
In-Reply-To: <CAHd499BwrEAxoGX++xRJz_p-_7Uh7vm=+FstRbCv1+wqeCiYbw@mail.gmail.com>
        (Robert Dailey's message of "Mon, 18 Dec 2017 09:47:54 -0600")
Message-ID: <xmqqbmivyih1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED961E52-E424-11E7-B84D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> $ git rebase
> First, rewinding head to replay your work on top of it...
> Applying: Fix state machine hang after integrity checking
>
> Since my merge-base is already the tip of `origin/master`, I expected
> it to say it was up-to-date, as it would if I disabled fork point:
>
> $ git rebase --no-fork-point
> Current branch feature/foo is up to date.

I haven't studied the symptom deeply enough but I have a feeling
that hunk @@ -572,7 +573,7 @@ in 1e0dacdb ("rebase: omit
patch-identical commits with --fork-point", 2014-07-16) may be what
goes wrong.  I do not offhand see why the "already up to date" check
need to be bypassed when fork-point mode is in use, and the log
message of the commit does not explain the reason behind that
change, either.

I wonder what happens if we simply enabled the "avoid unnecessary
rebase if we are already up to date" check even when $restrict_revision
is not empty.
