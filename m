From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Tue, 04 Oct 2011 21:07:36 -0700
Message-ID: <7vmxdg9j3r.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 06:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBIlk-0008Lq-N0
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 06:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab1JEEHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 00:07:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab1JEEHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 00:07:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C85FA5ED1;
	Wed,  5 Oct 2011 00:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ueixszU/kP50c5dcH2oa9Sn7yFs=; b=xCeMRa
	n3LEGu1ofxm8KhsvgwJyoSz+VSnUbC0k7FUjrc+4shbE+1vmTKYxIJtprwlRbX1a
	35hZlKtvPF9lhIpnMdtFwVVl9e0fZaSDD0rV/QH+PzunBaMorgZgGbsdJm3+leAN
	dQbu+r8b8QBKHPKmZzBbC6h9gkujrhh3JDeSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MeyKCppTCMvtI3gUEmlu3MYRJeznk+dk
	86dczE1LOdzb+dD1AKzwpG4cdZyfjZAe4SZy4x0UpHxd8nFRpfgW0eClkc+HKuhn
	5TTl6I9TcVDt2s2pRJ909loHHQPSsHAHGKSKsc94ecAc2GoSnrcLBctl9oUH1GSB
	/6qek2psAm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0CBA5ED0;
	Wed,  5 Oct 2011 00:07:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D5575ECF; Wed,  5 Oct 2011
 00:07:38 -0400 (EDT)
In-Reply-To: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue, 4 Oct 2011 23:43:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90070850-EF07-11E0-BB07-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182824>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5e356a6c61..26259a41a7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -709,12 +710,35 @@ static void orphaned_commit_warning(struct commit *commit)
>  	for_each_ref(clear_commit_marks_from_one_ref, NULL);
>  }
>  
> +static void record_checkout(const char *name, const char *work_tree)
> +{
> +	struct strbuf key = STRBUF_INIT;
> +	strbuf_addf(&key, "branch.%s.checkout", name);
> +	git_config_set(key.buf, work_tree);
> +	strbuf_release(&key);
> +}
> +
> +static void check_if_checked_out(struct checkout_opts *opts, const char *name)
> +{
> +	struct branch *branch = branch_get(name);
> +	if (branch->work_tree && strlen(branch->work_tree) &&
> +	    strcmp(branch->work_tree, get_git_work_tree())) {
> +		if (opts->force)
> +			warning(_("branch '%s' is currently checked out"
> +				  " in '%s'"), name, branch->work_tree);
> +		else
> +			die(_("branch '%s' is currently checked out"
> +			      " in '%s'"), name, branch->work_tree);
> +	}
> +}
> +
>  static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
>  {
>  	int ret = 0;
>  	struct branch_info old;
>  	unsigned char rev[20];
>  	int flag;
> +
>  	memset(&old, 0, sizeof(old));
>  	old.path = xstrdup(resolve_ref("HEAD", rev, 0, &flag));
>  	old.commit = lookup_commit_reference_gently(rev, 1);
> @@ -734,6 +758,9 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
>  		parse_commit(new->commit);
>  	}
>  
> +	if (opts->record_checkouts)
> +		check_if_checked_out(opts, new->name);

The close brace we can see in the context closes "if (!new->name) {", so
this codepath is very well prepared to be called with new->name == NULL.

Is check_if_checked_out() prepared to be called with name == NULL and do
the right thing?

> @@ -743,6 +770,14 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
>  
>  	update_refs_for_switch(opts, &old, new);
>  
> +	if (opts->record_checkouts) {
> +		const char *work_tree = get_git_work_tree();
> +		struct branch *branch = branch_get(old.name);
> +		if (branch->work_tree && !strcmp(branch->work_tree, work_tree))
> +			record_checkout(old.name, "");
> +		record_checkout(new->name, work_tree);
> +	}
> +

Likewise for new->name, but also old.name which is only set when old.path
is set and begins with "refs/heads/" and otherwise NULL.
