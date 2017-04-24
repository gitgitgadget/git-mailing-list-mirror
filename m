Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E2C207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 02:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164157AbdDXCYd (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 22:24:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53673 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164147AbdDXCYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 22:24:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD0CF7D29D;
        Sun, 23 Apr 2017 22:24:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z7UlqE2QN79ECBl12kQrPSNskG8=; b=MmkvWe
        5TAYIeYIVy7xyeNnGtrrXlS9vxK5Jrr4pwprCrY/m5JIKgL/8P9Njn1HsfWmDbc5
        BWp9YL6ESkI84n+dBRR6l0GnbdthPkhNnYoWMS1I7SlV20VYPLtklHi7yJKSYnvW
        ScOs1/yOSJao5KDAktbkhTwxNhiIsym20hAqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bcfOw0kU9DcBpw7WI77i0K1dSd0jBtrB
        jGTND+FqDY6hxIlInJc8TKrpDtJ+x4T1EyrIgVp7/JzfacRGsMkB1J5IkHKlUHEE
        oyxWE3HlURFAJ6ciOh2+Yxu+zS6u/uB0EtU+GeN/51CeTasIYKoKmWa/8B4BHWL3
        UoVY0mBdmkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A65EE7D29C;
        Sun, 23 Apr 2017 22:24:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18B777D29B;
        Sun, 23 Apr 2017 22:24:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: [GSoC][RFC/PATCH v2] submodule: port subcommand foreach from shell to C
References: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
        <20170422195804.18477-1-pc44800@gmail.com>
Date:   Sun, 23 Apr 2017 19:24:28 -0700
In-Reply-To: <20170422195804.18477-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sun, 23 Apr 2017 01:28:04 +0530")
Message-ID: <xmqqfugy35lv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 256B907E-2895-11E7-8C70-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static void foreach_submodule(int argc, const char **argv, const char *path,
> +			      const unsigned char *sha1, const char *prefix,
> +			      int quiet, int recursive)
> +{

I think that a reader would expect that a function whose name is
foreach_something() to iterate over some collection and do something
on each of them, but this is not.  It is "do something on one thing"
part in a loop that exists elsewhere.

Do not call such a helper "foreach_<something>".

Would it make more sense to use the "struct object_id" (instead of
uchar[40]) interface for new functions like this?

> +	const char *toplevel = xgetcwd();
> +	const struct submodule *sub;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf sub_sha1 = STRBUF_INIT;
> +	struct strbuf file = STRBUF_INIT;
> +	char* displaypath = NULL;
> +	int i;
> +
> +	/* Only loads from .gitmodules, no overlay with .git/config */
> +	gitmodules_config();
> +
> +	if (prefix && get_super_prefix()) {
> +		die("BUG: cannot have prefix and superprefix");
> +	} else if (prefix) {
> +		displaypath = xstrdup(relative_path(path, prefix,  &sb));

An extra SP after the last comma?

> +	} else if (get_super_prefix()) {
> +		strbuf_addf(&sb, "%s/%s", get_super_prefix(), path);
> +		displaypath = strbuf_detach(&sb, NULL);
> +	} else {
> +		displaypath = xstrdup(path);
> +	}
> +
> +	sub = submodule_from_path(null_sha1, path);
> +
> +	if (!sub)
> +		die(_("No url found for submodule path '%s' in .gitmodules"),
> +		      displaypath);
> +	strbuf_add_unique_abbrev(&sub_sha1, sha1 , 40);

Why add-unique-abbrev if we do not want to abbreviate at all (with
hardcoded constant 40)?  IOW, shouldn't this be

	strbuf_addstr(&sub_sha1, sha1_to_hex(sha1));

> +	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> +	argv_array_pushf(&cp.env_array, "path=%s", displaypath);
> +	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);

Why are we sending a value that will always be the same in two
variables?  "git submodule --help" seems to list only name, path,
sha1 and toplevel variables, and not sm_path.  Is it a documentation
bug, or are we clobbering a variable that the end user may be using
for other purposes in her foreach script?

> +	argv_array_pushf(&cp.env_array, "sha1=%s", sub_sha1.buf);
> +	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
> +
> +	cp.use_shell = 1;
> +	cp.dir = path;
> +
> +	for (i = 0; i < argc; i++)
> +		argv_array_push(&cp.args, argv[i]);
> +
> +	strbuf_addstr(&file, path);
> +	strbuf_addstr(&file, "/.git");
> +
> +	if (!quiet && !access_or_warn(file.buf, R_OK, 0))
> +		printf(_("Entering '%s'\n"), displaypath);
> +
> +	if (!access_or_warn(file.buf, R_OK, 0))
> +		run_command(&cp);
> +
> +	if(recursive) {

Missing SP after "if".

More importantly, if the earlier access-or-warn failed and we didn't
do the run-command for the path, does it even make sense to recurse
into it?

The original scripted version seems to refrain from recursing into
it if the command fails in the submodule in the first place.  This
code discards the exit status from run_command(), which looks wrong.

> +		struct child_process cpr = CHILD_PROCESS_INIT;
> +
> +		cpr.use_shell = 1;
> +		cpr.dir = path;
> +
> +		argv_array_pushf(&cpr.args, "git");
> +		argv_array_pushf(&cpr.args, "--super-prefix");
> +		argv_array_push(&cpr.args, displaypath);
> +		argv_array_pushf(&cpr.args, "submodule--helper");
> +
> +		if (quiet)
> +			argv_array_pushf(&cpr.args, "--quiet");
> +
> +		argv_array_pushf(&cpr.args, "foreach");
> +		argv_array_pushf(&cpr.args, "--recursive");
> +
> +		for (i = 0; i < argc; i++)
> +			argv_array_push(&cpr.args, argv[i]);
> +
> +		run_command(&cpr);

Similarly, the exit status of this invocation is discarded, which
probably is wrong.  The original seems to pay attention to the
failure from the command invoked via "foreach --recursive" and stops
interation when it sees a failure.

> +static int module_foreach(int argc, const char **argv, const char *prefix)
> +{
> +	struct pathspec pathspec;
> +	struct module_list list = MODULE_LIST_INIT;
> +	int quiet = 0;
> +	int recursive = 0;
> +	int i;
> +
> +	struct option module_foreach_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output of entering each submodule command")),
> +		OPT_BOOL(0, "recursive", &recursive,
> +			 N_("Recurse into nested submodules")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper [--quiet] foreach [--recursive] <command>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_foreach_options,
> +			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);

> +	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
> +			die("BUG: module_list_compute should not choke on empty pathspec");

This line would fit within 80-col if it weren't overly indented, I
would think.

One suggestion.

Start by updating "git submodule foreach [--recursive]" tests in t/
directory before writing any more C code.  Arrange to have two
submodules, have your custom command that is run with foreach fail
in the first submodule, and write a test that documents the
behaviour of the scripted version (e.g. your custom command should
not be even run inside the second submodule).  Add a similar test
with two submodules, first of which has a nested submodule, and have
your custom command fail in one of these three places, and document
the behaviour of the scripted version (e.g. your custom command will
run for the first submodule, and if it fails there, does not run in
the nested submodule or in the second submodule; if your custom
command succeeds in the first submodule, it goes to its nested
submodule, and if your custom command fails there, the second
submodule will not visited, etc.).

Also if it is not done in the existing tests, perhaps writing tests
or two with submodules whose names are "submodule 1", "submodule 2",
etc. and making sure that there is no funny splitting of the arguments
would be a healthy thing to do.

After getting that working, then start writing the above C code.
That would catch cases where your "rewrite in C" accidentally
introduces regressions.

Thanks.
