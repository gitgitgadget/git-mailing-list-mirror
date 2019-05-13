Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57601F461
	for <e@80x24.org>; Mon, 13 May 2019 03:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfEMDrM (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 23:47:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56423 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfEMDrM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 23:47:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5A9914E1D3
        for <git@vger.kernel.org>; Sun, 12 May 2019 23:47:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
        RtiSYSH78CsnAKYfhVsiz/oZIg=; b=HpqW7pP+V8D13qbeMB4U9RHelvWnv27qK
        JSAETi0FONHmbF5GGR4X0KkU/g1j1P2hp5OgGyjzDjF908npIin7Y5+uwkWkJRbo
        NECY1MmzTqC+VP6OeOSj2vNJUNQmtbSHj8SuYJOCio1PxKmQK3qQCZMBjd4pmJk6
        xkLTvX8r4A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD71F14E1D2
        for <git@vger.kernel.org>; Sun, 12 May 2019 23:47:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=mesmtp;
 bh=9gBVf0kk+uF+FSrxjMhvdArKpDoqafZnMl/mHDNT1+Q=;
 b=RlWzU7f+PkVlsa03/gEMSSJV3z3j352kEn69V6RycKxdsXLgwtHx8b7rgWv92w7+n8RuXpDAyJspw3KZzuTjf/0kMB6F68usxjSIv4N70unZee0tBVAopeuL0j0H8PQBHqe8wkj4R5iWQTjycU5H9dx8GQj2x3hJHT+DDthnIiw=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BD8114E1D1
        for <git@vger.kernel.org>; Sun, 12 May 2019 23:47:09 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: push docs: inaccurate description of omitted destination?
Date:   Sun, 12 May 2019 23:47:08 -0400
Message-ID: <87sgtj6mo3.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8C7B870-7531-11E9-9F2C-E828E74BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems to me that push's manpage contains a couple of inaccurate (or
at least confusingly incomplete) statements about omitting the
destination part of the refspec.

First, the refspec section of the manpage has this to say:

    If `git push [<repository>]` without any `<refspec>` argument is set to
    update some ref at the destination with `<src>` with
    `remote.<repository>.push` configuration variable, `:<dst>` part can
    be omitted--such a push will update a ref that `<src>` normally updates
    without any `<refspec>` on the command line.  Otherwise, missing
    `:<dst>` means to update the same ref as the `<src>`.

Reading that, I'd think that, if I haven't configured
remote.<repository>.push in a way that involves <src>, omitting <dst>
will update the remote ref with the same name.  But push.default is also
consulted before falling back entirely to using the remote ref with the
same name:

    $ git rev-parse --symbolic-full-name HEAD
    refs/heads/topic
    $ git rev-parse --symbolic-full-name @{upstream}
    refs/remotes/origin/master
    $ git -c push.default=upstream push -n origin topic ;# unmentioned case
    To ../rem
       09cc638..58f7f72  topic -> master

    $ git branch --unset-upstream topic
    $ git -c push.default=upstream push -n origin topic ;# fallback case
    To ../rem
     * [new branch]      topic -> topic

Second, the example section says

    `git push origin master`::
       Find a ref that matches `master` in the source repository
       (most likely, it would find `refs/heads/master`), and update
       the same ref (e.g. `refs/heads/master`) in `origin` repository
       with it.  If `master` did not exist remotely, it would be
       created.

Perhaps I'm misreading that, but I'd interpret that as saying the remote
ref with the same name will always be updated, but that doesn't match
the refspec description of an omitted destination shown above or the
push.default-dependent behavior demonstrated in the example above.
