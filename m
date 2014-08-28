From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Make sure fsck_commit_buffer() does not run out of the buffer
Date: Thu, 28 Aug 2014 13:59:50 -0700
Message-ID: <xmqqr4008h4p.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646450.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:00:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN6nn-0004X1-0s
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 23:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbaH1VAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 17:00:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55761 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaH1VAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 17:00:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1452536B58;
	Thu, 28 Aug 2014 17:00:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2JUNieZjPfiAEXhLpkuXu17mPms=; b=Chl8f7
	SQ6+z0cMevTNgnLtprk94dA9ZfpC5uOsbDOV1zNGRXPXkYpgs8QKdRu2YCZngnxw
	4VE73+F6Ssf4+c5USZfSQ9SZiVi1V2kylMcrNzLj9j2PzzZF1WDUePsJrpGr5aOH
	nE1vHCLOEM1M7vA7+rtQQ1brUc2JDAPdxOfHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCGx8PyZPCg7RwT8gYJ8z1/VH/FGQxzc
	9vFjrnj4peuQooJDikVa0VPEzaS/hM92kq24hZObTbRLIQ/SeFIjhK2a7dE+xevR
	9q/YzFFbXnHttoXHaqTvbIQWRfQCaZ5cQcJp6N86ztbyvKFzXIjvoho4jv/q3eNH
	zns50+KA6Ck=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B43D636B54;
	Thu, 28 Aug 2014 17:00:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4134036B46;
	Thu, 28 Aug 2014 16:59:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1408281646450.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 28 Aug 2014 16:46:49 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4171C7B6-2EF6-11E4-9827-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256124>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> So far, we assumed that the buffer is NUL terminated, but this is not
> a safe assumption, now that we opened the fsck_object() API to pass a
> buffer directly.
>
> So let's make sure that there is at least an empty line in the buffer.
> That way, our checks would fail if the empty line was encountered
> prematurely, and consequently we can get away with the current string
> comparisons even with non-NUL-terminated buffers are passed to
> fsck_object().
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Heh, I probably should have read this one before commenting on 2/6.

It makes me feel somewhat uneasy to insist that there must be a
blank line in the commit object, even though from the very first
implementation of "commit-tree" I think we have always had a blank
there at the end of the header, even when you feed nothing as the
message to it.

I think the new check is OK, but the message should be s/empty
line/end of header/ or something.  It is not like we require an
empty line in the log message proper.

>  fsck.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/fsck.c b/fsck.c
> index dd77628..db6aaa4 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -237,6 +237,26 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  	return retval;
>  }
>  
> +static int must_have_empty_line(const void *data, unsigned long size,
> +	struct object *obj, fsck_error error_func)
> +{
> +	const char *buffer = (const char *)data;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		switch (buffer[i]) {
> +		case '\0':
> +			return error_func(obj, FSCK_ERROR,
> +				"invalid message: NUL at offset %d", i);
> +		case '\n':
> +			if (i + 1 < size && buffer[i + 1] == '\n')
> +				return 0;
> +		}
> +	}
> +
> +	return error_func(obj, FSCK_ERROR, "invalid buffer: missing empty line");
> +}
> +
>  static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
>  {
>  	char *end;
> @@ -284,6 +304,9 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  	unsigned parent_count, parent_line_count = 0;
>  	int err;
>  
> +	if (must_have_empty_line(buffer, size, &commit->object, error_func))
> +		return -1;
> +
>  	if (!skip_prefix(buffer, "tree ", &buffer))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>  	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
