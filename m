Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6246DC433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13D9204EF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B377Jlfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbgJHRTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:19:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58313 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgJHRTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 13:19:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67D487E542;
        Thu,  8 Oct 2020 13:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v52FKUwvRq0A
        IN1XTVRJnpC3L2Q=; b=B377JlfhGdT7R5Faa3/VxpC9mmKZzAWe0vHi9/l2hYaQ
        Umg6xLLwFCGXponClPRsQb1lNJPtaKHCtpDWbi0z2jgLbXGRhR+Dq3cEeE2TTd0i
        qYLSpC3YXzYKkiHYdGSuNJmgxXoM1kD1ZJKbMVaPd5zrFjS/yfNXaSqKehEW4nE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qjCXmk
        Wht00r5hmPXXCriYxg9bIy+Dl1ffe5jmwWffgBQZ1rNxKnHouaopzwo5o6+6esDS
        SLY12jrLBTk404E3oPQ6PakmNtd7gD2IJL+2XKFySw01EzuKdLKGgPKn+Mi/grHw
        ZcXj+sapLMj/YHJL1rt8zg5B/hC7XymJNUGJw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D6187E541;
        Thu,  8 Oct 2020 13:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7F1C7E53F;
        Thu,  8 Oct 2020 13:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
        <20201007074538.25891-3-shouryashukla.oo@gmail.com>
