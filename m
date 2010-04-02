From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 01 Apr 2010 23:39:58 -0700
Message-ID: <7veiiymk75.fsf@alter.siamese.dyndns.org>
References: <m2wd411cc4a1004011514w6d350ac7l15ab6bb1a6be8d89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 08:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxaYD-0001fT-8H
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 08:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712Ab0DBGkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 02:40:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693Ab0DBGkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 02:40:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5891A77E9;
	Fri,  2 Apr 2010 02:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mN4nOv3mfIhramdHSnrbu3/S3MY=; b=WQjbyT
	UGz5azPODIxfn5JZod5GwJWHQyW8nO2fiI5a6aZmXT7Pbyf3aWT/dkPptxvbin6f
	cS69fZ428GpUdRdTu5Jmu1G1kBLUEYPpZHZEUI2TyWvdpi08w/1Zkl04In06VGht
	4KuoyEO+OrpzClwOzxsjvCyGNf0Z/C8vVF4Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D6nqFEYD0bL+i+m94jte/DjjLQ0+HiOk
	Ok9ZcBSikMhrRS8nkO+KViV3CJPffC+87RWcuJWSMiO0htqrWK7KTQDou4FHC8zH
	Psvf8NA7p2VjzM0eMl5WhgIrCwHWKWr8jdu9VQMJwVhyP7c1CZwNgjXkvx6lAXya
	h5VxduCiy6c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DDF6A77E8;
	Fri,  2 Apr 2010 02:40:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3C1BA77E7; Fri,  2 Apr
 2010 02:39:59 -0400 (EDT)
In-Reply-To: <m2wd411cc4a1004011514w6d350ac7l15ab6bb1a6be8d89@mail.gmail.com>
 (Scott Chacon's message of "Thu\, 1 Apr 2010 15\:14\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90E02DF2-3E22-11DF-A37F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143779>

Scott Chacon <schacon@gmail.com> writes:

> When an HTTP request returns a 401, Git will currently fail with a
> confusing message saying that it got a 401, which is not very
> descriptive.
>
> Currently if a user wants to use Git over HTTP, they have to use one
> URL with the username in the URL (e.g. "http://user@host.com/repo.git")
> for write access and another without the username for unauthenticated
> read access (unless they want to be prompted for the password each
> time). However, since the HTTP servers will return a 401 if an action
> requires authentication, we can prompt for username and password if we
> see this, allowing us to use a single URL for both purposes.

Thanks; this illustrates the issue you are trying to solve much easier to
see, don't you agree?

An obvious enhancement could be to make "http://user@host.com/repo.git"
ask for password lazily.  Then such a URL can be used even for an access
that does not need authentication and the user does not have to prompted
for the password each time, which was what you wanted to really solve, no?

Actually that could not just be an enhancement, but might be a better
alternative solution to the problem, but I haven't thought things
through.

> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>
> Updated the comments style and the commit message for Junio.

Heh, Message update is never _for_ me.  It is to clarify the problem you
are trying to solve, so that we can be certain that the proposed patch is
the best approach to solve it.

> diff --git a/http.c b/http.c
> index 4814217..51253e1 100644
> --- a/http.c
> +++ b/http.c
> @@ -815,7 +815,21 @@ static int http_request(const char *url, void
> *result, int target, int options)

I fixed this up when I queued the previous version, and you have the same
line wrapping problem in this version, which I have fixed, too, before
replacing what was queued to 'pu'.

I mention this not as a complaint (but I would appreciate if you try to be
careful next time, especially if you plan to post more patches and to
become a regular contributor), but primarily because it is curious that
only the hunk headers are wrapped but not these long lines we see below:

> ...
> +			} else {
> +				/*
> +				 * git_getpass is needed here because its very likely stdin/stdout are
> ...
