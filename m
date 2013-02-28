From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] contrib/subtree: allow addition of remote branch
 with name not locally present
Date: Wed, 27 Feb 2013 16:20:07 -0800
Message-ID: <7vwqtti91k.fsf@alter.siamese.dyndns.org>
References: <CALeLG_ndDWyPWRBQtKV4WswZUKRpNQzCAXmB0f0yoKGsAYMUig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	David Greene <greened@obbligato.org>,
	Jesper Lyager Nielsen <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:21:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UArEq-0001ke-JW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 01:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab3B1AUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 19:20:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab3B1AUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 19:20:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30E0CC18C;
	Wed, 27 Feb 2013 19:20:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8iQInosn/6v8XzKTEoKiRSo+u3U=; b=pr0+Gl
	4rIWdYKwL5MNp2ReE976clVWaAk4DMs26DlDJeAJsmofHzaCUYWVyHy3YZMx8YS2
	SeTqyFNHIx7xAwd+3+tGcnhPGeOeEIDgvW9vVj+Oo0SNow62xdf2GPe73oi6mzoU
	uJSSK2pbmsqy+v4H7IQNTiQ1i7+zJD6iozHiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CqAJ5K8Lx+4ipx6QkitsN9t0JK3lELZy
	YJXvQQxUNKJcrlY9eLwXXzmQtAyyz3SjZufjXTCRmsACPBBho8MUBFjILc9E9QuN
	BoW7pcrQnYzwR3pklDpUm3HPsxCjx3dBRhBghbJhzVHykw3ku1AcHBJF2K1tNYbC
	L8ImnLBTBBk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 255F6C18B;
	Wed, 27 Feb 2013 19:20:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E689C187; Wed, 27 Feb 2013
 19:20:08 -0500 (EST)
In-Reply-To: <CALeLG_ndDWyPWRBQtKV4WswZUKRpNQzCAXmB0f0yoKGsAYMUig@mail.gmail.com> (Paul
 Campbell's message of "Wed, 27 Feb 2013 23:51:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BC77490-813C-11E2-84FA-2B642E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217229>

Paul Campbell <pcampbell@kemitix.net> writes:

> cmd_add() attempts to check for the validity of refspec for the repository
> it is about to add as a subtree. It tries to do so before contacting the
> repository. If the refspec happens to exist locally (say 'master') then
> the test passes and the repo is fetched. If the refspec doesn't exist
> locally then the test fails and the remote repo is never contacted.
>
> Removing the tests still works as the git fetch command fails with the
> perfectly accurate error:
>
>   fatal: Couldn't find remote ref <refspec>
>
> Signed-off-by: Paul Campbell <pcampbell@carnegiecollege.ac.uk>
> ---
>
> I must confess to not understanding the comment preceding the
> rev-parse test. Given that it is against the rev-parse and not the
> cmd_add_repository call I'm assuming it can be removed.

This is contrib/ material and I do not use the command, so anything
I say should be taken with a moderate amount of salt, but I think
the comment is talking about _not_ accepting a full storing refspec,
or worse yet wildcard, e.g.

	refs/heads/topic:refs/remotes/origin/topic
	refs/heads/*:refs/remotes/origin/*

which will not make sense given that you are only adding a single
commit via "cmd_add".  Also, if you have already fetched from the
remote, "rev-parse $2^{commit}" at this point will protect against
a typo by the end user.

As you noticed, checking if $2 is a commit using rev-parse _before_
fetching $2 from the remote repository is not a valid way to check
against such errors.  So I tend to agree that removing the "die"
will be a good idea.

Typing "tipoc" when the user meant "topic" will error out at the
"git fetch" done in cmd_add_repository, but that fetch will happily
fetch and store whatever a refspec specifies, so you might want to
replace the bogus "rev-parse before fetching" check to "reject
refspec" with something else.

>  contrib/subtree/git-subtree.sh | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 8a23f58..9a38b18 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -503,14 +503,6 @@ cmd_add()
>
>             "cmd_add_commit" "$@"
>         elif [ $# -eq 2 ]; then
> -           # Technically we could accept a refspec here but we're
> -           # just going to turn around and add FETCH_HEAD under the
> -           # specified directory.  Allowing a refspec might be
> -           # misleading because we won't do anything with any other
> -           # branches fetched via the refspec.
> -           git rev-parse -q --verify "$2^{commit}" >/dev/null ||
> -           die "'$2' does not refer to a commit"
> -
>             "cmd_add_repository" "$@"
>         else
>             say "error: parameters were '$@'"
> --
> 1.8.2.rc1
