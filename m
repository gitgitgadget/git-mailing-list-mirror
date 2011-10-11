From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix is_gitfile() for files larger than PATH_MAX
Date: Tue, 11 Oct 2011 13:25:32 -0700
Message-ID: <7vy5wre0n7.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1110111424010.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 11 22:25:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDitQ-00020C-Rf
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 22:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab1JKUZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 16:25:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab1JKUZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 16:25:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20AD66195;
	Tue, 11 Oct 2011 16:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HwbPTqatTBtY
	EF6SRrAcBOYARxo=; b=nsVvF9u4IV5dz+BTSRdHusrZH8rckvpOQ4BCMhcKKeAR
	bvuyyqhiz4vevPKcnME7mO77fApObiDSKby1zu0VHwhnlT3sNN5O5Qtev7JfA/ib
	zLmoVkknQyRT022sqxW8itsmTM0wPs4P1WpKEjn1Im5UhStDR6RqA5cIT24GvhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nUmaQh
	q2t8sbvtqREqD3etY+TfniPbxV2mINhLMtxxbUQgt0TlG8SIiFkrnlZQ8B9GyV6j
	ask6aqN/+r7ira5GGXPaOUTPhhUH5Nqa60tIiM8dFWi3pM49Vqgw0sjPgFp1HNWP
	spIC33T41evcuCbFXnLWS0SHdKXSInoF6wUEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 172676194;
	Tue, 11 Oct 2011 16:25:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E9E86192; Tue, 11 Oct 2011
 16:25:33 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1110111424010.32316@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Tue, 11 Oct 2011 14:25:32 -0500 (CDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BD8BED8-F447-11E0-BE74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183323>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The logic to check whether a file is a gitfile used the heuristics th=
at
> the file cannot be larger than PATH_MAX. But in that case it returned=
 the
> wrong value. Our test cases do not cover this, as the bundle files
> produced are smaller than PATH_MAX. Except on Windows.
>
> While at it, fix the faulty logic that the path stored in a gitfile c=
annot
> be larger than PATH_MAX-sizeof("gitfile: ").
>
> Problem identified by running the test suite in msysGit, offending co=
mmit
> identified by J=C3=B6rg Rosenkranz.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 	This patch should apply cleanly to 'next', which we track in
> 	msysgit/git.
>
> 	The task of adding a test case is something I leave to someone who
> 	wants to get involved with Git development and needs an easy way
> 	in.
>
>  transport.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index f3195c0..57138d9 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -868,8 +868,8 @@ static int is_gitfile(const char *url)
>  		return 0;
>  	if (!S_ISREG(st.st_mode))
>  		return 0;
> -	if (st.st_size < 10 || st.st_size > PATH_MAX)
> -		return 1;
> +	if (st.st_size < 10 || st.st_size > 9 + PATH_MAX)
> +		return 0;

We are asked if the file is likely to be a single-liner "gitfile: <path=
>",
and were answering yes when it is a very short file (less than 10 bytes=
)
that cannot possibly even contain "gitfile: " prefix.

I suspect that we can and should get rid of the "cannot be very long"
check altogether---we do open and check the file, and after all it is n=
ot
like we are throwing different strings as "url" argument to this functi=
on
at random and this function needs heuristics to reject bogus input
early. The argument is an input from the user.

Quite an embarrasing bug. Thanks for spotting.
