From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] checkout-index: handle "--no-index" option
Date: Sun, 31 Jan 2016 18:25:22 -0800
Message-ID: <xmqqr3gxw4j1.fsf@gitster.mtv.corp.google.com>
References: <20160131112215.GA4589@sigill.intra.peff.net>
	<20160131112936.GD5116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 03:25:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ4BF-00076I-D4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 03:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933594AbcBACZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 21:25:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933526AbcBACZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 21:25:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71BEF41AA1;
	Sun, 31 Jan 2016 21:25:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pckc11g571P6iL4Oy6bud6ZDC+k=; b=SxGewF
	0d42gDbzfjEAPqBc0gOqat3o2QDNlNEM5WTvTh4l/R+txMUyKO2Hak2r4VF9mbzi
	Ey3qZpIYKoj92tpARwrzwqUmCgrJWmXBFk+j9sqo5RLCv5mTcNQIUqEjDURD93Gi
	JOycOYX/ALBk40mLWZmldxf87cMiXyIYV5PKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EujrWaj2tAXqh0vChDCL3cvsZt9YdbDE
	cjTO22+oOzHa/GtL6Zop/r9BawmO6Pv/84st0PsTNq5IYIHAoe5kp9tDGRBEhYAO
	ukzNAh1BHvaJvF7LRt6US+PiRWsWQdLxPUENHjEQUGteAwu9kKDmxefWZPMjsuM2
	hmf2UvZbwKU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 678BA41A9E;
	Sun, 31 Jan 2016 21:25:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D26EF41A9C;
	Sun, 31 Jan 2016 21:25:23 -0500 (EST)
In-Reply-To: <20160131112936.GD5116@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 31 Jan 2016 06:29:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C6759C0-C88B-11E5-B77A-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285179>

Jeff King <peff@peff.net> writes:

> I also reformatted the comment that violated our style
> guidelines, but I am not sure if it is all that helpful. It
> seems we also cancel "--index" with "--temp" or
> "--stage=all", but I do not know why. I left the content
> as-is, but if somebody knows enough to elaborate, it might
> be worth doing.

Isn't the --index about updating the cached stat information, to
allow us to then say "the working tree file hasn't been modified
since we wrote it out"?  After writing a file out to somewhere that
is not its natural location (i.e. using prefix, stage or temp would
all write the contents of F to somewhere that is not F), the next
"diff-files" would not compare the index entry with the contents
held in that relocated location, but with its natural location.

Admittedly, even if we update the cached stat info from that
relocated place, the next "diff-files" would certainly not match
(not just mtime but i-num would be different), but if the real
working tree file were clean when --temp checkout happened, that
would mean we would force another round of update-index --refresh,
so...

>  builtin/checkout-index.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 43bedde..f8179a7 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -130,18 +130,6 @@ static const char * const builtin_checkout_index_usage[] = {
>  
>  static struct lock_file lock_file;
>  
> -static int option_parse_u(const struct option *opt,
> -			      const char *arg, int unset)
> -{
> -	int *newfd = opt->value;
> -
> -	state.refresh_cache = 1;
> -	state.istate = &the_index;
> -	if (*newfd < 0)
> -		*newfd = hold_locked_index(&lock_file, 1);
> -	return 0;
> -}
> -
>  static int option_parse_stage(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> @@ -166,6 +154,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>  	int read_from_stdin = 0;
>  	int prefix_length;
>  	int force = 0, quiet = 0, not_new = 0;
> +	int index_opt = 0;
>  	struct option builtin_checkout_index_options[] = {
>  		OPT_BOOL('a', "all", &all,
>  			N_("check out all files in the index")),
> @@ -174,9 +163,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>  			N_("no warning for existing files and files not in index")),
>  		OPT_BOOL('n', "no-create", &not_new,
>  			N_("don't checkout new files")),
> -		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
> -			N_("update stat information in the index file"),
> -			PARSE_OPT_NOARG, option_parse_u },
> +		OPT_BOOL('u', "index", &index_opt,
> +			 N_("update stat information in the index file")),
>  		OPT_BOOL('z', NULL, &nul_term_line,
>  			N_("paths are separated with NUL character")),
>  		OPT_BOOL(0, "stdin", &read_from_stdin,
> @@ -211,15 +199,13 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>  		state.base_dir = "";
>  	state.base_dir_len = strlen(state.base_dir);
>  
> -	if (state.base_dir_len || to_tempfile) {
> -		/* when --prefix is specified we do not
> -		 * want to update cache.
> -		 */
> -		if (state.refresh_cache) {
> -			rollback_lock_file(&lock_file);
> -			newfd = -1;
> -		}
> -		state.refresh_cache = 0;
> +	/*
> +	 * when --prefix is specified we do not want to update cache.
> +	 */
> +	if (index_opt && !state.base_dir_len && !to_tempfile) {
> +		state.refresh_cache = 1;
> +		state.istate = &the_index;
> +		newfd = hold_locked_index(&lock_file, 1);
>  	}
>  
>  	/* Check out named files first */
