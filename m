From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/16] pack-objects: use bitmaps when packing objects
Date: Tue, 25 Jun 2013 16:06:24 -0700
Message-ID: <7v7ghhzt73.fsf@alter.siamese.dyndns.org>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-11-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:06:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcJj-0001JZ-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab3FYXG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:06:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab3FYXG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:06:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 821122B2FA;
	Tue, 25 Jun 2013 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ghEcOx5ggZ4HuDCA4Hkrw73qu4A=; b=UueArE
	a9ngYHmUz/vPQF8lBmHGhNMfatE24eBCFOeKXyJoHrKZPP2OhyeRNlSNM4O2zGFA
	YhgSxBWD0WV8LobWasChPj/JUcY7Hy/GfU+px5ZcuOmf7kgJPGx7TOymREwrAb4t
	KgHJy4l0Rfh0aKGM5schxzVKZBz5u2TWX/sLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZEc0Xe9choHBc8qAzMNtQBYnr/3lTB5U
	T4yWIYkEjDLdg4aCXZIol7vgIKNnh6EIZRrRiMguvG+ZHIo9LXzrTY+VpY5PCjVy
	8wvMxsnoIZbIJfEaKMBPJzMa+zIVAdRlmF9lAGiEwOi303gdRmaiLzBxcIC9AAj2
	boHkllUM3FE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78B1D2B2F9;
	Tue, 25 Jun 2013 23:06:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5A92B2F6;
	Tue, 25 Jun 2013 23:06:25 +0000 (UTC)
In-Reply-To: <1372116193-32762-11-git-send-email-tanoku@gmail.com> (Vicent
	Marti's message of "Tue, 25 Jun 2013 01:23:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC599626-DDEB-11E2-878A-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229014>

Vicent Marti <tanoku@gmail.com> writes:

> @@ -83,6 +84,9 @@ static struct progress *progress_state;
>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  static int pack_compression_seen;
>  
> +static int bitmap_support;
> +static int use_bitmap_index;

OK.

> @@ -2131,6 +2135,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  		cache_max_small_delta_size = git_config_int(k, v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "pack.usebitmaps")) {
> +		bitmap_support = git_config_bool(k, v);
> +		return 0;
> +	}

Hmph, so bitmap_support, not use_bitmap_index, keeps track of the
user request?  Somewhat confusing.

>  	if (!strcmp(k, "pack.threads")) {
>  		delta_search_threads = git_config_int(k, v);
>  		if (delta_search_threads < 0)
> @@ -2366,8 +2374,24 @@ static void get_object_list(int ac, const char **av)
>  			die("bad revision '%s'", line);
>  	}
>  
> +	if (use_bitmap_index) {
> +		uint32_t size_hint;
> +
> +		if (!prepare_bitmap_walk(&revs, &size_hint)) {
> +			khint_t new_hash_size = (size_hint * (1.0 / __ac_HASH_UPPER)) + 0.5;

What is __ac_HASH_UPPER?  That is a very unusual name for a variable
or a constant.  Also it is mildly annoying to see unnecessary use of
float like this.

> +			kh_resize_sha1(packed_objects, new_hash_size);
> +
> +			nr_alloc = (size_hint + 63) & ~63;
> +			objects = xrealloc(objects, nr_alloc * sizeof(struct object_entry *));
> +
> +			traverse_bitmap_commit_list(&add_object_entry_1);
> +			return;
> +		}
> +	}
> +
>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");
> +
>  	mark_edges_uninteresting(revs.commits, &revs, show_edge);
>  	traverse_commit_list(&revs, show_commit, show_object, NULL);
>  
> @@ -2495,6 +2519,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			    N_("pack compression level")),
>  		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
>  			    N_("do not hide commits by grafts"), 0),
> +		OPT_BOOL(0, "bitmaps", &bitmap_support,
> +			 N_("enable support for bitmap optimizations")),

Please match this with the name of configuration variable, i.e. --use-bitmaps

>  		OPT_END(),
>  	};
>  
> @@ -2561,6 +2587,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (keep_unreachable && unpack_unreachable)
>  		die("--keep-unreachable and --unpack-unreachable are incompatible.");
>  
> +	if (bitmap_support) {
> +		if (use_internal_rev_list && pack_to_stdout)
> +			use_bitmap_index = 1;

OK, so only when some internal condition is met, the user request to
use bitmap is honored and the deision is kept in use_bitmap_index.

It may be easier to read if you get rid of bitmap_support, set
user_bitmap_index directly from the command line and config, and did
this here instead:

	if (!(use_internal_rev_list && pack_to_stdout))
		use_bitmap_index = 0;
