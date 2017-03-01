Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F6D2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbdCAVSI (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:18:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753304AbdCAVSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:18:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4C3E77CBD;
        Wed,  1 Mar 2017 16:14:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pRefPztMNRTzqdKUIcChZZu3E6w=; b=IcK117
        Vt0Ub3H4Xj/elPXMQF1GPjJOL1Fe7DgGMsgaNK/wohPK7ma7CHP6pg+/ljGrmGW2
        eftjQuBHD5xUpe2iypLClq/QS9LQ6fyBSHznZBbLGndrx9FYMEI7xROy25ZvIOoP
        Yu2pgp9R0F86RcYA9q4oQEs8//PI+s2sGEBwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f+mvgnfyuNP4Dsy5Eoru/A/pVQ0iDI8Z
        yM5bA1LdVgjOPyqJsS2gO2iZgnWutNb6c5ZZhYc4rJWu1jFzDxAkAF40GXqBauaZ
        zEYV8RZvEeVlo0yhHPOFEN5AC0Jvx9MYigQu87yl4jztCKYyU+oPCcHG1tt6eZDn
        zqu9Viix/0c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCBCC77CBB;
        Wed,  1 Mar 2017 16:14:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D2EB77CBA;
        Wed,  1 Mar 2017 16:14:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, mac@mcrowe.com
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
Date:   Wed, 01 Mar 2017 13:14:01 -0800
In-Reply-To: <20170301170444.14274-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 1 Mar 2017 18:04:44 +0100")
Message-ID: <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF04E1B0-FEC3-11E6-8684-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> git diff --quiet may take a short-cut to see if a file is changed
> in the working tree:
> Whenever the file size differs from what is recorded in the index,
> the file is assumed to be changed and git diff --quiet returns
> exit with code 1
>
> This shortcut must be suppressed whenever the line endings are converted
> or a filter is in use.
> The attributes say "* text=auto" and a file has
> "Hello\nWorld\n" in the index with a length of 12.
> The file in the working tree has "Hello\r\nWorld\r\n" with a length of 14.
> (Or even "Hello\r\nWorld\n").
> In this case "git add" will not do any changes to the index, and
> "git diff -quiet" should exit 0.

The thing I find the most disturbing is that at this point in the
flow, p->one->size and p->two->size are supposed to be the sizes of
the blob object, not the contents of the file on the working tree.
IOW, p->two->size being 14 in the above example sounds like pointing
at a different bug, if it is 14.  

The early return in diff_populate_filespec(), where it does

	s->size = xsize_t(st.st_size);
	...
	if (size_only)
		return 0;

way before it runs convert_to_git(), may be the real culprit.

I am wondering if the real fix would be to do this, instead of the
two extra would_convert_to_git() call there in the patch you sent.
The result seems to still pass the new test in your patch.

Thanks for helping.

 diff.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 8c78fce49d..dc51dceb44 100644
--- a/diff.c
+++ b/diff.c
@@ -2792,8 +2792,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 			s->should_free = 1;
 			return 0;
 		}
-		if (size_only)
+
+		/*
+		 * Even if the caller would be happy with getting
+		 * only the size, we cannot return early at this
+		 * point if the path requires us to run the content
+		 * conversion.
+		 */
+		if (!would_convert_to_git(s->path) && size_only)
 			return 0;
+
+		/*
+		 * Note: this check uses xsize_t(st.st_size) that may
+		 * not be the true size of the blob after it goes
+		 * through convert_to_git().  This may not strictly be
+		 * correct, but the whole point of big_file_threashold
+		 * and is_binary check is that we want to avoid
+		 * opening the file and inspecting the contents, so
+		 * this is probably fine.
+		 */
 		if ((flags & CHECK_BINARY) &&
 		    s->size > big_file_threshold && s->is_binary == -1) {
 			s->is_binary = 1;
