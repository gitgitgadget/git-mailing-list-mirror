From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 14:34:10 -0800
Message-ID: <7v8vxhlyfx.fsf@alter.siamese.dyndns.org>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTTY-00036d-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab1BOWeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 17:34:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab1BOWeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 17:34:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 202E44B85;
	Tue, 15 Feb 2011 17:35:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o8RUFG87rDCA2WSd1lKri48C4rY=; b=RHhiV/
	S+PcYzsiSM0p7w2E0CPXJLyDZGFhsnOpmq6hr72TAhDZkey1BQSXIGT+merJJu8w
	vUrUEPUb58VkcSFAjJShaCzwFUmQQUp70y+xfDGREU0nwIQwLyulleKzcN4vuL4z
	uMIIwaLe0K2TzH9WaTVUfOYa9c98supHad5fM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdXZotrgRjFJjnHAthCv0LPMz/mqYckY
	p5iJSfXnRBj58IFzwQMNKy5cgHbm9Yhll/TOrINgADPG7z4O7KfMGxiuuvk9KdzM
	TuN2cmkPb+z01BekYCtFWREzS7Jup99s1nY208CSwNt1o26FY9F0LYL/xXIdYAXD
	glTwdekZKPw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F22D34B83;
	Tue, 15 Feb 2011 17:35:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7D414B7F; Tue, 15 Feb 2011
 17:35:20 -0500 (EST)
In-Reply-To: <1297805034-3512-3-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue\, 15 Feb 2011 16\:23\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0E8A4DC-3953-11E0-9E4A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166890>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8850621..2f0a8fc 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -70,7 +70,7 @@ static const char *logfile, *force_author;
>  static const char *template_file;
>  static char *edit_message, *use_message;
>  static char *fixup_message, *squash_message;
> -static int all, edit_flag, also, interactive, only, amend, signoff;
> +static int all, edit_flag, also, interactive, only, amend, signoff, cherry_pick;

This doesn't belong here; it should come next to "in_merge" that marks us
to be "in the middle of concluding a merge", and it probably is better to
call it "in_cherry_pick" to be consistent.

> @@ -704,6 +704,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				"#\n",
>  				git_path("MERGE_HEAD"));
>  
> +		if (cherry_pick)
> +			fprintf(fp,
> +				"#\n"
> +				"# It looks like you may be committing a cherry-pick.\n"
> +				"# If this is not correct, please remove the file\n"
> +				"#	%s\n"
> +				"# and try again.\n"
> +				"#\n",
> +				git_path("CHERRY_HEAD"));

Yeah, this shows clearly that in_merge is very similar to this new mode of
operation.

> @@ -929,6 +939,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die("You have nothing to amend.");
>  	if (amend && in_merge)
>  		die("You are in the middle of a merge -- cannot amend.");
> +	if (amend && cherry_pick)
> +		die("You are in the middle of a cherry-pick -- cannot amend.");
>  	if (fixup_message && squash_message)
>  		die("Options --squash and --fixup cannot be used together");
>  	if (use_message)

So does this.

Makes one wonder why the hunk that begins at line 609 special cases only
this new mode, no?

> @@ -943,11 +955,19 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die("Only one of -c/-C/-F/--fixup can be used.");
>  	if (message.len && f > 0)
>  		die("Option -m cannot be combined with -c/-C/-F/--fixup.");
> +	if (cherry_pick) {
> +		/* Let message-specifying options override CHERRY_HEAD */
> +		if (f > 0 || message.len)
> +			cherry_pick = 0;
> +		else
> +			/* used for authorship side-effect only */
> +			use_message = "CHERRY_HEAD";
> +	}
>  	if (edit_message)
>  		use_message = edit_message;
>  	if (amend && !use_message && !fixup_message)
>  		use_message = "HEAD";
> -	if (!use_message && renew_authorship)
> +	if (!use_message && !cherry_pick && renew_authorship)
>  		die("--reset-author can be used only with -C, -c or --amend.");
>  	if (use_message) {
>  		const char *out_enc;

Likewise.  Perhaps these show that the way updated code uses the
use_message variable needs some rethinking.

> @@ -1118,6 +1138,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	gitmodules_config();
>  	git_config(git_status_config, &s);
>  	in_merge = file_exists(git_path("MERGE_HEAD"));
> +	cherry_pick = file_exists(git_path("CHERRY_HEAD"));
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_status_options,
>  			     builtin_status_usage, 0);
> @@ -1140,7 +1161,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
> -	s.in_merge = in_merge;
> +	s.in_merge = in_merge || cherry_pick;

Ugly.  What does s.in_merge _MEAN_ after this patch gets applied?

I am not at all opposed to extending the semantics of an existing field of
the structure (i.e. "doing this and that when concluding a conflicted
merge made sense, and now we realize that doing exactly the same this and
that makes sense when concluding a conflicted cherry-pick" is perfectly
fine), but then that updated semantics should get a new name to cover both
old and new use scenario.  You are _not_ in "in-merge" anymore but trying
to get a behaviour from other parts of the system that is similar to what
you would get when "in-merge".  What is it?  That is what you should base
the new name for the field on.

> @@ -1369,7 +1391,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			parents = reduce_heads(parents);
>  	} else {
>  		if (!reflog_msg)
> -			reflog_msg = "commit";
> +			reflog_msg = cherry_pick ? "commit (cherry-pick)"
> +						 : "commit";

This seems to indicate that we don't say "commit (merge)" when concluding
a conflicted merge.  Shouldn't we?
