From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] imap-send: create target mailbox if it is missing
Date: Thu, 31 Jul 2014 11:57:35 -0700
Message-ID: <xmqqy4v9we3k.fsf@gitster.dls.corp.google.com>
References: <alpine.LSU.2.00.1407310910230.10413@hermes-1.csi.cam.ac.uk>
	<alpine.LSU.2.00.1407310914320.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCvY6-0000y0-MV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbaGaS5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 14:57:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60892 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbaGaS5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 14:57:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B92AB2EB02;
	Thu, 31 Jul 2014 14:57:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l4WUFAYICxHRaP+hxmPWQt+qTMU=; b=H87Qll
	lNJgCBmQGnSkC7KpvdHAFDIuqgEhg6CxsZkODOl8Fs9tpov9Drl+oxiNb1FxoOoZ
	OQ3ogDbSJ/iD+dbhglIy4w2T/rMMPZw7ABoRpcJqfTZ3Md6cDFwvS2HwBC7rnulW
	2R+2d2icCUF0+FbbsaIBBtsYnt4MrLht7BQPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q31apr4KiuR9ES5+sX6w/sG6aRAObPjP
	W82Yy5KFmMFdFTuCB7dnkWHpseBdsdD1tWPr9szJCCHRQv5HPePi0FKPOjysPbko
	5bAycpF8CPSIlw+IW57icV1fR8M8vJKRSid0y8FoaWSzhikqLES2Jhx6zTWN8GHv
	H16YppOCw3o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B08112EB01;
	Thu, 31 Jul 2014 14:57:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 03D3B2EAE1;
	Thu, 31 Jul 2014 14:57:36 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.00.1407310914320.13901@hermes-1.csi.cam.ac.uk>
	(Tony Finch's message of "Thu, 31 Jul 2014 09:14:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 89BA6262-18E4-11E4-98EA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254598>

Tony Finch <dot@dotat.at> writes:

> Some MUAs delete their "drafts" folder when it is empty, so
> git imap-send should be able to create it if necessary.
>
> This change checks that the folder exists immediately after
> login and tries to create it if it is missing.
>
> There was some vestigial code to handle a [TRYCREATE] response
> from the server when an APPEND target is missing. However this
> code never ran (the create and trycreate flags were never set)
> and when I tried to make it run I found that the code had already
> thrown away the contents of the message it was trying to append.
>
> Signed-off-by: Tony Finch <dot@dotat.at>
> ---

The basic idea looks good, but I have doubts on one point.

> diff --git a/imap-send.c b/imap-send.c
> index 524fbab..5e4a24e 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1156,6 +1133,25 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
>  		credential_approve(&cred);
>  	credential_clear(&cred);
>
> +	/* check the target mailbox exists */
> +	ctx->name = folder;
> +	switch (imap_exec(ctx, NULL, "EXAMINE \"%s\"", ctx->name)) {
> +	case RESP_OK:
> +		/* ok */
> +		break;
> +	case RESP_BAD:
> +		fprintf(stderr, "IMAP error: could not check mailbox\n");
> +		goto bail;
> +	case RESP_NO:
> +		if (imap_exec(ctx, NULL, "CREATE \"%s\"", ctx->name) == RESP_OK) {
> +			imap_info("Created missing mailbox\n");
> +		} else {
> +			fprintf(stderr, "IMAP error: could not create missing mailbox\n");
> +			goto bail;
> +		}
> +		break;
> +	}

At any and all the existing places that "goto bail" in the function,
we know we failed to authenticate.  I think they are all sensible
places to call credential_reject().

On the other hand, at this point before you try to "check the target
mailbox exists", we have authenticated sucessfully, we know the
credential used was good, and called credential_approve() to mark it
as such.  I do agree that you would want to signal an error to the
caller upon these two failures, but I do not think you want to "goto
bail" and reject the credential.  The error you observed in the new
codepath is caused by something else, not authentication failure,
and in such a case you do not want to cause the credential helper to
evict the user/pass pair from the keyring, no?

Thanks.
