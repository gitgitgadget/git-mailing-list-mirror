From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: avoid ls-remote in certain scenarios
Date: Sun, 02 Jun 2013 15:08:44 -0700
Message-ID: <7vip1wmahf.fsf@alter.siamese.dyndns.org>
References: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjGSK-0008R6-99
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab3FBWIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 18:08:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab3FBWIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 18:08:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 749642479C;
	Sun,  2 Jun 2013 22:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7CdEFuEzM1+SMZZKlq/S1L83AXY=; b=qg9gGU
	01rtSf8NLhYhrGIkxmCJ3XDdnT9bCNtlYA/sSGGUDetwlUB06Y9RG7CN+ToDEanV
	LgEP+RZTp3C2A/e/l/Jq3+6gO95wdBUwYdnbWCs+D/5NqvrkKvbEVJgSDFoiZzzq
	DY8ZRe01mPYqpcBE7kHAonWjyNBVzAotzOMZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EO9gknaRrGycg3WBg3TtgM95GL2gJfW/
	ZDL+3EVJi7XjmW9Rncx/IBUPvmgqr/SM0qrqZit4/Go+E6YHFaSA5JJO/NblXb3T
	alQ145CTNZ29AkIj3izfOK+wU5FhlnzpTarwMj7EiQSSjL5MXOLbcMraVoir1vJV
	tnTngIUQ5lY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A3692479B;
	Sun,  2 Jun 2013 22:08:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9F232479A;
	Sun,  2 Jun 2013 22:08:45 +0000 (UTC)
In-Reply-To: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 22:20:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE8FC3FA-CBD0-11E2-8CD0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226185>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's _very_ slow in many cases, and there's really no point in fetching
> *everything* from the remote just for completion. In many cases it might
> be faster for the user to type the whole thing.

Besides, if I understand the use of __git_refs correctly, it is
primarily about completing things like

	git checkout -b topic origin/<TAB>

where you actively want _local_ copies of what you currently have in
refs/remotes/origin/, not what you would get if you were to fetch
and then type the command again, so in that sense, using ls-remote
is a wrong thing to do in the first place.

This however may need to be made optional if this is also being used
to complete

	git fetch git://g.k.org/pub/scm/git/git.git/ <TAB>

to list what can be fetched, but I do not think that is a very
common thing to do (you either know what you want to fetch, in which
case you do not complete but copy & paste, or more likely you have a
named remote and fetch the whole thing).

So I think overall the above makes sense.

> If the user manually specifies 'refs/*', then the full ls-remote
> completion is triggered.

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1c35eef..2ce4f7d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -427,14 +427,8 @@ __git_refs ()
>  		done
>  		;;
>  	*)
> -		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null | \
> -		while read -r hash i; do
> -			case "$i" in
> -			*^{}) ;;
> -			refs/*) echo "${i#refs/*/}" ;;
> -			*) echo "$i" ;;
> -			esac
> -		done
> +		echo "HEAD"
> +		git for-each-ref --format="%(refname:short)" -- "refs/remotes/$dir/" | sed -e "s#^$dir/##"
>  		;;
>  	esac
>  }
