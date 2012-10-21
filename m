From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git symbolic-ref --delete $symref
Date: Sun, 21 Oct 2012 12:16:39 -0700
Message-ID: <7vobjvfxew.fsf@alter.siamese.dyndns.org>
References: <1350819153-23491-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 21:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ114-0000A9-V3
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 21:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515Ab2JUTQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 15:16:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab2JUTQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 15:16:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F83D9707;
	Sun, 21 Oct 2012 15:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XLoGJcCudjSEv32oJyspRJv/SMY=; b=Vz53MO
	LwzqDc+OBu1DD+8nMJTP+GUsceTL5uTU2wzRsBENKEydcT3JwHhKHxyDVWowyZ5p
	YVPBklqaFghpGd+aInuV//HL/8qHNV+cvucEQyyH/uCJmJ5uqBPLB8f9K4PhTb4Q
	x2ta3nJUd2S/eYs7aZ7mKxiK2LM81g79twqJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=alrwOv+k0+cKWO7vYyH3PR1cA4kgXUWP
	Tez9PL1liFP3AO06YS5Apy4E9Jffl5vV+gNgID6xK6MQbLegWlYr2tiD7DT6jVhD
	b5f9WgWtXQjrLS0kCOq/7m4+TTNbSdFx1ksxxXHxYkh/4nByjuGGY5wVIfZgengx
	taWGZxEJvfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A52A9706;
	Sun, 21 Oct 2012 15:16:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55C409704; Sun, 21 Oct 2012
 15:16:41 -0400 (EDT)
In-Reply-To: <1350819153-23491-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Sun, 21 Oct 2012 13:32:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D81FCFB2-1BB3-11E2-83F5-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208138>

Johan Herland <johan@herland.net> writes:

> Teach symbolic-ref to delete symrefs by adding the -d/--delete option to
> git-symbolic-ref. Both proper and dangling symrefs are deleted by this
> option, but other refs - or anything else that is not a symref - is not.
>
> The symref deletion is performed by first verifying that we are given a
> proper symref, and then invoking delete_ref() on it with the REF_NODEREF
> flag.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>
> Here is a quick first attempt at implementing the 'git symbolic-ref -d'
> you've been mentioning in the symref deletion thread.

Existing users are used to 'update-ref -d --no-deref SYM' being the
way to delete a symref (even though 'symbolic-ref SYM' being the way
to create one), I think, and the lack of this option in symbolic-ref
would not have hurt them, and addition of this option wouldn't help
them very much, either.

But addition of this option would help new people who wonder, after
creating a symref with 'symbolic-ref' (perhaps with a wrong name),
what command is to be used to remove it, finding no removal option
in the same command.

Thanks.

