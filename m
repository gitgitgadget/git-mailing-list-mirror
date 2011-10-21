From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] daemon: report permission denied error to clients
Date: Fri, 21 Oct 2011 12:25:17 -0700
Message-ID: <7vaa8u87vm.fsf@alter.siamese.dyndns.org>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
 <20111017195850.GC29479@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 21 21:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHKu4-0002lJ-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 21:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab1JUTZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 15:25:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab1JUTZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 15:25:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0E505E37;
	Fri, 21 Oct 2011 15:25:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uySd5cDuq6vv2ELtTB7fyg9dIXE=; b=MA7wpD
	HKhDQ/RsJ7nG76ekFUNs15r0nBswzOJ5I66bLoQ7iDEGYhYxo26FRKz7VtzdXXBW
	cEsM+0W7OkiaW8MdewjkZ0qL6S3TD7ACThZotyQTgjtKMM8G/wBKgh9IEbC7ewPt
	NWsWh63q33ar4qtjnHEF9IOzW94PiCXgomaM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFz9LW9PzNPUjBHGK7qArOlrygv/mMSo
	+ChzSYresTosYW2D3Iu8N1cbeVAfqC7pAdM23LKOsluZwt+kQR4skH7vnPi6PA5i
	NQdMXSEXMEYzl3gV1BWS7zrxBEzBBwmYXFmxMy5pdKFEty4KALhrTgJsS3Tmsc7U
	+fCRKt8GvFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D763E5E36;
	Fri, 21 Oct 2011 15:25:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B0E95E31; Fri, 21 Oct 2011
 15:25:19 -0400 (EDT)
In-Reply-To: <20111017195850.GC29479@ecki> (Clemens Buchacher's message of
 "Mon, 17 Oct 2011 21:58:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 699FC560-FC1A-11E0-ACA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184081>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/daemon.c b/daemon.c
> index 72fb53a..2f7f84e 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -120,12 +120,14 @@ static char *path_ok(char *directory)
>  
>  	if (daemon_avoid_alias(dir)) {
>  		logerror("'%s': aliased", dir);
> +		errno = 0;
>  		return NULL;
>  	}
>  
>  	if (*dir == '~') {
>  		if (!user_path) {
>  			logerror("'%s': User-path not allowed", dir);
> +			errno = EACCES;
>  			return NULL;
>  		}

Isn't the first one inconsistent from all the others?

A request cames "../some/path" and it is not allowed by a daemon policy
and it gets errno==0 which is turned into "no such repo" later, while
another request to "~drizzed/another/path" is also rejected by a daemon
policy and gets errno==EACCESS which is turned into "permission denied".

Indeed everything else says EACCESS in this patch, except for the check
done by enter_repo() which can additionally say ENAMETOOLONG (which would
not be very useful in practice) or whatever error coming from failure to
go there with chdir(), which is not likely to be EACCESS because it has
already been checked with a separate access() that is done before the
actual chdir() call.

> +	if (!(path = path_ok(dir))) {
> +		if (errno == EACCES)
> +			return daemon_error(dir, "permission denied");
> +		else
> +			return daemon_error(dir, "no such repository");
> +	}

If errno is set to EACCESS in cases (1) we are not even going to tell you
if a repository exists there or not--you are not authorized to know and
(2) there is a repository but you do not have authorization to access it,
then this "leaking a bit more information" part is acceptable for site
with "--informative-errors", I would think. A repository that is invalid
from the daemon's point of view (e.g. validate_headref("HEAD") fails
because it points at an object that does not exist) but that the owner
intended to make it valid by correcting such mistakes would be reported as
"no such repository" with such a logic, so I am not sure if the distinction
between these two cases really matters in practice, though.
