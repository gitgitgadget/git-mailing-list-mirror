Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB527B50F
	for <git@vger.kernel.org>; Sat,  3 May 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292909; cv=none; b=WGsRTLc6q3XDOCTpCPANO4Wehx7ZO6sCLedXOdUewsxswxqRpgOReJoPzCgWJBw90K+zCKStNOYJDMJDH2m5mIoalsV+FhUAo24Aj1V9tAokgVk7c2ra5ISE3hgSo6GtPm0x38gnSbd9IeLPUZrNWpsxUeAyEuIin7g4nSX3Pg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292909; c=relaxed/simple;
	bh=3ZopvySXEpt5sIGHSVy3kiOpb+YsySFJ5UupLVEl5t0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1CDNSURxXy6Vj7AgXkHyQArbRk7Ghb+NB8RWQcSJSO+tBpG/s+kNV2xNee2cag5AEndM3VpzqNepZoQTuDQ+3IUhuIBwPNUvTsycOSvY8Fsmq9N5CDnmm3Y95Ya8oo1VnP+Uhej3FsYXslp9kbQb6/V83h/8c+axU2daJJPIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 543HJuAh882540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 May 2025 17:19:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Lazar Sumar'" <sumar@lazar.co.nz>, <git@vger.kernel.org>
Cc: "'Lazar Sumar'" <bugzilla@lazar.co.nz>,
        "'Denton Liu'" <liu.denton@gmail.com>,
        "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Calvin Wan'" <calvinwan@google.com>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Derrick Stolee'" <stolee@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
References: <20250503160953.196329-1-bugzilla@lazar.co.nz> <20250503160953.196329-2-bugzilla@lazar.co.nz>
In-Reply-To: <20250503160953.196329-2-bugzilla@lazar.co.nz>
Subject: RE: [PATCH 1/1] Add git remote group sub-command
Date: Sat, 3 May 2025 13:19:52 -0400
Organization: Nexbridge Inc.
Message-ID: <001401dbbc4f$98c8db20$ca5a9160$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIoYKjvJ36FTcMPu+R7isL4GNY6TAB8X9tKsyP6fTA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250503-4, 5/3/2025), Outbound message
X-Antivirus-Status: Clean

On May 3, 2025 12:10 PM, Lazar Sumar wrote:
>Remote groups are an existing feature of git presently managed =
exclusively via the
>config. This patch gives them their own subcommand for listing the =
existing groups
>with the intent of adding future subcommands under it for
>adding/updating/removing groups.

Can you expand on the primary use case, please? Specifically the =
implications of what
The group subcommand not only does but the side effects of using it.

Thanks.

