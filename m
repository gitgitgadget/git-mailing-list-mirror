From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: preliminary support for hg patches
Date: Mon, 29 Aug 2011 09:57:04 -0700
Message-ID: <7v62lg6tr3.fsf@alter.siamese.dyndns.org>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy598-0005Hn-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1H2Q5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:57:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230Ab1H2Q5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:57:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 028EA3146;
	Mon, 29 Aug 2011 12:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kifEUmi7N85sUoge4iO9huzHPzI=; b=pOairy
	TT6SlnVa9uZDvWylkGPKep9lyXFVpwCOFLhoEFBDknVnoKlYVVPHSYVi4BiLrhxW
	KRcDFOzaDkQI83v3p9peBhWlWorBmP3oJixCK1r9adUJX4fDxCbpyNfVtgUTuryB
	/zw2Vzi+LPXhocGif0kwlg3DvStupvQWdy2j4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I2CuylCXy5P3ZDNCY4T8RC8sFLLHncIb
	iP9BmUmlX/sFUGtQ5pCv1bXJmki76mBx3anED5pF40OvmHXj0Ulru7aiHjgZDBJS
	9HxuQYmplKizCIjUEapPWl14WKwZr0Rz+Q+h/jTADMJtxfum9Myg5ZVdRLqn66+E
	2XSapLN7Oqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1A93144;
	Mon, 29 Aug 2011 12:57:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 471BA313F; Mon, 29 Aug 2011
 12:57:06 -0400 (EDT)
In-Reply-To: <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Mon, 29 Aug 2011 18:44:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED1E274A-D25F-11E0-8C93-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180321>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I'll leave nitpicking of this patch and helping to improve it to people
who actually have to deal with Hg generated patches for now.

> +	hg)
> +		this=0
> +		for hg in "$@"
> +		do
> +			this=`expr "$this" + 1`
> +			msgnum=`printf "%0${prec}d" $this`
> +			# hg stores changeset metadata in #-commented lines preceding
> +			# the commit message and diff(s). The only metadata we care about
> +			# are the User and Date (Node ID and Parent are hashes which are
> +			# only relevant to the hg repository and thus not useful to us)
> +			# Since we cannot guarantee that the commit message is in git-friendly
> +			# format, we put no Subject: line and just consume all of the message
> +			# as the body

Personally I am a bit worried about the phoney "diff --git" output Hg
seems to (be able to) produce. Do they have "index ..." line that express
the blob object names in git terms (implausible), for example? We _might_
want to strip s/diff --git /diff / so that apply won't be confused if that
turns out to be a problem.

Thanks.

> +			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
> +				if ($subject) { print ; }
> +				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
> +				elsif (/^\# Date /) {
> +					my ($hashsign, $str, $time, $tz) = split ;
> +					$tz = sprintf "%+05d", (0-$tz)/36;
> +					print "Date: " .
> +					      strftime("%a, %d %b %Y %H:%M:%S ",
> +						       localtime($time))
> +					      . "$tz\n";
> +				} elsif (/^\# /) { next ; }
> +				else {
> +					print "\n", $_ ;
> +					$subject = 1;
> +				}
> +			' < "$hg" > "$dotest/$msgnum" || clean_abort
> +		done
> +		echo "$this" > "$dotest/last"
> +		this=
> +		msgnum=
> +		;;
>  	*)
>  		if test -n "$patch_format" ; then
>  			clean_abort "$(eval_gettext "Patch format \$patch_format is not supported.")"
