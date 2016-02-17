From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/20] safe_create_leading_directories(): set errno on SCLD_EXISTS
Date: Wed, 17 Feb 2016 11:23:23 -0800
Message-ID: <xmqqziuzi1jo.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<7ddc8ac89f36b01494fbdc6f97bf1ca258b3e885.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:23:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7hD-0007wD-3P
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbcBQTX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:23:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030377AbcBQTX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:23:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5108242642;
	Wed, 17 Feb 2016 14:23:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HokWwMAYz9YzwkYAdMhFcHronU=; b=hqC9HZ
	dsqNahZJuhpC15HNu6Y7qWNCVAPW11IETrnQYZqq4rSJxILN6LF6wL4tPnZ7UWv0
	1e5bmwLc1d8Z/hC3GyLhI0qgquhSuWQS4xS8jE3f43P38kOSiqp21R2BVjUS5E88
	I+ZG8AP7W3ebUma5in9wQKuo6+/oOQMWVYK6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qWUXX+PvWRSTYX9gl0bTDOvJJTIY+mju
	XjyJjRDMavvcKS8sZU4CZXL/WwZ1cWYnFtkryWL4DI67i9eZKfl7BwQS3QMUme3/
	YYkmBhAV76AyKlhPf90uzIfdYyJfFSCtNxfcMms11Z7rbRjdZc0GgE+8/gdnWdla
	pBMopUI2eRA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 483E642641;
	Wed, 17 Feb 2016 14:23:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B090E42640;
	Wed, 17 Feb 2016 14:23:24 -0500 (EST)
In-Reply-To: <7ddc8ac89f36b01494fbdc6f97bf1ca258b3e885.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA15AE84-D5AB-11E5-A2E2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286541>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The exit path for SCLD_EXISTS wasn't setting errno, as expected by at
> least one caller. Fix the problem and document that the function sets
> errno correctly to help avoid similar regressions in the future.

> diff --git a/sha1_file.c b/sha1_file.c
> index 568120e..a1ac646 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -135,8 +135,10 @@ enum scld_error safe_create_leading_directories(char *path)
>  		*slash = '\0';
>  		if (!stat(path, &st)) {
>  			/* path exists */
> -			if (!S_ISDIR(st.st_mode))
> +			if (!S_ISDIR(st.st_mode)) {
> +				errno = EEXIST;
>  				ret = SCLD_EXISTS;

Hmm, when does this trigger?  There is a non-directory A/B, you are
preparing leading directories to create A/B/C/D, and you find A/B
exists but is not a directory so you cannot create A/B/C underneath
it?

That sounds more like ENOTDIR to me.

Does the caller expect EEXIST, or both?

> +			}
>  		} else if (mkdir(path, 0777)) {
>  			if (errno == EEXIST &&
>  			    !stat(path, &st) && S_ISDIR(st.st_mode))