>As a side-effect this command can now be used in bash tab completion =
for the fetch
>command which did not offer them as a completion option previously. =
Note that
>the push command does not accept remote groups as an argument.
>
>Signed-off-by: Lazar Sumar <bugzilla@lazar.co.nz>
>---
> Documentation/git-remote.adoc          |  6 ++++
> builtin/remote.c                       | 47 ++++++++++++++++++++++++++
> contrib/completion/git-completion.bash | 21 ++++++++++--
> t/t5506-remote-groups.sh               | 31 +++++++++++++++++
> 4 files changed, 103 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/git-remote.adoc =
b/Documentation/git-remote.adoc
>index 932a5c3ea4..87ddda8d58 100644
>--- a/Documentation/git-remote.adoc
>+++ b/Documentation/git-remote.adoc
>@@ -22,6 +22,7 @@ SYNOPSIS
> 'git remote' [-v | --verbose] 'show' [-n] <name>...
> 'git remote prune' [-n | --dry-run] <name>...
> 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | =
<remote>)...]
>+'git remote group'
>
> DESCRIPTION
> -----------
>@@ -197,6 +198,11 @@ be updated.  (See linkgit:git-config[1]).
> +
> With `--prune` option, run pruning against all the remotes that are =
updated.
>
>+'group'::
>+
>+List all configured remote groups. The remote groups configuration is
>+achieved using the `remotes.<group>` configuration variables.  (See
>+linkgit:git-config[1]).
>
> DISCUSSION
> ----------
>diff --git a/builtin/remote.c b/builtin/remote.c index =
b4baa34e66..2217447230
>100644
>--- a/builtin/remote.c
>+++ b/builtin/remote.c
>@@ -28,6 +28,7 @@ static const char * const builtin_remote_usage[] =3D =
{
> 	N_("git remote [-v | --verbose] show [-n] <name>"),
> 	N_("git remote prune [-n | --dry-run] <name>"),
> 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> |
><remote>)...]"),
>+	N_("git remote group"),
> 	N_("git remote set-branches [--add] <name> <branch>..."),
> 	N_("git remote get-url [--push] [--all] <name>"),
> 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"), @@ =
-77,6
>+78,11 @@ static const char * const builtin_remote_update_usage[] =3D {
> 	NULL
> };
>
>+static const char * const builtin_remote_group_usage[] =3D {
>+	N_("git remote group"),
>+	NULL
>+};
>+
> static const char * const builtin_remote_geturl_usage[] =3D {
> 	N_("git remote get-url [--push] [--all] <name>"),
> 	NULL
>@@ -1633,6 +1639,46 @@ static int update(int argc, const char **argv, =
const char
>*prefix,
> 	return run_command(&cmd);
> }
>
>+static int get_remote_group(const char *key, const char *value UNUSED,
>+			    const struct config_context *ctx UNUSED,
>+			    void *priv)
>+{
>+	struct string_list *remote_group_list =3D priv;
>+
>+	if (skip_prefix(key, "remotes.", &key)) {
>+		size_t wordlen =3D strlen(key);
>+		if (wordlen >=3D 1)
>+			string_list_append_nodup(remote_group_list,
>+						xstrndup(key, wordlen));
>+	}
>+	string_list_remove_duplicates(remote_group_list, 0);
>+
>+	return 0;
>+}
>+
>+static int group(int argc, const char **argv, const char *prefix,
>+	struct repository *repo UNUSED)
>+{
>+	struct string_list remote_group_list =3D STRING_LIST_INIT_DUP;
>+	struct option options[] =3D {
>+		OPT_END()
>+	};
>+
>+	argc =3D parse_options(argc, argv, prefix, options,
>+		builtin_remote_group_usage, 0);
>+	if (argc !=3D 0)
>+		usage_with_options(builtin_remote_group_usage, options);
>+
>+	git_config(get_remote_group, &remote_group_list);
>+	for (int i =3D 0; i < remote_group_list.nr; i++) {
>+		const char *name =3D remote_group_list.items[i].string;
>+		printf_ln(_("%s"), name);
>+	}
>+	string_list_clear(&remote_group_list, 0);
>+
>+	return 0;
>+}
>+
> static int remove_all_fetch_refspecs(const char *key)  {
> 	return git_config_set_multivar_gently(key, NULL, NULL, @@ -1844,6
>+1890,7 @@ int cmd_remote(int argc,
> 		OPT_SUBCOMMAND("show", &fn, show),
> 		OPT_SUBCOMMAND("prune", &fn, prune),
> 		OPT_SUBCOMMAND("update", &fn, update),
>+		OPT_SUBCOMMAND("group", &fn, group),
> 		OPT_END()
> 	};
>
>diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-
>completion.bash
>index e3d88b0672..658bea9d96 100644
>--- a/contrib/completion/git-completion.bash
>+++ b/contrib/completion/git-completion.bash
>@@ -1050,6 +1050,17 @@ __git_remotes ()
> 	__git remote
> }
>
>+__git_remote_groups ()
>+{
>+	__git remote group
>+}
>+
>+__git_remotes_or_groups ()
>+{
>+	__git_remotes
>+	__git_remote_groups
>+}
>+
> # Returns true if $1 matches the name of a configured remote, false =
otherwise.
> __git_is_configured_remote ()
> {
>@@ -1181,7 +1192,10 @@ __git_complete_remote_or_refspec ()
> 		((c++))
> 	done
> 	if [ -z "$remote" ]; then
>-		__gitcomp_nl "$(__git_remotes)"
>+		case "$cmd" in
>+		push) __gitcomp_nl "$(__git_remotes)" ;;
>+		*) __gitcomp_nl "$(__git_remotes_or_groups)" ;;
>+		esac
> 		return
> 	fi
> 	if [ $no_complete_refspec =3D 1 ]; then
>@@ -3073,7 +3087,7 @@ _git_remote ()
> {
> 	local subcommands=3D"
> 		add rename remove set-head set-branches
>-		get-url set-url show prune update
>+		get-url set-url show prune update group
> 		"
> 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> 	if [ -z "$subcommand" ]; then
>@@ -3109,6 +3123,9 @@ _git_remote ()
> 	update,*)
> 		__gitcomp "$(__git_remotes) $(__git_get_config_variables
>"remotes")"
> 		;;
>+	group,--*)
>+		__gitcomp_builtin remote_group
>+		;;
> 	set-url,--*)
> 		__gitcomp_builtin remote_set-url
> 		;;
>diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh index
>16e9a1bc2f..7859e6805b 100755
>--- a/t/t5506-remote-groups.sh
>+++ b/t/t5506-remote-groups.sh
>@@ -31,6 +31,12 @@ repo_fetched() {
> 	return 1
> }
>
>+check_groups() {
>+	echo $@ | sort >expected_groups;
>+	git remote group | sort >listed_groups;
>+	git diff --no-index --quiet expected_groups listed_groups }
>+
> test_expect_success 'setup' '
> 	mkdir one && (cd one && git init) &&
> 	mkdir two && (cd two && git init) &&
>@@ -64,6 +70,12 @@ test_expect_success 'updating group updates all =
members
>(remote update)' '
> 	repo_fetched two
> '
>
>+test_expect_success 'prints the configured group "all" once (remote =
group)' '
>+	echo "all" >expect &&
>+	test_expect_code 0 git remote group 1>actual &&
>+	test_cmp expect actual
>+'
>+
> test_expect_success 'updating group updates all members (fetch)' '
> 	mark fetch-group-all &&
> 	update_repos &&
>@@ -81,6 +93,15 @@ test_expect_success 'updating group does not update =
non-
>members (remote update)'
> 	! repo_fetched two
> '
>
>+test_expect_success 'prints configured groups "all" and "some" (remote =
group)' '
>+	cat >expect <<-EOF &&
>+	all
>+	some
>+	EOF
>+	test_expect_code 0 git remote group 1>actual &&
>+	test_cmp expect actual
>+'
>+
> test_expect_success 'updating group does not update non-members =
(fetch)' '
> 	mark fetch-group-some &&
> 	update_repos &&
>@@ -107,4 +128,14 @@ test_expect_success 'updating group in parallel =
with a
>duplicate remote does not
> 	repo_fetched one
> '
>
>+test_expect_success 'groups are printed in order of configuration =
(remote group)' '
>+	cat >expect <<-EOF &&
>+	all
>+	some
>+	duplicate
>+	EOF
>+	test_expect_code 0 git remote group 1>actual &&
>+	test_cmp expect actual
>+'
>+
> test_done
>--
>2.49.0.460.g0390bdefd0.dirty

