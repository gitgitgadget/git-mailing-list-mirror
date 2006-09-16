From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] cg-commit: Fix a typo that would inhibit running of post-commit script:
Date: Sat, 16 Sep 2006 17:10:36 +0200
Message-ID: <87ac4zq237.fsf@rho.meyering.net>
References: <8764giro6t.fsf@rho.meyering.net> <20060825002013.GG2817@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 17:12:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GObph-0001ms-77
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 17:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWIPPLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 11:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWIPPLu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 11:11:50 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21437 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932334AbWIPPLt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 11:11:49 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k8GFBa86014168
	for <git@vger.kernel.org>; Sat, 16 Sep 2006 15:11:49 GMT
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2980E17F0; Sat, 16 Sep 2006 17:10:36 +0200 (CEST)
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060825002013.GG2817@diku.dk> (Jonas Fonseca's message of "Fri,
	25 Aug 2006 02:20:13 +0200")
X-Virus-Scanned: ClamAV 0.88.4/1886/Sat Sep 16 10:39:23 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27118>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Jim Meyering <jim@meyering.net> wrote Thu, Aug 24, 2006:
>> I tried cg-commit with a commit hook, but the hook never ran.
>> The problem was a typo:
>>
>> Fix a typo that would inhibit running the post-commit script:
>> s/commit-post/post-commit/.
>
> If I remember correctly, historically, the commit-post existed before
> the post-commit appeared. You can see that it is documented in the man
> page so it is not a typo.
>
> However, this should certainly be updated, but I think a better fix
> would be to transitionally warn the user about the existence of the
> commit-post hook before using it in favour of post-commit.

How about this?
Check for both and if there's exactly one, use that.
If it's the old one, give a diagnostic suggesting to rename it.
If both exist, execute neither, give a diagnostic and fail.

If you like this, I'll prepare a patch.

>> diff --git a/cg-commit b/cg-commit
>> index 9d3b1a1..82eea60 100755
>> --- a/cg-commit
>> +++ b/cg-commit
>> @@ -604,15 +604,16 @@ if [ "$newhead" ]; then
>>  		branchname="$(cat "$_git/branch-name")"
>>  	fi
>>  	[ -z "$branchname" ] && [ "$_git_head" != "master" ] && branchname="$_git_head"
>> -	if [ -x "$_git/hooks/post-commit" -a ! "$no_hooks" ]; then
>> +	post_commit="$_git/hooks/post-commit"
>> +	if [ -x "$post_commit" -a ! "$no_hooks" ]; then
>>  		if [ "$(git-repo-config --bool cogito.hooks.commit.post.allmerged)" = "true" ]; then
>>  			# We just hope that for the initial commit, the user didn't
>>  			# manage to install the hook yet.
>>  			for merged in $(git-rev-list $newhead ^$oldhead | tac); do
>> -				"$_git/hooks/post-commit" "$merged" "$branchname"
>> +				"$post_commit" "$merged" "$branchname"
>>  			done
>>  		else
>> -			"$_git/hooks/post-commit" "$newhead" "$branchname"
>> +			"$post_commit" "$newhead" "$branchname"
>>  		fi
>>  	fi
>
> The patch looks more like a refactoring of a previous commit that did
> the commit-post -> post-commit replacement.

Exactly :)
