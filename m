From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote rename should match whole string when
 renaming remote ref directory
Date: Mon, 26 Sep 2011 11:04:26 -0700
Message-ID: <7v62kf41ud.fsf@alter.siamese.dyndns.org>
References: <1317045186-25206-1-git-send-email-benny@tonian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Benny Halevy <bhalevy@tonian.com>
To: Benny Halevy <benny@tonian.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 20:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8FXf-0002qb-3Z
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701Ab1IZSE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:04:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651Ab1IZSE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 14:04:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FEEF54A3;
	Mon, 26 Sep 2011 14:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qIXvyTvHL0CD9jE3nwQ7n31nLa8=; b=BGctlO
	Gn3pY7OUrjRGe+kHuysjkj4LgrXsFba5TfKX7LBOoVWyF8S/w/LGCMG7uYbnQ6ba
	uKGFw4NFmFshsBX7iZOjrr6pQBtIgwlTPFLz0QgiKa1VYn52WyKQywmQjgJWDR58
	ThKnMVg3uHNumFtlIF7BZWnYmEIfsdpKOkm2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=et64i5rRFfAg8lv+gBc7cuiLqNkedO6C
	5hsE6hZ5zNXaVXdO3QcAWjai+XaU97QCJd8JMoCpz4A8dB0w6pM3K29+x7AZQaPX
	tvb2NOuJ71alWcYtgqmj/5yOgqTWeUR5XBPpmaPkOx4CBA/cflA1Kj2i9clMNISo
	xQOR38NGQps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2734B54A2;
	Mon, 26 Sep 2011 14:04:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A50B549D; Mon, 26 Sep 2011
 14:04:27 -0400 (EDT)
In-Reply-To: <1317045186-25206-1-git-send-email-benny@tonian.com> (Benny
 Halevy's message of "Mon, 26 Sep 2011 16:53:06 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F978F25C-E869-11E0-A5F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182144>

Benny Halevy <benny@tonian.com> writes:

> From: Benny Halevy <bhalevy@tonian.com>
>
> Otherwise, with two remotes: test, test-2
> 	git remote rename test test-
> ends up with:
> 	.git/refs/remotes/test-
> 	.git/refs/remotes/test--2
> ...
> diff --git a/builtin/remote.c b/builtin/remote.c
> index f2a9c26..5443e71 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -571,7 +571,7 @@ static int read_remote_branches(const char *refname,
>  	const char *symref;
>  
>  	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
> -	if (!prefixcmp(refname, buf.buf)) {
> +	if (!strcmp(refname, buf.buf)) {

At this point of the code, refname has "refs/remotes/test/foo" and it is
queued to later rename it to "refs/remotes/test-/foo" (the next invocation
of this function will see "refs/remotes/test/bar" in refname). And the
strbuf buf.buf has "refs/remotes/test"; your !strcmp(refname, buf.buf)
would never trigger, I suspect.

Isn't 60e5eee (remote: "rename o foo" should not rename ref "origin/bar",
2011-09-01) the correct fix for this issue?  It makes buf.buf properly
terminated with a slash, to contain "refs/remotes/test/" so that prefixcmp
properly matches it with "refs/remotes/test/foo" but not with refs under
other hierarchies like "refs/remotes/test-2/anything".

Thanks.
