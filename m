From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 23:46:58 -0700
Message-ID: <7vpptjz9r1.fsf@alter.siamese.dyndns.org>
References: <1376288518-4875-1-git-send-email-stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
	sunshine@sunshineco.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 08:47:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lue-0003g9-1L
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab3HLGrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 02:47:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292Ab3HLGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 02:47:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 770C133C3D;
	Mon, 12 Aug 2013 06:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SjxpVaTj39T/dZNc69VGe18KP00=; b=d2Zn4+
	3cRyXfNOoLPAD0p52Wlf1rL518gKLsKY+nS9+1ip1qtLz7a3HmgAPqhbwQ8B1zGb
	v1aPAkfi4IEHdQOM/u8tBfYeCnfLLbt+xWohsV6kdYKz/mLL45aMRLuN0dLz0gn3
	N1LBmfQ3rHqpEifTI271aC0Yfbt6JrvpZHQzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGIvUU23aIImbaLaGrE9FzgBI+B056mj
	kyyRyYzWu2lVrliDC+y0mv8TrWBi53zxOhA7KjgjmzASV9Sydm8oGpaza2QDcnwT
	IaNm4bNrp9TbPcMoZBzpyuBaAK3Tm/1YcauuMT3cXsjx1yEhw0HnSwFRceCIabAg
	FJn4dU2K7Dk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A03233C3C;
	Mon, 12 Aug 2013 06:47:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3E5033C2B;
	Mon, 12 Aug 2013 06:47:01 +0000 (UTC)
In-Reply-To: <1376288518-4875-1-git-send-email-stephen@exigencecorp.com>
	(Stephen Haberman's message of "Mon, 12 Aug 2013 01:21:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE22A87A-031A-11E3-B6F5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232160>

Stephen Haberman <stephen@exigencecorp.com> writes:

> I assume I'm doing the right thing by just posting another version of
> this patch to the git list; let me know if I'm missing something.

Thanks.  Writing the "story so far..." summary like you did after
the three-dash line was very helpful.

> diff --git a/git-pull.sh b/git-pull.sh
> index f0df41c..6ae6640 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -4,7 +4,7 @@
>  #
>  # Fetch one or more remote refs and merge it/them into the current HEAD.
>  
> -USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
> +USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-r=[true|false|preserve]] [-s strategy]... [<fetch-options>] <repo> <head>...'

"-r", even though it happens to be accepted, is not a good idea
here, as there are other --r* commands that are not --rebase.

	[--[no-]rebase|--rebase=preserve]

would be better.

> @@ -40,13 +40,13 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
>  
>  strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
>  log_arg= verbosity= progress= recurse_submodules= verify_signatures=
> -merge_args= edit=
> +merge_args= edit= rebase_args=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short="${curr_branch#refs/heads/}"
> -rebase=$(git config --bool branch.$curr_branch_short.rebase)
> +rebase=$(git config branch.$curr_branch_short.rebase)
>  if test -z "$rebase"
>  then
> -	rebase=$(git config --bool pull.rebase)
> +	rebase=$(git config pull.rebase)


This is a grave regression (the same for the earlier one that reads
the branch.*.rebase configuraiton).  Those who did any of the
following will be broken:

	[pull]
		;; any of the following are "true"
        	rebase
                rebase = yes
                rebase = 1
                ;; any of the following are "false"
                rebase = no
                rebase = 0

You would want "bool or string" helper function to parse it
correctly, something like:

	bool_or_string_config () {
        	git config --bool "$1" 2>/dev/null || git config "$1"
	}

	rebase=$(boo_or_string_config pull.rebase)
