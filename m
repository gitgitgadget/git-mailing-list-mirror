Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9666920133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbdCFVmU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:42:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58754 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932468AbdCFVmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:42:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B5E86E95B;
        Mon,  6 Mar 2017 16:42:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z7U5qxN6FvSG
        G0d7d6udv95ptWk=; b=m2p0aUHl6rePQOnUSihOKlRWacMIyO9vxtEJLqoqM2Cy
        U3TJ+y3ZqFevLmjGVDLPy3WKzt1cQfJo/JRnuYRSt98+I2e4gjumx7vNfNMwHDOT
        +1gcHqXaJpaPs/f8A+Yf3Lb65rn5BWWRBZRDtYqWXX71Ri8Ie0gK+eKk5wXHGUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=o4CO+g
        uSWXeOgf9bX3WGg2oUSdlE+aEqvUSfD2Pg23xbQTeQRcgGbo6zNcUK8OHaVu2ybH
        Bcy+03Aw7DJuin0q/zkmj95CHCu7HGIP+zjg32SZWZaIUc9lxVZuqiaY2L20TPRP
        q2VjrqVx3BzlHwSGCUxG62xxWDDUhsXJancMQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 135EC6E95A;
        Mon,  6 Mar 2017 16:42:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BC186E959;
        Mon,  6 Mar 2017 16:42:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Lewis <mike@mplew.is>
Cc:     git@vger.kernel.org
Subject: Re: Server-side hooks on non-bare repository
References: <719CE082-14AB-4E18-AE7D-7D2A818CF499@mplew.is>
Date:   Mon, 06 Mar 2017 13:42:03 -0800
In-Reply-To: <719CE082-14AB-4E18-AE7D-7D2A818CF499@mplew.is> (Mike Lewis's
        message of "Fri, 3 Mar 2017 19:10:05 -0500")
Message-ID: <xmqq1suankus.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD26E4FA-02B5-11E7-AFB2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Lewis <mike@mplew.is> writes:

> I=E2=80=99m having some issues with using server-side hooks when pushin=
g
> to a non-bare repository. In my git config, I have
> `receive.denyCurrentBranch` set to `updateInstead`, which behaves
> as expected, and updates the current working tree when the current
> branch is pushed to. However, attempting to process those changes
> with pre-receive and post-receive hooks results in some unexpected
> behavior regarding the current working directory of the scripts
> and using git commands.

The pre-receive hook is to inspect the objects and ref updates and
say "yes, allow it" or "no, refuse it"---you are not supposed to do
anything else, so even though what processing you are interested in
doing in your "attempting to process" is unclear, this hook is not
what you want to use anyway.

The post-receive hook is a more interesting case.  It is called only
after everything finishes, so it is like running a custom script
after "git push" is processed.

> I=E2=80=99ve tested these issues using both git
> 2.11 and 2.12 on various systems (macOS and CentOS), and get the
> same behavior each time.

That is a very good news, as I do not think at least in the past few
years we planned to change the established behaviour of the hook.

> 1. When using a non-bare repository, I would expect the the
> working directory of the hook to be the root directory of the
> working tree,...
> 2. While running the hooks, git treats the repository as being
> bare, regardless of whether it actually is.

Yes, and it is unlikely that the behaviour wrt to where $cwd is
during the hook's execution will ever change; otherwise existing
scripts that know what the rule is (i.e. the rule you figured out in
2.) will be broken.  denycurrent=3Dupdateinstead *is* an odd-man out,
and its processing is purely internal---its addition does not mean
hook authors are suddenly required to do things differently
depending on bare/non-bare-ness of the repository.


