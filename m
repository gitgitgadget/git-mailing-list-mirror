Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A0520988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbcJRRaS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:30:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933658AbcJRRaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C72D748EE7;
        Tue, 18 Oct 2016 13:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vVsEdZrIyDQTGT7LuXMetUK2ltw=; b=OCa9KM
        hRXHFzCm3Ucbu7znVeF9LCL5cal1ASFI8fa3E4/BMhkw149FTx97yce5Dz5Wi02X
        YtUWF/RHNgPBLBEmZaedDgnsRZTzyE0BnQ47z6u6gxHOqyhT0sfY4v1dyUmiDM2n
        cU/FX4J/i6tVUVUjwMat+gQ5k4nLqLkE3y9iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ILjIr9vm7Wd60vAhciN8yduasQESzeq0
        qjzZ6SqVsOuOtJwIVjkjh9wgS6C2RO/VUj1eH+7H471+x9hGbXwp1BXjgHnHjQ8R
        ZZUX5jsLn3jqS3WnB7FENOl36BORbkhFLeEV+xqQOtgfR827YS9B8lVMdjKMeMOR
        KfMpg4OKkOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE59C48EE3;
        Tue, 18 Oct 2016 13:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4423948EDD;
        Tue, 18 Oct 2016 13:30:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com
Subject: Re: Merge conflicts in .gitattributes can cause trouble
References: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
        <alpine.DEB.2.20.1610171803400.197091@virtualbox>
        <xmqqvawqvp6y.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610181437180.197091@virtualbox>
Date:   Tue, 18 Oct 2016 10:30:13 -0700
In-Reply-To: <alpine.DEB.2.20.1610181437180.197091@virtualbox> (Johannes
        Schindelin's message of "Tue, 18 Oct 2016 14:39:04 +0200 (CEST)")
Message-ID: <xmqqmvi1pntm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88035F4E-9558-11E6-8DDA-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To the contrary. As far as I can see, when calling `git merge`, Git
> currently *does* read .gitattributes from the file, and if that fails,
> falls back to reading that file from the index.

Hmph.

Assuming that the merge always goes in the index order, I think you
are right.  When we need to merge path/to/dir/.gitattributes, we
would need to know all the .gitattributes files that may affect that
path, so .gitattributes, path/.gitattributes, path/to/.gitattributes
and the file being merged are all read into core before anything
happens and these are kept in attr_stack while merging anything
underneath path/to/dir/ hierarchy without being re-read from the
filesystem.  The original contents of path/to/dir/.gitattributes
cached in the attr_stack will be discarded when we start to merge
things outside path/to/dir (e.g. merging path/to/another/file), but
at that point the contents of path/to/dir/.gitattributes no longer
matters to the path being merged, so unless the merge somehow jumps
around it is OK.

It may be a fragile assumption in the longer term that the merge
always goes in the index order, but I think the assumption holds in
the current codebase, and the update planned immediately in the
future.

