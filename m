From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] path.c: allocate enough memory for string
Date: Tue, 29 Mar 2016 17:56:56 -0700
Message-ID: <xmqq7fgkvl47.fsf@gitster.mtv.corp.google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:57:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4RV-0001wI-4W
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbcC3A5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:57:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751128AbcC3A47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:56:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07F105021A;
	Tue, 29 Mar 2016 20:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6gXE5wRUcEe+tNHjXMX1UymsAFU=; b=gD9Uh/
	Xo51LkOVzQ6whhnjgfAI35EeUPbzGB4wISFkHSjRqJnSVwpAT9u3CB7ayTTm2NPL
	BnaQTSv4Ev0lzY+FkvPoWHhbJIcR/0gaj+bdqKWorDAxHutcvkzaQcReU/5+bLX5
	Rb8yyvWGtGm/FbLoT0PRlz9W8dCDYYO/VNk50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OoUomJn+FNLnKTNCmGYorIS4NCNzJkns
	7S5mmbLu0koVjVaHMhcIkxtTKg8hBJ/jbhg2gDT5nwcQkOeMjsDds7+G7RqPn/9c
	HlIWNafunLfRlPvU8WdlJlrlOXLrLDh1YXu6Rt6kZSaT3E8BOHjvleqQMDfKTGoG
	LUJeQKmiR/E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F259C50219;
	Tue, 29 Mar 2016 20:56:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 76C1F50217;
	Tue, 29 Mar 2016 20:56:57 -0400 (EDT)
In-Reply-To: <1459298333-21899-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 29 Mar 2016 17:38:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4D840D22-F612-11E5-B38C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290240>

Stefan Beller <sbeller@google.com> writes:

> `strlen` returns the length of a string without the terminating null byte.
> To make sure enough memory is allocated we need to pass `strlen(..) + 1`
> to the allocation function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/path.c b/path.c
> index 969b494..0ae8af5 100644
> --- a/path.c
> +++ b/path.c
> @@ -155,7 +155,7 @@ static struct trie *make_trie_node(const char *key, void *value)
>  	struct trie *new_node = xcalloc(1, sizeof(*new_node));
>  	new_node->len = strlen(key);
>  	if (new_node->len) {
> -		new_node->contents = xmalloc(new_node->len);
> +		new_node->contents = xmalloc(new_node->len + 1);
>  		memcpy(new_node->contents, key, new_node->len);
>  	}

This structure looks like a counted string <len,ptr> that does not
want to have a terminating NUL after the contents, judging from the
way memcpy() copies only len and not len+1.

Did I write this (wondering why this was addressed to me)?

>  	new_node->value = value;
