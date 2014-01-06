From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/17] remove_dir_recurse(): handle disappearing files and directories
Date: Mon, 06 Jan 2014 10:18:58 -0800
Message-ID: <xmqqy52tht2l.fsf@gitster.dls.corp.google.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:19:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Eld-0005jH-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbaAFSTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:19:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525AbaAFSTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:19:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4B95F15C;
	Mon,  6 Jan 2014 13:19:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uyFOReIZKtS7iLrLZLbu79m/Urg=; b=OaQjDG
	gv5HMyOEcfx0st4wbxav+VRX03ca6gGPM1QRxX/dqTZAw4wDDZfkF/zsMnG+vnL6
	oUYHOt8PTSfCqFumZwIMwGXJOI2GsDXuQz92dD5RyDX1WsaFoDZazaxNpJ2UPAS1
	uMCD1ahyQfVRXMb9yIq0G6Vwq6pU/WzeSdQ7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBEbZrYd3cUufM/Cptkhg7SPgyOih+M7
	i9xlE0dqGzWARsB8RvoBWcc5//c0sT8Nh26ZJ7MtRrpAWio5zIvbTm18RgVm2xQ3
	OiwZPeb+UPDkmo+jCb8GIQCSB79LpBeKt7vTcdZxkdnt0Wee540Or69b87h09EeS
	Qvf+RRvDMrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 065995F15B;
	Mon,  6 Jan 2014 13:19:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A7305F159;
	Mon,  6 Jan 2014 13:19:02 -0500 (EST)
In-Reply-To: <1389015935-21936-14-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 6 Jan 2014 14:45:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04EB1838-76FF-11E3-834F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240041>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If a file or directory that we are trying to remove disappears (e.g.,
> because another process has pruned it), do not consider it an error.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  dir.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 11e1520..716b613 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1476,7 +1476,9 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
>  	dir = opendir(path->buf);
>  	if (!dir) {
> -		if (errno == EACCES && !keep_toplevel)
> +		if (errno == ENOENT)
> +			return keep_toplevel ? -1 : 0;

If we were told that "foo/bar must go, but do not bother removing
foo/", is it an error if foo itself did not exist?  I think this
step does not change the behaviour from the original (we used to say
"oh, we were told to keep_toplevel, and the top-level cannot be read
for whatever reason, so it is an error"), but because this series is
giving us a finer grained error diagnosis, we may want to think
about it further, perhaps as a follow-up.

I also wonder why the keep-toplevel logic is in this "recurse" part
of the callchain. If everything in "foo/bar/" can be removed but
"foo/bar/" is unreadable, it is OK, when opendir("foo/bar") failed
with EACCESS, to attempt to rmdir("foo/bar") whether we were told
not to attempt removing "foo/", no?

> +		else if (errno == EACCES && !keep_toplevel)

That is, I am wondering why this part just checks !keep_toplevel,
not

	(!keep_toplevel || has_dir_separator(path->buf))

or something.

>  			/*
>  			 * An empty dir could be removable even if it
>  			 * is unreadable:
> @@ -1496,13 +1498,21 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  
>  		strbuf_setlen(path, len);
>  		strbuf_addstr(path, e->d_name);
> -		if (lstat(path->buf, &st))
> -			; /* fall thru */
> -		else if (S_ISDIR(st.st_mode)) {
> +		if (lstat(path->buf, &st)) {
> +			if (errno == ENOENT)
> +				/*
> +				 * file disappeared, which is what we
> +				 * wanted anyway
> +				 */
> +				continue;
> +			/* fall thru */
> +		} else if (S_ISDIR(st.st_mode)) {
>  			if (!remove_dir_recurse(path, flag, &kept_down))
>  				continue; /* happy */
> -		} else if (!only_empty && !unlink(path->buf))
> +		} else if (!only_empty &&
> +			   (!unlink(path->buf) || errno == ENOENT)) {
>  			continue; /* happy, too */
> +		}
>  
>  		/* path too long, stat fails, or non-directory still exists */
>  		ret = -1;
> @@ -1512,7 +1522,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  
>  	strbuf_setlen(path, original_len);
>  	if (!ret && !keep_toplevel && !kept_down)
> -		ret = rmdir(path->buf);
> +		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
>  	else if (kept_up)
>  		/*
>  		 * report the uplevel that it is not an error that we
