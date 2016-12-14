Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3A41FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 19:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbcLNTBt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 14:01:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753877AbcLNTBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 14:01:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75CE85430B;
        Wed, 14 Dec 2016 13:55:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wjtlc7tDxflzVZe8Zuq2J+cvj28=; b=D97zOi
        2A080TwyfNHqYpt/LMb+9GfqX3cJ7DmJgjdDAL/Szk8FdvXvmEMq6Fp3Xxxunqi/
        6nKzPujbD9UPKfd0HPpZXwltpBHl5+OMnJbkpZIubmyE4oX5ZKhgbkIy0vjjXzwC
        wAu6xz3C5h+BGizAa4gT5o2NB/bpFFyWQmG3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MjbMSCkWWSjUNpc9cOw8/2ALg2r3u6Lz
        7B0JzyPPoDOhXPug8gU+sphayaeDeWZsmfbDOUGWE/UMO2VzDWOyCuHzWkmEdwhu
        pNqNhoKUs7QHvsK7NOdiILHgL5Hwl/Bx8MGAClkpbB/Pf5Rc+YozZXNpbEbgToe6
        2Kgi6zivuLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B23D5430A;
        Wed, 14 Dec 2016 13:55:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D522D54309;
        Wed, 14 Dec 2016 13:55:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv2 5/5] rm: add absorb a submodules git dir before deletion
References: <20161213205622.841-1-sbeller@google.com>
        <20161213205622.841-6-sbeller@google.com>
Date:   Wed, 14 Dec 2016 10:55:15 -0800
In-Reply-To: <20161213205622.841-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 13 Dec 2016 12:56:22 -0800")
Message-ID: <xmqq7f72xrvw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA58F6DE-C22E-11E6-8DEF-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/rm.c b/builtin/rm.c
> index fdd7183f61..8c9c535a88 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -392,28 +392,14 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  		for (i = 0; i < list.nr; i++) {
>  			const char *path = list.entry[i].name;
>  			if (list.entry[i].is_submodule) {
> -				if (is_empty_dir(path)) {
> -					if (!rmdir(path)) {
> -						removed = 1;
> -						if (!remove_path_from_gitmodules(path))
> -							gitmodules_modified = 1;
> -						continue;
> -					}
> -				} else {
> -					strbuf_reset(&buf);
> -					strbuf_addstr(&buf, path);
> -					if (!remove_dir_recursively(&buf, 0)) {
> -						removed = 1;
> -						if (!remove_path_from_gitmodules(path))
> -							gitmodules_modified = 1;
> -						strbuf_release(&buf);
> -						continue;
> -					} else if (!file_exists(path))
> -						/* Submodule was removed by user */
> -						if (!remove_path_from_gitmodules(path))
> -							gitmodules_modified = 1;
> -					/* Fallthrough and let remove_path() fail. */
> -				}
> +				if (is_empty_dir(path) && rmdir(path))
> +					die_errno("git rm: '%s'", path);
> +				if (file_exists(path))
> +					depopulate_submodule(path);
> +				removed = 1;
> +				if (!remove_path_from_gitmodules(path))
> +					gitmodules_modified = 1;
> +				continue;

The updated code structure is somewhat nicer for understanding the
flow than the original, but it can further be improved.

A step "If empty directory, we try to rmdir and we check its return
status and die ourselves if we couldn't remove it" reads very
sensible, but coming immediately after that, "if it still exists,
call depop()" looks a bit strange.  I would have expected a similar
construct, i.e.

	if (directory_exists(path) && depop_submodlue(path))
		die("git rm: '%s' submodule still populated", path);

there.  Also,

	if (is_empty_dir(path)) {
		if (rmdir(path))
			die_errno(...);
	} else if (is_nonempty_dir(path)) {
		if (depop_subm(path))
                	die(...);
	}

would have clarified the structure even further.

Yes, I know that you made depop_subm() to die on error, and the
above is questioning if that is a sensible design choice.
