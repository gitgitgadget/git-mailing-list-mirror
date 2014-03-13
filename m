From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] fsck.c: Rewrite fsck_commit() to use skip_prefix()
Date: Thu, 13 Mar 2014 12:14:00 -0700
Message-ID: <xmqq7g7xj4hz.fsf@gitster.dls.corp.google.com>
References: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
	<1394685951-9726-3-git-send-email-yshuiv7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:14:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOB58-0008HJ-UC
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 20:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbaCMTON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 15:14:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804AbaCMTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 15:14:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1AA174660;
	Thu, 13 Mar 2014 15:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUvKV6266ls7F0ycqx7Jijp9T7Q=; b=qgGS0n
	Cj0R/wouYiz78oV/QayTacMu2/NrQ90t8Y9w8PtOgBJUh8JdTqXovAx77fasYGnI
	sMGu82hDFUv7gQNvqME1xNCNIwl+TXoOeLuS7Cx2v7V8GzcgRTTnQ6uCoXQzRbge
	2VbdRJlkkXZTU3aGqonDR0gWlABzyshnSoPWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHjFWzzCTfKouFDv/+Jbo9HySOsAejeq
	NchsGi1bVzkWr0qu3IcqMxeMnMtpVytnsLClzcey5azgayeGQHbZsOycHEIsyIuW
	uPom9LB32+uOKRT6J6V27u0EvLdvApNPBUJ1BzBvVotwb+HHb1xXmE2JH7VL7g7M
	s1ZxZ8Mur1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99FD87465E;
	Thu, 13 Mar 2014 15:14:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD1A77463E;
	Thu, 13 Mar 2014 15:14:10 -0400 (EDT)
In-Reply-To: <1394685951-9726-3-git-send-email-yshuiv7@gmail.com> (Yuxuan
	Shui's message of "Thu, 13 Mar 2014 12:45:51 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A82F032A-AAE3-11E3-A766-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244047>

Yuxuan Shui <yshuiv7@gmail.com> writes:

> Currently we use memcmp() in fsck_commit() to check if buffer start
> with a certain prefix, and skip the prefix if it does. This is exactly
> what skip_prefix() does. And since skip_prefix() has a self-explaintory
> name, this could make the code more readable.
>
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> ---
>  fsck.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 7776660..7e6b829 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -281,7 +281,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
>  
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -	const char *buffer = commit->buffer;
> +	const char *buffer = commit->buffer, *tmp;
>  	unsigned char tree_sha1[20], sha1[20];
>  	struct commit_graft *graft;
>  	int parents = 0;
> @@ -290,15 +290,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>  	if (commit->date == ULONG_MAX)
>  		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
>  
> -	if (memcmp(buffer, "tree ", 5))
> +	buffer = skip_prefix(buffer, "tree ");
> +	if (buffer == NULL)

We encourage people to write this as:

	if (!buffer)

The same comment applies to other new lines in this patch.
