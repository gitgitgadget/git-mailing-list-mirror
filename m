From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Mon, 12 Sep 2011 14:25:38 -0700
Message-ID: <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
References: <20110912195652.GA27850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3E0j-0000GW-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 23:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab1ILVZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 17:25:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab1ILVZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 17:25:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA5E5618;
	Mon, 12 Sep 2011 17:25:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WOhI5H/gpzFbQRpQcZy4XGNnBAo=; b=Aql0sd
	zJD5QTshT01ywquhF5ww2VvmWOZweWOKSU7GRjChEYgQr+KEyiU2JpZH+qdOTFPe
	EksFEZaOohelkf56w34ZXAVMP+p8mfO94kThrciPT53tAJ2rgy2ibK3jsviPZ8TQ
	3J5aoaq++omisuuXWR6Zh0q5gb4doyPFqL0Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J3/LjuyIQ/W1RCVYqwwRbpZov3gZcGAi
	mLB69HxH2FtJ0wKfcY2K6ACjPC+o83BQJgWL249ewXql7BZeN3940xg8smeWA48e
	O2xHdMNPYNvwjGxTiGVhLtsXaFVY2y2SS0E7va3ZVXIPrwqb/0BRTwNhto1n/ybJ
	qXlPpNX+TQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B328B5617;
	Mon, 12 Sep 2011 17:25:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 152425615; Mon, 12 Sep 2011
 17:25:40 -0400 (EDT)
In-Reply-To: <20110912195652.GA27850@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Sep 2011 15:56:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C41180A0-DD85-11E0-937E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181240>

Jeff King <peff@peff.net> writes:

> +struct argv_array {
> +	const char **argv;
> +	unsigned int argc;
> +	unsigned int alloc;
> +};
> +
> ...
> +static void calculate_changed_submodule_paths() {

Locally fixed while queueing; no need to resend:

        static void calculate_changed_submodule_paths(void)
        {

>  	struct rev_info rev;
>  	struct commit *commit;
> -	const char *argv[] = {NULL, NULL, "--not", "--all", NULL};
> -	int argc = ARRAY_SIZE(argv) - 1;
> +	struct argv_array argv;
>  
>  	init_revisions(&rev, NULL);
> -	argv[1] = xstrdup(sha1_to_hex(new_sha1));
> -	setup_revisions(argc, argv, &rev, NULL);
> +	init_argv(&argv);
> +	push_argv(&argv, "--"); /* argv[0] program name */
> +	sha1_array_for_each_unique(&ref_tips_after_fetch,
> +				   add_sha1_to_argv, &argv);
> +	push_argv(&argv, "--not");
> +	sha1_array_for_each_unique(&ref_tips_before_fetch,
> +				   add_sha1_to_argv, &argv);
> +	setup_revisions(argv.argc, argv.argv, &rev, NULL);

I initially thought "eh, what if we have very many refs that may not fit
on the command line", but this is running the internal rev-list, so there
is no such issue.

I however have to wonder if the use of object flags done by this revision
walking need to be cleared to prevent them from interfering with the
ancestry walking done in find_common(). Shouldn't this be done in a
subprocess "rev-list" that is fed these positive and negative refs from
its standard input?

The patch does not make things worse in any sense, so I'll queue it but I
have this suspicion that fetching in a superproject that uses submodules
may be broken in the versions of Git with these internal revision walking.
