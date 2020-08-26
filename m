Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A59C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CECA2074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gSCV7VUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHZBR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:17:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64019 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHZBRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:17:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56707E100E;
        Tue, 25 Aug 2020 21:17:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=CeSt3zbOaTPL47xSE9v04VVwF
        o8=; b=gSCV7VUcAyyDSp6oyWSU9p1kxLSK1dp/STSYKy7cIIOdWevwgj9Y8Ov58
        evLXLwWhoIJeA2ouy4e46j12x7URpYUO+KxXJpVRktM2X1scOyEIMHbwqOSuqr8Q
        pFdj6JwD9bniZFsOMUqBnQIQRblOIKFaUeoIOkp4Scv0DEscFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=cFzJGQ52UgcR30JBju8
        DNfaojSgveF+Fju6XRVbp+sgHeDIGdsvwQgh2iu3PKm1bu8jjhOAUS9W8uwCunCS
        Hq72i2dMsv3jdA4bsA6mHzEh85ZVlFhij+SYGN8THK6jLLSmw4L1pz9RU+wkkA9t
        CY0OW0PqY1XqXOSTBpzXxngI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41A3BE100D;
        Tue, 25 Aug 2020 21:17:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2DB3E100C;
        Tue, 25 Aug 2020 21:17:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v1 0/3] War on dashed-git
Date:   Tue, 25 Aug 2020 18:17:15 -0700
Message-Id: <20200826011718.3186597-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-454-g5f859b1948
In-Reply-To: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E30FB75C-E739-11EA-9CD6-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we were to propose breaking the 12-year old promise to our users
that we will keep "git-foo" binaries on disk where "git --exec-path"
tells them, we first need to gauge how big a population we would be
hurting with such a move.

So here is a miniseries towards that.  The third one hooks to the
codepath in git.c::cmd_main() where av[0] is of "git-foo" form and
we dispatch to "foo" as a builtin command.  In the original code, we
will die() if "foo" is not a built-in command in this codepath, so
it is exactly the place we want to catch remaining uses of "git-foo"
invoking built-in commands.

There are a few legitimate "git-foo" calls made even for built-ins
and those exceptions are marked in the command-list mechanism, which
is shared with the help subsystem.  We might want to see if we can
unify this exception list with what we have in the Makefile as
BIN_PROGRAMS and what Dscho introduces as ALL_COMMANDS_TO_INSTALL
in his series.  These have large overlaps in what they mean, but
they are not exactly identical.

Junio C Hamano (3):
  transport-helper: do not run git-remote-ext etc. in dashed form
  cvsexportcommit: do not run git programs in dashed form
  git: catch an attempt to run "git-foo"

 command-list.txt         | 11 +++++++----
 git-cvsexportcommit.perl | 16 ++++++++--------
 git.c                    |  2 ++
 help.c                   | 34 ++++++++++++++++++++++++++++++++++
 help.h                   |  3 +++
 transport-helper.c       |  3 ++-
 6 files changed, 56 insertions(+), 13 deletions(-)

--=20
2.28.0-454-g5f859b1948

