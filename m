Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90DFCD8CA9
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 17:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjJJRCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJJRC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 13:02:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465548E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:02:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EC612708C;
        Tue, 10 Oct 2023 13:02:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=75HpSOSzByQ6tHSdVsTc6O6aTtGMfXuX02syLG
        Exjf8=; b=khaVSy49mWkwi4vnfHun3U6yI7tGHzM+TyrNqsL0BGdqstVgm9fqFn
        MV41DxDbm4PNP7u9daxyMSwG6hb5+RzS6BKljbimQf1SlkdyJQHcMrxJz5PlSxnG
        WdD0XwHtoH5L6PDwZSvnk6xU1QitebUkQIIuRKHO3lnpKzzE9MIdU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 377E92708B;
        Tue, 10 Oct 2023 13:02:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AEB927085;
        Tue, 10 Oct 2023 13:02:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Thiel <sebastian.thiel@icloud.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com> (Sebastian
        Thiel's message of "Tue, 10 Oct 2023 14:37:36 +0200")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
Date:   Tue, 10 Oct 2023 10:02:20 -0700
Message-ID: <xmqqttqytnqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7812466-678E-11EE-A2F8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Thiel <sebastian.thiel@icloud.com> writes:

> I'd like to propose adding a new standard gitattribute "precious".

;-).

Over the years, I've seen many times scenarios that would have been
helped if we had not just "tracked? ignored? unignored?" but also
the fourth kind [*].  The word "ignored" (or "excluded") has always
meant "not tracked, not to be tracked, and expendable" to Git, and
"ignored but unexpendable" class was missing.  I even used the term
"precious" myself in those discussions.  At the concept level, I
support the effort 100%, but as always, the devil will be in the
details.

Scenarios that people wished for "precious" traditionally have been

 * You are working on 'master'.  You have in your .gitignore or
   .git/info/exclude a line to ignore path A, and have random
   scribbles in a throw-away file there.  There is another branch
   'seen', where they added some tracked contents at path A/B.  You
   do "git checkout seen" and your file A that is an expendable file,
   because it is listed as ignored in .git/info/exclude, is removed
   to make room for creating A/B.

 * Similar situation, but this time, 'seen' branch added a tracked
   contents at path A.  Again, "git checkout seen" will discard the
   expendable file A and replace it with tracked contents.

 * Instead of "git checkout", you decide to merge the branch 'seen'
   to the checkout of 'master', where you have an ignored path A.
   Because merging 'seen' would need to bring the tracked contents
   of either A/B (in the first scenario above) or A (in the second
   scenario), your "expendable" A will be removed to make room.

In previous discussions, nobody was disturbed that "git clean" was
unaware of the "precious" class, but if we were to have the
"precious" class in addition to "ignored" aka "expendable", I would
not oppose to teach "git clean" about it, too.

There was an early and rough design draft there in

https://lore.kernel.org/git/7vipsnar23.fsf@alter.siamese.dyndns.org/

which probably is worth a read, too.

Even though I referred to the precious _attribute_ in some of these
discussions, between the attribute mechanism and the ignore
mechanism, I am actually leaning toward suggesting to extend the
exclude/ignore mechanism to introduce the "precious" class.  That
way, we can avoid possible snafu arising from marking a path in
.gitignore as ignored, and in .gitattrbutes as precious, and have to
figure out how these two settings are to work together.

In any case, the "precious" paths are expected to be small minority
of what people never want to "git add" or "git commit", so coming up
with a special syntax to be used in .gitignore, even if that special
syntax is ugly and cumbersome to type, would be perfectly OK.


[Reference]

 * https://lore.kernel.org/git/7viptp9jos.fsf@alter.siamese.dyndns.org/
 * https://lore.kernel.org/git/xmqqva534vnb.fsf@gitster-ct.c.googlers.com/