Date:   Thu, 08 Oct 2020 10:19:14 -0700
In-Reply-To: <20201007074538.25891-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 7 Oct 2020 13:15:37 +0530")
Message-ID: <xmqqimbky6st.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63C6736E-098A-11EB-9E1E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> +static void config_added_submodule(struct add_data *info)
> +{

This one I may take a look at later, but won't review in this
message.

> +}
> +
> +static int module_add(int argc, const char **argv, const char *prefix)
> +{
> +	const char *branch =3D NULL, *custom_name =3D NULL, *realrepo =3D NUL=
L;
> +	const char *reference_path =3D NULL, *repo =3D NULL, *name =3D NULL;
> +	char *path;
> +	int force =3D 0, quiet =3D 0, depth =3D -1, progress =3D 0, dissociat=
e =3D 0;
> +	struct add_data info =3D ADD_DATA_INIT;
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	struct option options[] =3D {
> +		OPT_STRING('b', "branch", &branch, N_("branch"),
> +			   N_("branch of repository to add as submodule")),
> +		OPT_BOOL('f', "force", &force, N_("allow adding an otherwise "
> +						  "ignored submodule path")),
> +		OPT__QUIET(&quiet, N_("print only error messages")),
> +		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
> +		OPT_STRING(0, "reference", &reference_path, N_("repository"),
> +			   N_("reference repository")),
> +		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from r=
eference repositories")),
> +		OPT_STRING(0, "name", &custom_name, N_("name"),
> +			   N_("sets the submodule=E2=80=99s name to the given string "
> +			      "instead of defaulting to its path")),
> +		OPT_INTEGER(0, "depth", &depth, N_("depth for shallow clones")),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] =3D {
> +		N_("git submodule--helper add [<options>] [--] [<path>]"),
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (!is_writing_gitmodules_ok())
> +		die(_("please make sure that the .gitmodules file is in the working =
tree"));
> +
> +	if (reference_path && !is_absolute_path(reference_path) && prefix)

Checking "*prefix" lets us avoid an unnecessary allocation, i.e.

	if (prefix && *prefix &&
	    reference_path && !is_absolute_path(reference_path))

> +		reference_path =3D xstrfmt("%s%s", prefix, reference_path);
> +
> +	if (argc =3D=3D 0 || argc > 2) {

Nice that you are checking excess args, which the original didn't do.

> +		usage_with_options(usage, options);
> +	} else if (argc =3D=3D 1) {
> +		repo =3D argv[0];
> +		path =3D guess_dir_name(repo);

We've reviewed the function already.  Good.

> +	} else {
> +		repo =3D argv[0];
> +		path =3D xstrdup(argv[1]);

OK.  So after this if/else if/else cascade, path is an allocated
piece of memory we could later free() whichever branch is taken.

> +	}
> +
> +	if (!is_absolute_path(path) && prefix)
> +		path =3D xstrfmt("%s%s", prefix, path);

This also makes path freeable, but the original path is leaked.

	if (prefix && *prefix && !is_absolute_path(path)) {
		free(path);
		path =3D xstrfmt(...);
	}

Is there a reason (does not have to be a strong reason) why we use
'path', not 'sm_path', as the variable name that corresponds to
$sm_path in the original, by the way?

> +	/* assure repo is absolute or relative to parent */
> +	if (starts_with_dot_dot_slash(repo) || starts_with_dot_slash(repo)) {
> +		char *remote =3D get_default_remote();
> +		char *remoteurl;
> +		struct strbuf sb =3D STRBUF_INIT;
> +
> +		if (prefix)
> +			die(_("relative path can only be used from the toplevel "
> +			      "of the working tree"));

This is 'git submodule--helper resolve-relative-url "$repo"' in the
original.

> +		/* dereference source url relative to parent's url */
> +		strbuf_addf(&sb, "remote.%s.url", remote);
> +		if (git_config_get_string(sb.buf, &remoteurl))
> +			remoteurl =3D xgetcwd();
> +		realrepo =3D relative_url(remoteurl, repo, NULL);

And this is copied-and-pasted from resolve_relative_url() function
found in builtins/submodule--helper.c.

relative_url() returns an allocated memory so we can free() realrepo
if we took this branch.

> +		free(remoteurl);
> +		free(remote);
> +	} else if (is_dir_sep(repo[0]) || strchr(repo, ':')) {
> +		realrepo =3D repo;

This repo came from argv[0] so we cannot free realrepo if we took
this branch.  Are we willing to leak realrepo we obtained from the
other branch?

> +	} else {
> +		die(_("repo URL: '%s' must be absolute or begin with ./|../"),
> +		      repo);
> +	}
> +
> +	/*
> +	 * normalize path:
> +	 * multiple //; leading ./; /./; /../;
> +	 */
> +	normalize_path_copy(path, path);

It's nice that a handy (almost) equivalent helper is already
available ;-)

> +	/* strip trailing '/' */
> +	if (is_dir_sep(path[strlen(path) -1]))
> +		path[strlen(path) - 1] =3D '\0';

The original dealt with multiple trailing '/' but this one does not.
Shouldn't it loop starting at the end?

> +	if (check_sm_exists(force, path))
> +		return 1;

OK.  I think we reviewed the function.  Seeing it in the context of
the calling site makes us realize that it has a wrong name.  "check
submodule exists" sounds as if we expect a submodule to exist at the
path, and it is an error for a submodule not to be there, but that
is not what this caller (which is the only caller of the helper)
wants to check.  And more importantly, the helper reacts to anything
sitting at the path, not just submoudle.

So what does the helper really do?  I think it checks if it is OK to
create a submodule there.  IOW, "exists" part of the name is what
makes it a misnomer.  Perhaps "can_create_submodule()"?

> +	strbuf_addstr(&sb, path);
> +	if (is_nonbare_repository_dir(&sb)) {
> +		struct object_id oid;
> +		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
> +			die(_("'%s' does not have a commit checked out"), path);
> +	}
> +
> +	if (!force) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		struct child_process cp =3D CHILD_PROCESS_INIT;
> +		cp.git_cmd =3D 1;
> +		cp.no_stdout =3D 1;
> +		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
> +			     "--no-warn-embedded-repo", path, NULL);
> +		if (pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0)) {
> +			fprintf(stderr, _("%s"), sb.buf);

Sorry, but I cannot guess what this _("%s") is trying to achieve.
Shouldn't it be
			strbuf_complete_line(&sb);
			fputs(sb.buf, stderr);
instead?

> +			return 1;

The original honors the exit code from the dry-run and relays it to
the user.  Is this a regression, or nobody care what exit status
they get as long as it is not zero?

> +		}
> +		strbuf_release(&sb);
> +	}
> +
> +	name =3D custom_name ? custom_name : path;
> +	if (check_submodule_name(name))
> +		die(_("'%s' is not a valid submodule name"), name);
> +
> +	info.prefix =3D prefix;
> +	info.sm_name =3D name;
> +	info.sm_path =3D path;
> +	info.repo =3D repo;
> +	info.realrepo =3D realrepo;
> +	info.reference_path =3D reference_path;
> +	info.branch =3D branch;
> +	info.depth =3D depth;
> +	info.progress =3D !!progress;
> +	info.dissociate =3D !!dissociate;
> +	info.force =3D !!force;
> +	info.quiet =3D !!quiet;
> +
> +	if (add_submodule(&info))
> +		return 1;

I think we've reviewed this funciton already.

> +	config_added_submodule(&info);
> +
> +	free(path);

Looking a bit uneven wrt to leak handling.

> +	return 0;
> +}

Thanks.
