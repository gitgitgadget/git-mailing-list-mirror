Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E151FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 20:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756217AbdCGUeD (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:34:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64966 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756115AbdCGUeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:34:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A61B97F2C1;
        Tue,  7 Mar 2017 15:33:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UQRjHbZbkwb617WXDge0IWIbtaE=; b=F1Jrgh
        /4q50Sbhex+QKaRmrUGfYnPv7XmUBGA9DY0cMFqJbEeo/0HobGxuCjk3l7ScMZ0V
        DhOYenNPc1uMmoGB4KWw9SN0tPe7vyBq4z0Pd2KX9fD/+gEcJK0+QV7aN4K3/+j+
        FPrft5dx/H/E4vI6Yt+xSBqs5qk/l1mNfFwvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mQsiZBqCAh17YaFPsQClJfoXL9cA6iXA
        3pZf6itL9e8wu/WKrLNyze4xhF9Utpj8KdCFZZLJT8Yivf7GPOkXWKZ0CIi3WLLP
        iX5xu0sgc+sdNLHmVJaK9+sX4exKyfmcFTPouT34sRUAjOstQy4sX5R+QFRjlMts
        3lZxT/68G3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F8037F2C0;
        Tue,  7 Mar 2017 15:33:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A3287F2BF;
        Tue,  7 Mar 2017 15:33:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Melvin <jmelvin@codeaurora.org>
Cc:     git@vger.kernel.org, nasserg@codeaurora.org, mfick@codeaurora.org,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH] repack: Add options to preserve and prune old pack files
References: <20170307164035.27866-1-jmelvin@codeaurora.org>
Date:   Tue, 07 Mar 2017 12:33:42 -0800
In-Reply-To: <20170307164035.27866-1-jmelvin@codeaurora.org> (James Melvin's
        message of "Tue, 7 Mar 2017 09:40:35 -0700")
Message-ID: <xmqq4lz4968p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B939718-0375-11E7-9160-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Melvin <jmelvin@codeaurora.org> writes:

> These options are designed to prevent stale file handle exceptions
> during git operations which can happen on users of NFS repos when
> repacking is done on them. The strategy is to preserve old pack files
> around until the next repack with the hopes that they will become
> unreferenced by then and not cause any exceptions to running processes
> when they are finally deleted (pruned).

I find it a very sensible strategy to work around NFS, but it does
not explain why the directory the old ones are moved to need to be
configurable.  It feels to me that a boolean that causes the old
ones renamed s/^pack-/^old-&/ in the same directory (instead of
pruning them right away) would risk less chances of mistakes (e.g.
making "preserved" subdirectory on a separate device mounted there
in a hope to reduce disk usage of the primary repository, which
may defeat the whole point of moving the still-active file around
instead of removing them).

And if we make "preserve-old" a boolean, perhaps the presence of
"prune-preserved" would serve as a substitute for it, iow, perhaps
we may only need --prune-preserved option (and repack.prunePreserved
configuration variable)?

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 677bc7c81..f1a0c97f3 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -10,8 +10,10 @@
>  
>  static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
> +static int preserve_oldpacks = 0;
> +static int prune_preserved = 0;

We avoid initializing statics to 0 or NULL and instead let BSS take
care of them...

>  static int write_bitmaps;
> -static char *packdir, *packtmp;
> +static char *packdir, *packtmp, *preservedir;

... just like what you did here.

> @@ -108,6 +110,27 @@ static void get_non_kept_pack_filenames(struct s
> ...
> +static void preserve_pack(const char *file_path, const char *file_name,  const char *file_ext)
> +{
> +	char *fname_old;
> +
> +	if (mkdir(preservedir, 0700) && errno != EEXIST)
> +		error(_("failed to create preserve directory"));

You do not want to do the rest of this function after issuing this
error, no?  Because ...

> +
> +	fname_old = mkpathdup("%s/%s.old-%s", preservedir, file_name, ++file_ext);
> +	rename(file_path, fname_old);

... this rename(2) would fail, whose error return you would catch
and act on.

> +	free(fname_old);
> +}
> +
> +static void remove_preserved_dir(void) {
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addstr(&buf, preservedir);
> +	remove_dir_recursively(&buf, 0);

This is a wrong helper function to use on files and directories
inside .git/; the function is about removing paths in the working
tree.

> @@ -121,7 +144,10 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
>  	for (i = 0; i < ARRAY_SIZE(exts); i++) {
>  		strbuf_setlen(&buf, plen);
>  		strbuf_addstr(&buf, exts[i]);
> -		unlink(buf.buf);
> +		if (preserve_oldpacks)
> +			preserve_pack(buf.buf, base_name, exts[i]);
> +		else
> +			unlink(buf.buf);

OK.

> @@ -194,6 +220,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				N_("maximum size of each packfile")),
>  		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
>  				N_("repack objects in packs marked with .keep")),
> +		OPT_BOOL(0, "preserve-oldpacks", &preserve_oldpacks,
> +				N_("move old pack files into the preserved subdirectory")),
> +		OPT_BOOL(0, "prune-preserved", &prune_preserved,
> +				N_("prune old pack files from the preserved subdirectory after repacking")),
>  		OPT_END()
>  	};
>  
> @@ -217,6 +247,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	packdir = mkpathdup("%s/pack", get_object_directory());
>  	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
> +	preservedir = mkpathdup("%s/preserved", packdir);
>  
>  	sigchain_push_common(remove_pack_on_signal);
>  
> @@ -404,6 +435,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	/* End of pack replacement. */
>  
> +	if (prune_preserved)
> +		remove_preserved_dir();

I am not sure if I understand your design.  Your model looks to me
like there are two modes of operation.  #1 uses "--preserve-old" and
sends old ones to purgatory instead of removing them and #2 uses
"--prune-preserved" to remove all the ones in the purgatory
immediately.  A few things that come to my mind immediately:

 * When "--prune-preseved" is used, it removes both ancient ones and
   more recent ones indiscriminately.  Would it make more sense to
   "expire" only the older ones while keeping the more recent ones?

 * It appears that the main reason you would want --prune-preserved
   in this design is after running with "--preserve-old" number of
   times, you want to remove really old ones that have accumulated,
   and I would imagine that at that point of time, you are only
   interested in repack, but the code structure tells me that this
   will force the users to first run a repack before pruning.

I suspect that a design that is simpler to explain to the users may
be to add a command line option "--preserve-pruned=<expiration>" and
a matching configuration variable repack.preservePruned, which
defaults to "immediate" (i.e. no preserving), and

 - When the value of preserve_pruned is not "immediate", use
   preserve_pack() instead of unlink();

 - At the end, find preserved packs that are older than the value in
   preserve_pruned and unlink() them.

It also may make sense to add another command line option
"--prune-preserved-packs-only" (without matching configuration
variable) that _ONLY_ does the "find older preserved packs and
unlink them" part, without doing any repack.
