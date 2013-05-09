From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fast-export: improve argument parsing
Date: Thu, 09 May 2013 15:17:47 -0700
Message-ID: <7vzjw37q7o.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 00:17:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZ9u-0008Bl-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3EIWRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:17:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab3EIWRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:17:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518AA1D045;
	Thu,  9 May 2013 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vGBtCzZLSvYkBoIAG4zRErkVUaM=; b=X4Zs+G
	qj27FzPRTbPlKXBjZySSkNqnw3UBYlO5CUfucl4T3NEjuRzWdWHaeNxv3xf6+RMr
	5ayqHdXWclhcU2kLTs8U/3bwvNYiVzqq5S9vmF0RXrPTamo6myJl3hQcnwbHm40Z
	7XizQliycpyheyVfZbv8e1/rAiaDWgC2ey4j0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u6i2KroETVg9MJPV3JKQBbHJXc4OClNz
	c1RlbSYoF9rhaUHvf9JNqyzNLR5NWdL9UrNTJk7qj+eOMYJGgEs7QjCD/U/tTEjt
	erJ8iKfTo8j7cYkc1raHwyB6/KiydgKXIFMrhgc6gvzIq5ul3Sk8mrgLiaW3ZbmD
	3IlGrxerTAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44D191D043;
	Thu,  9 May 2013 22:17:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB9CA1D042;
	Thu,  9 May 2013 22:17:48 +0000 (UTC)
In-Reply-To: <1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 8 May 2013 20:31:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 483056A2-B8F6-11E2-9A8E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223788>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We don't want to pass arguments specific to fast-export to
> setup_revisions.

Interesting.  What bad things happen with the current order?

Does "fast-export --export-marks=foo" causes setup_revisions() to
mistakenly eat --export-marks=foo and barf?

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d60d675..6e46057 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -686,8 +686,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  	revs.topo_order = 1;
>  	revs.show_source = 1;
>  	revs.rewrite_parents = 1;
> +	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
> +			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
>  	argc = setup_revisions(argc, argv, &revs, NULL);
> -	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
>  	if (argc > 1)
>  		usage_with_options (fast_export_usage, options);

There is a SP between the function name and its arguments here ;-)
