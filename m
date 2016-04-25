From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/10] t0027: Make commit_chk_wrnNNO() reliable
Date: Mon, 25 Apr 2016 12:15:05 -0700
Message-ID: <xmqqy481jy9y.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461603387-30639-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Apr 25 21:15:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulyY-00013X-A1
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 21:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbcDYTPL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 15:15:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932821AbcDYTPJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 15:15:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A6D815B8E;
	Mon, 25 Apr 2016 15:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JEjaLUE27Vae
	z0yCftEfs9o+C6s=; b=memXLcHl6hyvH85UXphPpnxIKRzDfSlTkBZSJbK0YDA6
	yoqrxATPup0YobRtB0MSAJIgdDve8JzcG6YFG7cN1TK8IONAoXKKXh3RiDwIoRMq
	k4tBDNWEH8nA+6qsdp74qS8c8yjMyUKpBxcKaN++dZKmtlB/JOQcpnSgEVZsGQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w3t0NE
	ZN5KRsDLWnjV3NlN93ShhmzGSBrPelT5Ch+Fde6bT/yxthXhKplBBoD4uIsNQBpm
	rVeKr8ADFwpcyRmmRfcHAXVOJafWHVesA/ITiq4tKtNXi16ZBH3T2MTQhaYSZE2N
	N3P3zYwMPq5RM80PvBWuyi3Dj1XoClvcVrEzc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FDF715B8D;
	Mon, 25 Apr 2016 15:15:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F1EC15B8C;
	Mon, 25 Apr 2016 15:15:07 -0400 (EDT)
In-Reply-To: <1461603387-30639-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 25 Apr 2016 18:56:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05BC8B32-0B1A-11E6-B99B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292548>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When the content of a commited file is unchanged and the attributes a=
re changed,
> Git may not detect that the next commit must treat the file as change=
d.
> This happens when lstat() doesn't detect a change, since neither inod=
e,
> mtime nor size are changed.
>
> Add a singe "Z" character to change the file size (and content).

singLe (no need to reroll for this nit; locally fixed already).



> When the files are compared later in checkout_files(), the "Z" is rem=
oved
> before the comparison.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Change since v6b:
>  - Remove 2 sparse warnings, thanks Ramsay
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index f33962b..9fe539b 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -12,7 +12,7 @@ fi
> =20
>  compare_files () {
>  	tr '\015\000' QN <"$1" >"$1".expect &&
> -	tr '\015\000' QN <"$2" >"$2".actual &&
> +	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
>  	test_cmp "$1".expect "$2".actual &&
>  	rm "$1".expect "$2".actual
>  }
> @@ -114,6 +114,7 @@ commit_chk_wrnNNO () {
>  	do
>  		fname=3D${pfx}_$f.txt &&
>  		cp $f $fname &&
> +		printf Z >>"$fname" &&
>  		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
>  		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${=
pfx}_$f.err" 2>&1
>  	done
