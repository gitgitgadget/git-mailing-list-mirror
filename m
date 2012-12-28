From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/19] Add git-check-ignore sub-command
Date: Fri, 28 Dec 2012 13:21:02 -0800
Message-ID: <7vtxr5ho01.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-20-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TohN2-0004Se-OF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 22:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab2L1VVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 16:21:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab2L1VVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 16:21:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22567AAAB;
	Fri, 28 Dec 2012 16:21:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nxfeBbSBlUaygdZiBaD+I+Oa3uk=; b=rr3+/X
	o5Ke9Zo5zJgGtX3eLNplb1XznVgPDeYNxfLCiv9h8yN9zAd8MEQ9oDpc3oJhcR0Z
	7+dl7EPuTASqeEUqrKixFwbJuKJO3q6pL6N42rXChDI7XWr4hOeFMF7Oj7pDa39K
	jgE8A0gsWQ+RZgMJ/354l7i3TcjiOCx0Nu/lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ORnM2Qe0qPSrsq5PChzfL3rTqTCkzpQf
	rgLzGbqR/4Mqbo+v1CdLDftUcOJIie5tkUHiDJMHksBoM7H29jsqQzrkG59NFg31
	pa3XDU+X8LJnyVhLDrtDYvV2vEp8F4JwlhUUO8u2AUVOdojGu1c++Q7/G9JF4ojT
	PjvQ5rB6k8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3A7AAA9;
	Fri, 28 Dec 2012 16:21:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 443AEAAA2; Fri, 28 Dec 2012
 16:21:04 -0500 (EST)
In-Reply-To: <1356575558-2674-20-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C771A6A-5134-11E2-96A9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212266>

Adam Spiers <git@adamspiers.org> writes:

> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> new file mode 100644
> index 0000000..c825736
> --- /dev/null
> +++ b/builtin/check-ignore.c
> @@ -0,0 +1,170 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "dir.h"
> +#include "quote.h"
> +#include "pathspec.h"
> +#include "parse-options.h"
> +
> +static int quiet, verbose, stdin_paths;
> +static const char * const check_ignore_usage[] = {
> +"git check-ignore [options] pathname...",
> +"git check-ignore [options] --stdin < <list-of-paths>",
> +NULL
> +};
> +
> +static int null_term_line;
> +
> +static const struct option check_ignore_options[] = {
> +	OPT__QUIET(&quiet, N_("suppress progress reporting")),
> +	OPT__VERBOSE(&verbose, N_("be verbose")),
> +	OPT_GROUP(""),
> +	OPT_BOOLEAN(0, "stdin", &stdin_paths,
> +		    N_("read file names from stdin")),
> +	OPT_BOOLEAN('z', NULL, &null_term_line,
> +		    N_("input paths are terminated by a null character")),
> +	OPT_END()
> +};
> +
> +static void output_exclude(const char *path, struct exclude *exclude)
> +{
> +	char *bang = exclude->flags & EXC_FLAG_NEGATIVE ? "!" : "";
> +	char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";

That's inconsistent.  Either s/bang/negated/ or s/dir/slash/ (but
obviously not both).

> +static int check_ignore(const char *prefix, const char **pathspec)
> +{
> +	struct dir_struct dir;
> +...
> +	if (pathspec) {
> +...
> +	} else {
> +		printf("no pathspec\n");
> +	}

Is this an error message, an informative warning, or what?  The
command is presumably for script consumption downstream of a pipe.
Does it make sense to emit this message to their standard input?
Does it even have to be output?  Especially what should happen when
the user says "--quiet"?

Perhaps

	if (!quiet)
		fprintf(stderr, "no pathspec given.\n");

or something?

> +int cmd_check_ignore(int argc, const char **argv, const char *prefix)
> +{
> +	int num_ignored = 0;

I do not think you need to initialize this one.

> +	if (stdin_paths) {
> +		num_ignored = check_ignore_stdin_paths(prefix);
> +	} else {
> +		num_ignored = check_ignore(prefix, argv);
> +		maybe_flush_or_die(stdout, "ignore to stdout");
> +	}
> +
> +	return num_ignored > 0 ? 0 : 1;

Given that num_ignored will always be >=0, that is a funny way to
say

	return !num_ignored;

or if you plan to report a non-fatal error as negative return from
the two check_ignore* functions, perhaps:

	return num_ignored <= 0;

> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> new file mode 100755
> index 0000000..3937ca4
> --- /dev/null
> +++ b/t/t0008-ignores.sh
> @@ -0,0 +1,595 @@
> +#!/bin/sh
> +
> +test_description=check-ignore
> +
> +. ./test-lib.sh
> +
> +init_vars () {
> +	global_excludes="$(pwd)/global-excludes"
> +}
> +
> +enable_global_excludes () {
> +	init_vars
> +	git config core.excludesfile "$global_excludes"
> +}
> +
> +expect_in () {
> +	dest="$HOME/expected-$1" text="$2"
> +	if test -z "$text"
> +	then
> +		>"$dest" # avoid newline
> +	else
> +		echo "$text" >"$dest"
> +	fi
> +}
> +
> +expect () {
> +	expect_in stdout "$1"
> +}
> +
> +expect_from_stdin () {
> +	cat >"$HOME/expected-stdout"
> +}
> +
> +test_stderr () {
> +	expected="$1"
> +	expect_in stderr "$1" &&
> +	test_cmp "$HOME/expected-stderr" "$HOME/stderr"
> +}
> +
> +stderr_contains () {
> +	regexp="$1"
> +	if grep -q "$regexp" "$HOME/stderr"

Please do not use "grep -q"; the output from commands in test
harness is normally hidden already.  This only makes script more
cluttered and robs debuggers of potentially useful output when the
test script is run with "-v".

> +test_check_ignore () {
> +	args="$1" expect_code="${2:-0}" global_args="$3"
> +
> +	init_vars &&
> +	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
> +	echo git $global_args check-ignore $quiet_opt $verbose_opt $args \
> +		>"$HOME/cmd" &&

Does a debugger needs this "cmd" file when we already have "-v" option?

> +test_expect_success_multi () {
> +	prereq=
> +	if test $# -eq 4
> +	then
> +		prereq=$1
> +		shift
> +	fi
> +	testname="$1" expect_verbose="$2" code="$3"
> +
> +	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
> +
> +	test_expect_success $prereq "$testname" "
> +		expect '$expect' &&
> +		$code
> +	"

This is brittle when $expect may have single quotes, isn't it?
Perhaps

	test_expect_success $prereq "$testname" '
		expect "$expect" && eval "$code"
        '

may fix it, but in general I hate to see each test script trying to
invent their own mini-harness like this (and getting them wrong).
