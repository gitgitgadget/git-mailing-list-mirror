From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-pull.sh: introduce --[no-]autostash and
 pull.autostash
Date: Fri, 22 Mar 2013 10:02:13 -0700
Message-ID: <7vtxo374h6.fsf@alter.siamese.dyndns.org>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 18:02:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5Me-000468-6C
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 18:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042Ab3CVRCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 13:02:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161038Ab3CVRCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 13:02:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8055B69B;
	Fri, 22 Mar 2013 13:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IIhGXcwIV4yXCYzx5b1FnITX9YA=; b=dz1hu0
	kb8oONE+8/BCVrXV9EYmRoIx8cQUXAJln551o4wNzCkUNZb0goLEs4I9JhnndI+J
	eWLD21YS5CYVhhr+0B0T6ztTzaiJpEHhGEuvnCHkE/pbKSKhdNFxh6+s0IhQGrfb
	C/eh7cUir/SF9t+eA6XfAsy5kl1ydwN9MWe5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VFI2xNfEtxCwA1Z/rGqMOj9uC3v5mDef
	VdwOe3/fcWNbHsPs8xcfyX9hpKWhsge+IWI5sqT4GHAZNSU2qtL//VhCQNuiJQ+W
	IQ4oo+hcI9syFa68XHWKeCT27B4/2UtTBfK2yg2FhEqvTAPsVztm3t33KB3gdDEC
	umOWhFk6OmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC6AFB69A;
	Fri, 22 Mar 2013 13:02:19 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35EBAB697; Fri, 22 Mar 2013
 13:02:19 -0400 (EDT)
In-Reply-To: <1363955399-13153-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 22 Mar 2013 17:59:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41824F86-9312-11E2-8A45-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218823>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> @@ -1786,6 +1786,11 @@ pull.rebase::
>  	of merging the default branch from the default remote when "git
>  	pull" is run. See "branch.<name>.rebase" for setting this on a
>  	per-branch basis.
> +
> +pull.autostash::
> +	When true, automatically stash all changes before attempting to
> +	merge/rebase, and pop the stash after a successful
> +	merge/rebase.
>  +
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand the implications (see linkgit:git-rebase[1]

Is autosquash a possibly dangerous operation?

> @@ -196,7 +203,8 @@ test true = "$rebase" && {
>  		then
>  			die "$(gettext "updating an unborn branch with changes added to the index")"
>  		fi
> -	else
> +	elif test "$autostash" = false
> +	then
>  		require_clean_work_tree "pull with rebase" "Please commit or stash them."
>  	fi

A safety net, after you run "git stash", to validate that the
added "git stash" indeed made the working tree clean, is necessary
below, but there does not seem to be any.

>  	oldremoteref= &&
> @@ -213,6 +221,12 @@ test true = "$rebase" && {
>  		fi
>  	done
>  }
> +
> +stash_required () {
> +	! (git diff-files --quiet --ignore-submodules &&
> +	git diff-index --quiet --cached HEAD --ignore-submodules)
> +}
> +
>  orig_head=$(git rev-parse -q --verify HEAD)
>  git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
>  test -z "$dry_run" || exit 0
> @@ -288,4 +302,12 @@ true)
>  	eval="$eval \"\$merge_name\" HEAD $merge_head"
>  	;;
>  esac
> -eval "exec $eval"
> +
> +if test "$autostash" = true && stash_required
> +then
> +	git stash
> +	eval "$eval"
> +	test $? = 0 && git stash pop
> +else
> +	eval "exec $eval"
> +fi

Delaying to run "git stash" as much as possible is fine, but with
the above, can the user tell if something was stashed and she has
to "stash pop" once she is done helping the command to resolve the
conflicts, or she shouldn't run "stash pop" after she is done
(because if nothing is stashed at this point, that "pop" will pop an
unrelated stash)?

What protects the "git stash" from failing and how is its error
handled?
