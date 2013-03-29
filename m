From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick -x: improve handling of one-liner commit
 messages
Date: Fri, 29 Mar 2013 10:23:26 -0700
Message-ID: <7v8v56p1bl.fsf@alter.siamese.dyndns.org>
References: <20130329153818.GB27251@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>, Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULd1x-00067b-SX
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab3C2RX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:23:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756432Ab3C2RX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:23:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5392EEEEC;
	Fri, 29 Mar 2013 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0eWS1fWyS8h1veho8XoLzBZLKLA=; b=q8FaB0
	rSHmVxHOEZFR2Wgk+fVdSh10y934BFD3XsHcS7MgTf/U5wE2e4iTuQgAUfoRXGRU
	cO9/DN3h4ByUhmpYS0jzfeE/VKYReQUhA+p1AvPAHpLrPCp1gfFEIYhzicf+rD8Z
	DuVvkBJWSKlkL9SIZt95ZGjRCpx2z44S8USEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rRd5QntCQ5YSiRdbh5YAqaCo3G7vGNhV
	fSsWHwEs/FsA/xMypRaTnjgY20vz19JVk24QcE2qrL/0ckOGbmzOoHgVrVHp3xl+
	bhxSfDGNPsoWvETxpT6gPiPS+UJu9Xl5DJ+0S3E0mGllVnf1IXPPRJLIP77HMZAv
	Z9Ke2DZyKQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A738EEEB;
	Fri, 29 Mar 2013 17:23:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AABC4EEE8; Fri, 29 Mar 2013
 17:23:27 +0000 (UTC)
In-Reply-To: <20130329153818.GB27251@suse.cz> (Miklos Vajna's message of
 "Fri, 29 Mar 2013 16:38:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E79201E-9895-11E2-B8DE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219512>

Miklos Vajna <vmiklos@suse.cz> writes:

> git cherry-pick -x normally just appends the "cherry picked from commit"
> line at the end of the message, which is fine. However, in case the
> original commit message had only one line, first append a newline,
> otherwise the second line won't be empty, which is against
> recommendations.
> ---

Sign-off?

I think this is part of the bc/append-signed-off-by topic that is
about to graduate to 'master'; more specifically, b971e04f54e7
(sequencer.c: always separate "(cherry picked from" from commit
body, 2013-02-12) does the equivalent, no?

>  sequencer.c                   | 10 ++++++++++
>  t/t3501-revert-cherry-pick.sh |  8 ++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index aef5e8a..1ae0e43 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -496,6 +496,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		}
>  
>  		if (opts->record_origin) {
> +
> +			/*
> +			 * If this the message is a one-liner, append a
> +			 * newline, so the second line will be empty, as
> +			 * recommended.
> +			 */
> +			p = strstr(msgbuf.buf, "\n\n");
> +			if (!p)
> +				strbuf_addch(&msgbuf, '\n');
> +
>  			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
>  			strbuf_addstr(&msgbuf, ")\n");
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 6f489e2..858c744 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -70,6 +70,14 @@ test_expect_success 'cherry-pick after renaming branch' '
>  
>  '
>  
> +test_expect_success 'cherry-pick -x of one-liner commit message' '
> +
> +	git checkout rename2 &&
> +	git cherry-pick -x added &&
> +	git show -s --pretty=format:%s | test_must_fail grep "cherry picked"
> +
> +'
> +
>  test_expect_success 'revert after renaming branch' '
>  
>  	git checkout rename1 &&
