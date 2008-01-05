From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: add new 'drop' subcommand
Date: Fri, 04 Jan 2008 17:47:43 -0800
Message-ID: <7vtzltf3gg.fsf@gitster.siamese.dyndns.org>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil>
	<477EDDD4.5060509@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:48:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAy9C-0007HO-U9
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 02:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbYAEBrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 20:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYAEBrz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 20:47:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbYAEBry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 20:47:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F0384AD6;
	Fri,  4 Jan 2008 20:47:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1A764AD5;
	Fri,  4 Jan 2008 20:47:47 -0500 (EST)
In-Reply-To: <477EDDD4.5060509@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 04 Jan 2008 19:31:00 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69629>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I'm not sure if there is a proper way to get 'stash@{0}' from
> 'refs/stash' so I kept my usage of that former string outside
> of the drop_stash() function.

Doesn't "$refs_stash@{0}" (which would give refs/stash@{0} not
stash@{0}) work for you?

> diff --git a/git-stash.sh b/git-stash.sh
> index 06cb177..a789a53 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # Copyright (c) 2007, Nanako Shiraishi
>  
> -USAGE='[  | save | list | show | apply | clear | create ]'
> +USAGE='[  | save | list | show | apply | clear | create | drop ]'

Might want to put drop next to clear, but that is minor.

> +drop_stash () {
> +	if ! have_stash
> +	then
> +		echo >&2 'No stash entries to drop'
> +		exit 0
> +	fi
> +
> +	# Verify supplied argument looks like a stash entry
> +	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
> +	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
> +	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
> +	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
> +		die "$*: not a valid stashed state"
> +
> +	git reflog delete "$@" && echo "Dropped $@ ($s)" ||

The second $@ is inconsistent with the next line's use of $*; intentional?

> +		die "$*: Could not drop stash entry"
> +}

> +drop)
> +	shift
> +	if test $# = 0
> +	then
> +		set -- "stash@{0}"
> +	fi
> +	drop_stash "$@" &&
> +	(git rev-parse --verify "stash@{0}" > /dev/null 2>&1 || clear_stash)

Curious.

 (1) Why not do the clearing inside drop_stash?

 (2) Why is clearning necessary in the first place (iow,
     shouldn't "reflog delete" take care of that)?

Other than that, nicely done.
