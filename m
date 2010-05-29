From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/4] revert: allow cherry-picking a range of commits
Date: Sat, 29 May 2010 08:27:01 -0700
Message-ID: <7vmxvi4tkq.fsf@alter.siamese.dyndns.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
 <20100529044044.569.7874.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 29 17:27:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OINwr-0001IP-KT
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 17:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945Ab0E2P1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 11:27:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab0E2P1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 11:27:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1831B7C6F;
	Sat, 29 May 2010 11:27:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZrbJgIjSA6J4mVq4KBxhl1WBK2o=; b=WTiokQ
	ViHBwQjwYqG/dHZ3KOTRqYSS9sY3r2OuKLdwiuTkmzmzIPOdDkHaVSFwn3gq8cQs
	r+r4icyOJCTrzSjtM/TApZZVvLszBqThRAFUQwFSWPSWuLw39wmZ43jZfcyahhdP
	tpoxW2/uVCe8OgbbgMeOqZtRx+Afd1I+TH9G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xyc50CQUDLmUYJvmc7rH4FKKXct5UbD/
	/t1J8U9IT02H3osHAkeaFPDG+YYIm8X+oVSy2A5Ls1DBTrFUukYq6oX4TD5kn64T
	9MyavMI6XtyRAXgAehS0oZpGR36S//9JrctqIIQPoDzz8f02o3D4iCVYXtDkFwg7
	le9NUYVHCI4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D7A8B7C6C;
	Sat, 29 May 2010 11:27:07 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6EC8B7C6A; Sat, 29 May
 2010 11:27:03 -0400 (EDT)
In-Reply-To: <20100529044044.569.7874.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat\, 29 May 2010 06\:40\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4635836-6B36-11DF-9B65-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147968>

Christian Couder <chriscool@tuxfamily.org> writes:

> This makes it possible to pass a range of commits like A..B
> to "git cherry-pick" and to "git revert" to process many
> commits instead of just one.

> @@ -545,6 +542,40 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>  	if (read_cache() < 0)
>  		die("git %s: failed to read the index", me);
>  
> +	dotdot = strstr(commit_name, "..");
> +	if (dotdot) {
> +		struct rev_info revs;
> +		const char *argv[4];
> +		int argc = 0;
> +
> +		argv[argc++] = NULL;
> +		if (action != REVERT)
> +			argv[argc++] = "--reverse";
> +		argv[argc++] = commit_name;
> +		argv[argc++] = NULL;
> +
> +		init_revisions(&revs, NULL);

The goal of the series is a worthy one, but I would imagine people would
want to run these while on "maint":

    git cherry-pick master~2..master
    git cherry-pick master^ master

or even

    git cherry-pick -2 master

How about enumerating the commits with an equivalent of

    git rev-list --no-walk "$@"

as an alternative implementation?

The current behaviour would fall out just as a natural special case
because

    git rev-list --no-walk $commit == $commit

Hmm?
