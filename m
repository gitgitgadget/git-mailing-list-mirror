Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F1C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF15361158
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhDOUGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:06:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58503 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhDOUGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:06:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CEA7C0A7B;
        Thu, 15 Apr 2021 16:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QplTrifBSEBpK7Nc2bl205j2Eb4=; b=OA2bK1
        AvmaiqgqcBcJCuV11/Gbmb07nJ00kGSfY9P+vuNFIrJCokcLZmNJgTr6wt+154s5
        z+9s0IcpG1DZU86FIbAAVecyu1jxfJxJP0PF9bTFuSycN2BYqFf4B7lfwWSZ6q8m
        d/ivhwCYzHbJUsu60HQQnkdFD/Et3eA8bvwLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mqy4MGxxeLpcMJ/hEz3SqIMfqqcNsCgj
        fZ4K7pQTDCgwRtzwjuIfaMULVN0ej0wkIAxTuQcjeedqdGUBgD4CL2HEGAJNuyv4
        BJfyXazNhoOKX83Zs5yr/i+I5Ey9WwVhfDGQqYKEsknOZC7ImqDe2LvGHlVK7kVo
        ZQlFaiccDjs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25369C0A7A;
        Thu, 15 Apr 2021 16:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5902C0A79;
        Thu, 15 Apr 2021 16:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] pkt-line: do not report packet write errors twice
References: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
Date:   Thu, 15 Apr 2021 13:06:20 -0700
In-Reply-To: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 15 Apr 2021 16:10:07 -0300")
Message-ID: <xmqqtuo7pb2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C48429E-9E26-11EB-BCF9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> On write() errors, packet_write() dies with the same error message that
> is already printed by its callee, packet_write_gently(). This produces
> an unnecessarily verbose and repetitive output:
>
> error: packet write failed
> fatal: packet write failed: <strerror() message>
>
> In addition to that, packet_write_gently() does not always fulfill its
> caller expectation that errno will be properly set before a non-zero
> return. In particular, that is not the case for a "data exceeds max
> packet size" error. So, in this case, packet_write() will call
> die_errno() and print a strerror(errno) message that might be totally
> unrelated to the actual error.
>
> Fix both those issues by turning packet_write() and
> packet_write_gently() into wrappers to a lower level function which is
> now responsible to either error() or die() as requested by its caller.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  pkt-line.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Nicely done.  Duplicated error message literals do look, eh,
repetitious, though.

I wonder if something like this on top would be an improvement.

Upon seeing "return error(_(VARIABLE_NAME))", it may be distracting
that you now have to move to where the actual message is defined
while following the logic of the code, but as long as the variable
name captures the essense of what the message says, it may be OK.

I dunno.


 pkt-line.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git c/pkt-line.c w/pkt-line.c
index 39c9ca4212..d357c74fcd 100644
--- c/pkt-line.c
+++ w/pkt-line.c
@@ -199,12 +199,16 @@ static int do_packet_write(const int fd_out, cons
 {
 	char header[4];
 	size_t packet_size;
+	static const char size_error_message[] =
+		N_("packet write failed - data exceeds max packet size");
+	static const char write_error_message[] =
+		N_("packet write failed");
 
 	if (size > LARGE_PACKET_DATA_MAX) {
 		if (gentle)
-			return error(_("packet write failed - data exceeds max packet size"));
+			return error(_(size_error_message));
 		else
-			die(_("packet write failed - data exceeds max packet size"));
+			die(_(size_error_message));
 	}
 
 	packet_trace(buf, size, 1);
@@ -222,9 +226,9 @@ static int do_packet_write(const int fd_out, const
 	if (write_in_full(fd_out, header, 4) < 0 ||
 	    write_in_full(fd_out, buf, size) < 0) {
 		if (gentle)
-			return error_errno(_("packet write failed"));
+			return error_errno(_(write_error_message));
 		else
-			die_errno(_("packet write failed"));
+			die_errno(_(write_error_message));
 	}
 	return 0;
 }
