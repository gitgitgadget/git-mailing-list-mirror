From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE;
 it may be the user's cwd
Date: Thu, 15 Mar 2012 00:16:08 -0700
Message-ID: <7v7gyml4g7.fsf@alter.siamese.dyndns.org>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
 <1331769333-13890-1-git-send-email-johan@herland.net>
 <7vipi6l52w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 08:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S84v3-0003IP-9B
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 08:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab2COHQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 03:16:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab2COHQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 03:16:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A51374A35;
	Thu, 15 Mar 2012 03:16:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=emzIII7OIESBhd46Ayaaun7UkHk=; b=v0uqtO
	RcxajTU/npwXnc5LhippvKcWB63Hm9x0zBHPiY4ZU8pkwf7KwdSzVWMS0gxDFWgY
	R5tvb9BAPf7Zk0Eo1GNa+m9OO7nJFb/VgDNSdyKb0LwJfLvQsx7qOy33asDhQVn7
	fzeGWh1brlHHR9i7hIcHijlulxLPMJgbHnp7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qhcbR+56Jp7ZhouZPu88t7vNtpzKE2Tk
	pgqhk/0+Grh0VjI7pc6ovcSGbPismW14/TT/HeNyCEdIXV6j+zE7AAh1UhWFiYbt
	PV2n7HH+t1M2vRmP0YEIbWl46L6Q7CH1HUr6lZXZse8V7lmdyZJc7hBzKaZMgp8H
	V5xGxX/DjoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CFFB4A34;
	Thu, 15 Mar 2012 03:16:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B0584A33; Thu, 15 Mar 2012
 03:16:10 -0400 (EDT)
In-Reply-To: <7vipi6l52w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Mar 2012 00:02:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD758186-6E6E-11E1-AD8D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193191>

Junio C Hamano <gitster@pobox.com> writes:

> Johan Herland <johan@herland.net> writes:
>
>> I'm torn about the new remove_everything_inside_dir(). Obviously it's a
>> copy-paste-modify of dir.c:remove_dir_recursively(), and could instead be
>> implemented by adding an extra flag to remove_dir_recursively(). However,
>> adding a "#define REMOVE_DIR_CONTENTS_BUT_NOT_DIR_ITSELF 04" seemed even
>> uglier to me...
>
> Hmm, what ugliness am I missing when viewing the attached patch?  It looks
> simple and straightforward enough, at least to me.
>
>  dir.c |   14 ++++++++++----
>  dir.h |    1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 0a78d00..6432728 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1178,6 +1178,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>  	struct dirent *e;
>  	int ret = 0, original_len = path->len, len;
>  	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
> +	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
>  	unsigned char submodule_head[20];
>  
>  	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
> @@ -1185,9 +1186,14 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>  		/* Do not descend and nuke a nested git work tree. */
>  		return 0;
>  
> +	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;

Nit. This needs to drop REMOVE_DIR_KEEP_NESTED_GIT as well in order to
preserve the current behaviour.

I actually suspect that the passing of "only_empty" in the original may be
a bug in a0f4afb (clean: require double -f options to nuke nested git
repository and work tree, 2009-06-30), and this patch might be a fix to
the bug, but I didn't think things through, and it is getting late, so...

>  	dir = opendir(path->buf);
> -	if (!dir)
> -		return rmdir(path->buf);
> +	if (!dir) {
> +		if (!keep_toplevel)
> +			return rmdir(path->buf);
> +		else
> +			return -1;
> +	}
>  	if (path->buf[original_len - 1] != '/')
>  		strbuf_addch(path, '/');
>  
> @@ -1202,7 +1208,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>  		if (lstat(path->buf, &st))
>  			; /* fall thru */
>  		else if (S_ISDIR(st.st_mode)) {
> -			if (!remove_dir_recursively(path, only_empty))
> +			if (!remove_dir_recursively(path, flag))
>  				continue; /* happy */
>  		} else if (!only_empty && !unlink(path->buf))
>  			continue; /* happy, too */
