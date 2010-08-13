From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/9] stash: introduce is_stash_ref and
 assert_stash_ref functions.
Date: Thu, 12 Aug 2010 17:49:37 -0700
Message-ID: <7v39ujnxpa.fsf@alter.siamese.dyndns.org>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
 <1281398688-21008-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 02:50:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjiTE-00053o-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 02:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761214Ab0HMAtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 20:49:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab0HMAtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 20:49:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7CFCD613;
	Thu, 12 Aug 2010 20:49:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BRd4xVdV5w3FZCVgzGwZYa483Pw=; b=JN+dQ3htEsD9nG4GubQLKQu
	tQOH6zegXl7TCSzor2xdaRD2TJN6SnhAufmYcxFRC1kgbckgX/tk4gIZYCeZmI3S
	jwmj/CtM3wWRxvrEQHSJDwGV818OwhoLdcrCrttDSjFppfKAWfmiuHzqBDgdiBmd
	M5kFkwuxRQHRyFeu6dSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KT739MxyKyXIAN0NfqtikGFXvvtOqo/ohPEt6w1nK6xK2OwUj
	wAZxjautkMdMWnb7YjjImcsyPrGcAHl7N4pHyQq0aeIxxq+fBRUzaHMENlU/sQon
	4CNN2pV83P15vgHiCy8cBBK1QhDG0ZQNf+beAt6YNRAq0R1GLzYTCnb838=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36FC6CD611;
	Thu, 12 Aug 2010 20:49:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2A22CD607; Thu, 12 Aug
 2010 20:49:38 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9F0DB9C-A674-11DF-AF95-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153446>

Jon Seymour <jon.seymour@gmail.com> writes:

> Introduce a function, is_stash_ref, which checks whether an
> argument is valid stash reference (e.g. is of the form ['refs/']stash['@{'something'}])
>
> Introduce a function, assert_stash_ref, which can be used to ensure
> that certain commands are only called with stash references as
> arguments.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  git-stash.sh |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index dbb7944..41a9359 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -223,6 +223,15 @@ show_stash () {
>  	git diff $flags $b_commit $w_commit
>  }
>  
> +is_stash_ref() {
> +	revs="$(git rev-parse --revs-only --symbolic --verify --default ${ref_stash} "$@")" &&
> +	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${revs%@*}")"
> +}
> +
> +assert_stash_ref() {
> +	is_stash_ref "$@" || die "$* is not a stash reference"
> +}

I have to wonder what these functions would do when given more than one
args, but I cannot (yet) see the users of this function, which may be
doing their own sanity checking to avoid that situation, so...
