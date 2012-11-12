From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-sh-setup: refactor ident-parsing functions
Date: Mon, 12 Nov 2012 12:08:37 -0800
Message-ID: <7vzk2mh9dm.fsf@alter.siamese.dyndns.org>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072522.GA9999@sigill.intra.peff.net>
 <7vpq3ik97i.fsf@alter.siamese.dyndns.org>
 <20121112194434.GB4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:08:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0JT-0000hG-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab2KLUIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:08:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab2KLUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:08:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D17B59C72;
	Mon, 12 Nov 2012 15:08:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/AOhSxBl4+v375NDtgF3CC4TEX8=; b=Eo0SM8
	g5Za8/6aVEqMz5a5aoAQiiHcqXttQIkUwBLDzq8nPBOA+RUzHAANURZegN/MY3Ct
	p7POeHPE5xm/8FVxuyhYJSO7tbEYox25WsNDbrEu7hH7WyP0fekiE2oLmphstN9e
	qXBMEEg5dTPT9u1EiXP23K5dMVtLHJs6jQ7r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iVAooow7iE7Crz6frLmwI7WHJvbiAEO+
	SHAyuXRvNgjJ6Ivx7kOWg1fyqOYpd7ZnSQQ6OlZ4yf6BdwO+XEzXP9jrzYNZaKX5
	7BgqsGM3P13QWfRHydYiGEjnZzQZ5Hwj4q2ik7TSf6DzN0mFBgH2oLQDJUAJe+aC
	JEPTRlCQH04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C00C79C71;
	Mon, 12 Nov 2012 15:08:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AA8A9C6F; Mon, 12 Nov 2012
 15:08:40 -0500 (EST)
In-Reply-To: <20121112194434.GB4623@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 14:44:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C022F288-2D04-11E2-855A-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209515>

Jeff King <peff@peff.net> writes:

> Changing the interface for get_author_ident_from_commit would be a pain,
> but if we just wanted to help filter-branch, we could do something like
> this:

Yes, that is the direction I was alluding to.

Callers of get_author_ident_from_commit can also do the same and
avoid rebuilding the same $pick_author_script over and over again,
or get_author_ident_from_commit can do so for its callers.

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 5314249..7a693ba 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -74,7 +74,7 @@ finish_ident() {
>  }
>  
>  set_ident () {
> -	parse_ident_from_commit author AUTHOR committer COMMITTER
> +	parse_ident_from_commit_via_script "$ident_script"
>  	finish_ident AUTHOR
>  	finish_ident COMMITTER
>  }
> @@ -93,6 +93,7 @@ if [ "$(is_bare_repository)" = false ]; then
>  	require_clean_work_tree 'rewrite branches'
>  fi
>  
> +ident_script=$(pick_ident_script author AUTHOR committer COMMITTER)
>  tempdir=.git-rewrite
>  filter_env=
>  filter_tree=
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 22f0aed..1e20e17 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -225,10 +225,17 @@ pick_ident_script () {
>  	echo '/^$/q'
>  }
>  
> +# Feed a pick_ident_script return value to sed. Use this instead of
> +# parse_ident_from_commit below if you are going to be parsing commits in a
> +# tight loop and want to save a process.
> +parse_ident_from_commit_via_script() {
> +	LANG=C LC_ALL=C sed -ne "$1"
> +}
> +
>  # Create a pick-script as above and feed it to sed. Stdout is suitable for
>  # feeding to eval.
>  parse_ident_from_commit () {
> -	LANG=C LC_ALL=C sed -ne "$(pick_ident_script "$@")"
> +	parse_ident_from_commit_via_script "$(pick_ident_script "$@")"
>  }
>  
>  # Parse the author from a commit given as an argument. Stdout is suitable for
