From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid loading commits twice in log with diffs
Date: Sat, 02 Mar 2013 23:06:03 -0800
Message-ID: <7va9qlc690.fsf@alter.siamese.dyndns.org>
References: <3193c96cf5b036a91bc78b508b8b30ac87ca0f21.1362218700.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 03 08:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC30O-00051F-18
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 08:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab3CCHGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 02:06:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab3CCHGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 02:06:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974C28360;
	Sun,  3 Mar 2013 02:06:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Hzvlm+rnMVWrdc8lLsdull/jTU=; b=sA4c9o
	5zVSURpH96LnfdUs3zr8s2FvNY25krwtvIVleISUK4BuXTkZ29lvlD1xYVnmBv/a
	0+60YCViAT/IMbt+pN+FyfPzRUx8EtjdxeC5v8lXUoswDn6kBbrag4ZTiVAxupa9
	jdTZgDi4hpurEg+wiv5N/58qixNtNDE8yZ4ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g3UHv0MtXp8dW30lJIgt93dicZ8xLmc9
	UvVMCewVRawAUXbYkDy3Itw2/0R1qxyBqZ5+cZK2yWcNjTU0lTUewjp+UaPNXRp8
	abAS+tUoq6KWcstVgYrrUrYBr0lQolRXoiTNUgIt8pLehNF54eAyjYmpnW8t/cSL
	SAZvFfH5KPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C71A835F;
	Sun,  3 Mar 2013 02:06:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A0D9835E; Sun,  3 Mar 2013
 02:06:04 -0500 (EST)
In-Reply-To: <3193c96cf5b036a91bc78b508b8b30ac87ca0f21.1362218700.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat, 2 Mar 2013 11:05:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D09642DC-83D0-11E2-B1D0-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217340>

Thomas Rast <trast@student.ethz.ch> writes:

> Test                      with patch        before
> --------------------------------------------------------------------
> 4000.2: log --raw -3000   0.50(0.43+0.06)   0.54(0.46+0.06) +7.0%***
> 4000.3: log -p -3000      2.34(2.20+0.13)   2.37(2.22+0.13) +1.2%
> --------------------------------------------------------------------
> Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

It may be a silly question but what is a significance hint?

> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  log-tree.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index eb1a1b4..277a38f 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -715,7 +715,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  {
>  	int showed_log;
>  	struct commit_list *parents;
> -	unsigned const char *sha1 = commit->object.sha1;
> +	unsigned const char *sha1 = commit->tree->object.sha1;

Overall I think this goes in the right direction and I can see why
the changes in later two hunks are correct, but I am not sure if we
can safely assume that the caller has parsed the incoming commit and
we have a good commit->tree here already.

Right now, this static function has a single call-site in a public
function log_tree_commit(), whose existing callers may all pass an
already parsed commit, but I feel somewhat uneasy to do the above
without some mechanism in place (either parse it here or in the
caller if unparsed, or document that log_tree_commit() must be
called with a parsed commit and perhaps add an assert there) to
ensure that the invariant is not broken in the future.

Thanks.

>  	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
>  		return 0;
> @@ -742,7 +742,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  			 * parent, showing summary diff of the others
>  			 * we merged _in_.
>  			 */
> -			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt);
> +			parse_commit(parents->item);
> +			diff_tree_sha1(parents->item->tree->object.sha1, sha1, "", &opt->diffopt);
>  			log_tree_diff_flush(opt);
>  			return !opt->loginfo;
>  		}
> @@ -755,7 +756,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  	for (;;) {
>  		struct commit *parent = parents->item;
>  
> -		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
> +		parse_commit(parent);
> +		diff_tree_sha1(parent->tree->object.sha1, sha1, "", &opt->diffopt);
>  		log_tree_diff_flush(opt);
>  
>  		showed_log |= !opt->loginfo;
