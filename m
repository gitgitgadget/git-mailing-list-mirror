From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other remotes
Date: Fri, 21 Jun 2013 11:42:41 -0700
Message-ID: <7v8v23mhjy.fsf@alter.siamese.dyndns.org>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	<1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6IL-0003Ge-O1
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423649Ab3FUSmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:42:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUSmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:42:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C3B2ADC7;
	Fri, 21 Jun 2013 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYsXFY7JcDeG7JvlxYHelOka0yE=; b=BzvyIC
	XoeyprIRRqN4xblru1eyzqfwAC3ZjYa4VZrpnwzCi1uhPOdqJ8hMQ3c6grSiU5XC
	b6bxcq4MtsCc+d6NktpMaafXeX2UtHeWue3uSlJ5N0ylYPiC8XCmHzGHgQXTAvWv
	1ST40lzvwLYArc72xjPEXH0F8jiXmpHeQ54P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VBAxMUSjQDA/fLbXzAnV8isnmi060Gwo
	X3LgxAj6kRT9i4m5xS4A5dikVZPUAKeMgUCIUl9R7zjf1iTjJ3fEMWt5rJ27s3rW
	91U/jeUz0wtTYgHn/EIxVhn7QMIT3Y0EuEQEbGtDM++uZqYGX999HSEIOSoAgzfF
	RcqdXOwRZcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 595932ADC6;
	Fri, 21 Jun 2013 18:42:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A6AF2ADC2;
	Fri, 21 Jun 2013 18:42:43 +0000 (UTC)
In-Reply-To: <1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	(Dennis Kaarsemaker's message of "Fri, 21 Jun 2013 12:04:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BE3E5EC-DAA2-11E2-AF46-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228644>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> When cloning a repo with --mirror, and adding more remotes later,

Even though --mirror is not the only way to trigger this, I think it
is good to mention it because it is the most common way to do so.

> get_stale_heads for origin will mark all refs from other repos as stale.

As Peff already said, that is only one symptom.  Another is "git
fetch" from origin and then "git fetch another" can try to overwrite
the same ref in refs/remotes/* hierarchy.  We should say what we are
avoiding upfront, not just one of the consequences of the bad thing
we are avoiding.

	... more remotes later, we would end up with fetch refspecs
	from different remotes trying to overwrite the same ref for
	their remote tracking purposes.

        This can cause confusion (e.g. where did
	"refs/remotes/peff/master" come from?  Is it a copy of the
	master branch of remote 'peff', or does our mirror origin
	have a remote tracking branch for a remote it calls 'peff',
	which may not be related to our 'peff', and we just got a
	straight copy from it?) and can cause "remote prune" to
	misbehave.

or something like that.

> Add a warning to the documentation, and warn the user when we detect
> such things during git remote add.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  Documentation/git-remote.txt |  6 +++++-
>  builtin/remote.c             | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 581bb4c..d7457df 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -71,7 +71,11 @@ When a fetch mirror is created with `--mirror=fetch`, the refs will not
>  be stored in the 'refs/remotes/' namespace, but rather everything in
>  'refs/' on the remote will be directly mirrored into 'refs/' in the
>  local repository. This option only makes sense in bare repositories,
> -because a fetch would overwrite any local commits.
> +because a fetch would overwrite any local commits. If you want to add extra
> +remotes to a repository created with `--mirror=fetch`, you will need to change
> +the configuration of the mirrored remote to fetch only `refs/heads/*`,
> +otherwise `git remote prune <remote>` will remove all branches for the extra
> +remotes.
>  +
>  When a push mirror is created with `--mirror=push`, then `git push`
>  will always behave as if `--mirror` was passed.
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5e54d36..a4f9cb8 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -112,6 +112,21 @@ enum {
>  #define MIRROR_PUSH 2
>  #define MIRROR_BOTH (MIRROR_FETCH|MIRROR_PUSH)
>  
> +static int check_overlapping_refspec(struct remote *remote, void *priv)

It is customery to call that cb_data (i.e. data for the callback) in
our codebase.

> +{
> +	char *refspec = priv;

You are passing only the RHS of the refspec, so this variable name
is confusing to the reader.  Perhaps "dst", as you will be comparing
with ".dst" which is RHS of the fetch refspec for the remotes?

> +	int i;
> +	for (i = 0; i < remote->fetch_refspec_nr; i++) {
> +		if(strcmp(refspec, remote->fetch[i].dst) &&

Style (have SP between if and open paren).

> +		   (!fnmatch(refspec, remote->fetch[i].dst, 0) ||
> +		    !fnmatch(remote->fetch[i].dst, refspec, 0))) {

Does .dst always exist and is never a NULL?  My quick scan of
remote.c::parse_refspec_internal() tells me otherwise.

Also what are you matching with what?  refs/* against refs/remotes/origin/*?

What if remote->fetch[i] is not a wildcarded refspec, e.g.

	[remote "origin"]
        	fetch = +refs/heads/master:refs/heads/origin
		fetch = +refs/heads/next:refs/remotes/origin/next

You would want to check for equality in such a case against the RHS
of the refspeec you have.

> +			warning(_("Overlapping refspecs detected: '%s' and '%s'"),
> +			        refspec, remote->fetch[i].dst);

We know which remote is the offending one, so we can afford to be
more helpful to the user and say which existing remote's fetch
refspec overlaps with the one the user is attempting to add.

> +		}
> +	}
> +	return 0;
> +}
> +
>  static int add_branch(const char *key, const char *branchname,
>  		const char *remotename, int mirror, struct strbuf *tmp)
>  {
> @@ -123,6 +138,8 @@ static int add_branch(const char *key, const char *branchname,
>  	else
>  		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
>  				branchname, remotename, branchname);
> +
> +	for_each_remote(check_overlapping_refspec, strchr((const char*)tmp->buf, ':') + 1);

Do you need this cast???

>  	return git_config_set_multivar(key, tmp->buf, "^$", 0);
>  }
