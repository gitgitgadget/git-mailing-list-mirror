From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Tue, 15 Jun 2010 08:05:22 -0700
Message-ID: <7v8w6g8hfx.fsf@alter.siamese.dyndns.org>
References: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 15 17:05:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOXhq-0001ou-Mk
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 17:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab0FOPFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 11:05:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0FOPFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 11:05:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30559BA516;
	Tue, 15 Jun 2010 11:05:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ky4elxvDLVQUMHHWwmD2L4L3tY0=; b=mGT8jHxup9qNhfG1BCsI1LI
	N6vQdBBjDbMCK575Xbc8s1h/aLuur5K5Bh+TcwLSi9QITPorQZYrHYYIWSVPWNIe
	VtsAsh2Dkh/JDqhexS3C9IsEt9szzYcBrbrn4WsZYmeszooLoWvXdVLrjU+4gdYL
	yVugKZXei/MUsIl0eZls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GNITY22216Ax2OKLFzEc8G3ucoEDcgm0Mzfl6AJf4CoY0y8RE
	HHffymo/lcgs/xScsRcjFiwizAqBHJBgTIWMgkafsgDdYJSDvNx7TZzg/KQNk9k3
	YGWIGnt2nF9JF89mrkTHOXpzID85qWVSd+6dPOOTblqkRn0YgLOSNl23a0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD640BA50A;
	Tue, 15 Jun 2010 11:05:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FE1ABA501; Tue, 15 Jun
 2010 11:05:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F560ACE-788F-11DF-AB27-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149189>

Thomas Rast <trast@student.ethz.ch> writes:

> common_prefix() scans backwards from the far end of each 'next'
> pathspec, starting from 'len', shortening the 'prefix' using 'path' as
> a reference.
>
> However, there was a small opportunity for an out-of-bounds access:
> len is unconditionally set to prefix-1 after a "direct match" test
> failed.  This means that if 'next' is shorter than prefix+2, we read
> past it.
> ...
> Found by valgrind.
>
>  dir.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 5615f33..ca689ff 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -34,9 +34,11 @@ static int common_prefix(const char **pathspec)
>  	prefix = slash - path + 1;
>  	while ((next = *++pathspec) != NULL) {
>  		int len = strlen(next);
> -		if (len >= prefix && !memcmp(path, next, prefix))
> -			continue;
> -		len = prefix - 1;
> +		if (len >= prefix) {
> +			if (!memcmp(path, next, prefix))
> +				continue;
> +			len = prefix - 1;
> +		}
>  		for (;;) {
>  			if (!len)
>  				return 0;

The structure of this loop is somewhat curious.  It starts out by setting
prefix based on what is found in "path" (i.e. the first proposed common
prefix is the longest leading directory path of "path"), and when it finds
that the prefix being considered does not match "next", it uses what is
found in "next" to shorten it.

Isn't it more intuitive to structure the loop by saying 'Ok, if "path" up
to the currently proposed "prefix" is too long to match, let's shorten it
by one path component and try again'?  IOW, something like...

static int common_prefix(const char **pathspec)
{
	const char *path, *slash, *next;
	int prefix;

	if (!pathspec)
		return 0;

	path = *pathspec;
	slash = strrchr(path, '/');
	if (!slash)
		return 0;

	prefix = slash - path + 1;
	while ((next = *++pathspec) != NULL) {
		int len;
	again:
		len = strlen(next);
		if (len > prefix && !memcmp(path, next, prefix))
			continue;
		while (0 < --prefix && path[prefix - 1] != '/')
			;
		if (!prefix)
			break;
		goto again;
	}
	return prefix;
}
