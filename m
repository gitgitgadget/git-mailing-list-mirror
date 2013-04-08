From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: better error message when the parameter is
 a non-commit
Date: Mon, 08 Apr 2013 09:56:55 -0700
Message-ID: <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
References: <20130403092704.GC21520@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFNR-0002SB-QF
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935421Ab3DHQ47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 12:56:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934462Ab3DHQ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 12:56:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B58B13838;
	Mon,  8 Apr 2013 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3fix4K3Y8GidKg6m5CKyOCRMAFE=; b=TYF0ar
	xAG66gTMRkw5uzT597dJqQ7awFiYSG8ilhq3wgveSm25ka/szWP2t1m6810s2Vm6
	zFSLy3OG6NChDN1mmU+/eHDju6R+rdcLjW29i/WecHK74ihAS9UFn0KMoxMfOpsM
	RB9QCXzkSU+nHKCrB5dvEiyL1g72XFIXvS5CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0ACWTPibWKb0ddQUqr906d0JDRdlfil
	Kdc7HmifntRAw4xLFDmZBQaEODg3lLjI1/3ijtjrOGOl0tQ4BHVh8qllXwl8Shr8
	zF/0rku73gpR07AZRIjRBUznEUVepet737o1cJbLyXQ5LM8Q3v0mI+bc0X4lJs7V
	ImV/lItBSn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F351F13836;
	Mon,  8 Apr 2013 16:56:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4ECDE13833; Mon,  8 Apr
 2013 16:56:57 +0000 (UTC)
In-Reply-To: <20130403092704.GC21520@suse.cz> (Miklos Vajna's message of
 "Wed, 3 Apr 2013 11:27:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52AA8BC6-A06D-11E2-BA9E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220440>

Miklos Vajna <vmiklos@suse.cz> writes:

> When copy&paste goes wrong, and the user e.g. tries to cherry-pick a
> blob, the error message used to be:

It is the other way around.  When the user tries to cherry-pick a
non-commit we say a correct but nonspecific "expected one commit",
and it does not matter how the user threw a non-commit at us.  One
possibility could be copy&paste going wrong.

> 	fatal: BUG: expected exactly one commit from walk
>
> Instead, now it is:
>
> 	fatal: Can't cherry-pick a blob

I wonder what we would do when "git cherry-pick master: next"
is given.  That is not "single commit input" case and not covered by
this patch, but perhaps something we may want to diagnose?

In other words, perhaps we would want to inspect pending objects
before running prepare_revision_walk and make sure everybody is
commit-ish or something?

>
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
> ---
>  sequencer.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index baa0310..0ac00d4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1082,8 +1082,15 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  		if (prepare_revision_walk(opts->revs))
>  			die(_("revision walk setup failed"));
>  		cmit = get_revision(opts->revs);
> -		if (!cmit || get_revision(opts->revs))
> +		if (!cmit || get_revision(opts->revs)) {
> +			unsigned char sha1[20];
> +			if (!get_sha1(opts->revs->cmdline.rev->name, sha1)) {
> +				enum object_type type = sha1_object_info(sha1, NULL);
> +				if (type > 0 && type != OBJ_COMMIT)
> +					die(_("Can't cherry-pick a %s"), typename(type));
> +			}
>  			die("BUG: expected exactly one commit from walk");
> +		}
>  		return single_pick(cmit, opts);
>  	}
