Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B48C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 06:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiDWGIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiDWGIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 02:08:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DFB13F76
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 23:05:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07EF4183367;
        Sat, 23 Apr 2022 02:05:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JhZloTlcb1i5
        FDZkPcNiUqULvtvPyU8yoDHUuuzoLLM=; b=uaIp8lya2XLulKUjYfdbVi6UdrX4
        tGAvMWgsBMTRHASnrE9GY1morrTU007vfvG3syySLxp6mekyjz/MZug70SJjMb8q
        f043SvTmPEp2McM/ZsVnF1NdGLomD7AkgWZQQqGlsfYVchBzIDV8qSKh9Qyga+xP
        FPXLlUKdksgG2Xw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6922183366;
        Sat, 23 Apr 2022 02:05:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63962183365;
        Sat, 23 Apr 2022 02:05:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: gitk regression in version 2.36.0
References: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <xmqqpml82vkd.fsf@gitster.g>
Date:   Fri, 22 Apr 2022 23:05:46 -0700
In-Reply-To: <xmqqpml82vkd.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        22 Apr 2022 22:54:58 -0700")
Message-ID: <xmqqlevw2v2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B320F40-C2CB-11EC-928A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthias A=C3=9Fhauer <mha1993@live.de> writes:
>
>> Git 2.36.0 (or more precisely 244c27242f (diff.[ch]: have diff_free()
>> call clear_pathspec(opts.pathspec), 2022-02-16)) introduced some
>> change in behaviour that causes gitks highlight feature not to work
>> correctly anymore.
>
> Nicely found.

A simple reproduction recipe without gitk is a command line
invocation like this:

$ git rev-list -10 --max-parents=3D1 v2.36.0 -- Documentation |=20
  git diff-tree --stdin --stat -- Documentation

The upstream of the pipe lists 10 topmost non-merge commits, going
back from v2.36.0, that touch Documentation/ directory, and the
downstream "diff-tree" is told to show for each of these commits to
compute equivalent of "git show --stat -- Documentation", i.e. only
the Documentation directory.  But "diff-tree" loses pathspec and we
will see paths outside Documentation appearing in the output.

If I substitute "git diff-tree" on the downstream of the pipe with
the version from v2.35.0, of course the correct thing happens X-<.
