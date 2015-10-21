From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 26/26] introduce "extensions" form of core.repositoryformatversion
Date: Wed, 21 Oct 2015 12:40:21 -0700
Message-ID: <xmqqy4ewui1m.fsf@gitster.mtv.corp.google.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
	<1444938410-2345-27-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:48:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozNL-0001rA-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbbJUTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:48:30 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756039AbbJUTs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:48:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6152523486;
	Wed, 21 Oct 2015 15:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bA+gx7dgThwGuxiCSW6X3ZxWg2A=; b=FFImpu
	O+LXKw+X1HBSPY+GbfKy+OlcDrvRCqmRGElWj+iqR3iSVuCAhA2KQs83cyUR5VIG
	hlEnpy+9Sc/h6P2RNv5C8Qf/ccux6zZnuEvbFY/NV7L9dUbBfELxmELZnRu+zUiF
	DwvG4QVKZICRXrDCOZxGRRLomfOpr5HXi4OoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUL3bHZG+EMIrSZOX9Iz58IziM1d7ZfE
	2Mzny9bMiEM2gZdeRfW1uH5GTrwgvYYPgWXq4q0OQR2BX4XsNRA8GVqucPoHz+0Q
	vqjHXeE/TG84pyCcnbCxxhSvyLyM4rdirLcHJd4NOpyjGJ3/uwCIRArOwtSOO+VH
	GfMJLwDMpvQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5927223485;
	Wed, 21 Oct 2015 15:40:23 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C44D623484;
	Wed, 21 Oct 2015 15:40:22 -0400 (EDT)
In-Reply-To: <1444938410-2345-27-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 15 Oct 2015 15:46:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91B52F90-782B-11E5-BE79-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280005>

David Turner <dturner@twopensource.com> writes:

> From: Jeff King <peff@peff.net>

I just made sure this is bit-for-bit identical with the first of the
two patches I received from Peff and I locally have kept.

Re-reading the two patches again, I do not see a reason why we should
reject them.  I'll queue this and the other "precious object" one
separately.

Thanks.

