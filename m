From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/19] reset.c: pass pathspec around instead of (prefix,
 argv) pair
Date: Wed, 09 Jan 2013 11:26:56 -0800
Message-ID: <7vy5g25f9b.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-4-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:27:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1J4-00089J-B0
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab3AIT1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:27:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451Ab3AIT07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:26:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78E88B6AA;
	Wed,  9 Jan 2013 14:26:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cfYa0o3yjZHQxmx0bY+VajuTu/M=; b=fJRGwk
	/qOXBpK9Kp1kmVrt19iL4Y16GYssXX1m7akynm9Ek1bxiyQ0RRJHX7KeLGYZkuuf
	V3KT8MHNxKYPrIwbVwNTdhfhgp0LvLkHmuO9izlT9y2mqabSCFeRg2QUqN+JgWE3
	/YCwxTCXVUugw37BrIo4Y/blvP31ojSzZjsKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h8j9+M415rNvyJ8yAAJqtlnkQIp1ZR0U
	cFDN4Pjt2XKHlEE6kteGBpQ69vtkvRGGiPkBDdYPufHyjGnQWvmWPEObm0DdFvSV
	S8SCOBPXST0ED7EvPgbxbAcKd+rSSvhN1UftBmAL5XsbptjxOIuZG1QAuH2IfAkU
	whu+wDJlgbs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CEACB6A8;
	Wed,  9 Jan 2013 14:26:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98F10B69F; Wed,  9 Jan 2013
 14:26:58 -0500 (EST)
In-Reply-To: <1357719376-16406-4-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8918987C-5A92-11E2-B44E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213082>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> We use the path arguments in two places in reset.c: in
> interactive_reset() and read_from_tree(). Both of these call
> get_pathspec(), so we pass the (prefix, arv) pair to both
> functions. Move the call to get_pathspec() out of these methods, for
> two reasons: 1) One argument is simpler than two. 2) It lets us use
> the (arguably clearer) "if (pathspec)" in place of "if (i < argc)".
> ---
> If I understand correctly, this should be rebased on top of
> nd/parse-pathspec. Please let me know.

Yeah, this will conflict with the get_pathspec-to-parse_pathspec
conversion Duy has been working on.

Without the interactions with that topic, the conversion seems
straightforward to me, though.

>
>  builtin/reset.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 65413d0..045c960 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -153,26 +153,15 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>  	}
>  }
>  
> -static int interactive_reset(const char *revision, const char **argv,
> -			     const char *prefix)
> -{
> -	const char **pathspec = NULL;
> -
> -	if (*argv)
> -		pathspec = get_pathspec(prefix, argv);
> -
> -	return run_add_interactive(revision, "--patch=reset", pathspec);
> -}
> -
> -static int read_from_tree(const char *prefix, const char **argv,
> -		unsigned char *tree_sha1, int refresh_flags)
> +static int read_from_tree(const char **pathspec, unsigned char *tree_sha1,
> +			  int refresh_flags)
>  {
>  	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>  	int index_fd;
>  	struct diff_options opt;
>  
>  	memset(&opt, 0, sizeof(opt));
> -	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
> +	diff_tree_setup_paths(pathspec, &opt);
>  	opt.output_format = DIFF_FORMAT_CALLBACK;
>  	opt.format_callback = update_index_from_diff;
>  
> @@ -216,6 +205,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	const char *rev = "HEAD";
>  	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
>  				*old_orig = NULL, sha1_old_orig[20];
> +	const char **pathspec = NULL;
>  	struct commit *commit;
>  	struct strbuf msg = STRBUF_INIT;
>  	const struct option options[] = {
> @@ -287,22 +277,25 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		die(_("Could not parse object '%s'."), rev);
>  	hashcpy(sha1, commit->object.sha1);
>  
> +	if (i < argc)
> +		pathspec = get_pathspec(prefix, argv + i);
> +
>  	if (patch_mode) {
>  		if (reset_type != NONE)
>  			die(_("--patch is incompatible with --{hard,mixed,soft}"));
> -		return interactive_reset(rev, argv + i, prefix);
> +		return run_add_interactive(rev, "--patch=reset", pathspec);
>  	}
>  
>  	/* git reset tree [--] paths... can be used to
>  	 * load chosen paths from the tree into the index without
>  	 * affecting the working tree nor HEAD. */
> -	if (i < argc) {
> +	if (pathspec) {
>  		if (reset_type == MIXED)
>  			warning(_("--mixed with paths is deprecated; use 'git reset -- <paths>' instead."));
>  		else if (reset_type != NONE)
>  			die(_("Cannot do %s reset with paths."),
>  					_(reset_type_names[reset_type]));
> -		return read_from_tree(prefix, argv + i, sha1,
> +		return read_from_tree(pathspec, sha1,
>  				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
>  	}
>  	if (reset_type == NONE)
