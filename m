From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inconsistent behavior of the path disambiguator
Date: Fri, 29 Oct 2010 13:25:20 -0700
Message-ID: <7vsjzo691r.fsf@alter.siamese.dyndns.org>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org> <20101029194639.GA1738@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 22:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBvW4-0003zS-7M
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 22:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761849Ab0J2UZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 16:25:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996Ab0J2UZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 16:25:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 528871C23;
	Fri, 29 Oct 2010 16:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dXNlN+vbahHdgGaBBB2RZn+v92Q=; b=fUNPbv
	1XQoPU1ire62Us+ckHqIiSS8uQGRBLmF8QjIBiA9NBcBV4xXvYHhVjviRAeelG4w
	OHunknEIb5l3viiZb/zgMwQdrKdB6nS7yY+stvDV7lWPKJEk2ceb1tda6y7Q+DMs
	rmoeyOE2m8TpmeTZ+LOBdt9p/fAmf8vi3T1rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lVAC01581EOTR8FU42lFvcFhz59AtjMn
	oKvRX+1dyxVtjN36O+JkOiMjYis6shB3SBOhGirsiZOFBOiLlaPcOimknNYUOwZB
	1sP2gQLhAJfAaVQqwiTZN2N+ISqTwl2qJdB1N5U57t4Gv4OSdRXivscJIYOifwZm
	+YMMITwtQfE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E7231C1F;
	Fri, 29 Oct 2010 16:25:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 230931C1E; Fri, 29 Oct
 2010 16:25:21 -0400 (EDT)
In-Reply-To: <20101029194639.GA1738@burratino> (Jonathan Nieder's message of
 "Fri\, 29 Oct 2010 14\:46\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9FF8A30-E39A-11DF-B90E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160361>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>       I can see why this is confusing, though.
>>
>> Dun Peal <dunpealer@gmail.com> writes:
>>> $ git checkout foo --
>>> fatal: invalid reference: foo
>>
>> Immediately after a clone you would have
>>
>>     refs/heads/master
>>     refs/HEAD -> refs/heads/master
>>     refs/remotes/origin/foo
>>     refs/remotes/origin/whatever-else-you-have
>>     ...
>>
>> and there is no commit that you can name with "foo" when asking git to
>> check out some paths out of, nor there is no branch that you can name with
>> "foo" when asking git to check out to work on it.
>
> How about something like this?

That looks simpler than what I just did.  Can we have a few tests, too?

> -- 8< --
> Subject: checkout: apply Dscho's dwim even with "--" present
>
> git reset and similar commands use -- to disambiguate between
> revisions and paths on the command line.  The same syntax is not
> necessary to specify a revision to git checkout (for convenience
> and historical reasons, revisions are preferred over paths), but
> for consistency it is accepted:
>
> 	git checkout master --; # check out master branch, not "master" file.
>
> The autovivification of branches introduced by 70c9ac2f1 (DWIM "git
> checkout frotz" to "git checkout -b frotz origin/frotz", 2009-10-18)
> is currently disabled by that syntax, for no good reason.  Paranoid
> scripts can still use
>
> 	git checkout --no-guess master
>
> or even better,
>
> 	old=$(git rev-parse --verify HEAD)
> 	new=$(git rev-parse --verify refs/heads/master^0)
> 	git read-tree -m -u --exclude-standard $old $new
> 	git symbolic-ref -m "$me: switching branches" HEAD refs/heads/master
>
> Requested-by: Dun Peal <dunpealer@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 9240faf..1dc3640 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -771,6 +771,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	 *   <ref> must be a valid tree, everything after the '--' must be
>  	 *   a path.
>  	 *
> +	 *   Except: with no paths, if <something> does not resolve as
> +	 *   an object, no -t nor -b was given, and there is a tracking
> +	 *   branch whose name is <something> in one and only one remote,
> +	 *   then this is a short-hand to fork local <something> from
> +	 *   that remote-tracking branch.
> +	 *
>  	 * case 2: git checkout -- [<paths>]
>  	 *
>  	 *   everything after the '--' must be paths.
> @@ -808,13 +814,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  			arg = "@{-1}";
>  
>  		if (get_sha1_mb(arg, rev)) {
> -			if (has_dash_dash)          /* case (1) */
> -				die("invalid reference: %s", arg);
>  			if (!patch_mode &&
>  			    dwim_new_local_branch &&
>  			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
>  			    !opts.new_branch &&
> -			    !check_filename(NULL, arg) &&
> +			    (has_dash_dash || !check_filename(NULL, arg)) &&
>  			    argc == 1) {
>  				const char *remote = unique_tracking_name(arg);
>  				if (!remote || get_sha1(remote, rev))
> @@ -822,9 +826,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  				opts.new_branch = arg;
>  				arg = remote;
>  				/* DWIMmed to create local branch */
> -			}
> -			else
> +			} else if (has_dash_dash) {	/* case (1) */
> +				die("invalid reference: %s", arg);
> +			} else {
>  				goto no_reference;
> +			}
>  		}
>  
>  		/* we can't end up being in (2) anymore, eat the argument */
