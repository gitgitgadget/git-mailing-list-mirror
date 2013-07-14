From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Sun, 14 Jul 2013 12:20:56 -0700
Message-ID: <7v1u71gd7r.fsf@alter.siamese.dyndns.org>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
	<1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
	<1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 21:21:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRqx-0004iB-Ro
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 21:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab3GNTVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 15:21:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab3GNTU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 15:20:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A130C2F5F9;
	Sun, 14 Jul 2013 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AnpP2zK70CLhq34j4+szStci99w=; b=b3LHLk
	mWs4HVhUiNs+MgL/qc0O7IfvDQae/rn5DY6LR9VzQ9XAfxmWMVxcwvz+ypkV1tXy
	o+DccbL2fUo+JQiKJrTGewnx2Q+UTXqrv27cV06O9YCS5Jvxe/XHcsc2cr9JjxQQ
	+N3cGF/mInHzjxgVcNIu4TChZZGQxEvEpn7sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lEKRLCNCdA8dqVSP1ZTuthfn4GQR/M/V
	2JigrnkD9sijxqGKkQ29a7gGnyZ4G+Ar4F8YbxTIEUvdcpWTsOpRIWasPt6Jmhxn
	x0rHRypCCYvMOXF9yjuaPiwKFxc4B+QSQiWnM8Gj/YiiYtf4GXp07IILeBweCXbx
	1SA3m2H2gs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 963EA2F5F8;
	Sun, 14 Jul 2013 19:20:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCB812F5F7;
	Sun, 14 Jul 2013 19:20:57 +0000 (UTC)
In-Reply-To: <1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
	(Richard Hartmann's message of "Sun, 14 Jul 2013 18:21:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82EC4AE2-ECBA-11E2-93C6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230385>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> Spawning a new subprocess for every line printed is inefficient.

This is not a valid justification at all, is it?  

Shells on modern distros and platforms have "echo" built-in, so this
patch replaces series of writes internal to the shell with a fork to
cat with heredoc (which often is implemented with a temporary file).




> Use heredoc, instead.
>
> Based on 98770971aef8d1cbc78876d9023d10aa25df0526 in original patch
> series from 2013-06-10.
>
> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
> ---
>  templates/hooks--pre-commit.sample |   25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 18c4829..889967c 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -31,18 +31,19 @@ if [ "$allownonascii" != "true" ] &&
>  	test $(git diff --cached --name-only --diff-filter=A -z $against |
>  	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
>  then
> -	echo "Error: Attempt to add a non-ascii file name."
> -	echo
> -	echo "This can cause problems if you want to work"
> -	echo "with people on other platforms."
> -	echo
> -	echo "To be portable it is advisable to rename the file ..."
> -	echo
> -	echo "If you know what you are doing you can disable this"
> -	echo "check using:"
> -	echo
> -	echo "  git config hooks.allownonascii true"
> -	echo
> +	cat <<-EOF
> +Error: Attempt to add a non-ascii file name.
> +
> +This can cause problems if you want to work
> +with people on other platforms.
> +
> +To be portable it is advisable to rename the file.
> +
> +If you know what you are doing you can disable this
> +check using:
> +
> +  git config hooks.allownonascii true
> +EOF
>  	exit 1
>  fi
