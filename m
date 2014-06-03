From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: optionally deny case-clone refs
Date: Tue, 03 Jun 2014 14:33:58 -0700
Message-ID: <xmqqioohwud5.fsf@gitster.dls.corp.google.com>
References: <1401822896-816-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwLT-0002hR-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbaFCVeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:34:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58372 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932907AbaFCVeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:34:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F23301D38A;
	Tue,  3 Jun 2014 17:34:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UDrU9oX25rAurK+4uFkUWr8mTH0=; b=Ju4s3Q
	xPCerBWlA0FngnEsXCJ2jMNMb1p+3guyTcXGb2lGWrksG6S0DDQsvZmdgex7KX6M
	S/6ClL9EJXx1mNgZcVHxsHtRHxwNEyfz7OoRLhI0hqeZ9x75ehXfsUrGAwu37G+Z
	Z9sLsZrPjrTFCJbMPO6DMVhZrysfa+UWqakeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YnIsBGh7qGCHBDxZhTlt8+O+PJXEazdd
	BTMh788PH2+wC8GVLvjP6zlaf/rrQ1NvrzVpDmfNlYLsFgMWDx3G2jXwfrAI4bGk
	bY3QWXv9lSvJK4v0OqEmlAfRIepQTejGYYNIBhSBdV9ZW/+f1YVUf6IEVsSXRT9C
	GcMY1YunsfQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E609A1D389;
	Tue,  3 Jun 2014 17:34:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 209941D382;
	Tue,  3 Jun 2014 17:34:00 -0400 (EDT)
In-Reply-To: <1401822896-816-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Tue, 3 Jun 2014 15:14:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C68B5EE0-EB66-11E3-8D01-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250647>

David Turner <dturner@twopensource.com> writes:

> It is possible to have two branches which are the same but for case.
> This works great on the case-sensitive filesystems, but not so well on
> case-insensitive filesystems.  It is fairly typical to have
> case-insensitive clients (Macs, say) with a case-sensitive server
> (GNU/Linux).
>
> Should a user attempt to pull on a Mac when there are case-clone
> branches with differing contents, they'll get an error message
> containing something like "Ref refs/remotes/origin/lower is at
> [sha-of-lowercase-branch] but expected [sha-of-uppercase-branch]....
> (unable to update local ref)"
>
> With a case-insensitive git server, if a branch called capital-M
> Master (that differs from lowercase-m-master) is pushed, nobody else
> can push to (lowercase-m) master until the branch is removed.
>
> Create the option receive.denycaseclonebranches, which checks pushed
> branches to ensure that they are not case-clones of an existing
> branch.  This setting is turned on by default if core.ignorecase is
> set, but not otherwise.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

I do not object to this new feature in principle, but I do not know
if we want to introduce a new word "case-clone refs" without adding
it to the glossary documentation.

It feels a bit funny to tie this to core.ignorecase, which is an
attribute of the filesystem used for the working tree, though.

Updates to Documentation/config.txt and Documentation/git-push.txt
are also needed.

>  builtin/receive-pack.c | 29 ++++++++++++++++++++++++++++-
>  t/t5400-send-pack.sh   | 20 ++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c323081..0894ded 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -27,6 +27,7 @@ enum deny_action {
>  
>  static int deny_deletes;
>  static int deny_non_fast_forwards;
> +static int deny_case_clone_branches = -1;
>  static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
>  static enum deny_action deny_delete_current = DENY_UNCONFIGURED;

Would it make sense to reuse the enum deny_action for this new
settings, with an eye to later convert the older boolean ones also
to use enum deny_action to make them consistent and more flexible?

> @@ -69,6 +70,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  	if (status)
>  		return status;
>  
> +	if (strcmp(var, "receive.denycaseclonebranches") == 0) {
> +		deny_case_clone_branches = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (strcmp(var, "receive.denydeletes") == 0) {
>  		deny_deletes = git_config_bool(var, value);
>  		return 0;
> @@ -468,6 +474,24 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	return 0;
>  }
>  
> +static int is_case_clone(const char *refname, const unsigned char *sha1,
> +			int flags, void *cb_data)
> +{
> +	const char* incoming_refname = cb_data;

We write C not C++ around here; the pointer-asterisk sticks to the
variable name, not typename.

> +	return !strcasecmp(refname, incoming_refname) &&
> +		strcmp(refname, incoming_refname);

(Mental note to the reviewer himself) This returns true iff there is
an existing ref whose name is only different in case, and cause
for-each-ref to return early with true.  In a sane case of not
receiving problematic refs, this will have to iterate over all the
existing refnames.  Wonder if there are better ways to optimize this
in a repository with hundreds or thousands of refs, which is not all
that uncommon.

> +}
> +
> +static int ref_is_denied_case_clone(const char *name)
> +{
> +
> +	if (!deny_case_clone_branches)
> +		return 0;
> +
> +	return for_each_ref(is_case_clone, (void *) name);
> +

The trailing blank line inside a function at the end is somewhat
unusual.

> +}
> +

> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 0736bcb..099c0e3 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -129,6 +129,26 @@ test_expect_success 'denyNonFastforwards trumps --force' '
>  	test "$victim_orig" = "$victim_head"
>  '
>  
> +if ! test_have_prereq CASE_INSENSITIVE_FS
> +then

Hmm, don't we want the feature to kick in for both case sensitive
and case insensitive filesystems?

> +test_expect_success 'denyCaseCloneBranches works' '
> +	(
> +	    cd victim &&
> +	    git config receive.denyCaseCloneBranches true
> +	    git config receive.denyDeletes false
> +	) &&
> +	git checkout -b caseclone &&
> +	git send-pack ./victim caseclone &&
> +	git checkout -b CaseClone &&
> +	test_must_fail git send-pack ./victim CaseClone &&

At this point, we would want to see not just that send-pack fails
but also that "victim" does not have CaseClone branch and does have
caseclone branch pointing at the original value (i.e. we do not want
to see "caseclone" updated to a value that would have gone to
CaseClone with this push).

Each push in the sequence should be preceded by a "git commit" or
something so that we can verify the object at the tip of the ref in
the "victim" repository, I would think.  Otherwise it is hard to
tell an expected no-op that has failed and a no-op because it
mistakenly pushed the same value to a wrong ref.

> +	git checkout -b notacaseclone &&
> +	git send-pack ./victim notacaseclone &&
> +	test_must_fail git send-pack ./victim :CaseClone &&

This is expected to fail we expect that earlier push of CaseClone
has failed and we do not have such a branch, OK.

> +	git send-pack ./victim :caseclone &&

This is expected to succeed because we expect that earlier push of
CaseClone has failed and we still have caseclone intact.

> +	git send-pack ./victim CaseClone
> +'
> +fi
> +
>  test_expect_success 'push --all excludes remote-tracking hierarchy' '
>  	mkdir parent &&
>  	(
