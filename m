From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 09:42:48 -0700
Message-ID: <7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<1369132915-25657-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:43:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uepeq-0004B7-K7
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab3EUQnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:43:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab3EUQmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:42:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59D981E341;
	Tue, 21 May 2013 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3++3COv0GgBIoYIvCn6N5szFSQ=; b=NaQGBL
	tWnMeuJKwsW9QZRy2J/XTdIYtsvLOuYABX1ly2YxqyGcsXD1GjgQ72DJURZSO2Lw
	YupabVCYOi3jPEjuqaQJtvdxPb5R4xnfNcKAgPgFP8U+Sk3K59PK9HFRHHyxBA4A
	QUKq+sakHq2ZQzrle4X+CjIj8OWTVk4OrJ/Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmCTb0IpwzKsCIOCex5cIDLpGqn3+415
	za7mmZgVCjrCKag8djRYpkZyo2r4wRwTANKkLscD4i1QMZA1PQE+QeFkgrBamV4v
	7xkY/1jsd+zSPgpTk2CUksTEY2u0IXz4SjjEO0Y0DLs8YObOzo8l8M9nRKbqbOHZ
	/IW4i5BZhAg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A6651E340;
	Tue, 21 May 2013 16:42:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 735531E33D;
	Tue, 21 May 2013 16:42:50 +0000 (UTC)
In-Reply-To: <1369132915-25657-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 21 May 2013 16:11:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79AA8DCC-C235-11E2-A841-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225041>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, when no (valid) upstream is configured for a branch, we get
> an error like:
>
>   $ git show @{u}
>   error: No upstream configured for branch 'upstream-error'
>   error: No upstream configured for branch 'upstream-error'
>   fatal: ambiguous argument '@{u}': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
> The "error: " line actually appears twice, and the rest of the error
> message is useless.  In sha1_name.c:interpret_branch_name(), there is
> really no point in processing further if @{u} couldn't be resolved, and
> we might as well die() instead of returning an error().  After making
> this change, you get:
>
>   $ git show @{u}
>   fatal: No upstream configured for branch 'upstream-error'
>
> Also tweak a few tests in t1507 to expect this output.

Does a failure in interpret-branch-name that issue these error
messages always followed by die() in the caller?  I know you looked
at the cases you noticed as an end-user (like the above "git show @{u}"
example), but if some codepaths did this:

	if (interpret-branch-name()) {
        	you do not seem to have upstream defined,
	        so I will helpfully do something else that
                you probably have meant.
	}

this patch will break that codepath you did not look.

I do not offhand know if there is such a codepath, so if you did a
code audit and know this patch is regression-free, please say that
in the log message.  "I ran all the tests and they passed" is not
good enough.

Other than that, the idea sounds OK.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  sha1_name.c                   | 13 +++++++------
>  t/t1507-rev-parse-upstream.sh | 15 +++++----------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 3820f28..416a673 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1033,14 +1033,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>  	 * points to something different than a branch.
>  	 */
>  	if (!upstream)
> -		return error(_("HEAD does not point to a branch"));
> +		die(_("HEAD does not point to a branch"));
>  	if (!upstream->merge || !upstream->merge[0]->dst) {
>  		if (!ref_exists(upstream->refname))
> -			return error(_("No such branch: '%s'"), cp);
> -		if (!upstream->merge)
> -			return error(_("No upstream configured for branch '%s'"),
> -				     upstream->name);
> -		return error(
> +			die(_("No such branch: '%s'"), cp);
> +		if (!upstream->merge) {
> +			die(_("No upstream configured for branch '%s'"),
> +				upstream->name);
> +		}
> +		die(
>  			_("Upstream branch '%s' not stored as a remote-tracking branch"),
>  			upstream->merge[0]->src);
>  	}
> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> index b27a720..2a19e79 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -129,8 +129,7 @@ test_expect_success 'branch@{u} works when tracking a local branch' '
>  
>  test_expect_success 'branch@{u} error message when no upstream' '
>  	cat >expect <<-EOF &&
> -	error: No upstream configured for branch ${sq}non-tracking${sq}
> -	fatal: Needed a single revision
> +	fatal: No upstream configured for branch ${sq}non-tracking${sq}
>  	EOF
>  	error_message non-tracking@{u} 2>actual &&
>  	test_i18ncmp expect actual
> @@ -138,8 +137,7 @@ test_expect_success 'branch@{u} error message when no upstream' '
>  
>  test_expect_success '@{u} error message when no upstream' '
>  	cat >expect <<-EOF &&
> -	error: No upstream configured for branch ${sq}master${sq}
> -	fatal: Needed a single revision
> +	fatal: No upstream configured for branch ${sq}master${sq}
>  	EOF
>  	test_must_fail git rev-parse --verify @{u} 2>actual &&
>  	test_i18ncmp expect actual
> @@ -147,8 +145,7 @@ test_expect_success '@{u} error message when no upstream' '
>  
>  test_expect_success 'branch@{u} error message with misspelt branch' '
>  	cat >expect <<-EOF &&
> -	error: No such branch: ${sq}no-such-branch${sq}
> -	fatal: Needed a single revision
> +	fatal: No such branch: ${sq}no-such-branch${sq}
>  	EOF
>  	error_message no-such-branch@{u} 2>actual &&
>  	test_i18ncmp expect actual
> @@ -156,8 +153,7 @@ test_expect_success 'branch@{u} error message with misspelt branch' '
>  
>  test_expect_success '@{u} error message when not on a branch' '
>  	cat >expect <<-EOF &&
> -	error: HEAD does not point to a branch
> -	fatal: Needed a single revision
> +	fatal: HEAD does not point to a branch
>  	EOF
>  	git checkout HEAD^0 &&
>  	test_must_fail git rev-parse --verify @{u} 2>actual &&
> @@ -166,8 +162,7 @@ test_expect_success '@{u} error message when not on a branch' '
>  
>  test_expect_success 'branch@{u} error message if upstream branch not fetched' '
>  	cat >expect <<-EOF &&
> -	error: Upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
> -	fatal: Needed a single revision
> +	fatal: Upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
>  	EOF
>  	error_message bad-upstream@{u} 2>actual &&
>  	test_i18ncmp expect actual
