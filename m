Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2298D1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756176AbcIURMd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:12:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752360AbcIURMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:12:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AE333E139;
        Wed, 21 Sep 2016 13:12:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dI9oR80S3CxIWhqtKmto4VpJGbA=; b=NF4gHs
        3dsy4Lfm5VaNGki01GIhy/103Iv9Ch0iupksbnbP952+s55b6hfk6phqjbYv8R5A
        U2eF05uHq4bNT0j3DjQnUj9Aah3DLBG/UCuXr1L71lJO7tv0+HWoyhcUUTAA+Pp0
        t4+65x14pffTDh8C7UG4xoBQO+O0qKO+kc2xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VUNgDbDzKgulbZPYFpugd+gFLKKEQFf+
        kIPtKzwUIgpPmlPdTTILqXqgWWxRtMrsg4Pf0rrtG+6u3N4ZlkNg1VNIvRtldh+Y
        Z89rLvgFhXvJ1RVd6Q+7+Yky6PrcIOtsl3N4Vr0tPz6KD1+vg69mONj/WiEOkYfH
        3BG8v/HMjc0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31EC03E138;
        Wed, 21 Sep 2016 13:12:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 140AA3E136;
        Wed, 21 Sep 2016 13:12:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] ls-files: add pathspec matching for submodules
References: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
        <1474311151-117883-1-git-send-email-bmwill@google.com>
        <xmqqh99bcw6m.fsf@gitster.mtv.corp.google.com>
        <CAKoko1oU+QR61Vy0eSxaRe_w8u4q_bC9gx9H7oMqH=CwNzBVCA@mail.gmail.com>
        <CAKoko1qS0+DgnMeNnjayEK3sWnvpuiS4oRDBSR=6s8i4okQ_Hw@mail.gmail.com>
Date:   Wed, 21 Sep 2016 10:12:14 -0700
In-Reply-To: <CAKoko1qS0+DgnMeNnjayEK3sWnvpuiS4oRDBSR=6s8i4okQ_Hw@mail.gmail.com>
        (Brandon Williams's message of "Tue, 20 Sep 2016 14:03:04 -0700")
Message-ID: <xmqqmvj19nyp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92C1FF70-801E-11E6-B826-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On a similar but slightly different note.  In general do we want
> the pathspec '??b' to match against the sib/ directory and
> subsequently have ls-files print all entries inside of the sib/
> directory?  (this is in the non-recursive case)

I'd need to find time to dig a bit of history before I can give a
firm opinion on this, but here is a knee-jerk version of my reaction.

 * A pathspec element that matches literally to a directory causes
   itself and everything underneath the directory match that
   element, e.g. "sib" would be considered a match.

 * Otherwise, a pathspec that matches with the whole path as a
   pattern matches the path, e.g. "??b" would match "sib" itself,
   but not "sib/file".  Note that "??b*" would match "sib" and
   "sib/file" because the pattern match is without FNM_PATNAME
   unless ':(glob)' magic is in effect.

Historically, some commands treated a pathspec as purely a prefix
match (i.e. the former) and did not use _any_ pattern matching,
while other commands did both of the above two (e.g. compare ls-tree
and ls-files).  I thought we were slowly moving towards unifying
them, but apparently 'git log -- "D?cumentation"' does not show
anything close to what 'git log -- Documentation' gives us even in
today's Git.

Probably we want to change it at some point so that a pattern that
matches one leading directory would cause everything underneath to
match, e.g. "??b" would include "sib/file" just because "sib" would.


