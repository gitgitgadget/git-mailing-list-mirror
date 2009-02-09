From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Sun, 08 Feb 2009 22:04:46 -0800
Message-ID: <7vwsc0uow1.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 07:06:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWPHm-0006le-OV
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 07:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbZBIGFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 01:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbZBIGFB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 01:05:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbZBIGFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 01:05:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CCDFA2ABEB;
	Mon,  9 Feb 2009 01:04:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B47022ABEA; Mon, 
 9 Feb 2009 01:04:48 -0500 (EST)
In-Reply-To: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Mon, 9 Feb 2009 01:44:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9424E5DA-F66F-11DD-8DC1-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109047>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> diff --git a/git-repack.sh b/git-repack.sh
> index 458a497..6a7ba90 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -93,22 +93,43 @@ for name in $names ; do
>  	chmod a-w "$PACKTMP-$name.pack"
>  	chmod a-w "$PACKTMP-$name.idx"
>  	mkdir -p "$PACKDIR" || exit

> +	ok=t

This does not seem to be used at all.

> +	if test -f "$PACKDIR/pack-$name.pack"
> +	then
> +		mv -f "$PACKDIR/pack-$name.pack" \
> +			"$PACKDIR/old-pack-$name.pack"
> +	fi &&
> +	if test -f "$PACKDIR/pack-$name.idx"
> +	then
> +		mv -f "$PACKDIR/pack-$name.idx" \
> +			"$PACKDIR/old-pack-$name.idx" ||
> +		(
> +			mv -f "$PACKDIR/old-pack-$name.pack" \
> +			"$PACKDIR/pack-$name.pack" || (
> +				echo >&2 "Failed to restore after a failure to rename"\
> +					"pack-$name{pack,idx} to old-$pack{pack,idx} in $PACKDIR"
> +				echo >&2 "Please acquire advice on how to recover from this"\
> +					"situation before you proceed."
> +				exit 1
> +			) || false
> +		) || (
> +			echo >&2 "Failed to replace the existing pack with updated one."
> +			echo >&2 "We recovered from the situation, but cannot continue".
> +			echo >&2 "repacking."
> +			exit 0
> +		)
> +	fi &&
>  	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
>  	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
>  	test -f "$PACKDIR/pack-$name.pack" &&
>  	test -f "$PACKDIR/pack-$name.idx" || {
>  		echo >&2 "Couldn't replace the existing pack with updated one."
> +		if (test -f "$PACKDIR/old-pack-$name.pack" ||
> +			test -f "$PACKDIR/old-pack-$name.idx")

Why fork a subshell?

> +		then
> +			echo >&2 "The original set of packs have been saved as"
> +			echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
> +		fi
>  		exit 1

What's troubling more is that this would seem to leave the result even
more inconsistent if there are more than one packs that need to be
replaced.

I wonder if a completely different strategy would be less problematic.

 (1) create a new directory objects/new-pack/, copy ones with the same
     name, and hardlink the rest;

 (2) Do the usual "mv temp to final" dance into objects/new-pack/, but
     without any old-pack-$name part; if any fail, do not even try to
     recover but just barf, perhaps removing new-pack directory;

 (3) If all succeed, rename pack/ to old-pack/, rename new-pack/ to pack/.
     If the former fails, you can stop and report that your repack did not
     quite work, but new packs are still found in new-pack.  If the latter
     fails, you can stop and report that your repack did not quite work,
     but original packs are still found in old-pack.

 (4) If the directory rename succeed, remove old-pack/
