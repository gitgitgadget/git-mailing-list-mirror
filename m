Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBCB201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 05:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934745AbdKPFh1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 00:37:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934012AbdKPFhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 00:37:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 360E3B7C00;
        Thu, 16 Nov 2017 00:37:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PUqwIVBV0d5RSQsKQrbnmbncwLo=; b=QW0bFZ
        knLFjofj9wLOd+5x+4c8tBqSQ0SYNyHDKX7YOOitcW74PMgSz68N13YlpdvZe6Je
        H0Fm980qrm+Nva5HX3lL6i+WMmeLG5TGcNKk5fRahJ3NDjLhREkRMniUuRC5G04J
        7Onmuw41zE/FtB3az0Vcin6De422Oi9S7d1Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JBL4+mCRzC9zqb1xWTjJBjBQqZM5rJTj
        D2jbnErM+hU7pEdM/RXDFNBv/fVyPHABC80iV9O3WNjQ6mvgPqn/33LWuSqt2eGS
        SVRZRWNxzhk3MsGHIJKAWklMUSr5u/mNJSrqzMO4h2UPRHLALedBkiwRBPoOvJiC
        XQu6vbI1/tU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DA9BB7BFF;
        Thu, 16 Nov 2017 00:37:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91443B7BFE;
        Thu, 16 Nov 2017 00:37:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
        <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Nov 2017 14:37:23 +0900
In-Reply-To: <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Nov 2017 07:32:12 +0900")
Message-ID: <xmqq375ewzqk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39748DBC-CA90-11E7-B3E3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if we can do something like
> ...
> to tentatively give a message without permanently wasting the
> vertical space.

Learning from 13e4760a ("recv_sideband: Do not use ANSI escape
sequence on dumb terminals.", 2008-01-08), I think the above should
be more like this:

	git_spawn_editor()
	{
		static const char *finish;

		if (!finish) {
			const char ANSI_FINISH[] = "\r\033[K";
			const char DUMB_FINISH[] = "done.\n";
			char *term = getenv("TERM");

			if (term && strcmp(term, "dumb"))
				finish = ANSI_FINISH;
			else
				finish = DUMB_FINISH;
		}

		/* notice the lack of terminating LF */
		fprintf(stderr, "Launched your editor, waiting...");
		fflush(stderr);

		if (!run_command(... spawn the editor ...))
			fputs(finish, stderr);
		else
			fprintf(stderr, "failed (%s)\n", strerror(errno));
		fflush(stderr);
	}
