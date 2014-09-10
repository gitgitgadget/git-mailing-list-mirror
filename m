From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] Make sure fsck_commit_buffer() does not run out of the buffer
Date: Wed, 10 Sep 2014 10:43:42 -0700
Message-ID: <xmqqlhprgylt.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101552560.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRlvq-0001zh-0T
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaIJRnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:43:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52342 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbaIJRno (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:43:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42EF837016;
	Wed, 10 Sep 2014 13:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4kP5K6bXNou4aQil0pPGVpM+cvQ=; b=BlRdVw
	US2wQkgpejXSocoL02aFtnjZuMpw6T7rP2Gj+eTs1ld0Iii+h+3evDf9gVhioqyQ
	T1mV0eF7SiLfg5QPQGewDNupLDk1wEIjBQFcXWXhLwRgcvsXoyVY9DaFNFk+19Y3
	ak/3fPRUQ2luurpCZBlMTSsrexd8zOPnL8nbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oA2ci+3WXhQyeBelduawLyI4UgiC7bF6
	zdBCzczTUI/nNZrSZGeQHun4wbgYdwE/aSRC3CXxabPa+2ET89RXdrHG5DrB8W3d
	evOKUbfX/YtLXBHgtZqikCMgNP+MxvLeOG7v2H7KC6FzgPxJ3bl95yToQRv1Phtg
	dgqK9xOoB94=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3785A37014;
	Wed, 10 Sep 2014 13:43:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B537537012;
	Wed, 10 Sep 2014 13:43:43 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409101552560.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 10 Sep 2014 15:52:58 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 023A2A68-3912-11E4-AA6B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256757>

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
>  fsck.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/fsck.c b/fsck.c
> index dd77628..9dd7d12 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -237,6 +237,26 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  	return retval;
>  }
>  
> +static int require_end_of_header(const void *data, unsigned long size,
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

Isn't this "invalid header"?  After all we haven't escaped this loop
and haven't seen the message part of the commit object (and it is
the same if you are going to later reuse this for tag objects).

> +		case '\n':
> +			if (i + 1 < size && buffer[i + 1] == '\n')
> +				return 0;
> +		}
> +	}
> +
> +	return error_func(obj, FSCK_ERROR, "invalid buffer: missing empty line");

I think you meant "missing end of header" here.

Other than these small nits, the patch looks good from a cursory
read.

> +}
> +
>  static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
>  {
>  	char *end;
> @@ -284,6 +304,9 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  	unsigned parent_count, parent_line_count = 0;
>  	int err;
>  
> +	if (require_end_of_header(buffer, size, &commit->object, error_func))
> +		return -1;
> +
>  	if (!skip_prefix(buffer, "tree ", &buffer))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>  	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
