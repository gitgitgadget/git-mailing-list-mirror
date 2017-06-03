Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7160209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdFCOHV (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 10:07:21 -0400
Received: from avasout08.plus.net ([212.159.14.20]:34566 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdFCOHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 10:07:20 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id UE7H1v0031keHif01E7JiS; Sat, 03 Jun 2017 15:07:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8
 a=TkyNKufPLWlc2MX5a78A:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] submodule foreach: correct $sm_path in nested submodules
 from a dir
To:     Stefan Beller <sbeller@google.com>, bmwill@google.com,
        gitster@pobox.com
Cc:     git@vger.kernel.org, pc44800@gmail.com
References: <20170515183405.GA79147@google.com>
 <20170603003710.5558-1-sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0a0ad045-0c58-aaaf-d0ac-a4fa17570356@ramsayjones.plus.com>
Date:   Sat, 3 Jun 2017 15:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170603003710.5558-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/06/17 01:37, Stefan Beller wrote:
> When running 'git submodule foreach' from a subdirectory of your
> repository, nested submodules get a bogus value for $sm_path:
> For a submodule 'sub' that contains a nested submodule 'nested',
> running 'git -C dir submodule foreach echo $path' would report
> path='../nested' for the nested submodule. The first part '../' is
> derived from the logic computing the relative path from $pwd to the
> root of the superproject. The second part is the submodule path inside
> the submodule. This value is of little use and is hard to document.
> 
> There are two different possible solutions that have more value:
> (a) The path value is documented as the path from the toplevel of the
>     superproject to the mount point of the submodule.
>     In this case we would want to have path='sub/nested'.
> 
> (b) As Ramsay noticed the documented value is wrong. For the non-nested
>     case the path is equal to the relative path from $pwd to the
>     submodules working directory. When following this model,
>     the expected value would be path='../sub/nested'.
> 
> The behavior for (b) was introduced in 091a6eb0fe (submodule: drop the

Ah, so prior to 091a6eb0fe the documentation of $path was actually
correct - you could not run the command from a sub-directory, so
$path _was_ the 'name of the submodule directory relative to the
superproject'. (The fact that git-ls-files worked from a subdirectory
is not in the least relevant - it never was!) ;-)

> top-level requirement, 2013-06-16) the intent for $path seemed to be
> relative to $cwd to the submodule worktree, but that did not work for
> nested submodules, as the intermittent submodules were not included in
                            ^^^^^^^^^^^^
intermediate?

Hmm, so nobody noticed the change in behaviour (and, of course, that
the documentation hadn't been updated to match) since 2013!

> the path.
> 
> If we were to fix the meaning of the $path using (a) such that "path"
> is "the path from the toplevel of the superproject to the mount point
> of the submodule", we would break any existing submodule user that runs
> foreach from non-root of the superproject as the non-nested submodule
> '../sub' would change its path to 'sub'.
> 
> If we would fix the meaning of the $path using (b), such that "path"
> is "the relative path from $pwd to the submodule", then we would break
> any user that uses nested submodules (even from the root directory) as
> the 'nested' would become 'sub/nested'.
> 
> Both groups can be found in the wild.  The author has no data if one group
> outweighs the other by large margin, and offending each one seems equally
> bad at first.  However in the authors imagination it is better to go with
> (a) as running from a sub directory sounds like it is carried out
> by a human rather than by some automation task.  With a human on
> the keyboard the feedback loop is short and the changed behavior can be
> adapted to quickly unlike some automation that can break silently.

I do not use submodules (I have absolutely no interest in them, except
in a general wish to improve git sense). So, I have no idea what kind
of impact either change will have. However, FWIW, I agree with your
reasoning here. (Not that I actually get a vote, but I vote for a!)

> To ameliorate the situation, perform these changes
> * Document 'sm_path' instead of 'path'.
>   As using a variable '$path' may be harmful to users due to
>   capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
>   use $path variable in eval_gettext string, 2012-04-17). Adjust
>   the documentation to advocate for using $sm_path,  which contains
>   the same value. We still make the 'path' variable available,
>   though not documented.
> 
> * Clarify the 'toplevel' variable documentation.
>   It does not contain the topmost superproject as the author assumed,
>   but the direct superproject, such that $toplevel/$sm_path is the
>   actual absolute path of the submodule.
> 
> * The variable '$displaypath' was accessible but undocumented.
>   Rename it '$displaypath' to '$dpath'. Document what it contains.
>   Users that are broken by the behavior change of 'sm_path' introduced
>   in this commit, can switch from '$path' to '$dpath'.
> 
> Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 

  Documentation/git-submodule.txt | 32 ++++++++++++++++++--------------
>  git-submodule.sh                |  7 +++----
>  t/t7407-submodule-foreach.sh    | 39 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 57 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 74bc6200d5..52e3ef1325 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -218,20 +218,24 @@ information too.
>  
>  foreach [--recursive] <command>::
>  	Evaluates an arbitrary shell command in each checked out submodule.
> -	The command has access to the variables $name, $path, $sha1 and
> -	$toplevel:
> -	$name is the name of the relevant submodule section in .gitmodules,
> -	$path is the name of the submodule directory relative to the
> -	superproject, $sha1 is the commit as recorded in the superproject,
> -	and $toplevel is the absolute path to the top-level of the superproject.
> -	Any submodules defined in the superproject but not checked out are
> -	ignored by this command. Unless given `--quiet`, foreach prints the name
> -	of each submodule before evaluating the command.
> -	If `--recursive` is given, submodules are traversed recursively (i.e.
> -	the given shell command is evaluated in nested submodules as well).
> -	A non-zero return from the command in any submodule causes
> -	the processing to terminate. This can be overridden by adding '|| :'
> -	to the end of the command.
> +	The command has access to the following variables:
> ++
> +* `$name` is the name of the relevant submodule section in .gitmodules,
> +* `$sha1` is the commit as recorded in the superproject.
> +* `$sm_path` is the path recorded in the superproject.

Just to be sure, the 'path recorded in the superproject' means the
same thing as the 'name of the submodule directory relative to the
superproject'. Yes?

> +* `$toplevel` is the absolute path to its superproject, such that
> +  `$toplevel/$sm_path` is the absolute path of the submodule.
> +* `$dpath` contains the relative path from the current working directory
> +   to the submodules root directory.

Subject to the above, this all looks good to me. (I can't comment
on the implementation - I just assume that it correctly implements
the above).

Thanks!

ATB,
Ramsay Jones


