Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE5C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6043D20872
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDNX8xi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgJOSfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:35:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62557 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgJOSfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 14:35:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88DABF3DB1;
        Thu, 15 Oct 2020 14:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Ng4PMbx3pKl8S3YMuv0PTR0Kb0=; b=TDNX8x
        i+M/OE/5ti52AFG4CpOiP0tQp4jypuYqxu58nB5xS52C9327iO9gzULufbcRurbZ
        Z31LO9LXidLhSd1PIAas1s/ayGojnqtSInQRd0NZeiehF2xILe3M447QhY+pAQmv
        2hcOyp8Dkvkd3ilkV1Sna7JM8zBjXiNAhVRgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GgFB2VsFQ4CWwwHZ1tyaCC8yd/oy5IVn
        mT72Uhlj/dn+4pVu9HYejOYDnek6u7E6ZNrnv68SSq7lFTgL/OJAuYei1RnBoEMa
        ofZK9vHDJxdOVrYtt/zgU3lFuvSmuIqL4OuaFzF9CiRwqYP8Ke+BwFcfBhMlD2iy
        PF4GPrUWecw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81034F3DB0;
        Thu, 15 Oct 2020 14:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EBCBF3DAE;
        Thu, 15 Oct 2020 14:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
        <20201015012636.GA387901@coredump.intra.peff.net>
        <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
        <20201015153849.GA551964@coredump.intra.peff.net>
        <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
        <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
        <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
Date:   Thu, 15 Oct 2020 11:35:28 -0700
In-Reply-To: <f3e4f7ccc36dc214201c1838acce4aff@sebres.de> (Dipl. Ing. Sergey
        Brester's message of "Thu, 15 Oct 2020 20:09:47 +0200")
Message-ID: <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33F4D3A2-0F15-11EB-B147-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dipl. Ing. Sergey Brester" <serg.brester@sebres.de> writes:

> May be this is a sign to introduce real issue tracker finally? :)
> No offence, but I was always wondering how a team is able to hold all
> the issue related stuff in form
> of a mailing list, without to experience such an "embarrassments".
> Especially on such large projects and communities.

I do not know if an issue-tracker would have helped, though.  The
issue was discovered and discussed there the day before:

  https://lore.kernel.org/git/xmqqimg5o5fq.fsf@gitster.c.googlers.com/

and then was discussed in other thread the next day.  Somehow the
discussion petered out without producing the final patch to be
applied.  For this particular case, what we need is a functioning
patch tracker *and* people who pay attention to patches in the "came
very close to conclusion but no final patch in the tree" state.  We
need people who can volunteer their eyeballs and attention to nudge,
prod and help patches to perfection, and that won't be me.

By the way, now I know why it looked familiar---the fix largely was
my code.  And the diff between Brian's from June and Peff's in this
thread is indeed quite small (shown below), which actually worries
me.  Was there something in the old attempt that was incomplete that
made us wait for the final finishing touches?  If so, is the current
round missing the same thing?  Or perhaps the test was what was
missing in the old attempt, in which case it's perfect (in the
attached diff, I excluded t/ directroy as the old fix didn't have
tests).

Thanks.

diff --git w/builtin/fast-import.c c/builtin/fast-import.c
index 71289b21e3..70d7d25eed 100644
--- w/builtin/fast-import.c
+++ c/builtin/fast-import.c
@@ -526,15 +526,15 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static void insert_mark(struct mark_set **sp, uintmax_t idnum, struct object_entry *oe)
+static void insert_mark(struct mark_set **top, uintmax_t idnum, struct object_entry *oe)
 {
-	struct mark_set *s = *sp;
+	struct mark_set *s = *top;
 
 	while ((idnum >> s->shift) >= 1024) {
 		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
-		s->shift = (*sp)->shift + 10;
-		s->data.sets[0] = (*sp);
-		(*sp) = s;
+		s->shift = (*top)->shift + 10;
+		s->data.sets[0] = *top;
+		*top = s;
 	}
 	while (s->shift) {
 		uintmax_t i = idnum >> s->shift;
@@ -3323,13 +3323,14 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	*f = '\0';
 	f++;
 	ms = xcalloc(1, sizeof(*ms));
-	string_list_insert(list, s)->util = ms;
 
 	fp = fopen(f, "r");
 	if (!fp)
 		die_errno("cannot read '%s'", f);
 	read_mark_file(&ms, fp, insert_oid_entry);
 	fclose(fp);
+
+	string_list_insert(list, s)->util = ms;
 }
 
 static int parse_one_option(const char *option)
