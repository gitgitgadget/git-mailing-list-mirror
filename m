From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] open_sha1_file: report "most interesting" errno
Date: Thu, 15 May 2014 10:02:06 -0700
Message-ID: <xmqqbnuzgelt.fsf@gitster.dls.corp.google.com>
References: <20140515085405.GA27033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 15 19:02:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkz32-00058k-RG
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbaEORCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:02:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62062 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbaEORCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:02:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48AE716537;
	Thu, 15 May 2014 13:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MwT/CN8lwz/gU6N6dlR0kNRd6rk=; b=aSlnl/
	5b/aNyhuz2G8Zq96pdwXwqpg4LkdX1vALnfYLIoWvHnsUObomzOxTYBvd7bJpTpH
	LmF9soPf+xlT8byH6FW9wPF1xMhhh7JNWHTfc8s1nhy1/tYxtWKxiIPFNQGj/Oet
	n2xmb4LuYGhdn0C//13ykBAaVzNMdPZiQhDpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Beeakcn47r6KqH/lmYMyptd1CdB1mSDN
	5HwVt2p8H2xCjXgl0i4i0ESAl9lEirurTLzjQqkGsJyp5MLtamwkfRYWvJvHgNn8
	b8mUgoMRoPjPYBiB7Li/3dcb1xUMmHj6HqX0KQQH5bWXkjZlIfuk2aZZuYWyvgs9
	9sZC/xtNGk8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3ABD416535;
	Thu, 15 May 2014 13:02:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 526451651A;
	Thu, 15 May 2014 13:02:09 -0400 (EDT)
In-Reply-To: <20140515085405.GA27033@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 15 May 2014 04:54:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A6B44528-DC52-11E3-A160-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249118>

Jeff King <peff@peff.net> writes:

> When we try to open a loose object file, we first attempt to
> open in the local object database, and then try any
> alternates. This means that the errno value when we return
> will be from the last place we looked (and due to the way
> the code is structured, simply ENOENT if we do not have have
> any alternates).
>
> This can cause confusing error messages, as read_sha1_file
> checks for ENOENT when reporting a missing object. If errno
> is something else, we report that. If it is ENOENT, but
> has_loose_object reports that we have it, then we claim the
> object is corrupted. For example:
>
>     $ chmod 0 .git/objects/??/*
>     $ git rev-list --all
>     fatal: loose object b2d6fab18b92d49eac46dc3c5a0bcafabda20131 (stored in .git/objects/b2/d6fab18b92d49eac46dc3c5a0bcafabda20131) is corrupt

Hmmmmmmmm.  So we keep track of a more interesting errno we get from
some other place than what we get for this local loose object, and
we no longer give this message pointing at the local loose
object---is that the idea?

What I am wondering is that this report we give in the new code

>     $ git rev-list --all
>     fatal: failed to read object b2d6fab18b92d49eac46dc3c5a0bcafabda20131: Permission denied

may want to say which of the various possible places we saw this
most interesting errno, which I think was the original motivation
came from e8b15e61 (sha1_file: Show the the type and path to corrupt
objects, 2010-06-10) that added "(stored in ...)".

But that may involve a larger surgery, and I definitely do not want
to add unnecessary logic in the common-case codepath to keep track
of pieces of information that are only used in the error codepath,
so it smells like that this is the best fix to the issue the commit
message describes.

Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 3e9f55f..34d527f 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1437,19 +1437,23 @@ static int open_sha1_file(const unsigned char *sha1)
>  {
>  	int fd;
>  	struct alternate_object_database *alt;
> +	int most_interesting_errno;
>  
>  	fd = git_open_noatime(sha1_file_name(sha1));
>  	if (fd >= 0)
>  		return fd;
> +	most_interesting_errno = errno;
>  
>  	prepare_alt_odb();
> -	errno = ENOENT;
>  	for (alt = alt_odb_list; alt; alt = alt->next) {
>  		fill_sha1_path(alt->name, sha1);
>  		fd = git_open_noatime(alt->base);
>  		if (fd >= 0)
>  			return fd;
> +		if (most_interesting_errno == ENOENT)
> +			most_interesting_errno = errno;
>  	}
> +	errno = most_interesting_errno;
>  	return -1;
>  }
