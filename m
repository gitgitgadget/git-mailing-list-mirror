From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/21] refs: check submodules ref storage config
Date: Tue, 12 Jan 2016 16:19:18 -0800
Message-ID: <xmqqtwmiqqk9.fsf@gitster.mtv.corp.google.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	<1452561740-8668-17-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:19:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ99p-0004XN-9g
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbcAMATV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:19:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751940AbcAMATU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:19:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D781C3BF24;
	Tue, 12 Jan 2016 19:19:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kwsGkcpF6YPUouWFmEZ0Ym/vtec=; b=vvIwZRaE0j24zDVDmQ84
	TNamtC2O0ESKolIAILKYL98FdrXvpHRlrmGwds7iZhfGtNPcKQrP/TJPmihgCtit
	jWQN7IydHKuN/V/WW3L3ShhS6l8cD1xLm4rocqbVBdvUdDuZW/c0ikLq3I9ZlPdc
	/gTQnOo+G72bQ3RY+kIGUxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fqWye1iXgaNc/sFz8OewWIVK3/I4GoWtYE4l6eJ6JdHjeE
	p49uOXbeomyoVpw8Ytz2I6o6Fu95/1EEK4XrCX/j2J+aJ8FKfNTb9dFa/uSXGpN0
	5iVn8d578T09gnRuqSPwHuP90/uSGFlVbzzSObZDUo/g5nBD6zn7qiF7a7XGY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF39F3BF23;
	Tue, 12 Jan 2016 19:19:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3EF9F3BF22;
	Tue, 12 Jan 2016 19:19:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49B2E83A-B98B-11E5-8C12-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283859>

David Turner <dturner@twopensource.com> writes:

> All submodules must have the same ref storage (for now).  Confirm that
> this is so before attempting to do anything with submodule refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 07f1dab..1ccc7f6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -297,8 +297,43 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
>  	return for_each_ref_in("refs/tags/", fn, cb_data);
>  }
>  
> +static int submodule_backend(const char *key, const char *value, void *data)
> +{
> +	char **path = data;
> +	if (!strcmp(key, "extensions.refstorage"))
> +		*path = xstrdup(value);
> +}

This should return "int" (namely 0).
