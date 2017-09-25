Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C319B2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 03:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbdIYDvr (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 23:51:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752969AbdIYDvq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 23:51:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3457FB2371;
        Sun, 24 Sep 2017 23:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lzWgJJqFCB37SlaQsvGC8EVgzfM=; b=oqnbGZ
        XNgcdvddsyMfZf64MUtN63J7StmPv5/ciBreiCZ/iCSMZAqWmxOcBrPusHA6adDE
        1LRACi5rU7Ksh1YWt7rUX/J2yZxkJ1/U480e2DwqXVGgz8iWh564IiiBsDGc+mUc
        7FUZUCtHI+CtoOXx/KXX/pstqDvgnmvA0Tk50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cT/EwX6kMPUupCTz/fNQYmFsXFvs/JxP
        EziwMMioe4UKOsgjnsUvqjuT/szKGF0To8fGGSXJhcQli88ErWcA5fSObhGiWJwk
        1Tx3xG/BQg7mJ9HbkFjtqmzkXejLAQs0fnD+j04x+TY0+VriLSPGvCl5TJVNWgTH
        X/XgiHfjVeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B570B2370;
        Sun, 24 Sep 2017 23:51:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E0C6B236F;
        Sun, 24 Sep 2017 23:51:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     hanwen@google.com, christian.couder@gmail.com, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v5 3/4] submodule: port set_name_rev() from shell to C
References: <20170921161059.11750-1-hanwen@google.com>
        <20170924120858.26813-1-pc44800@gmail.com>
        <20170924120858.26813-4-pc44800@gmail.com>
Date:   Mon, 25 Sep 2017 12:51:44 +0900
In-Reply-To: <20170924120858.26813-4-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sun, 24 Sep 2017 17:38:57 +0530")
Message-ID: <xmqqfubbfnan.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9A027F2-A1A4-11E7-BC44-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +static char *compute_rev_name(const char *sub_path, const char* object_id)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	const char ***d;
> +
> +	static const char *describe_bare[] = {
> +		NULL
> +	};
> +...
> +	static const char **describe_argv[] = {
> +		describe_bare, describe_tags, describe_contains,
> +		describe_all_always, NULL
> +	};
> +
> +	for (d = describe_argv; *d; d++) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		prepare_submodule_repo_env(&cp.env_array);
> +		cp.dir = sub_path;
> +		cp.git_cmd = 1;
> +		cp.no_stderr = 1;
> +
> +		argv_array_push(&cp.args, "describe");
> +		argv_array_pushv(&cp.args, *d);
> +		argv_array_push(&cp.args, object_id);

Nicely done.

> +		if (!capture_command(&cp, &sb, 0) && sb.len) {

Observation: even if the command did not fail, if it returned an
empty string, then you would reject that result and loop on here.
This is different from the original scripted version, but it should
be OK.

> +			strbuf_strip_suffix(&sb, "\n");
> +			return strbuf_detach(&sb, NULL);
> +		}
> +	}
> +
> +	strbuf_release(&sb);
> +	return NULL;

Observation: and if you do not find any non-empty-string answer, you
return NULL.

> +}
> +
> +static int get_rev_name(int argc, const char **argv, const char *prefix)
> +{
> +	char *revname;
> +	if (argc != 3)
> +		die("get-rev-name only accepts two arguments: <path> <sha1>");
> +
> +	revname = compute_rev_name(argv[1], argv[2]);
> +	if (revname && revname[0])
> +		printf(" (%s)", revname);

So, while it is not wrong per-se, I do not think we need to check
revname[0] here.  The helper never returns a non-NULL pointer that
points at an empty string, right?

On the other hand, if we dropped the "&& sb.len" check in the helper
function to be more faithful to the original, then we must check
revname[0] for an empty string.

> +	printf("\n");
> +
> +	free(revname);
> +	return 0;
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -1293,6 +1355,7 @@ static struct cmd_struct commands[] = {
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> +	{"get-rev-name", get_rev_name, 0},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 66d1ae8ef..5211361c5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -758,18 +758,6 @@ cmd_update()
>  	}
>  }
>  
> -set_name_rev () {
> -	revname=$( (
> -		sanitize_submodule_env
> -		cd "$1" && {
> -			git describe "$2" 2>/dev/null ||
> -			git describe --tags "$2" 2>/dev/null ||
> -			git describe --contains "$2" 2>/dev/null ||
> -			git describe --all --always "$2"
> -		}
> -	) )
> -	test -z "$revname" || revname=" ($revname)"
> -}
>  #
>  # Show commit summary for submodules in index or working tree
>  #
> @@ -1041,14 +1029,14 @@ cmd_status()
>  		fi
>  		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
>  		then
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper get-rev-name "$sm_path" "$sha1")
>  			say " $sha1 $displaypath$revname"
>  		else
>  			if test -z "$cached"
>  			then
>  				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
>  			fi
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper get-rev-name "$sm_path" "$sha1")
>  			say "+$sha1 $displaypath$revname"
>  		fi
