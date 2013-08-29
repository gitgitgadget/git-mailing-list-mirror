From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 0/2] Rewriting repack in C
Date: Thu, 29 Aug 2013 13:53:06 -0700
Message-ID: <xmqqob8g2p8t.fsf@gitster.dls.corp.google.com>
References: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 22:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9DP-0000f2-5Y
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 22:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936Ab3H2UxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 16:53:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756281Ab3H2UxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 16:53:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B665E3DE51;
	Thu, 29 Aug 2013 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sJOqeAPgxqllOHkbdncWdywsO1w=; b=GZODGW
	SOJ7qTYIAbolC3M4TIIimK100rWVCvHDgwXnHsAEkbMAMVAOa8W5I1LgmFb8Dt3m
	aI2V9WeV4zt5dTwHI/Uj638DfZDGx4yk4ns0PUHG43EHb5tCcLfXHfONgo/zxZhD
	z7C9Kl/g8BWiQ8tKdk0LtvJVV0tiIC6fhbm1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RtpC48Qz13VIHPvnO7q8gR7M8rARw13Z
	CwbU4RT11D/aqOLAE6b4R24q81+L2tqa+HW98gCcDFghlQKnPj7xqt1oLDm3UGTj
	c8s62UmPZ4Gi/H/i6+We3Or1g7/yCt4gVbKmlG1TanRvn5ThpqAL6rbOlo9ymWe9
	GXlGASts4xE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8F33DE50;
	Thu, 29 Aug 2013 20:53:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06C953DE4E;
	Thu, 29 Aug 2013 20:53:07 +0000 (UTC)
In-Reply-To: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 29 Aug 2013 22:39:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0222D258-10ED-11E3-AA88-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233359>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Here is a diff since the last time sending this patch series:

This is very readable.

There may be people who misread "LOOSE" as "LOSE"; the option -A is 
about making the unreachable ones loose so that they can be expired,
so let's rename it LOOSEN_UNREACHABLE to avoid confusion.

Thanks.

>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 0ace2a3..0cc823d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -41,10 +41,10 @@ static void remove_temporary_files(void)
>  
>  	strbuf_addstr(&buf, packdir);
>  
> -	/* dirlen holds the length of the path before the file name */
> +	/* Point at the slash at the end of ".../objects/pack/" */
>  	dirlen = buf.len + 1;
>  	strbuf_addf(&buf, "%s", packtmp);
> -	/* prefixlen holds the length of the prefix */
> +	/* Point at the dash at the end of ".../.tmp-%d-pack-" */
>  	prefixlen = buf.len - dirlen;
>  
>  	while ((e = readdir(dir))) {
> @@ -109,9 +109,12 @@ static void remove_redundant_pack(const char *path_prefix, const char *hex)
>  	}
>  }
>  
> +#define ALL_INTO_ONE 1
> +#define LOOSE_UNREACHABLE 2
> +
>  int cmd_repack(int argc, const char **argv, const char *prefix)
>  {
> -	const char *exts[2] = {".idx", ".pack"};
> +	const char *exts[2] = {".pack", ".idx"};
>  	struct child_process cmd;
>  	struct string_list_item *item;
>  	struct argv_array cmd_args = ARGV_ARRAY_INIT;
> @@ -124,7 +127,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	/* variables to be filled by option parsing */
>  	int pack_everything = 0;
> -	int pack_everything_but_loose = 0;
>  	int delete_redundant = 0;
>  	char *unpack_unreachable = NULL;
>  	int window = 0, window_memory = 0;
> @@ -136,10 +138,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	int local = 0;
>  
>  	struct option builtin_repack_options[] = {
> -		OPT_BOOL('a', NULL, &pack_everything,
> -				N_("pack everything in a single pack")),
> -		OPT_BOOL('A', NULL, &pack_everything_but_loose,
> -				N_("same as -a, and turn unreachable objects loose")),
> +		OPT_BIT('a', NULL, &pack_everything,
> +				N_("pack everything in a single pack"), ALL_INTO_ONE),
> +		OPT_BIT('A', NULL, &pack_everything,
> +				N_("same as -a, and turn unreachable objects loose"), LOOSE_UNREACHABLE),
>  		OPT_BOOL('d', NULL, &delete_redundant,
>  				N_("remove redundant packs, and run git-prune-packed")),
>  		OPT_BOOL('f', NULL, &no_reuse_delta,
> @@ -193,7 +195,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (no_reuse_object)
>  		argv_array_pushf(&cmd_args, "--no-reuse-object");
>  
> -	if (!pack_everything && !pack_everything_but_loose) {
> +	if (!pack_everything) {
>  		argv_array_push(&cmd_args, "--unpacked");
>  		argv_array_push(&cmd_args, "--incremental");
>  	} else {
> @@ -204,7 +206,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				argv_array_pushf(&cmd_args,
>  						"--unpack-unreachable=%s",
>  						unpack_unreachable);
> -			else if (pack_everything_but_loose)
> +			else if (pack_everything & LOOSE_UNREACHABLE)
>  				argv_array_push(&cmd_args,
>  						"--unpack-unreachable");
>  		}
> @@ -246,6 +248,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (!nr_packs && !quiet)
>  		printf("Nothing new to pack.\n");
>  
> +	/*
> +	 * Ok we have prepared all new packfiles.
> +	 * First see if there are packs of the same name and if so
> +	 * if we can move them out of the way (this can happen if we
> +	 * repacked immediately after packing fully.
> +	 */
>  	failed = 0;
>  	for_each_string_list_item(item, &names) {
>  		for (ext = 0; ext < 2; ext++) {
> @@ -366,5 +374,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		run_command(&cmd);
>  		argv_array_clear(&cmd_args);
>  	}
> +	remove_temporary_files();
>  	return 0;
>  }
> -- 
> 1.8.4
>
> Stefan Beller (2):
>   repack: rewrite the shell script in C
>   repack: retain the return value of pack-objects
>
>  Makefile                                        |   2 +-
>  builtin.h                                       |   1 +
>  builtin/repack.c                                | 379 ++++++++++++++++++++++++
>  git-repack.sh => contrib/examples/git-repack.sh |   0
>  git.c                                           |   1 +
>  5 files changed, 382 insertions(+), 1 deletion(-)
>  create mode 100644 builtin/repack.c
>  rename git-repack.sh => contrib/examples/git-repack.sh (100%)
