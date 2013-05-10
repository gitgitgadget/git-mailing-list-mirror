From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] rebase: implement --[no-]autostash and rebase.autostash
Date: Fri, 10 May 2013 08:29:48 -0700
Message-ID: <7v38tu4zv7.fsf@alter.siamese.dyndns.org>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 17:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UapGd-0001Af-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab3EJP3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:29:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab3EJP3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:29:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802ED1CBE9;
	Fri, 10 May 2013 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gCuutytOTTU/EbTPA4S5CbhiCsc=; b=qrsjjA
	62HffuAYttNUckZaUxTX2v6lSHZ4GvXkzc2hnxqIgbIycAurSF3lV0CSZ/lZLCqX
	sXo3B58rgvODkF7Oe/UT8RxzboDCEuskaD2FOdPuZVj8ddLTDjzlzFGAFH2QI27k
	Nc0q5TDr2hdr7t1HvwLPgmH33N4LRM5rstBrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhchcTnhHI75wwaWcDemFZYlFQixdYtx
	mmw2i24wlTRig5pJF7Ri0YQfsmzJgtSCGYXy8WZ0Zz8eTweyRODB6xmH9gyX3+/T
	mMth/SvPZCsjnrvHFMXD+DZnF3cj4Ir0JXXynbIY+m2SIul2aCucY5jjw0f3PAke
	TFHG0qbW5CE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D471CBE8;
	Fri, 10 May 2013 15:29:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E13851CBE7;
	Fri, 10 May 2013 15:29:49 +0000 (UTC)
In-Reply-To: <1368196005-5354-9-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 10 May 2013 19:56:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 741C1F22-B986-11E2-B2AB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223871>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +finish_rebase () {
> +	if test -f "$state_dir/autostash"
> +	then
> +		stash_sha1=$(cat "$state_dir/autostash")
> +		if git stash apply $stash_sha1 2>&1 >/dev/null
> +		then
> +			echo "Applied autostash"
> +		else
> +			ref_stash=refs/stash &&
> +			: >>"$GIT_DIR/logs/$ref_stash" &&
> +			git update-ref -m "autostash" $ref_stash $stash_sha1 \
> +				|| die "$(eval_gettext 'Cannot store $stash_sha1')" &&
> +			echo "
> +$(gettext 'Applying autostash resulted in conflicts.
> +...

This is confusing (or confused):

	these && might && fail
            || die &&
        success

It is much easier to read if you just drop && after die and write it
like so:
	
		ref_stash=refs/stash &&
		: >>"$GIT_DIR/logs/$ref_stash" &&
		git update-ref -m "autostash" $ref_stash $stash_sha1 ||
		die "$(eval_gettext 'Cannot store $stash_sha1')"

		echo "... success message comes here..."
