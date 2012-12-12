From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/3] submodule update: add --remote for submodule's
 upstream changes
Date: Wed, 12 Dec 2012 11:54:20 -0800
Message-ID: <7v7gon3v2r.fsf@alter.siamese.dyndns.org>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
 <64d109da03c521303ad87b8370bf09ab28a5c09f.1355251862.git.wking@tremily.us>
 <CABURp0oLmSjiZAOJxEzwSmL+jimpVj8DcDi-odPTzCpCcyH8yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TisOA-0001ZQ-2u
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab2LLTyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:54:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab2LLTyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:54:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A82894B0;
	Wed, 12 Dec 2012 14:54:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GOYbUslLEjUUi2IqElcacTALCYg=; b=iWRBiv
	s3LWIY7qM/5G9DkjKfTuUplL4cj1DrZ7AYK8NJo64r6Iwm8U0fj2sY75OGtgeho8
	KckNgu9+g8su9jfoAD61+a9M9n+Ec287PUIs91ha+KoVa7gTkvBwS2gL4G3QZ+iT
	3BdwE8SPPNyH3xFTIRf7G6X4m+cl4YkQLuFMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t0era1rmhqqDTB8h4k8zSP8dOslvU5M4
	UX+Qu49PU5hfPLgzmHsCscuzmYY7s+0p8C285kcnHlKwLcuNxjtF9VIP/CAu6lEy
	yomhUabm70ZAmXYnxJ+HBh64R6sIr+j9nFTy7HFwPSEHjpFqQIJLu9CJNq/w0MB4
	BzGRA9xfTZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA4C094AF;
	Wed, 12 Dec 2012 14:54:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F5AC94AD; Wed, 12 Dec 2012
 14:54:22 -0500 (EST)
In-Reply-To: <CABURp0oLmSjiZAOJxEzwSmL+jimpVj8DcDi-odPTzCpCcyH8yA@mail.gmail.com> (Phil
 Hord's message of "Wed, 12 Dec 2012 12:43:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B94E2C2C-4495-11E2-B126-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211389>

Phil Hord <phil.hord@gmail.com> writes:

>> +               if test -n "$remote"
>> +               then
>> +                       if test -z "$nofetch"
>> +                       then
>> +                               # Fetch remote before determining tracking $sha1
>> +                               (clear_local_git_env; cd "$sm_path" && git-fetch) ||
>
> You should 'git fetch $remote_name' here, and of course, initialize
> remote_name before this.  But how can we know the remote_name in the
> first place?  Is it safe to assume the submodule remote names will
> match those in the superproject?
>
>> +                               die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
>> +                       fi
>> +                       remote_name=$(get_default_remote)
>
> This get_default_remote finds the remote for the remote-tracking
> branch for HEAD in the superproject.  It is possible that HEAD !=
> $branch, so we have very few clues to go on here to get a more
> reasonable answer, so I do not have any good suggestions to improve
> this.
>
> One option would be to find the remote given for
> submodule."$branch".merge, but this would suppose there is some
> remote-tracking branch configured in the submodule, and that is not
> likely to be the case.
>
>> +                       sha1=$(clear_local_git_env; cd "$sm_path" &&
>> +                               git rev-parse --verify "${remote_name}/${branch}") ||
>
> This does assume the submodule remote names will match those in the
> superproject.  Is this safe?

All good points.  Thanks for reviewing.
