Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06C07202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755870AbdKQSlD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 13:41:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64412 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755723AbdKQSlB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 13:41:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 917C7A42FD;
        Fri, 17 Nov 2017 13:40:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Z5u3CXP0nPaBVVXgtkGd+dNDws=; b=rVThhy
        q7ZgLeDI4zQIIZy5Op/pSbcKrFh6VBI+iQug04fayIwU03dORX77lOe6c6pQwKNX
        qC9zAlJYYPVehI5Y08svQ4jCosvU22QKWE4+GikdfE8qrUX3gYGEr4Pqy2VUWwBL
        imzdyNK28pADI8xazeRU+UNPvAz36MewgeARc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZAP+tmGLes0w22EFb/PfBTI/L3Tzs+V3
        pnRBYC6Jt1bDh/r7Z7Ywa9v/5DQwuTklXNXjpT8QXG3VGMw6MxaSJ8O7RrhoqXdr
        mKdCymZ3ClZjAEOm2E2hSxEOuRZvbDIPjzbxTUexuqmH06zgn1B7Vb3XkvOFFAoS
        0hbrvRp89ZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89E7BA42FC;
        Fri, 17 Nov 2017 13:40:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A9E5A42FB;
        Fri, 17 Nov 2017 13:40:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
Date:   Sat, 18 Nov 2017 03:40:56 +0900
In-Reply-To: <20171117135109.18071-1-lars.schneider@autodesk.com> (lars
        schneider's message of "Fri, 17 Nov 2017 14:51:09 +0100")
Message-ID: <xmqqy3n4rbnr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA1125A0-CBC6-11E7-A5DB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> Junio posted the original version of this patch [1] as response to my RFC [2].
> I took Junio's patch and slightly changed the commit message as well as the
> message printed to the user after GIT_EDITOR is invoked [3].
>
> Thanks,
> Lars

Thanks.

> diff --git a/editor.c b/editor.c
> index 7519edecdc..23db92d8c6 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -40,6 +40,32 @@ int launch_editor(const char *path, struct strbuf...
> ...
> +		if (close_notice) {
> +			fprintf(
> +				stderr,
> +				"Launched your editor ('%s'). Adjust, save, and close the "
> +				"file to continue. Waiting for your input... ", editor

How wide is your typical terminal window?  With message this long, a
sample standalone program I used while developing the prototype of
this feature no longer can retract this "temporary" message.

Would something shorter like "Waiting for you to finish editing..."
work well enough?

-- -- --
#include <stdio.h>

int main(void)
{
	const char *EL = "\033[K"; /* Erase in Line */
	const char *editor = "emacsclient";

	fprintf(
		stderr,
		"Launched your editor ('%s'). Adjust, save, and close the "
		"file to continue. Waiting for your input... ", editor);
	fflush(stderr);
	sleep(2);
	fprintf(stderr, "\r%s", EL);
	fflush(stderr);
	return 0;
}
-- -- --

