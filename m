Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8779F1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 19:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbcLGTlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 14:41:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55071 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752524AbcLGTlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 14:41:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC10A55787;
        Wed,  7 Dec 2016 14:41:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=S8Ti
        MLm+dPfHsN6qYN7iZDoGJsg=; b=hPZyUPV8y1uuJQfAEVnx2gtai+JvIpKCJ6Lo
        hPpEzlZiSkOaUm9XQuoJm6UT4ToCMqbimn5aHyqj5OrWZ0/RBu+DW6dg9J1Yd+KM
        YTf43+d/CYZpth3JLA+Aieaq0ynEoS0rVmB5tY1AqyabwznAJUqr7y7PfG6dGilB
        ea+90ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        h5CGYuo5JFZfRpYVog0NhNR7ez9qj5Y/yWx9Mdh6yralwh43tkqPK1RlXPswsn6m
        910F9QWs1780j3WjktVzTCuwnSSeCJC4hDVrJXFmXm500YFp2XVd6aa2iPH+dQJJ
        /RxUHuA9i79OlJEFgUX30g8ipiwUsPQtSBjhi8zJaKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B240955786;
        Wed,  7 Dec 2016 14:41:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A2D655785;
        Wed,  7 Dec 2016 14:41:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Robbie Iannucci <iannucci@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/3] Do not be totally silent upon lock error
Date:   Wed,  7 Dec 2016 11:41:02 -0800
Message-Id: <20161207194105.25780-1-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-274-g0631465056
In-Reply-To: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 18C2700A-BCB5-11E6-81AC-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robbie Iannucci reported that "git merge" that fast-forwards fails
silently when a competing or stale index.lock is present in recent
Git:

    $ git merge --ff-only master; echo $?
    Updating 454cb6bd52..8d7a455ed5
    1
    $ exit

Did the update happen?  We used to give "fatal: Unable to create
..." followed by "Another git process seems to be running..."
advice, and that would have helped the user from the confusion.

This was because there were only two choices available to the
callers of the lockfile API--they can either ask it to die with
message when the lock cannot be acquired, or ask it to silently
return -1 to signal an error. The recent "libify sequencer" topic
turned many existing "please die" calls to "just silently return
-1", and while it added new "unable to lock" error messages to most
of them, one spot didn't get any and now is allowed to just die
silently.

This series should fix it:

 - 1/3 is something I noticed while reading the existing callers of
   the lockfile API, and is not a new issue with "libify sequencer"
   topic.

 - 2/3 gives a new third option to callers of the lockfile API; they
   can now say "please emit the usual error message upon failing to
   acquire the lock, but give control back to me".

 - 3/3 uses the new option to resurrect the message.

Junio C Hamano (3):
  wt-status: implement opportunisitc index update correctly
  hold_locked_index(): align error handling with hold_lockfile_for_update()
  lockfile: LOCK_REPORT_ON_ERROR

 apply.c                          |  2 +-
 builtin/add.c                    |  2 +-
 builtin/am.c                     |  6 +++---
 builtin/checkout-index.c         |  2 +-
 builtin/checkout.c               |  4 ++--
 builtin/clone.c                  |  2 +-
 builtin/commit.c                 |  8 ++++----
 builtin/merge.c                  |  6 +++---
 builtin/mv.c                     |  2 +-
 builtin/read-tree.c              |  2 +-
 builtin/reset.c                  |  2 +-
 builtin/rm.c                     |  2 +-
 builtin/update-index.c           |  1 +
 lockfile.c                       | 12 ++++++++++--
 lockfile.h                       |  8 +++++++-
 merge-recursive.c                |  2 +-
 merge.c                          |  2 +-
 read-cache.c                     |  7 ++-----
 rerere.c                         |  2 +-
 sequencer.c                      |  2 +-
 t/helper/test-scrap-cache-tree.c |  2 +-
 wt-status.c                      |  7 ++++---
 22 files changed, 49 insertions(+), 36 deletions(-)

-- 
2.11.0-274-g0631465056