>  Documentation/git-symbolic-ref.txt | 10 +++++++++-
>  builtin/symbolic-ref.c             | 33 +++++++++++++++++++++++----------
>  t/t1401-symbolic-ref.sh            | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
> index 981d3a8..ef68ad2 100644
> --- a/Documentation/git-symbolic-ref.txt
> +++ b/Documentation/git-symbolic-ref.txt
> @@ -3,13 +3,14 @@ git-symbolic-ref(1)
>
>  NAME
>  ----
> -git-symbolic-ref - Read and modify symbolic refs
> +git-symbolic-ref - Read, modify and delete symbolic refs
>
>  SYNOPSIS
>  --------
>  [verse]
>  'git symbolic-ref' [-m <reason>] <name> <ref>
>  'git symbolic-ref' [-q] [--short] <name>
> +'git symbolic-ref' --delete [-q] <name>
>
>  DESCRIPTION
>  -----------
> @@ -21,6 +22,9 @@ argument to see which branch your working tree is on.
>  Given two arguments, creates or updates a symbolic ref <name> to
>  point at the given branch <ref>.
>
> +Given `--delete` and an additional argument, deletes the given
> +symbolic ref.
> +
>  A symbolic ref is a regular file that stores a string that
>  begins with `ref: refs/`.  For example, your `.git/HEAD` is
>  a regular file whose contents is `ref: refs/heads/master`.
> @@ -28,6 +32,10 @@ a regular file whose contents is `ref: refs/heads/master`.
>  OPTIONS
>  -------
>
> +-d::
> +--delete::
> +	Delete the symbolic ref <name>.
> +
>  -q::
>  --quiet::
>  	Do not issue an error message if the <name> is not a
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 9e92828..f481959 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -5,12 +5,11 @@
>
>  static const char * const git_symbolic_ref_usage[] = {
>  	N_("git symbolic-ref [options] name [ref]"),
> +	N_("git symbolic-ref -d [-q] name"),
>  	NULL
>  };
>
> -static int shorten;
> -
> -static void check_symref(const char *HEAD, int quiet)
> +static int check_symref(const char *HEAD, int quiet, int shorten, int print)
>  {
>  	unsigned char sha1[20];
>  	int flag;
> @@ -22,20 +21,24 @@ static void check_symref(const char *HEAD, int quiet)
>  		if (!quiet)
>  			die("ref %s is not a symbolic ref", HEAD);
>  		else
> -			exit(1);
> +			return 1;
> +	}
> +	if (print) {
> +		if (shorten)
> +			refname = shorten_unambiguous_ref(refname, 0);
> +		puts(refname);
>  	}
> -	if (shorten)
> -		refname = shorten_unambiguous_ref(refname, 0);
> -	puts(refname);
> +	return 0;
>  }
>
>  int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  {
> -	int quiet = 0;
> +	int quiet = 0, delete = 0, shorten = 0, ret = 0;
>  	const char *msg = NULL;
>  	struct option options[] = {
>  		OPT__QUIET(&quiet,
>  			N_("suppress error message for non-symbolic (detached) refs")),
> +		OPT_BOOL('d', "delete", &delete, N_("delete symbolic ref")),
>  		OPT_BOOL(0, "short", &shorten, N_("shorten ref output")),
>  		OPT_STRING('m', NULL, &msg, N_("reason"), N_("reason of the update")),
>  		OPT_END(),
> @@ -46,9 +49,19 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  			     git_symbolic_ref_usage, 0);
>  	if (msg &&!*msg)
>  		die("Refusing to perform update with empty message");
> +
> +	if (delete) {
> +		if (argc != 1)
> +			usage_with_options(git_symbolic_ref_usage, options);
> +		ret = check_symref(argv[0], 1, 0, 0);
> +		if (ret)
> +			die("Cannot delete %s, not a symbolic ref", argv[0]);
> +		return delete_ref(argv[0], NULL, REF_NODEREF);
> +	}
> +
>  	switch (argc) {
>  	case 1:
> -		check_symref(argv[0], quiet);
> +		ret = check_symref(argv[0], quiet, shorten, 1);
>  		break;
>  	case 2:
>  		if (!strcmp(argv[0], "HEAD") &&
> @@ -59,5 +72,5 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  	default:
>  		usage_with_options(git_symbolic_ref_usage, options);
>  	}
> -	return 0;
> +	return ret;
>  }
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index 2c96551..36378b0 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -33,4 +33,34 @@ test_expect_success 'symbolic-ref refuses bare sha1' '
>  '
>  reset_to_sane
>
> +test_expect_success 'symbolic-ref deletes HEAD' '
> +	git symbolic-ref -d HEAD &&
> +	test_path_is_file .git/refs/heads/foo &&
> +	test_path_is_missing .git/HEAD
> +'
> +reset_to_sane
> +
> +test_expect_success 'symbolic-ref deletes dangling HEAD' '
> +	git symbolic-ref HEAD refs/heads/missing &&
> +	git symbolic-ref -d HEAD &&
> +	test_path_is_missing .git/refs/heads/missing &&
> +	test_path_is_missing .git/HEAD
> +'
> +reset_to_sane
> +
> +test_expect_success 'symbolic-ref fails to delete missing FOO' '
> +	echo "fatal: Cannot delete FOO, not a symbolic ref" >expect &&
> +	test_must_fail git symbolic-ref -d FOO >actual 2>&1 &&
> +	test_cmp expect actual
> +'
> +reset_to_sane
> +
> +test_expect_success 'symbolic-ref fails to delete real ref' '
> +	echo "fatal: Cannot delete refs/heads/foo, not a symbolic ref" >expect &&
> +	test_must_fail git symbolic-ref -d refs/heads/foo >actual 2>&1 &&
> +	test_path_is_file .git/refs/heads/foo &&
> +	test_cmp expect actual
> +'
> +reset_to_sane
> +
>  test_done
> --
> 1.7.12.1.609.g5cd6968
