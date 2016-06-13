From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Don't free remote->name after fetch
Date: Mon, 13 Jun 2016 15:25:39 -0700
Message-ID: <xmqqbn34buak.fsf@gitster.mtv.corp.google.com>
References: <1465841837-31604-1-git-send-email-kmcguigan@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: kmcguigan@twopensource.com
X-From: git-owner@vger.kernel.org Tue Jun 14 00:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCaIm-0007sc-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423797AbcFMWZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:25:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423191AbcFMWZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:25:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 754C5249D0;
	Mon, 13 Jun 2016 18:25:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nvplgiQGsa9tW3RdrQF7RpzyElM=; b=iGPgQO
	6w5daL3/6dVlCn93lZiCTM/dtuKJY2QKzUgf7IvOS8THz5PAVCuTyV9acZvzw162
	GeGnX9S9j+bhPiPpv4eEnd+DXUIWmqID0efGCvSZayBbLPLEoe1gvvOIT5030mUf
	MEWOuWtUI7G5iIu+aEEJbGGzE9ivXrJLUM+XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UHDLJ08rzFxEBcJ02VpIu0Zyzc2mdfGU
	4Lg8CVc581xzW3m+O0YpVtGzv7/Zl4eYcmQhkKacxCAFwj7SBfEYg7Ng7dlkjhWT
	NIzbDR3St3Xj1ib7Kwekxl6k04GteOOjGnXeueIXJnICs2jV56tQMLGxustvF3ty
	dtGkzYeD4WM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BF20249CF;
	Mon, 13 Jun 2016 18:25:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6672249CD;
	Mon, 13 Jun 2016 18:25:40 -0400 (EDT)
In-Reply-To: <1465841837-31604-1-git-send-email-kmcguigan@twopensource.com>
	(kmcguigan@twopensource.com's message of "Mon, 13 Jun 2016 14:17:17
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2DDDD30-31B5-11E6-893A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297255>

kmcguigan@twopensource.com writes:

> From: Keith McGuigan <kmcguigan@twopensource.com>
>
> The string_list gets populated with the names from the remotes[] array,
> which are not dup'd and the list does not own.
>
> Signed-of-by: Keith McGuigan <kmcguigan@twopensource.com>
> ---

For names that come from remote_get()->name, e.g.

    static int get_one_remote_for_fetch(struct remote *remote, void *priv)
    {
            struct string_list *list = priv;
            if (!remote->skip_default_update)
                    string_list_append(list, remote->name);
            return 0;
    }

you are correct that this is borrowed memory we are not allowed to
free.  But is borrowing from remote->name the only way this list is
populated?  For example, what happens in add_remote_or_group(),
which does this?

    struct remote_group_data {
            const char *name;
            struct string_list *list;
    };

    static int get_remote_group(const char *key, const char *value, void *priv)
    {
            struct remote_group_data *g = priv;

            if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
                    /* split list by white space */
                    while (*value) {
                            size_t wordlen = strcspn(value, " \t\n");

                            if (wordlen >= 1)
                                    string_list_append(g->list,
                                                       xstrndup(value, wordlen));

This newly allocated piece of memory is held by g->list, which was...

                            value += wordlen + (value[wordlen] != '\0');
                    }
            }

            return 0;
    }

    static int add_remote_or_group(const char *name, struct string_list *list)
    {
            int prev_nr = list->nr;
            struct remote_group_data g;
            g.name = name; g.list = list;

... passed as a callback parameter from here.

            git_config(get_remote_group, &g);
            if (list->nr == prev_nr) {
                    struct remote *remote = remote_get(name);
                    if (!remote_is_configured(remote))
                            return 0;
                    string_list_append(list, remote->name);

This makes remote->name borrowed, which we cannot free() as you
point out.

            }
            return 1;
    }

So, while I agree that many should not be freed, this change makes
the code leak some at the same time.



>  builtin/fetch.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 630ae6a1bb78..181da5a2e7a3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		argv_array_clear(&options);
>  	}
>  
> -	/* All names were strdup()ed or strndup()ed */
> -	list.strdup_strings = 1;
>  	string_list_clear(&list, 0);
>  
>  	close_all_packs();
