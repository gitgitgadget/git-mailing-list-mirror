From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/23] contrib/subtree: Add command from-submodule
Date: Sun, 10 Mar 2013 20:19:09 -0700
Message-ID: <7vwqtebp3m.fsf@alter.siamese.dyndns.org>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
 <1362958891-26941-3-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>,
	Peter Jaros <pjaros@pivotallabs.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Mar 11 04:19:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEtH7-0005II-9z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 04:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab3CKDTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 23:19:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3CKDTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 23:19:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC257CD6E;
	Sun, 10 Mar 2013 23:19:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TESL1wzYCQvNQ8ft+8c57EqzJag=; b=iy1BPB
	Zo9qrmqBmeMuUWnJ7eqVfkOYHc6aYZprP3nAgX7CVjQDkY8OX8sB/u+t9q4lnp6O
	bk0vsDXoMQ71QqP4dKJaEcg56E6CYz7DPrytiSP9eUZOFC4xrlEKzbl9E/0jSOAc
	FfHkLG0bRbT2wibWKkdqZkz+ePP90p8ELXa+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0z8RqbBX2na8NLpiAO8K1pfLJzWxJER
	qSRcj8UfaAy4qVkhHpGdWPbKa+BlnfE60hrK9lgyqpoTQVg8fXo+5CUPH8D+q/ua
	QtAYEVEzy2Z+SgXYvKUMF19A+mv0aRbju/seqk3WeYq2q24zsQZ8/7oWVWSmUCk2
	h3QVWbm32Rk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B091CCD6D;
	Sun, 10 Mar 2013 23:19:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0368CCD6B; Sun, 10 Mar 2013
 23:19:10 -0400 (EDT)
In-Reply-To: <1362958891-26941-3-git-send-email-pcampbell@kemitix.net> (Paul
 Campbell's message of "Sun, 10 Mar 2013 23:41:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 714D12F8-89FA-11E2-97C2-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217849>

Paul Campbell <pcampbell@kemitix.net> writes:

> @@ -721,4 +722,31 @@ cmd_push()
>  	fi
>  }
>  
> +cmd_from-submodule()
> +{

I know contrib/subtree does not work with anything other than bash,
and bash may accept this as a valid function name, but if you can
avoid it easily I would prefer not to see a non-POSIX construct like
this in my tree, even in contrib/ part:

  http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_230

because people often reference random parts of the tree and mimick
what existing code does.

> +	ensure_clean
> +
> +	local submodule_sha=$(git submodule status $prefix | cut -d ' ' -f 2)

Is $prefix guaranteed not to have any $IFS whitespaces?

> +	# Remove references to submodule.
> +	git config --remove-section submodule.$prefix
> +	git config --file .gitmodules --remove-section submodule.$prefix
> +	git add .gitmodules
> +
> +	# Move submodule aside.
> +	local tmp_repo="$(mktemp -d /tmp/git-subtree.XXXXX)"

Doesn't "git subtree" honor TMPDIR?  Not complaining, but being
curious.

> +	rm -r $tmp_repo
> +	mv $prefix $tmp_repo
> +	git rm $prefix

Is $prefix guaranteed not to have any $IFS whitespaces?

> +
> +	# Commit changes.
> +	git commit -m "Remove '$prefix/' submodule"
> +
> +	# subtree add from submodule repo.
> +	cmd_add_repository $tmp_repo HEAD
> +
> +	# Remove submodule repo.
> +	rm -rf $tmp_repo
> +}
> +
>  "cmd_$command" "$@"
