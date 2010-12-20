From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sun, 19 Dec 2010 18:26:55 -0800
Message-ID: <7vr5dddvrk.fsf@alter.siamese.dyndns.org>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru> <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru> <20101218161337.GB18643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 20 03:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUVT7-0008Mb-3h
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 03:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab0LTC1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 21:27:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab0LTC1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 21:27:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4C9B4763;
	Sun, 19 Dec 2010 21:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xow0Znn6cJDdtNHIWXcU+EY9Xi4=; b=hYFNIt
	ceIhpgcBOxkz4Kgqyqyxcq6OJlg7GwT3wRD/CEHNkSsRM7c27w4H3VbHCx74uJJM
	kpaNs8d1grHRoXAEEXEHpjNANnkG3FVyfpktuNDPGrRS0THSYxfO9z76zp39ZqDw
	I4aG5bfn4sZD4OfM1I27ao+QA3zIigjXgmMyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+oVz4HZus81Qba/z53k58i5AxvGe42D
	uzvbhnXPofYtpgAcGsv8kvYC/iwhuf7xX/en8Vs0JI7dZfiPmKhEXxIccaOlTPtO
	6domc2gfOyGXLMHBKiwkQ8nJHdyTgkS5Q+DRTLLMPK88V2mc3Wj58OqwE4/XoLED
	XYZwPp8vpLQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31FB6475D;
	Sun, 19 Dec 2010 21:27:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4B49D4758; Sun, 19 Dec 2010
 21:27:26 -0500 (EST)
In-Reply-To: <20101218161337.GB18643@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 18 Dec 2010 11\:13\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B400BE00-0BE0-11E0-B7EA-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163976>

Jeff King <peff@peff.net> writes:

> PS It is a little disturbing that in fill_textconv, we handle
> case (1), !DIFF_FILE_VALID for the non-textconv case, but not so for the
> textconv case. I think we are OK, as get_textconv will never load a
> textconv driver for a !DIFF_FILE_VALID filespec, so we always follow the
> non-textconv codepath in that case. But I am tempted to do this just to
> be more defensive:

FILE_VALID() is about "does that side have a blob there, or is this
create/delete diff?", so the caller should be handling this properly as
you said, but your fill_textconv() already prepares for the case where the
caller for some reason calls this function with "no blob on this side" and
returns an empty string (see the precontext of your patch).

I think it is fine to be defensive to prepare for such a case, but then
dying like this patch does is inconsistent.  Perhaps we should move the
new check higher and remove the *outbuf = "" while at it?

> diff --git a/diff.c b/diff.c
> index b0ee213..5320849 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4404,22 +4404,25 @@ size_t fill_textconv(struct userdiff_driver *driver,
>  	if (!driver || !driver->textconv) {
>  		if (!DIFF_FILE_VALID(df)) {
>  			*outbuf = "";
>  			return 0;
>  		}
>  		if (diff_populate_filespec(df, 0))
>  			die("unable to read files to diff");
>  		*outbuf = df->data;
>  		return df->size;
>  	}
>  
> +	if (!DIFF_FILE_VALID(df))
> +		die("BUG: attempt to textconv an invalid filespec");
> +
