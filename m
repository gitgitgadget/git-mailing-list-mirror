From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Thu, 11 Feb 2016 12:00:08 -0800
Message-ID: <xmqqpow3vwzb.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-2-git-send-email-sbeller@google.com>
	<xmqqfux11pm8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:00:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTxPW-0006FY-LK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 21:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbcBKUAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 15:00:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbcBKUAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 15:00:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 971C3416AF;
	Thu, 11 Feb 2016 15:00:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w4UJbQP7ajrqQcFLrgw9jaxQnoQ=; b=tNZYkB
	4MnXtxS+coG7fPGleBf/udHrepUAhB21T+Vuh5RWj7rROK+TFV9BWs5160VtHxpf
	vi6Gm8qttwr72Zvomqj+aj27Fp8WQ9LASx2zq9XQkDUzqVynUcNR/qnSpNGxyiws
	tfPT7bPGNGvd4h8DvOx075n0oWzdVNPq1q8C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBbj+/rE51Og8d79LExOHqrRv20n9u9H
	n0x4+h43Hdplonn46QzTJWPDuM8xzQ4ByVwzpVsWjCRR5B83iFRrOyYerkJGPS2p
	kdPpfh94LzEoZKPaO6tTlVJIf/KNcRJ4l/mmm/smR5357NCgE5uVRapEqYHLg0Lz
	9nmJVJ023Ag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C0CF416AE;
	Thu, 11 Feb 2016 15:00:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA872416AD;
	Thu, 11 Feb 2016 15:00:09 -0500 (EST)
In-Reply-To: <xmqqfux11pm8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Feb 2016 14:32:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0DFCACDC-D0FA-11E5-9634-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285993>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +		else {
>> +			submodule->update_command = NULL;
>> +			if (!strcmp(value, "none"))
>> +				submodule->update = SM_UPDATE_NONE;
>> +			else if (!strcmp(value, "checkout"))
>> +				submodule->update = SM_UPDATE_CHECKOUT;
>> +			else if (!strcmp(value, "rebase"))
>> +				submodule->update = SM_UPDATE_REBASE;
>> +			else if (!strcmp(value, "merge"))
>> +				submodule->update = SM_UPDATE_MERGE;
>> +			else if (!skip_prefix(value, "!", &submodule->update_command))
>> +				die(_("invalid value for %s"), var);
>> +		}
>
> I think this "string to enum" parser can become a separate helper
> function in this patch, so that later patch can use it to parse the
> "--update" option in the update_clone() function.
>
> That would solve the slight inconsistency we have seen
>
> +		if ((pp->update && !strcmp(pp->update, "none")) ||
> +		    (!pp->update && sub->update == SM_UPDATE_NONE)) {
>
> in that patch.

In addition, you would eventually want the reverse translation,
i.e. SM_UPDATE_ENUM to string, when you rebase the second patch of
your sb/submodule-init series (I just tried it myself and realized
that a patch to refactor the above part would be the best place to
add such a helper).
