Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D317F20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbdLHRtl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:49:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752105AbdLHRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 704F5D1FA2;
        Fri,  8 Dec 2017 12:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vXjsGtvDU9Ap6Sha4tzNraVl3lQ=; b=N5leRv
        h99kRouuWkY3USq0W66EmR1F2bFO45oSkFTTpMlAluAtPa6Hem43vkG4zPIii7Vy
        heOe8xfuc6QWOxnWdk/jtF5FmVWRRNAGrkkYI4+qrQIDg6OXxtgrj7PBmtL+dnFv
        tedkNQbEgRLKUVYzpP/wy6kRKOY7C5eEcVd00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KlExBAlgYQyuFNZsNgls9Ebl3OsyhLmU
        BQDBxXOQ4mKPDqYgZ44D0vH0eAslllnHsA1usXDWaqOrFlWUqyLjfuvnZI7WxxTE
        64lP0X2IgdoPy47HOiHEH2WYHlK6u9suzfB7Gc2B0lJS5zkFP6bp7uqEy3F28yJA
        Plbj1dBm8GA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66900D1FA1;
        Fri,  8 Dec 2017 12:49:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2ADCD1FA0;
        Fri,  8 Dec 2017 12:49:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] version --build-options: report commit, too, if possible
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
        <908989103a06291e38c8551c447bc73eb781fb26.1512752468.git.johannes.schindelin@gmx.de>
        <20171208172733.GC14261@aiede.mtv.corp.google.com>
Date:   Fri, 08 Dec 2017 09:49:38 -0800
In-Reply-To: <20171208172733.GC14261@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 8 Dec 2017 09:27:33 -0800")
Message-ID: <xmqqy3md85zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A01353A-DC40-11E7-8C9F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> We need to be careful, though, to report when the current commit cannot be
>> determined, e.g. when building from a tarball without any associated Git
>> repository.
>
> This means that on Debian, it would always print
>
> 	built from commit: (unknown)
>
> Maybe I shouldn't care, but I wonder if there's a way to improve on
> that. E.g. should there be a makefile knob to allow Debian to specify
> what to put there?

Another "interesting" possibility is to build from a tarball
extracted into a directory hierarchy that is controlled by an
unrelated Git repository.  E.g. "my $HOME is under $HOME/.git
repository, and then I have a tarball extract in $HOME/src/git".
We shouldn't embed the HEAD commit of that $HOME directory project
in the resulting executable in such a case.

We should be able to do this by being a bit more careful than the
presented patch.  Make sure that the toplevel is at the same
directory as we assumed to be (i.e. where we found that Makefile)
and trust rev-parse output only when that is the case, or something
like that.
