From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Wed, 04 May 2016 14:13:47 -0700
Message-ID: <xmqqd1p1frw4.fsf@gitster.mtv.corp.google.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
	<20160503235652.GA395@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:13:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay47H-00036M-56
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcEDVNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:13:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751844AbcEDVNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:13:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 354A3181A0;
	Wed,  4 May 2016 17:13:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+pGc+NSkdZtqmb6WjRJUDsu94Y=; b=nGB9Mw
	0PKDVGKiWX3v4F36jXX04omiJJFdUgpr91ZVCS9wYLr2U5CY54oAUvOh2XzoxGqU
	9tygLEJrS7v+zDzA/InLSID6W+Sh+ZMZGk3hxFn81zAnfPO6cMAaYDxxegW9noiy
	4dQolVVrhGizgDYdGR7YSXcaDKXNKci0n9qAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mIHuWv+v1nq9YBkNYDMcCp2vrk8oxYV5
	dwANm2bPfBBhYFi6h/FgNIRRF808N30E7nfO+Rn4Cb6RMl/xyaElDe2rlQuSdx4u
	1fJxGlicJXHNTsaYIhBJCl4BYu50p/h2TNO8XDEOGtgjkjoJ5tK/W0veiQDdSf7b
	rYCFA1ZImjI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9251819E;
	Wed,  4 May 2016 17:13:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9496F1819D;
	Wed,  4 May 2016 17:13:48 -0400 (EDT)
In-Reply-To: <20160503235652.GA395@google.com> (Jonathan Nieder's message of
	"Tue, 3 May 2016 16:56:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 17FEA0E4-123D-11E6-A183-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293592>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This design is somewhat problematic for a few reasons:
>
> - When I want to stop paying attention to a particular submodule and
>   start paying attention to it again later, all my local settings are
>   gone.

True; "[submodule "foo"] enabled = no" may also be a way to fix it
without throwing the whole with bathwater, though.

> - When upstream adds a new submodule, I have to do the same manual
>   work to change the options for that new submodule.

Because a new module is not automatically "init"ed by default?

Isn't "config only" vs "config with gitmodules fallback" orthogonal
to that issue?

> - When upstream changes submodule options (perhaps to fix a URL
>   typo), I don't get those updates.

True.

> A fix is to use settings from .git/config when present and fall back
> to .gitmodules when not.  

How would that fix the "upstream updated"?

I think an alternative suggested in an ancient time had a more
elaborate scheme:

 * Use .git/config as the authoritative source, but record
   sufficient information to detect the case and cope with it when
   entry in .gitmodules changes (details below).

 * When seeing a new .gitmodules entry, either by "git pull" or even
   "git checkout other-branch", copy that to .git/config (just like
   what "git submodule init" does).  It would be a policy decision
   to automatically enabling it or not.  If the policy is "no
   autoinit", then "module.<name>.inited = no" may also have to be
   added to .git/config at this point.

   Record contents of the entry in .gitmodules to the corresponding
   .git/config entry as "seen".

 * When the entry in .gitmodules for a submodule known to
   .git/config is different from what has been "seen", offer the
   user a chance to update corresponding .git/config entry, and
   append to the "seen" set of variants in .gitmodules so that the
   user will not be bugged with "we see .gitmodules entry for module
   <foo> is different from anything you have ever seen; do you want
   to make corresponding changes to the module entry in your
   .git/config" again.

which would handle all of the above, and without using anything from
.gitmodules before the user has a chance to vet it.
