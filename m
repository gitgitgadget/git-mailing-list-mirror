Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F821FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 02:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdJLCKL (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 22:10:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63366 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751757AbdJLCKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 22:10:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45668B61A0;
        Wed, 11 Oct 2017 22:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=lKxb
        tHIuUFSbi8bAxQbYISE3C5Q=; b=GnhMjddMrrnK/P9tGzkgNdy3fC3/bzS/DjZX
        l+zG26RxCvofHcyzDernS3PWdNxEDVezj5M+WXiKt5wbyfcaCU69y48G5q+VRm56
        6SYfMQCg94gcPAFErMuyj/oKvPTGe7vi6pHxF1SrS8KdqFcKx4ZY3HG4xdr+ydC7
        s5sJRVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=xY6gKs
        nPD3qH2/D5OWhbza32yis17Dwi/jp8T8DIJp3KnTelK1x8giuL0dAeNNVf9TKww8
        moET3UnjQsC3in6y8hQ2tf3Iw7c2fI6OoWWnbEE/FI9fF4sDEIgaloHFTkbQTCgY
        tCheD7dOowVE92s6HgUm/3mUkRSEq+4ANSV7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B5DAB619F;
        Wed, 11 Oct 2017 22:10:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9ADFDB619C;
        Wed, 11 Oct 2017 22:10:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] Piling more kludge on top of color.ui
Date:   Thu, 12 Oct 2017 11:10:05 +0900
Message-Id: <20171012021007.7441-1-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-151-g44fe2f342f
In-Reply-To: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 7895E388-AEF2-11E7-BA8E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier we added a patch to unconditionally downgrade 'always' that
is set to the color.ui configuration variable.  This was done to
correc the unintended regression to "git add -i" that was caused by
two earlier mistakes that we no longer can undo.

 - The "add -i" command wants to parse output from "git diff-index"
   plumbing.  The plumbing commands started paying attention to
   color configuration variables (which is a mistaken "solution" to
   cover another mistake), which caused people who have color.ui set
   to "always" to see breakage, as their "git diff-index" started
   coloring its output even when "git add -i" wanted to read it and
   parse it (without expecting to see any colors in its input);

 - The mistake the mistaken "solution" wanted to cover was that some
   time ago we started to automatically color the output (i.e. color
   when the output goes to the terminal) by default, but did so even
   to the plumbing commands.  As many plumbing commands do not even
   have their own color control, it made it impossible to disable
   this auto-coloring--a mistaken "solution" was to pay attention to
   "git -c color.ui=never" from the command line.

It turns out that there are many third-party scripts that do want to
read colored output from our tools and the way they do so is to run
"git -c color.ui=always cmd", which is a way to defeat any end-user
settings and force coloured output reliably---at least they thought
that they can rely on it working, that is.  We saw one report of
such a private tool getting broken on list, and I've seen another
one inside $work.

Let's keep "git -c color.ui=always cmd" form "working", while
downgrading the setting made in the configuration files to "auto",
to placate both camps.  Let's also discourage use of 'always' and
leave the door open for us to introduce "git --default-color=<what>
cmd" later as a substitute for "git -c color.ui=<what>".

Jeff King (1):
  color: downgrade "always" to "auto" only for on-disk configuration

Junio C Hamano (1):
  color: discourage use of ui.color=always

 Documentation/config.txt |  2 +-
 color.c                  | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.15.0-rc1-151-g44fe2f342f

