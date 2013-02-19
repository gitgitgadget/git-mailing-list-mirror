From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] check-ignore.c: fix segfault with '.' argument from
 repo root
Date: Tue, 19 Feb 2013 09:54:10 -0800
Message-ID: <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7rOp-0003Ua-RM
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758744Ab3BSRyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 12:54:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757885Ab3BSRyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:54:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97C0DBB51;
	Tue, 19 Feb 2013 12:54:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R49oFfYeoOfKrYkxxGNzxxpC2qU=; b=GZTZ9x
	+nvBFLyay0MtDu7C6kehRQ6JtcnhRI3QRD3U/yTklHCUNO7mswE1QyJ1XCKR7/49
	x1lrGsiG44hktwmyNRqDllb0HJBfyLiIx25NoTarhTknXovFuIJfHjwS4rB4Bngl
	dJZdXrNbmkXcKW8RWlWyEViW7oyAu5FWA/EII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhY6l62jfldyO4lF3lJCt/+eJqPMq613
	3DS/oortIIHHbS93Z76RveaeHXJcRq0AfDLftVf/fvJYx9Jr9g9Jm7aC7qYkd7Bm
	bwfnXsl4OXVLHKdf6pdKURttVLfFTFkfeBM97gngnWuCRHtBwpi65H95rhl4X8x1
	sq+LlJw8du0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88E86BB50;
	Tue, 19 Feb 2013 12:54:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DCB9BB34; Tue, 19 Feb 2013
 12:54:13 -0500 (EST)
In-Reply-To: <1361282783-1413-2-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Tue, 19 Feb 2013 14:06:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EFB80AE-7ABD-11E2-AA4E-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216639>

Adam Spiers <git@adamspiers.org> writes:

> Fix a corner case where check-ignore would segfault when run with the
> '.' argument from the top level of a repository, due to prefix_path()
> converting '.' into the empty string.  It doesn't make much sense to
> call check-ignore from the top level with '.' as a parameter, since
> the top-level directory would never typically be ignored, but of
> course it should not segfault in this case.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---

Please step back a bit and explain why the original had check for
path[0] in the first place?

If the answer is "the code wanted to special case the question 'is
the top-level excluded?', but used a wrong variable to implement the
check, and this patch is a fix to that", then the proposed commit
log message looks incomplete.  The cause of the segv is not that
prefix_path() returns an empty string, but because the function
called inside the "if" block was written without expecting to be fed
the path that refers to the top-level of the working tree, no?

While this change certainly will prevent the "check the top-level"
request to last-exclude-matching-path, I have to wonder if it is a
good idea to force the caller of the l-e-m-p function to even care.

In other words, would it be a cleaner approach to fix the l-e-m-p
function so that the caller can ask "check the top-level" and give a
sensible answer (perhaps the answer may be "nothing matches"), and
remove the "&& path[0]" (or "&& full_path[0]") special case from
this call site?

The last sentence "It doesn't make much sense..." in the proposed
log message would become a good justification for such a special
case at the beginning of l-e-m-p function, I would think.

>  builtin/check-ignore.c | 2 +-
>  t/t0008-ignores.sh     | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 709535c..b0dd7c2 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -89,7 +89,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
>  					? strlen(prefix) : 0, path);
>  		full_path = check_path_for_gitlink(full_path);
>  		die_if_path_beyond_symlink(full_path, prefix);
> -		if (!seen[i] && path[0]) {
> +		if (!seen[i] && full_path[0]) {
>  			exclude = last_exclude_matching_path(&check, full_path,
>  							     -1, &dtype);
>  			if (exclude) {
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index ebe7c70..9c1bde1 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -138,6 +138,7 @@ test_expect_success 'setup' '
>  	cat <<-\EOF >.gitignore &&
>  		one
>  		ignored-*
> +		top-level-dir/
>  	EOF
>  	for dir in . a
>  	do
> @@ -177,6 +178,10 @@ test_expect_success 'setup' '
>  #
>  # test invalid inputs
>  
> +test_expect_success_multi '. corner-case' '' '
> +	test_check_ignore . 1
> +'
> +
>  test_expect_success_multi 'empty command line' '' '
>  	test_check_ignore "" 128 &&
>  	stderr_contains "fatal: no path specified"
