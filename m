From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools/p4merge: Honor $TMPDIR for the /dev/null
 placeholder
Date: Wed, 19 Dec 2012 22:28:04 -0800
Message-ID: <7v623x6xvv.fsf@alter.siamese.dyndns.org>
References: <1355978754-7041-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 07:28:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlZcN-0005nI-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 07:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab2LTG2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 01:28:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab2LTG2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 01:28:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01968DC5;
	Thu, 20 Dec 2012 01:28:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iq2hTIEFUbgUpxdRqnvb0ct0XPg=; b=HyQI8X
	uDceWF7G83tt2VghIZyOcjMNblSFWvLd/Id6SOJ5KlkC3xJe9xC6bNTBe85bb0+w
	c+IT9Ah8EJuRIP3+VC26WC1eSrpzFO/ai+YB65lahw2aJi0qkY6QUk4IIFO4162X
	a5FweepvF+PPbAE7cXE9ivEh/fHD/CAcZI8I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OjktwKK0YC2dp7X4IsHhHyCvKZzcRV4F
	qAYB8L4gH7eMB1gNgJf5q92Zj/0IY2cNAf4XHKiR2esho2ngDC5WneRmE3goIWgh
	NVd5na9D87bl+yOM5Jk0dSulXBDzlVPA9XSmpn9MBc++EjuL1KlwXIG2BfPRBWx5
	rJViuZtvIrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB2728DC1;
	Thu, 20 Dec 2012 01:28:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19C438DBC; Thu, 20 Dec 2012
 01:28:06 -0500 (EST)
In-Reply-To: <1355978754-7041-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Wed, 19 Dec 2012 20:45:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A14AA62-4A6E-11E2-AE9C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211882>

David Aguilar <davvid@gmail.com> writes:

> Use mktemp to create the /dev/null placeholder for p4merge.
> This keeps it out of the current directory.
>
> Reported-by: Jeremy Morton <admin@game-point.net>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> I consider this a final finishing touch on a new 1.8.1 feature,
> so hopefully we can get this in before 1.8.1.

Does everybody have mktemp(1), which is not even in POSIX.1?

I'm a bit hesitant to apply this to the upcoming release without
cooking it in 'next' for sufficiently long time to give it a chance
to be tried by wider audience.

>  mergetools/p4merge | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mergetools/p4merge b/mergetools/p4merge
> index 295361a..090fa9b 100644
> --- a/mergetools/p4merge
> +++ b/mergetools/p4merge
> @@ -4,13 +4,13 @@ diff_cmd () {
>  	rm_remote=
>  	if test "/dev/null" = "$LOCAL"
>  	then
> -		LOCAL="./p4merge-dev-null.LOCAL.$$"
> +		LOCAL="$(create_empty_file)"
>  		>"$LOCAL"
>  		rm_local=true
>  	fi
>  	if test "/dev/null" = "$REMOTE"
>  	then
> -		REMOTE="./p4merge-dev-null.REMOTE.$$"
> +		REMOTE="$(create_empty_file)"
>  		>"$REMOTE"
>  		rm_remote=true
>  	fi
> @@ -33,3 +33,7 @@ merge_cmd () {
>  	"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>  	check_unchanged
>  }
> +
> +create_empty_file () {
> +	mktemp -t git-difftool-p4merge-empty-file.XXXXXX
> +}
