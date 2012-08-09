From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let submodule command exit with error status if path
 does not exist
Date: Thu, 09 Aug 2012 13:42:20 -0700
Message-ID: <7vboijol03.fsf@alter.siamese.dyndns.org>
References: <1340872080.2103.92.camel@athena.dnet>
 <20120809200302.GA93203@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:42:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzZYs-0005Vp-FU
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 22:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab2HIUmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 16:42:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127Ab2HIUmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 16:42:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A819441;
	Thu,  9 Aug 2012 16:42:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BE0OoOd/mfKEPCMqEfAkGFwyVwo=; b=VlmWHL
	kMaeuQbtq6PJglQ5rs+HHvyRI+gXue1eDlogx8q4e5TNKwtiub4B5VK/2IcYIjbY
	+s+PuUrw6CkYUHkBGnNjqWOhanMwVqCS3jieFzKxXFyUIEMOWpHs+J/jDTljg4ux
	rrLDEozv0cHiS+NVIwJEMj3UVZy5igM/rag94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rzRQOQ6DaIV+RnophGSjslnJUxQoEXEl
	dGvDXMFQkUhix/HWu5XnS7J012BtVPs1YC5ERVj+Sfm831NRPM74PtrD1HYdx7IC
	p2RIOZGIsEXwhchV21eP4UuYja7Bxb01XqmA0EcV4lHMh5zqwhlWRf2ddNqVCbFz
	HJBMEiqlre0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 125C89440;
	Thu,  9 Aug 2012 16:42:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C4F7943E; Thu,  9 Aug 2012
 16:42:22 -0400 (EDT)
In-Reply-To: <20120809200302.GA93203@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 9 Aug 2012 22:03:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B82E7A8A-E262-11E1-B37B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203180>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Previously the exit status of git submodule was zero for various
> subcommands even though the user specified an unknown path.
>
> The reason behind that was that they all pipe the output of module_list
> into the while loop which then does the action on the paths specified by
> the commandline. Since piped commands are run in parallel the status
> code of module_list was swallowed.

It is more like that the shell ignores the exit status of command
that is on the upstream side of a pipeline.

> We work around this by introducing a new function module_list_valid
> which is used to check the leftover commandline parameters passed to
> module_list.

Doesn't it slow things down for the normal case, though?

A plausible hack, assuming all the problematic readers of the pipe
are of the form "... | while read mode sha1 stage sm_path", might be
to update module_list () to do something like:

	(
		git ls-files --error-unmatch ... ||
                echo "#unmatched"
	)

and then update the readers to catch "#unmatched" token, e.g.

	module_list "$@" |
        while read mode sha1 stage sm_path
        do
		if test "$mode" = "#unmatched"
                then
        		... do the necessary error thing ...
                        continue
		fi
                ... whatever the loop originally did ...
	done

One thing to note is that the above is not good if you want to
atomically reject

	git submodule foo module1 moduel2

and error the whole thing out without touching module1 (which
exists) because of misspelt module2.

But is it what we want to see happen in these codepaths?

> diff --git a/git-submodule.sh b/git-submodule.sh
> index aac575e..1fd21da 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -103,13 +103,21 @@ resolve_relative_url ()
>  	echo "${is_relative:+${up_path}}${remoteurl#./}"
>  }
>  
> +module_list_ls_files() {
> +	git ls-files --error-unmatch --stage -- "$@"
> +}
> +
> +module_list_valid() {
> +	module_list_ls_files "$@" >/dev/null
> +}
> +

This is a tangent, but among the 170 hits

	git grep -e '^[a-z][a-z0-9A-Z_]* *(' -- './git-*.sh'

gives, about 120 have SP after funcname, i.e.

	funcname () {

and 50 don't, i.e.

	funcname() {

This file has 12 such definitions, among which 10 are the latter
form.  There is no "rational" reason to choose between the two, but
having two forms in the same project hurts greppability.  Updating
the style of existing code shouldn't be done in the same patch, but
please do not make things worse.

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index c73bec9..3a40334 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -258,6 +258,27 @@ test_expect_success 'init should register submodule url in .git/config' '
>  	test_cmp expect url
>  '
>  
> +test_failure_with_unknown_submodule() {

Likewise, even though inside t/ directory we seem to have more
offenders (190/480 ~ 40%, vs 50/170 ~ 30%).

> +	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
> +	grep "^error: .*no-such-submodule" output.err
> +}

I think the latter half already passes with the current code, but
the exit code from "git submodule $1" would be corrected with this
patch, which is good.

Thanks.