>
> Normally we try to avoid bumps of the whole-repository
> core.repositoryformatversion field. However, it is
> unavoidable if we want to safely change certain aspects of
> git in a backwards-incompatible way (e.g., modifying the set
> of ref tips that we must traverse to generate a list of
> unreachable, safe-to-prune objects).
>
> If we were to bump the repository version for every such
> change, then any implementation understanding version `X`
> would also have to understand `X-1`, `X-2`, and so forth,
> even though the incompatibilities may be in orthogonal parts
> of the system, and there is otherwise no reason we cannot
> implement one without the other (or more importantly, that
> the user cannot choose to use one feature without the other,
> weighing the tradeoff in compatibility only for that
> particular feature).
>
> This patch documents the existing repositoryformatversion
> strategy and introduces a new format, "1", which lets a
> repository specify that it must run with an arbitrary set of
> extensions. This can be used, for example:
>
>  - to inform git that the objects should not be pruned based
>    only on the reachability of the ref tips (e.g, because it
>    has "clone --shared" children)
>
>  - that the refs are stored in a format besides the usual
>    "refs" and "packed-refs" directories
>
> Because we bump to format "1", and because format "1"
> requires that a running git knows about any extensions
> mentioned, we know that older versions of the code will not
> do something dangerous when confronted with these new
> formats.
>
> For example, if the user chooses to use database storage for
> refs, they may set the "extensions.refbackend" config to
> "db". Older versions of git will not understand format "1"
> and bail. Versions of git which understand "1" but do not
> know about "refbackend", or which know about "refbackend"
> but not about the "db" backend, will refuse to run. This is
> annoying, of course, but much better than the alternative of
> claiming that there are no refs in the repository, or
> writing to a location that other implementations will not
> read.
>
> Note that we are only defining the rules for format 1 here.
> We do not ever write format 1 ourselves; it is a tool that
> is meant to be used by users and future extensions to
> provide safety with older implementations.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/technical/repository-version.txt | 81 ++++++++++++++++++++++++++
>  cache.h                                        |  6 ++
>  setup.c                                        | 37 +++++++++++-
>  t/t1302-repo-version.sh                        | 38 ++++++++++++
>  4 files changed, 159 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/technical/repository-version.txt
>
> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> new file mode 100644
> index 0000000..3d7106d
> --- /dev/null
> +++ b/Documentation/technical/repository-version.txt
> @@ -0,0 +1,81 @@
> +Git Repository Format Versions
> +==============================
> +
> +Every git repository is marked with a numeric version in the
> +`core.repositoryformatversion` key of its `config` file. This version
> +specifies the rules for operating on the on-disk repository data. An
> +implementation of git which does not understand a particular version
> +advertised by an on-disk repository MUST NOT operate on that repository;
> +doing so risks not only producing wrong results, but actually losing
> +data.
> +
> +Because of this rule, version bumps should be kept to an absolute
> +minimum. Instead, we generally prefer these strategies:
> +
> +  - bumping format version numbers of individual data files (e.g.,
> +    index, packfiles, etc). This restricts the incompatibilities only to
> +    those files.
> +
> +  - introducing new data that gracefully degrades when used by older
> +    clients (e.g., pack bitmap files are ignored by older clients, which
> +    simply do not take advantage of the optimization they provide).
> +
> +A whole-repository format version bump should only be part of a change
> +that cannot be independently versioned. For instance, if one were to
> +change the reachability rules for objects, or the rules for locking
> +refs, that would require a bump of the repository format version.
> +
> +Note that this applies only to accessing the repository's disk contents
> +directly. An older client which understands only format `0` may still
> +connect via `git://` to a repository using format `1`, as long as the
> +server process understands format `1`.
> +
> +The preferred strategy for rolling out a version bump (whether whole
> +repository or for a single file) is to teach git to read the new format,
> +and allow writing the new format with a config switch or command line
> +option (for experimentation or for those who do not care about backwards
> +compatibility with older gits). Then after a long period to allow the
> +reading capability to become common, we may switch to writing the new
> +format by default.
> +
> +The currently defined format versions are:
> +
> +Version `0`
> +-----------
> +
> +This is the format defined by the initial version of git, including but
> +not limited to the format of the repository directory, the repository
> +configuration file, and the object and ref storage. Specifying the
> +complete behavior of git is beyond the scope of this document.
> +
> +Version `1`
> +-----------
> +
> +This format is identical to version `0`, with the following exceptions:
> +
> +  1. When reading the `core.repositoryformatversion` variable, a git
> +     implementation which supports version 1 MUST also read any
> +     configuration keys found in the `extensions` section of the
> +     configuration file.
> +
> +  2. If a version-1 repository specifies any `extensions.*` keys that
> +     the running git has not implemented, the operation MUST NOT
> +     proceed. Similarly, if the value of any known key is not understood
> +     by the implementation, the operation MUST NOT proceed.
> +
> +Note that if no extensions are specified in the config file, then
> +`core.repositoryformatversion` SHOULD be set to `0` (setting it to `1`
> +provides no benefit, and makes the repository incompatible with older
> +implementations of git).
> +
> +This document will serve as the master list for extensions. Any
> +implementation wishing to define a new extension should make a note of
> +it here, in order to claim the name.
> +
> +The defined extensions are:
> +
> +`noop`
> +~~~~~~
> +
> +This extension does not change git's behavior at all. It is useful only
> +for testing format-1 compatibility.
> diff --git a/cache.h b/cache.h
> index 1d8a051..4b03cb3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -696,7 +696,13 @@ extern char *notes_ref_name;
>  
>  extern int grafts_replace_parents;
>  
> +/*
> + * GIT_REPO_VERSION is the version we write by default. The
> + * _READ variant is the highest number we know how to
> + * handle.
> + */
>  #define GIT_REPO_VERSION 0
> +#define GIT_REPO_VERSION_READ 1
>  extern int repository_format_version;
>  extern int check_repository_format(void);
>  
> diff --git a/setup.c b/setup.c
> index 2b64cbb..0c29469 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -5,6 +5,7 @@
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
>  static int work_tree_config_is_bogus;
> +static struct string_list unknown_extensions = STRING_LIST_INIT_DUP;
>  
>  /*
>   * The input parameter must contain an absolute path, and it must already be
> @@ -349,10 +350,23 @@ void setup_work_tree(void)
>  
>  static int check_repo_format(const char *var, const char *value, void *cb)
>  {
> +	const char *ext;
> +
>  	if (strcmp(var, "core.repositoryformatversion") == 0)
>  		repository_format_version = git_config_int(var, value);
>  	else if (strcmp(var, "core.sharedrepository") == 0)
>  		shared_repository = git_config_perm(var, value);
> +	else if (skip_prefix(var, "extensions.", &ext)) {
> +		/*
> +		 * record any known extensions here; otherwise,
> +		 * we fall through to recording it as unknown, and
> +		 * check_repository_format will complain
> +		 */
> +		if (!strcmp(ext, "noop"))
> +			;
> +		else
> +			string_list_append(&unknown_extensions, ext);
> +	}
>  	return 0;
>  }
>  
> @@ -363,6 +377,8 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
>  	config_fn_t fn;
>  	int ret = 0;
>  
> +	string_list_clear(&unknown_extensions, 0);
> +
>  	if (get_common_dir(&sb, gitdir))
>  		fn = check_repo_format;
>  	else
> @@ -380,16 +396,31 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
>  	 * is a good one.
>  	 */
>  	git_config_early(fn, NULL, repo_config);
> -	if (GIT_REPO_VERSION < repository_format_version) {
> +	if (GIT_REPO_VERSION_READ < repository_format_version) {
>  		if (!nongit_ok)
>  			die ("Expected git repo version <= %d, found %d",
> -			     GIT_REPO_VERSION, repository_format_version);
> +			     GIT_REPO_VERSION_READ, repository_format_version);
>  		warning("Expected git repo version <= %d, found %d",
> -			GIT_REPO_VERSION, repository_format_version);
> +			GIT_REPO_VERSION_READ, repository_format_version);
>  		warning("Please upgrade Git");
>  		*nongit_ok = -1;
>  		ret = -1;
>  	}
> +
> +	if (repository_format_version >= 1 && unknown_extensions.nr) {
> +		int i;
> +
> +		if (!nongit_ok)
> +			die("unknown repository extension: %s",
> +			    unknown_extensions.items[0].string);
> +
> +		for (i = 0; i < unknown_extensions.nr; i++)
> +			warning("unknown repository extension: %s",
> +				unknown_extensions.items[i].string);
> +		*nongit_ok = -1;
> +		ret = -1;
> +	}
> +
>  	strbuf_release(&sb);
>  	return ret;
>  }
> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> index 0d9388a..8dd6fd7 100755
> --- a/t/t1302-repo-version.sh
> +++ b/t/t1302-repo-version.sh
> @@ -67,4 +67,42 @@ test_expect_success 'gitdir required mode' '
>  	)
>  '
>  
> +check_allow () {
> +	git rev-parse --git-dir >actual &&
> +	echo .git >expect &&
> +	test_cmp expect actual
> +}
> +
> +check_abort () {
> +	test_must_fail git rev-parse --git-dir
> +}
> +
> +# avoid git-config, since it cannot be trusted to run
> +# in a repository with a broken version
> +mkconfig () {
> +	echo '[core]' &&
> +	echo "repositoryformatversion = $1" &&
> +	shift &&
> +
> +	if test $# -gt 0; then
> +		echo '[extensions]' &&
> +		for i in "$@"; do
> +			echo "$i"
> +		done
> +	fi
> +}
> +
> +while read outcome version extensions; do
> +	test_expect_success "$outcome version=$version $extensions" "
> +		mkconfig $version $extensions >.git/config &&
> +		check_${outcome}
> +	"
> +done <<\EOF
> +allow 0
> +allow 1
> +allow 1 noop
> +abort 1 no-such-extension
> +allow 0 no-such-extension
> +EOF
> +
>  test_done
