Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DCF1FF76
	for <e@80x24.org>; Tue, 27 Dec 2016 01:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755778AbcL0BLC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 20:11:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60078 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755730AbcL0BKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 20:10:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A93C0591A2;
        Mon, 26 Dec 2016 20:10:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2MKE3f8JtlCDyjC+NHFeJC0UhdA=; b=bjCEpS
        gQqLVqimgZNRezx3ya95D5XtDAw+rQIFPrcIqZTIZR8nmu2GzI28reco+6hvhszk
        quYtrmOjrX54aH2eRBkWpdqVlhq4Od48wYpB0h7Q7DyWePw5R2H4PoeTZ/ciqTIU
        NcVBNqM4ccJwz3KwQ/PIP7mCMRUg5T7Xyeqfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uP6uB+wsio8ERmIJcd0GTCXr/yPZBEaO
        j27ytqvgLz0wAGnzONrn6zXX2C2ceGmjffPWJFuNSeDIHB6L6zCIbQF6w9TQvLii
        U061lugXtipS9070qQsnT6LEEtgl2fJJug2pPMUDfZ+iJX7O9163FInMX8B5+dQo
        lEjBHXnKn+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96DBE591A1;
        Mon, 26 Dec 2016 20:10:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 092485919E;
        Mon, 26 Dec 2016 20:10:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org
Subject: Re: [PATCHv5 4/4] rm: absorb a submodules git dir before deletion
References: <20161220232012.15997-1-sbeller@google.com>
        <20161220232012.15997-5-sbeller@google.com>
Date:   Mon, 26 Dec 2016 17:10:49 -0800
In-Reply-To: <20161220232012.15997-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 20 Dec 2016 15:20:12 -0800")
Message-ID: <xmqqmvfich2e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EB6A516-CBD1-11E6-BA33-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -342,6 +313,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  			exit(0);
>  	}
>  
> +	submodules_absorb_gitdir_if_needed(prefix);
> +
>  	/*
>  	 * If not forced, the file, the index and the HEAD (if exists)
>  	 * must match; but the file can already been removed, since
> @@ -358,9 +331,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  			oidclr(&oid);
>  		if (check_local_mod(&oid, index_only))
>  			exit(1);
> -	} else if (!index_only) {
> -		if (check_submodules_use_gitfiles())
> -			exit(1);
>  	}
>  

Hmph.  It may be a bit strange to see an "index-only" remove to
touch working tree, no?  Yet submodules_absorb_gitdir_if_needed() is
unconditionally called above, which feels somewhat unexpected. 

> @@ -389,32 +359,20 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  	 */
>  	if (!index_only) {
>  		int removed = 0, gitmodules_modified = 0;
>  		for (i = 0; i < list.nr; i++) {
>  			const char *path = list.entry[i].name;
>  			if (list.entry[i].is_submodule) {
> +				struct strbuf buf = STRBUF_INIT;
> +
> +				strbuf_addstr(&buf, path);
> +				if (remove_dir_recursively(&buf, 0))
> +					die(_("could not remove '%s'"), path);
> +				strbuf_release(&buf);
> +
> +				removed = 1;
> +				if (!remove_path_from_gitmodules(path))
> +					gitmodules_modified = 1;
> +				continue;
>  			}

I do not see any behaviour change from the original (not quoted
here), but it is somewhat surprising that "git rm ./submodule" does
not really check if the submodule has local modifications and files
that are not even added before remove_dir_recursively() is called.

Or perhaps I am reading the code incorrectly and such a check is
done elsewhere?
