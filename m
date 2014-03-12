From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] fsck.c: Rewrite fsck_commit() to use skip_prefix()
Date: Wed, 12 Mar 2014 12:47:04 -0700
Message-ID: <xmqqeh27kxmv.fsf@gitster.dls.corp.google.com>
References: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
	<1394650290-3750-3-git-send-email-yshuiv7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNp7T-00083g-9o
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbaCLTrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:47:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbaCLTrH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4577E7311C;
	Wed, 12 Mar 2014 15:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rd8PC/Y8wbpbC7mw1MZQ3vbBWIg=; b=ZpRvWH
	bsA8QzQqrsD3HY0aa6219qKFkj3OXDq+tFVQzf9eLI6x5N7A4zoZhYPgHqHPMBx5
	GQHDXHDAO0UocN5/LaVCW6WSYjQ9CLna/hrGXCXpJY681cjI7+aD4d9Bg7FgmGwW
	ZLxv5i9OLyG+ZKB2Ydf2duTLHZh46AaDWrrCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TEw1/gb5lXy1w4Aheyh24c44G6ygW7UM
	lEoMNlPyArppea2bta65R9N7YQb262xxlIm2O/xerEJkg8+sVJkNMJ3Yc7y6QYps
	BzDwsYr8UexIroJ1HgmkGlD1e+hm8dhoLUZNHYQbqDowAJ01sUNvW/ZkAFMSNDDZ
	1ODj71zXGHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35FE67311B;
	Wed, 12 Mar 2014 15:47:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6685673118;
	Wed, 12 Mar 2014 15:47:06 -0400 (EDT)
In-Reply-To: <1394650290-3750-3-git-send-email-yshuiv7@gmail.com> (Yuxuan
	Shui's message of "Thu, 13 Mar 2014 02:51:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 17626716-AA1F-11E3-91FA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243972>

Yuxuan Shui <yshuiv7@gmail.com> writes:

> The purpose of skip_prefix() is much clearer than memcmp().  Also
> skip_prefix() takes one less argument and its return value makes
> more sense.

Instead of justifying the change with a subjective-sounding and
vague "much clearer" and "makes more sense", perhaps you can state
what the purpose is and why it makes more sense, no?  "We are using
memcmp() to see if the buffer starts with a known constant prefix
string and skip that prefix if it does so, skip_prefix() is a better
match" or something?

>
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> ---
>  fsck.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 1789c34..7e6b829 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -281,7 +281,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
>  
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -	char *buffer = commit->buffer;
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

if (!buffer)

>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
