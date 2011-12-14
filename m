From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Fix multiple error messages on create if no HEAD
Date: Tue, 13 Dec 2011 17:16:26 -0800
Message-ID: <7vsjkorlzp.fsf@alter.siamese.dyndns.org>
References: <20111214001432.GA2959@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Wed Dec 14 02:16:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RadSU-00035t-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 02:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab1LNBQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 20:16:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab1LNBQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 20:16:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A5572BF;
	Tue, 13 Dec 2011 20:16:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6JXrIdllLIgq9WF7i8BaAw0FAFA=; b=I1y4hh
	NcSAn9jHhbumDbToRVOsPwtZplcY7tUqdSm0/JrOJ38PQCF5vFw36sO2oWmFKH1s
	8pT6ccx3wcfe6wxImA1L3l0yJWldRF9COyLARYqMM/bg/mpetAZ2dZAjmFDYzG3o
	1aUjLa/CtZeZ1lGIhXlHlIDLULDOahYCWpnRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cTUV84WcClkRifFP8nubj9040Z22psF2
	+P9pJMSr6nvtxQallso+b5gPHs27pGwD3xzQ8TLG7qsD9+0GZoaRFTs+3hVyyQLY
	8Nlu+FksiAQ0kjjrbDKB02rzIJ9QzHtLXquc3vpAqSS7pI1+GGp/PlRzwn9mN//w
	j16XyT2sJcM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C8A472BE;
	Tue, 13 Dec 2011 20:16:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA3D772BD; Tue, 13 Dec 2011
 20:16:27 -0500 (EST)
In-Reply-To: <20111214001432.GA2959@thinkpad> (Sebastian Morr's message of
 "Wed, 14 Dec 2011 01:14:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F6965D4-25F1-11E1-99A9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187090>

Sebastian Morr <sebastian@morr.cc> writes:

> This bugged me: In a new, empty repository:
>
>     $ git stash
>     fatal: bad revision 'HEAD'
>     fatal: bad revision 'HEAD'
>     fatal: Needed a single revision
>     You do not have the initial commit yet
>
> With this patch:
>
>     $ git stash
>     You do not have the initial commit yet

Yeah, that looks tidier.

> With the --quiet option, I wouldn't expect diff-index to print error
> messages.

Even with --quiet, an error is an error.

Asking for a diff with the current HEAD when you do not have one yet _is_
an error and "diff-index" is correct to report the error. The bug
(i.e. "git stash" shows that error message) is in the program that calls
diff-index when the operation does not make sense.

"Hiding error" is not desirable, especially if it is only for giving a
cleaner error message for a narrow corner case that nobody cares
(i.e. running "stash" when you do not have any commit to go back to), with
the side effect that it hides _real_ errors that may help users notice
unusual situation (e.g. corrupted index file).

Probably the right way to fix it is to check if HEAD is a valid commit
before running any command that requires to have a valid HEAD (i.e.
create and save would need one; list, show, etc. would not) and give that
"You do not have the initial commit yet" message, before passing the
control to the implementations of these individual subcommands, without
touching the places you touched in this patch.

>  no_changes () {
> -	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
> +	git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null &&
>  	git diff-files --quiet --ignore-submodules &&
>  	(test -z "$untracked" || test -z "$(untracked_files)")
>  }
> @@ -67,7 +67,7 @@ create_stash () {
>  	fi
>  
>  	# state of the base commit
> -	if b_commit=$(git rev-parse --verify HEAD)
> +	if b_commit=$(git rev-parse --quiet --verify HEAD)
>  	then
>  		head=$(git rev-list --oneline -n 1 HEAD --)
>  	else
