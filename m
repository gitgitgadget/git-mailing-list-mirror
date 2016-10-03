Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4740C207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 15:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbcJCPiO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 11:38:14 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:52414 "EHLO
        mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbcJCPiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 11:38:13 -0400
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
        by mail.gooeysoftware.com (Postfix) with ESMTPSA id 7AF5018A2781;
        Mon,  3 Oct 2016 10:39:17 -0500 (CDT)
Message-ID: <57F27B02.8080803@game-point.net>
Date:   Mon, 03 Oct 2016 16:36:34 +0100
From:   Jeremy Morton <admin@game-point.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Chris Packham <judge.packham@gmail.com>
CC:     git@vger.kernel.org, mara.kim@vanderbilt.edu, gitster@pobox.com
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
In-Reply-To: <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Did this ever get anywhere?  Can we recursively update submodules with 
"git pull" in the supermodule now?

-- 
Best regards,
Jeremy Morton (Jez)

On 04/06/2014 10:30, Chris Packham wrote:
> Add a config option that will cause clone to recurse into submodules as
> if the --recurse-submodules option had been specified on the command
> line. This can be overridden with the --no-recurse-submodules option.
>
> Signed-off-by: Chris Packham<judge.packham@gmail.com>
> ---
> On 04/06/14 09:05, Junio C Hamano wrote:
>>> Mara Kim<mara.kim@vanderbilt.edu>  writes:
>>>
>>>> Apologies if this question has been asked already, but what is the
>>>> reasoning behind making git clone not recursive (--recursive) by
>>>> default?
>>>
>>> The primary reason why submodules are separate repositories is not
>>> to require people to have everything.  Some people want recursive,
>>> some others don't, and the world is not always "majority wins" (not
>>> that I am saying that majority will want recursive).
>>>
>>> Inertia, aka backward compatibility and not surprising existing
>>> users, plays some role when deciding the default.
>>>
>>> Also, going --recursive when the user did not want is a lot more
>>> expensive mistake to fix than not being --recursive when the user
>>> wanted to.
>>
>> Having said all that, I do not mean to say that I am opposed to
>> introduce some mechanism to let the users express their preference
>> between recursive and non-recursive better, so that "git clone"
>> without an explicit --recursive (or --no-recursive) can work to
>> their taste.  A configuration in $HOME/.gitconfig might be a place
>> to start, even though that has the downside of assuming that the
>> given user would want to use the same settings for all his projects,
>> which may not be the case in practice.
>
> And here's a quick proof of concept. Not sure about the config variable name
> and it could probably do with a negative test as well.
>
>   builtin/clone.c              |  9 +++++++++
>   t/t7407-submodule-foreach.sh | 17 +++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b12989d..92aea81 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -734,6 +734,14 @@ static void write_refspec_config(const char* src_ref_prefix,
>   	strbuf_release(&value);
>   }
>
> +static int git_clone_config(const char *key, const char *value, void *data)
> +{
> +	if (!strcmp(key, "clone.recursesubmodules"))
> +		option_recursive = git_config_bool(key, value);
> +
> +	return 0;
> +}
> +
>   int cmd_clone(int argc, const char **argv, const char *prefix)
>   {
>   	int is_bundle = 0, is_local;
> @@ -759,6 +767,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>   	junk_pid = getpid();
>
>   	packet_trace_identity("clone");
> +	git_config(git_clone_config, NULL);
>   	argc = parse_options(argc, argv, prefix, builtin_clone_options,
>   			     builtin_clone_usage, 0);
>
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 7ca10b8..fc2c189 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -307,6 +307,23 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
>   	)
>   '
>
> +test_expect_success 'use "git clone" with clone.recursesubmodules to checkout all submodules' '
> +	git config --local clone.recursesubmodules true&&
> +	git clone super clone7&&
> +	(
> +		cd clone7&&
> +		git rev-parse --resolve-git-dir .git&&
> +		git rev-parse --resolve-git-dir sub1/.git&&
> +		git rev-parse --resolve-git-dir sub2/.git&&
> +		git rev-parse --resolve-git-dir sub3/.git&&
> +		git rev-parse --resolve-git-dir nested1/.git&&
> +		git rev-parse --resolve-git-dir nested1/nested2/.git&&
> +		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git&&
> +		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
> +	)&&
> +	git config --local --unset clone.recursesubmodules
> +'
> +
>   test_expect_success 'command passed to foreach retains notion of stdin' '
>   	(
>   		cd super&&
