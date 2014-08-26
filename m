From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/6] Change copy_fd() to not close input fd
Date: Tue, 26 Aug 2014 10:10:34 -0700
Message-ID: <xmqqd2bnjhx1.fsf@gitster.dls.corp.google.com>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
	<1409066605-4851-6-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:10:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKGf-0005rn-NI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaHZRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:10:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58945 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbaHZRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFA0F32C3A;
	Tue, 26 Aug 2014 13:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uc4U3QyIhwV74u76+aSRD19p2yM=; b=hukxpV
	oTpN5xGU0BaujYsfvMdmT3rhzt6NaPhAqevbxkdyZHa9eFrt1oIYPHgHgp4PDIX4
	pPLnmlnJo2UhM+gIcgur5QQT5HfjKZfd3sEy3UnK7tDdEXsuKgT6IhkreRYnEOHA
	tQRjFIL1tE5iZ/qIZ/mIEs3Bn+mFkV/ISXjBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fDwObWbGrCN8V+iQwomTJG19OedJD434
	BDw/NF9EY71hpk9udBqS46PSyxLmXZMBrkjznr3Q3TQdhBQ3oGpBwYW2IvI1bl+p
	2cddL7mbes08jmxMqD5ylqPSvbuH3yVDokDc84TqbWOWCP5mKcDU8n2sCuy+gda4
	g7wId0CZS4c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B481532C39;
	Tue, 26 Aug 2014 13:10:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CDC8F32C33;
	Tue, 26 Aug 2014 13:10:36 -0400 (EDT)
In-Reply-To: <1409066605-4851-6-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Tue, 26 Aug 2014 17:23:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E5BFBF1C-2D43-11E4-B760-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255920>

Steffen Prohaska <prohaska@zib.de> writes:

> The caller opened the fd, so it should be responsible for closing it.

Hmmmm, I am not sure what the benefit of such a dogmatism.  This
function consumes all that is useful in the fd, and there is nothing
interesting that can be do further on it, no?

Ah, wait.  The caller could choose to rewind and reuse the contents,
and it is very selfish of this function to unilaterally declare that
once you give an fd to it you cannot do anything with it laster.

So I think this is a good change, but the justification is not
quite.  It is not "the caller should be responsible"; it is more
about "the callee did not open it, does not own it, and should allow
the caller, if it chooses, reuse it by seeking after the callee is
done."

>> Subject: Re: [PATCH v6 5/6] Change copy_fd() to not close input fd

Let's follow the "<area>: <description>" convention here, too, e.g.

    copy_fd(): allow callers to work on input fd after it returns

or something.

Thanks.

>  copy.c     | 5 +----
>  lockfile.c | 3 +++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/copy.c b/copy.c
> index a7f58fd..d0a1d82 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -10,7 +10,6 @@ int copy_fd(int ifd, int ofd)
>  			break;
>  		if (len < 0) {
>  			int read_error = errno;
> -			close(ifd);
>  			return error("copy-fd: read returned %s",
>  				     strerror(read_error));
>  		}
> @@ -21,17 +20,14 @@ int copy_fd(int ifd, int ofd)
>  				len -= written;
>  			}
>  			else if (!written) {
> -				close(ifd);
>  				return error("copy-fd: write returned 0");
>  			} else {
>  				int write_error = errno;
> -				close(ifd);
>  				return error("copy-fd: write returned %s",
>  					     strerror(write_error));
>  			}
>  		}
>  	}
> -	close(ifd);
>  	return 0;
>  }
>  
> @@ -60,6 +56,7 @@ int copy_file(const char *dst, const char *src, int mode)
>  		return fdo;
>  	}
>  	status = copy_fd(fdi, fdo);
> +	close(fdi);
>  	if (close(fdo) != 0)
>  		return error("%s: close error: %s", dst, strerror(errno));
>  
> diff --git a/lockfile.c b/lockfile.c
> index 2564a7f..2448d30 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -224,8 +224,11 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
>  	} else if (copy_fd(orig_fd, fd)) {
>  		if (flags & LOCK_DIE_ON_ERROR)
>  			exit(128);
> +		close(orig_fd);
>  		close(fd);
>  		return -1;
> +	} else {
> +		close(orig_fd);
>  	}
>  	return fd;
>  }
