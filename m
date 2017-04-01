Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918FB1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 02:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdDAC3q (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 22:29:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750826AbdDAC3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 22:29:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74EE2823CB;
        Fri, 31 Mar 2017 22:29:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sFXXebJE4QCJUHB7RokUVUDJoR4=; b=NbAlSM
        67YT6UBiNTW1x9kgfA+pH4i3txJxm0kbfU+kN6M0wm89XvGAR9tqGGIkZbrLjEkg
        Br07yvhN55VUF95dxqRj1hBkTm3+j2aaEyiLo8biqGDpMScc5dEisOzs10Oe52Oa
        eniyXijF7J+oulEKy8s8ysAQ2418tEL6aFCek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XBEtDrZH77QxfbcWC7GPhqnJiJ4kbLSf
        zJ7XuZMpo0S8GEqxDdrCFdovTKZRz3d19SlnOKSDaSjoxQzGyRhFHqnxjlPZT1Lh
        5TaORnhB+3mdXJuvmSEAaY8J96fC84Fb5OvLEyuPQgWu2J+GdRZfrIIujVVyTsWJ
        bg9v8obxBA4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C989823CA;
        Fri, 31 Mar 2017 22:29:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D004B823C8;
        Fri, 31 Mar 2017 22:29:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [GSOC] prune_worktrees(): reimplement with dir_iterator
References: <1491009687-10419-1-git-send-email-robert.stanca7@gmail.com>
Date:   Fri, 31 Mar 2017 19:29:42 -0700
In-Reply-To: <1491009687-10419-1-git-send-email-robert.stanca7@gmail.com>
        (Robert Stanca's message of "Sat, 1 Apr 2017 04:21:27 +0300")
Message-ID: <xmqqlgrkx3l5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10EE624E-1683-11E7-B0B6-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Stanca <robert.stanca7@gmail.com> writes:

> Replaces recursive traversing of opendir with dir_iterator

The original code for this one, and also the other one, is not
recursive traversing.  This one enumerates all the _direct_
subdirectories of ".git/worktrees", and feeds them to
prune_worktree() without recursing.  The other one scans all the
files _directly_ underneath ".git/objects/pack" to find the ones
that begin with the packtmp prefix, and unlinks them without
recursing.  Neither of them touches anything in subdirectory of
".git/worktrees/" nor ".git/objects/pack/".

Using dir_iterator() to make it recursive is not just overkill but
is a positively wrong change, isn't it?
