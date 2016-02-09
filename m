From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Tue, 09 Feb 2016 14:32:47 -0800
Message-ID: <xmqqfux11pm8.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:32:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGq6-0006Le-2b
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbcBIWcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:32:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932719AbcBIWct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:32:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 031684256B;
	Tue,  9 Feb 2016 17:32:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+GSBGBRvNwyN45ARNTENR4krI0=; b=utF9EQ
	8P7+H8YHU7e0yRxcQ552H6SUiP4tx1hCFOyCE7cVPueU/KqhGW2F7/tVZV/HvtIx
	8AZoCdboy8QXyB/qcaymuMkpsszGn8//uBzEi+HlN8+0vDYFfaleGD4zgPnEe/tY
	GkzyBAo38zl+5vjdP1zgQJKfg7Nt+O/VdfOwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DifWEVvP7pTwGyYHDTZelCJ1GANPehY+
	QawTOn+arg8C/AHPLmUjMws13ALD08tQKDGNiwtUTZG5ARzHaAE/tJzp4sP+fRmj
	tquzZ7SISdDI2OUZ2oM3cnHK7tQbaDxQD/oxArJPgIHzCxmIC/p6G8T5CiRNoDon
	oPG9W42aYVw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF6404256A;
	Tue,  9 Feb 2016 17:32:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 72E2B42569;
	Tue,  9 Feb 2016 17:32:48 -0500 (EST)
In-Reply-To: <1455051274-15256-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 9 Feb 2016 12:54:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C0EE83C-CF7D-11E5-9F9A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285879>

Stefan Beller <sbeller@google.com> writes:

> +		else {
> +			submodule->update_command = NULL;
> +			if (!strcmp(value, "none"))
> +				submodule->update = SM_UPDATE_NONE;
> +			else if (!strcmp(value, "checkout"))
> +				submodule->update = SM_UPDATE_CHECKOUT;
> +			else if (!strcmp(value, "rebase"))
> +				submodule->update = SM_UPDATE_REBASE;
> +			else if (!strcmp(value, "merge"))
> +				submodule->update = SM_UPDATE_MERGE;
> +			else if (!skip_prefix(value, "!", &submodule->update_command))
> +				die(_("invalid value for %s"), var);
> +		}

I think this "string to enum" parser can become a separate helper
function in this patch, so that later patch can use it to parse the
"--update" option in the update_clone() function.

That would solve the slight inconsistency we have seen

+		if ((pp->update && !strcmp(pp->update, "none")) ||
+		    (!pp->update && sub->update == SM_UPDATE_NONE)) {

in that patch.
