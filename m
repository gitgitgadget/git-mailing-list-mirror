Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664FF1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 18:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755995AbdCGSoZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 13:44:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755781AbdCGSoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 13:44:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 774BE7C00E;
        Tue,  7 Mar 2017 13:44:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EE3DwNFF6SClprDQjmqzGvkAuoA=; b=lyGQbV
        b6vxjMPzHwK/TZ9VqLwKw7BblgUCPZVweOM6PqonQoIVm2rjikAQnrDpCLx2/451
        yOaQLFzXDHlB152rqHUm8SDxg80fmDMjWoPWy7UlLWo7R4Yrqli5Fcp9Z5hriaVx
        pq8oWJcA5QBBccb40/bS+XHzLC7l5Z2BZQnko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BTV9HAGO7ulX1XN8Cb5nuJPbBqgWr0sj
        3PEGMbIwaJOG6W+/XR1YUVdWol//60jzgTGNpb1K3gaY6lbfh7y7hjiOa8159HWL
        evbvAX2PysaQEj5Iv0Fk7PfgTZZVrhoQ1EPvIOhIR8Sowe2DAZJNEFkTkjRAu3vR
        8ppLTSzeoJU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E8F37C00D;
        Tue,  7 Mar 2017 13:44:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C60807C00C;
        Tue,  7 Mar 2017 13:44:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [RFC PATCH] rev-parse: add --show-superproject-working-tree
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
        <20170307034553.10770-1-sbeller@google.com>
Date:   Tue, 07 Mar 2017 10:44:09 -0800
In-Reply-To: <20170307034553.10770-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 6 Mar 2017 19:45:53 -0800")
Message-ID: <xmqq8toh7wqu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DAA7DB4-0366-11E7-A730-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +const char *get_superproject_working_tree()

const char *get_superproject_working_tree(void)

The same for the *.h file declaration.

> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!superproject_exists())
> +		return NULL;
> + ...
> +	return strbuf_detach(&sb, NULL);

Having reviewed it, I somehow think you do not want to have a
separate superproject_exists() that grabs some part of the
information this caller needs and then discards it.

The helper already does these things:

    - xgetcwd(), which may give you "/local/repo/super/sub/dir"

    - relative_path() with the result and "..", which may give you
      "dir"

    - ls-tree HEAD "dir" to see what is in "sub/dir" of the
      repository that governs ".."; if "sub/dir" is a gitlink,
      you know you started in a working tree of a repository
      different from the one that governs "..".

And the caller is trying to figure out where the root of the
superproject is, i.e. "/local/repo/super", and the helper has half
of the answer to that already.  If you ask the "ls-tree HEAD" (as I
said, I think it should be "ls-files") to give you not "dir" but
"sub/dir", you can subtract it from the result of xgetcwd() you did
at the beginning of the helper, and that gives what this caller of
the helper wants.

So perhaps your superproject_exists() helper can be eliminated and
instead coded in get_superproject_working_tree() in place to do:

	- xgetcwd() to get "/local/repo/super/sub/dir".

	- relative_path() to get "dir".

	- ask "ls-{tree,files} --full-name HEAD dir" to get "160000"
          and "sub/dir".

	- subtract "sub/dir" from the tail of the "/local/repo/super/sub/dir"
	  you got from xgetcwd() earlier.

	- return the result.

with a failure/unmet expectations (like not finding 160000) from any
step returning an error, or something like that.

