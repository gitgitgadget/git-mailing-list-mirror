Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB9DC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 22:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7A62054F
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YV9MOfdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHXWXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:23:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51795 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXWXn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 18:23:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D435F6CC64;
        Mon, 24 Aug 2020 18:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=k
        CisVBK5tao2QlZfY7zLi2IeSNQ=; b=YV9MOfdtIgmcXKu++DzNqmXLHD6g0k+7P
        Zop8KVwAf4AtMIgGaRdCav8s5VD60W6Uq4CD+sm4uICZ5FbDKhg1nmu7ldsdnWA3
        dW8IiDo5yxe3wmvYpWO4hP5i/S9cksAegWVlnWqzFBRTGYCAai6VDlMHKmTVLisy
        17dviInkMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=UpQ8R0OEk/D48BnHauS3W9z6MMKM6UfE2xHV8vMnietH+wy/wfa94nzr
        NAfZ/Ln0+FSwLfFAl+BOfUNFiSSdRRr+w3QEeLHNvrn9Fw4r1EY9upDb98eITGuu
        ZgmwrT/+Oc0Om+XjSeEGeQBh15Bij45zvut1hdcNNwvlTP/rBig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B84806CC63;
        Mon, 24 Aug 2020 18:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E0576CC5E;
        Mon, 24 Aug 2020 18:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     users@kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFD] on removing "git-foo" for builtins from disk
Date:   Mon, 24 Aug 2020 15:23:39 -0700
Message-ID: <xmqqbliz3cpg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76321364-E658-11EA-BBF6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 2005, all "git" subcommands were installed in $PATH as
"git-commit" etc., and people wrote their scripts assuming that they
are all available on their $PATH.  But it then became cumbersome to
have so many "git-foo" commands in /usr/bin/.  Because "git" is
installed in /usr/bin/ and knows to dispatch to 'git-foo' subcommand
when invoked with 'foo' as its first argument, we asked our users to
use "git foo" form and moved "git-foo" commands out of /usr/bin/,
moved to /usr/libexec/git-core/, and gave an escape hatch, which is
to add the output of "git --exec-path" early in their $PATH, to old
scripts (i.e. the scripts needed a one-line fix).

Exectly 12 years ago, we asked the users if they still need these
on-disk binaries [*1*].  Many built-in commands (i.e. subcommands
whose code is in the "git" binary), as long as they are invoked in
"git foo" form, do not need to be installed anywhere on-disk, and
theoretically can be removed, as long as the users and the scripts
they wrote long time ago, following our advise to use the escape
hatch, can somehow be convinced.

Removing /usr/libexec/git-core/git-{add,branch,commit,...} will
allow us to reduce disk footprint on systems that do not support
hardlinks and slightly simplifies the installation procedure.  Some
folks want to do so unconditionally.  The only downside being that
we finally break the promise we made our users 12 years ago.

I do not have a strong opinion either way, but if proponents for
removal can convince others successfully, I do not mind removing the
unnecessary on-disk binaries for built-in commands.

Discuss away.


[References and Footnotes]

*1* https://lore.kernel.org/git/7vprnzt7d5.fsf@gitster.siamese.dyndns.org/
