From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Fri, 19 Feb 2016 13:13:45 -0800
Message-ID: <xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
References: <1455908253-1136-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, dborowitz@google.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 22:14:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWsNL-00084M-6q
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 22:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993927AbcBSVNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 16:13:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992964AbcBSVNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 16:13:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB68346058;
	Fri, 19 Feb 2016 16:13:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0nn3LFNnqiVqKr74obq+rswDutw=; b=fili3z
	d3MIi7NJtGkWRbZgWpsrQYrAwGTemQ6DY6CfHezV3AnNf6A+U6q9ICLpf99SN8uI
	/7co2AYjxaDDYI6NMQj2Pqr1CZQzmoqCRVHNyZq/9RnuHVfuMD6kO1m0qQ7zADlA
	ZplaLqXioE6WH4bmRCxcL77+y6Dm7s7gIt5cU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YfK7BM3R7kDl0idHPqXnh0r64uR1fnPW
	Vt+qopN6UnvYD76S+u3vQTGTxyJkkHprMhT2QIgRdg8Qs9mw9JOYf6O/itiwbpYM
	hdJcUyQrXMvn0hWUC2Uh/Pd1UsXnVR4+lI2KvUKLzC/5ZJ4nxjBwILFzLYiE/wmK
	UA3hPKT4i4Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B321946057;
	Fri, 19 Feb 2016 16:13:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 372CF46055;
	Fri, 19 Feb 2016 16:13:46 -0500 (EST)
In-Reply-To: <1455908253-1136-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 19 Feb 2016 10:57:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9971E62-D74D-11E5-BC98-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286751>

Stefan Beller <sbeller@google.com> writes:

> When reviewing a change in Gerrit, which also updates a submodule,
> a common review practice is to download and cherry-pick the patch locally
> to test it. However when testing it locally, the 'git submodule update'
> may fail fetching the correct submodule sha1 as the corresponding commit
> in the submodule is not yet part of the project history, but also just a
> proposed change.
>
> To ease this, try fetching by sha1 first and when that fails (in case of
> servers which do not allow fetching by sha1), fall back to the default
> behavior we already have.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> I think it's best to apply this on origin/master, there is no collision
> with sb/submodule-parallel-update.
>
> Also I do not see a good way to test this both in correctness as well
> as performance degeneration. If the first git fetch fails, the second
> fetch is executed, so it should behave as before this patch w.r.t. correctness.
>
> Regarding performance, the first fetch should fail quite fast iff the fetch
> fails and then continue with the normal fetch. In case the first fetch works
> fine getting the exact sha1, the fetch should be faster than a default fetch
> as potentially less data needs to be fetched.

"The fetch should be faster" may not be making a good trade-off
overall--people may have depended on the branches configured to be
fetched to be fetched after this codepath is exercised, but now if
the commit bound to the superproject tree happens to be complete,
even though it is not anchored by any remote tracking ref (hence the
next GC may clobber it), the fetch of other branches will not
happen.

My knee-jerk reaction is that the order of fallback is probably the
other way around.  That is, try "git fetch" as before, check again
if the commit bound to the superproject tree is now complete, and
fallback to fetch that commit with an extra "git fetch".

Jens, what do you think?

>  git-submodule.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9bc5c5f..ee0b985 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -746,8 +746,9 @@ Maybe you want to use 'update --init'?")"
>  				# Run fetch only if $sha1 isn't present or it
>  				# is not reachable from a ref.
>  				(clear_local_git_env; cd "$sm_path" &&
> +					remote_name=$(get_default_remote)
>  					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> -					 test -z "$rev") || git-fetch)) ||
> +					 test -z "$rev") || git-fetch $remote_name $rev

Regardless of the "fallback order" issue, I do not think $rev is a
correct thing to fetch here.  The superproject binds $sha1 to its
tree, and you would be checking that out, so shouldn't you be
fetching that commit?
