Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2308C1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 18:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfGPSU4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 14:20:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59981 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388386AbfGPSUz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 14:20:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD97216E43C;
        Tue, 16 Jul 2019 14:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TzJXxmhMQSxLFTqFY4bCk/xCE3A=; b=lM2+3n
        x6MM09BXnBazfwUipYP2EItZWxBpWmI1GNT0+dfoINWa7wOG70pmD5BMbhSIMV4x
        aq2cBklTyBGvcG1jbreiX2uP0PiVZPUCoQcaOxA+qpRUsf+yZOv45v8+qlsGhFl9
        NmoFe00b2QqE+dfvA+NiYsIe+sLG8IoEJzV94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eke6LdFxwkBQ47hw6nIWebkSvW6yhLGc
        CYD2FlcXI6gkMCvs+Pe/pECd9axVjRud6j/HcGheeij/AI9o3krKaeh0rq06OII5
        q7WKUr361oxNU6XCMRINUu4oc2SdYyr28hdFRJOrI+2sIFA1uFLoKcbm+Q3MmGfX
        3GvlHKrzZSc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B495616E43B;
        Tue, 16 Jul 2019 14:20:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13D6716E43A;
        Tue, 16 Jul 2019 14:20:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steven Roberts <fenderq@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git segfault in tag verify (patch included)
References: <CAOGP0GoYviFHhFzhqEimEw+ebd=DJx9JucG4BNvSvPuDudoWxw@mail.gmail.com>
Date:   Tue, 16 Jul 2019 11:20:48 -0700
In-Reply-To: <CAOGP0GoYviFHhFzhqEimEw+ebd=DJx9JucG4BNvSvPuDudoWxw@mail.gmail.com>
        (Steven Roberts's message of "Tue, 16 Jul 2019 10:47:17 -0700")
Message-ID: <xmqqsgr53kov.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7064E7DC-A7F6-11E9-870B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steven Roberts <fenderq@gmail.com> writes:

> I believe I have found an off-by-one error in git.
>
> Please see https://marc.info/?l=openbsd-ports&m=156326783610123&w=2

That is this thing.

        static void parse_gpg_output(struct signature_check *sigc)
        {
                const char *buf = sigc->gpg_status;
                const char *line, *next;
                int i, j;
                int seen_exclusive_status = 0;

                /* Iterate over all lines */
                for (line = buf; *line; line = strchrnul(line+1, '\n')) {
                        while (*line == '\n')
                                line++;
                        /* Skip lines that don't start with GNUPG status */
                        if (!skip_prefix(line, "[GNUPG:] ", &line))
                                continue;

If the GPG output ends with a trailing blank line, we skip and get
to the terminating NUL, then find that it does not begin with
the "[GNUPG:] " prefix, and hit the continue.  We try to scan and
look for LF (or stop at the end of the string) for the next round,
starting at one past where we are, which is already the terminating
NUL.  Ouch.

Good finding.

We need your sign-off (see Documentation/SubmittingPatches).

Thanks.


-- >8 --
From: Steven Roberts <fenderq@gmail.com>
Subject: gpg-interface: do not scan past the end of buffer

If the GPG output ends with trailing blank lines, after skipping
them over inside the loop to find the terminating NUL at the end,
the loop ends up looking for the next line, starting past the end.

---
 gpg-interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 8ed274533f..eb55d46ea4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -116,6 +116,9 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (line = buf; *line; line = strchrnul(line+1, '\n')) {
 		while (*line == '\n')
 			line++;
+		if (!*line)
+			break;
+
 		/* Skip lines that don't start with GNUPG status */
 		if (!skip_prefix(line, "[GNUPG:] ", &line))
 			continue;

