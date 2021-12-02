Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C17C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 07:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbhLBHfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 02:35:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbhLBHfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 02:35:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67D5F1766FF;
        Thu,  2 Dec 2021 02:31:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xMs+Xp+yGTVGWAxz7EuSaBWHXH9OQb+vqV/bez
        rVhaA=; b=lqnaTvAGcHZKmlh0dfU37KzCwLVnA/O3JV7YiKpiVhQ+ftJ1hVLxIR
        Z6Eez3LWp4pjsgNDo6OSVFn2qhgnnSqAz51KuOdapR0/qkVUlUaoNFsK9qtZqESg
        FknuM+rcyLSEJxhjAEJBbCXcPK9iSrBWemxeqKDnZmu+L+IZ4RJXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 611651766FE;
        Thu,  2 Dec 2021 02:31:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1DDF21766FD;
        Thu,  2 Dec 2021 02:31:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] http-backend: CGI error messages need to be output
 on stdout
References: <20211202001238.21808-1-jengelh@inai.de>
Date:   Wed, 01 Dec 2021 23:31:49 -0800
In-Reply-To: <20211202001238.21808-1-jengelh@inai.de> (Jan Engelhardt's
        message of "Thu, 2 Dec 2021 01:12:37 +0100")
Message-ID: <xmqqk0gnwjh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA59875C-5341-11EC-962E-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> writes:

> Accessing a clone-only URL with a browser would always show a blank
> page, because the reason string "Request is not supported" was

"is not supported" -> "not supported", I think.

> sent to the wrong file descriptor.

I looked at the messages given to not_found() and forbidden().  Most
of them do look like they are meant to be given to the remote user,
but some reveal the server side paths, and I am reluctant to judge
the security implication to start giving them, which have been
hidden so far, to the remote users.

I am not sure how strictly it is enforced these days, but at least
in early days we were fairly paranoid and aimed to make sure that a
remote user cannot tell a repository that does not exist from a
repository that the user does not have access to by throwing random
requests at the server.

http-backend.c:161:		forbidden(hdr, "Unsupported service: getanyfile");

This one should be safe, I would think.

http-backend.c:184:		not_found(hdr, "Cannot open '%s': %s", p, strerror(errno));

The 'p' is a path to a file in the repository like
'objects/alternates', that is ready to be given to open(2), so it
clearly leaks the path on the server.

http-backend.c:260:		forbidden(hdr, "Unsupported service: '%s'", name);
http-backend.c:271:		forbidden(hdr, "Unsupported service: '%s'", name);
http-backend.c:278:		forbidden(hdr, "Service not enabled: '%s'", svc->name);

These I think should be benign, but I have to admit that I didn't
think too deep about them.
