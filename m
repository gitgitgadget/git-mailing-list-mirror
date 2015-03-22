From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] http: release the memory of a http pack request as well
Date: Sun, 22 Mar 2015 12:36:35 -0700
Message-ID: <xmqq1tkgddto.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZlfu-0008CS-I7
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbbCVTgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:36:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751819AbbCVTgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:36:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86FDD42008;
	Sun, 22 Mar 2015 15:36:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3cAq4Ex1eCfOCFFsSoO0QkwHAk=; b=BeiSyP
	xQmKiaoyhbQX5ZaovYJG0Q2hoz4UtCGaeVOrgkRP3O8GX5xi9VklbrleQm3fzoDS
	vcQ3ZeyTmukFRcyOY+J/iE7QM3tZHQIULXLG4cPK+XFJ69MHMCeM8gggOZe7mfcu
	R1NmyxAo6lktP4sR+hM78EC0qPKRE50SxGXJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=svIQ5tzdL95On4NrhLTn0k+wdX0FTJFB
	/QPOgXdEFfV71uvIjtM9jaNUawLKyzMY68VHezfXP8wkiMmdFKwNHF00bVJJSrn7
	IsEelc2hq78cfkxgFeri32YxrmAHA5zLOQw989Vc/UwJtzFZUNAc3AaZiFxBgEs6
	lKYb5py+Hfs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FBA542007;
	Sun, 22 Mar 2015 15:36:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E97C042006;
	Sun, 22 Mar 2015 15:36:36 -0400 (EDT)
In-Reply-To: <1426897692-18322-10-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C11AF660-D0CA-11E4-B55C-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266087>

Stefan Beller <sbeller@google.com> writes:

> The cleanup function is used in 4 places now and it's always safe to
> free up the memory as well.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  http.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/http.c b/http.c
> index 9c825af..4b179f6 100644
> --- a/http.c
> +++ b/http.c
> @@ -1462,6 +1462,7 @@ void release_http_pack_request(struct http_pack_request *preq)
>  	}
>  	preq->slot = NULL;
>  	free(preq->url);
> +	free(preq);
>  }
>  
>  int finish_http_pack_request(struct http_pack_request *preq)

Freeing of preq in all the callers of this one looks sensible,
except for the one in finish_request() of http-push.c that pulls an
preq instance out of request->userData.

Can somebody help me follow the dataflow to convince me that this is
not leading to double-free in start_fetch_packed()?

Thanks.
