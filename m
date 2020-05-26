Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FFC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183BD2068D
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Job0H9O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgEZQK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 12:10:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53312 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgEZQK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 12:10:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57B2F6D790;
        Tue, 26 May 2020 12:10:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YCL2xcL0iUGgaKzuDRV8jF00y7E=; b=Job0H9
        O0aLkuJa6lJ4ZUw1OAtZzxIJOh6RsG50KFEKfITmSWOMokZ5pXkUMGBNqsBFwpaM
        UZ/4frAPNXZXwSgeAVHHVTX6SMxzcUc9h/U5fdCdpTbEqWK/fJRFx724rhCd1jJy
        rZCAgQ7+89ISyWmpSadqRAQBiqOhtYE+2rfuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cYUcc1u+Y/xMd+TSiKxyefRSW+PTjaMQ
        vFaf/dTJGiNr1Uh+pDTkVN+zA/LwZtA1MMh5zIoAcn+yfg7vuFot+q5aMISIFTSJ
        eoTTE5vIYD4BWqkfynPBu2wkMilY+fCLCxXzPqNCWN/jhV221J9IGkkm3H1JPAk3
        nVRrT1xXNuk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 503476D78F;
        Tue, 26 May 2020 12:10:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C36006D78E;
        Tue, 26 May 2020 12:10:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] diff algorithm selection issue
References: <540830445.1034524732.1590485817611.JavaMail.root@zimbra39-e7>
Date:   Tue, 26 May 2020 09:10:22 -0700
In-Reply-To: <540830445.1034524732.1590485817611.JavaMail.root@zimbra39-e7>
        (ydirson@free.fr's message of "Tue, 26 May 2020 11:36:57 +0200
        (CEST)")
Message-ID: <xmqqh7w2oexd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67181F24-9F6B-11EA-89EE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ydirson@free.fr writes:

> When the config has diff.algorithm=patience set, "git diff --minimal" seems to
> be ignored, and does not give the same output as "git diff --diff-algorithm=minimal",
> but really the same as "git diff --diff-algorithm=patience".

Thanks for reporting.  The document on --diff-algorithm does make it
sound as if the --diff-algorithm=minimal option must operate as if
myers algorithm is used with the minumalization tweak, but that is
wrong from the point of view of the intent of the "minimal" option,
which was meant to be a secondary option that tweaks the base
algorithm (be it myers or patience or any other new algorithm we
might introduce in the future) by allowing it to spend more cycles
to come up with a smaller diff.

At least, it is what the "--minimal" option (not the value "minimal"
given to the "--diff-algorithm=<algo>" option), and the underlying
mechanism that supports the option, meant to do.

But the way the option is surfaced to the end-user facing UI (and
the documentation) with "--diff-algorithm=minimal", it does look
like 

	git -c diff.algorithm=patience cmd --diff-algorithm=minimal
	git -c diff.algorithm=patience cmd --diff-algorithm=myers --minimal

ought to be equivalent.

Also, I suspect that

	git -c diff.algorithm=patience cmd --diff-algorithm=myers

does not do what we expect, either.

I have not convinced myself that the attached is the best way to fix
the issue, but anyway, somebody seems to be OR'ing in diff_algorithm
to xdl_opts field after we see --diff-algorithm=minimal and replaced
XDF_DIFF_ALGORITHM_MASK bits in xdl_opts field in this function, so
the attached patch may defeat that code---the real bug is probably in
that code, but I haven't figured out where it is X-<.

 diff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index 863da896c0..a6dba45cd6 100644
--- a/diff.c
+++ b/diff.c
@@ -5026,6 +5026,10 @@ static int diff_opt_diff_algorithm(const struct option *opt,
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
+	/* we shouldn't have to do this... */
+	if (!(value & XDF_DIFF_ALGORITHM_MASK))
+		diff_algorithm &= ~XDF_DIFF_ALGORITHM_MASK;
+
 	/* clear out previous settings */
 	DIFF_XDL_CLR(options, NEED_MINIMAL);
 	options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
