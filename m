Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F97D20756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdATTDc (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:03:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61855 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751497AbdATTDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:03:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B46AE5FF3F;
        Fri, 20 Jan 2017 14:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kP1UruYNIH2e00/WxK9aIoLtzow=; b=wmGqze
        9y+CZuc5Y7s4NJIrCmCRwvL2XziFO/+ZpZ+x/mnq3WVlWYQP3RR4MphrkuM4p1V1
        BtnDswfFSTKLvWwvsjlN7+TsYVTZXJYrqZinpx4W2T3Y3yMzdfoKmTNdGjBv1anN
        FfCpL/17BFNZ7Fcr4iaT1cLPNjhIoIyJI6dQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y1V882p8MVEPaGD/qe0jZM7IHLTqAsO8
        Ufy5HYtE4MNk9rENa9LGpdHJjqDlTemToszGavqC5YL48Z1a6b+WiU9bbAnGo9+A
        9gx3QrLbuXd16Z42+WhTEWEiZLNR07oHtniMYFfs04BkqdgB6NydkIKLoFXx4Hp4
        4lmWQ7xFf0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA9DA5FF3D;
        Fri, 20 Jan 2017 14:03:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FF385FF3C;
        Fri, 20 Jan 2017 14:03:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <git@thecybershadow.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
References: <20170120155015.4360-1-git@thecybershadow.net>
Date:   Fri, 20 Jan 2017 11:03:23 -0800
In-Reply-To: <20170120155015.4360-1-git@thecybershadow.net> (Vladimir
        Panteleev's message of "Fri, 20 Jan 2017 15:50:15 +0000")
Message-ID: <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 219880CE-DF43-11E6-A49F-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Panteleev <git@thecybershadow.net> writes:

> This patch adds --head support to show-ref's --verify logic, by
> explicitly checking if the "HEAD" ref is specified when --head is
> present.

> @@ -207,6 +207,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
>  				if (!quiet)
>  					show_one(*pattern, &oid);
>  			}
> +			else if (show_head && !strcmp(*pattern, "HEAD"))
> +				head_ref(show_ref, NULL);
>  			else if (!quiet)
>  				die("'%s' - not a valid ref", *pattern);
>  			else

The context around here look like this:

		while (*pattern) {
			struct object_id oid;

			if (starts_with(*pattern, "refs/") &&
			    !read_ref(*pattern, oid.hash)) {
				if (!quiet)
					show_one(*pattern, &oid);
			}
			else if (!quiet)
				die("'%s' - not a valid ref", *pattern);
			else
				return 1;
			pattern++;
		}

and viewed in the wider context, I notice that quiet is not honored
in the added code.  I think that is easily fixable by replacing this
hunk with something like:

-	if (starts_with(*pattern, "refs/") &&
+	if (to_show_ref(*pattern) &&

and then another hunk that implements to_show_ref() helper function,
perhaps like

	static int to_show_ref(const char *pattern)
	{
		if (starts_with(pattern, "refs/"))
			return 1;
		if (show_head && !strcmp(pattern, "HEAD"))
			return 1;
		return 0;
	}

or something.

Having said all that, using --verify on HEAD does not make much
sense, because if HEAD is missing in .git/, I do not think Git
considers that directory as a Git repository to begin with.  So from
that point of view, I am not sure what value this change adds to the
system, even though the change is almost correct (modulo the "quiet"
thing).
