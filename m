Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05CC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0B76124C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354537AbhESO7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:59:01 -0400
Received: from outmail148110.authsmtp.com ([62.13.148.110]:17746 "EHLO
        outmail148110.authsmtp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239447AbhESO7A (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 10:59:00 -0400
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 10:59:00 EDT
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
        by punt17.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 14JEfwgo034126;
        Wed, 19 May 2021 15:41:58 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from [192.168.0.212] (177.30.125.91.dyn.plus.net [91.125.30.177])
        (authenticated bits=0)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id 14JEfuJO076342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 19 May 2021 15:41:57 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Subject: Re: Bug in git submodule update --remote
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
 <EB55447C-538F-44DE-BFC0-A3BD1A970E99@gmail.com>
From:   Ben Avison <bavison@riscosopen.org>
Organization: RISC OS Open Ltd
Message-ID: <a727c1af-4993-684d-d299-00bf1a47cfc7@riscosopen.org>
Date:   Wed, 19 May 2021 15:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <EB55447C-538F-44DE-BFC0-A3BD1A970E99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Server-Quench: 5c921b19-b8b0-11eb-ba2e-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd1YggXA1ZfRRob ESQCJDVBUg4iPRpU DBlFKhFVNl8UURhQ KkJXbgASJgRNAnRQ SnkJW1ZVQFx0U2d0 YQ9WIwxcfEtMWhtp UFZIRVVNFgBqBAMA SB8aKGwkMn85eHl2 ZkJgEHlSW0A0cBV0 QE8GFGQbN28yaH0e URUKalEFclZXdhtG bll4VXILaDFUKBg1 TUcZIj95PDMXJyVJ ChoQJ1cVTVsPE3Yh XxwLAThnWAgfSiA0 MxFO
X-Authentic-SMTP: 61633632303230.1024:7600
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 91.125.30.177/2525
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/05/2021 11:49, Atharva Raykar wrote:
> If I understood you correctly, you'd prefer that the updating of the
> submodule should be independent of the ref that is checked out in the
> submodule's directory.
> 
> While I am not sure of the reason why the design of 'update
> --remote' uses the remote-tracking branch of the submodule, I can
> imagine adding a switch like 'submodule.<name>.remote' that defaults
> to 'origin'. Then the behaviour could be changed such that it always 
> pulls from the remote specified in that option.
> 
> This would help make the behaviour consistent in all the cases you 
> mentioned, while also giving the option for a user to update the 
> submodule from the remote of their choice (which may not be origin).

I like that solution. Although, I should note that if the user has set
submodule.<name>.remote to something other than 'origin', they will need
to ensure that submodule.<name>.branch is also set, or they will still
hit the "Unable to find current <remote>/HEAD revision in submodule"
error that I initially stumbled on.

How about an implementation like the following? I introduced a new "git
submodule--helper" command rather than modify "print-default-remote" for
a couple of reasons:

1) "print-default-remote" is also used for "git submodule sync" (I'm not
sure if we should change its behaviour too)

2) "print-default-remote" needs to be executed from within the
submodule, and takes no arguments, whereas I need to parse the
superproject's .git/config so need to be executed from the superproject
and take the submodule path as an argument

The two functions I added are heavily based on "git submodule--helper
remote-branch". However:

* Unlike with the branch name, I don't fall back to using the name for
the remote cached from when we read the .gitmodules file, if it isn't
found in .git/config. It doesn't make sense to me for the .gitmodules
file to include this information, as any new clones will only contain
"origin" remotes anyway.

* I removed "struct strbuf sb" since I don't think it's used.

Ben


diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d505a6329..25ce3c8a1d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2444,6 +2444,41 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static const char *remote_submodule_remote(const char *path)
+{
+	const struct submodule *sub;
+	const char *remote = NULL;
+	char *key;
+
+	sub = submodule_from_path(the_repository, &null_oid, path);
+	if (!sub)
+		return NULL;
+
+	key = xstrfmt("submodule.%s.remote", sub->name);
+	repo_config_get_string_tmp(the_repository, key, &remote);
+	free(key);
+
+	if (!remote)
+		return "origin";
+
+	return remote;
+}
+
+static int resolve_remote_submodule_remote(int argc, const char **argv,
+		const char *prefix)
+{
+	const char *ret;
+	if (argc != 2)
+		die("submodule--helper remote-remote takes exactly one arguments, got %d", argc);
+
+	ret = remote_submodule_remote(argv[1]);
+	if (!ret)
+		die("submodule %s doesn't exist", argv[1]);
+
+	printf("%s", ret);
+	return 0;
+}
+
 static int push_check(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -2770,6 +2805,7 @@ static struct cmd_struct commands[] = {
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"remote-remote", resolve_remote_submodule_remote, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index eb90f18229..4d0df1cf5a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -577,7 +577,7 @@ cmd_update()
 				fetch_in_submodule "$sm_path" $depth ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
+			remote_name=$(git submodule--helper remote-remote "$sm_path")
 			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
