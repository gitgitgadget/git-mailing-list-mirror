From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] wrapper.c: add a new function unlink_or_msg
Date: Fri, 18 Jul 2014 15:25:58 -0700
Message-ID: <xmqqha2el2x5.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:26:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8GbU-0002sP-FV
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 00:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbaGRW0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 18:26:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51094 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbaGRW0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 18:26:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 994F428659;
	Fri, 18 Jul 2014 18:26:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y9wSK7Nu/PoiCxtXYUwne1WBq+o=; b=bsvyEz
	JDtMK890iTecBnQd/mzajwT9tnFh4M08abF0rClmV+CdrfyfX5j1dJOe5R2RlhxW
	WQwzNn9omk3NEo3TbJ+1BVHZ/ZmLRtlekmhyeyv/MNxXAJDrU0KwGH+yJki94Em6
	ZlhX5PajLQPVWOOStA37KVOdT8GTaQDbXSiEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQndL5ocIQr9eFbEmk6CCKc8kEThDzyg
	Uoz3HbV3X/K7rU3jA9d+9K7Gvmfaf8GksO4Xb9bVta5d48M+8c6/t9tYdwItQeYK
	I4eacDmtbvX/kwnoWat2pn69xXHN0NqokhQEjnAIJXRycrzmmAtnbKOqnsW7KWcF
	S9OcouZQSHU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DC7F28658;
	Fri, 18 Jul 2014 18:26:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 892CF2864C;
	Fri, 18 Jul 2014 18:25:59 -0400 (EDT)
In-Reply-To: <1405549392-27306-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 16 Jul 2014 15:23:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E74B35E-0ECA-11E4-B0F4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253854>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  git-compat-util.h |  6 ++++++
>  wrapper.c         | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b6f03b3..426bc98 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -704,12 +704,18 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>  #endif
>  #endif
>  
> +#include "strbuf.h"
> +
>  /*
>   * Preserves errno, prints a message, but gives no warning for ENOENT.
>   * Always returns the return value of unlink(2).
>   */
>  int unlink_or_warn(const char *path);
>  /*
> + * Like unlink_or_warn but populates a strbuf
> + */
> +int unlink_or_msg(const char *file, struct strbuf *err);
> +/*
>   * Likewise for rmdir(2).
>   */
>  int rmdir_or_warn(const char *path);
> diff --git a/wrapper.c b/wrapper.c
> index 740e193..74a0cc0 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -438,6 +438,24 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
>  	return rc;
>  }
>  
> +int unlink_or_msg(const char *file, struct strbuf *err)
> +{
> +	if (err) {
> +		int rc = unlink(file);
> +		int save_errno = errno;
> +
> +		if (rc < 0 && errno != ENOENT) {
> +			strbuf_addf(err, "unable to unlink %s: %s",
> +				    file, strerror(errno));
> +			errno = save_errno;
> +			return -1;
> +		}
> +		return 0;
> +	}
> +
> +	return unlink_or_warn(file);
> +}

In general, I do not generally like to see messages propagated
upwards from deeper levels of the callchain to the callers to be
used later, primarily because that will easily make it harder to
localize the message-lego.

For this partcular one, shouldn't the caller be doing

	if (unlink(file) && errno != ENOENT) {
        	... do its own error message ...
	}

instead of calling any of the unlink_or_whatever() helper?


>  int unlink_or_warn(const char *file)
>  {
>  	return warn_if_unremovable("unlink", file, unlink(file));
