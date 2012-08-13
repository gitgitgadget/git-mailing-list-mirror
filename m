From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cherry-pick/revert: default to topological sorting
Date: Mon, 13 Aug 2012 13:23:07 -0700
Message-ID: <7vpq6uczis.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e51.29d0320a.65ff.2c48SMTPIN_ADDED@gmr-mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: y@google.com
X-From: git-owner@vger.kernel.org Mon Aug 13 22:37:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11Oc-0002eT-EE
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 22:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab2HMUXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 16:23:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349Ab2HMUXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 16:23:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70BAF9D35;
	Mon, 13 Aug 2012 16:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Igk6LW5EwVLimA81aFBQ70dqo6o=; b=Vxqpkk
	DUqsfIMnUgcGHUs8OhmkkM0uZ5bVgSDqU3YofZWwHPBjBRHKemukVio9EI7U4Z+b
	VAjzgVdZU84+Qwah7f9aTCC3L1mh+M9Dnnt/otoSw5S3K0jVv4rw5e7WkqhNXRTc
	dUiMpM5+noccSewTrbUHkE8EB5HjYsrc/EPtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b1aSXkkY9y1zmFDoHLF8uQpjkzbWu7Ri
	n5DUJNdv7MIKswA86v0NWLMmhIyNuv+9VbkfVtrm/EKpKsIDorlQEcR1wODWMU18
	woyefIvVbSVV/TX6ksBMxlP8Ku9CZCAVdjREczQcGcVVfmAum6XRAVvv2e3qtiiW
	3tmEdQqKc6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E0D49D33;
	Mon, 13 Aug 2012 16:23:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B90429D32; Mon, 13 Aug 2012
 16:23:08 -0400 (EDT)
In-Reply-To: <50289e51.29d0320a.65ff.2c48SMTPIN_ADDED@gmr-mx.google.com>
 (y.'s message of "Sun, 12 Aug 2012 23:27:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B24D242A-E584-11E1-A6E8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203360>

y@google.com writes:

> From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>
> When 'git cherry-pick' and 'git revert' are used with ranges such as
> 'git cherry-pick A..B', the order of the commits to pick are
> determined by the default date-based sorting. If a commit has a commit
> date before the commit date of its parent, it will therfore be applied
> before its parent.

Is that what --topo-order really means?

I just tried this:

	$ git checkout v1.7.12-rc2
	$ GIT_COMMITTER_DATE='@0 +0000' git commit --allow-empty -m old
        $ git log --pretty=fuller -2

and (obviously) the result shows the "old" one and then the v1.7.12-rc2.

The point of --topo-order is to deal with merges more sensibly, I
think, e.g. with a history with this shape with timestamps,

    ---1----2----4----7
        \              \
         3----5----6----8---   

"git log" may show "8 7 6 5 4 3 2 1", while "git log --topo-order"
would give you "8 6 5 3 7 4 2 1".

And indeed in the context of cherry-pick and revert, topo-order is a
more sensible option.

So there is nothing wrong in the patch, but the above explanation of
yours is flawed.

> In the context of cherry-pick/revert, this is most
> likely not what the user expected, so let's enable topological sorting
> by default.
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
>  builtin/revert.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 98ad641..6880ce5 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -194,6 +194,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  		opts->revs = xmalloc(sizeof(*opts->revs));
>  		init_revisions(opts->revs, NULL);
>  		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
> +		opts->revs->topo_order = 1;
>  		if (argc < 2)
>  			usage_with_options(usage_str, options);
>  		memset(&s_r_opt, 0, sizeof(s_r_opt));
