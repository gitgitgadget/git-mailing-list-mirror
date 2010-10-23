From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 07/10] Change incorrect "remote branch" to "remote tracking branch" in C code
Date: Sat, 23 Oct 2010 21:19:18 +0200
Message-ID: <vpqd3r0lnt5.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-8-git-send-email-Matthieu.Moy@imag.fr>
	<20101023185843.GJ21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jgI-0002ah-NM
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933544Ab0JWTXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:23:01 -0400
Received: from imag.imag.fr ([129.88.30.1]:65257 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933655Ab0JWTW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:22:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9NJJIq0015994
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 21:19:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P9jcc-0007vD-Jo; Sat, 23 Oct 2010 21:19:18 +0200
In-Reply-To: <20101023185843.GJ21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 13\:58\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 23 Oct 2010 21:19:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159822>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/branch.h
>> +++ b/branch.h
>> @@ -22,7 +22,7 @@ void create_branch(const char *head, const char *name, const char *start_name,
>>  void remove_branch_state(void);
>>  
>>  /*
>> - * Configure local branch "local" to merge remote branch "remote"
>> + * Configure local branch "local" to merge remote-tracking branch "remote"
>>   * taken from origin "origin".
>>   */
>>  #define BRANCH_CONFIG_VERBOSE 01
>
> Is this really more accurate?

Good question ;-).

> I thought what install_branch_config does is to configure local
> branch "local" as downstream to remote branch "remote" from origin
> "origin". That means:
>
>  - "git pull" fetches that remote and then merges the corresponding
>    remote-tracking branch
>  - "git remote show" compares the local branch to the remote branch
>  - "git branch -v" compares the local branch to the remote-tracking
>    branch
>
> and so on.

(there's also "git status" which says how many commits are in a
branch and not the other)

Well, actually, this configuration creates a relationship from the
local branch to both the remote-tracking and the remote branch.
Disconnected operations (git status for example) will deal with the
remote-tracking, but "pull" will pull from the actually remote one.

Anyway, the original wording was not ambiguous (thanks to the "taken
from origin" part), so I'm fine with dropping this hunk.

>> index 3b0b614..4243ef0 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -359,7 +359,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>  			what = rm->name + 10;
>>  		}
>>  		else if (!prefixcmp(rm->name, "refs/remotes/")) {
>> -			kind = "remote branch";
>> +			kind = "remote-tracking branch";
>
> For use by "git merge" and other "git fmt-merge-msg"-like consumers.  Good.
>
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -791,9 +791,9 @@ static int rm(int argc, const char **argv)
>>  
>>  	if (skipped.nr) {
>>  		fprintf(stderr, skipped.nr == 1 ?
>> -			"Note: A non-remote branch was not removed; "
>> +			"Note: A non-remote-tracking branch was not removed; "
>>  			"to delete it, use:\n" :
>> -			"Note: Non-remote branches were not removed; "
>> +			"Note: Non-remote-tracking branches were not removed; "
>>  			"to delete them, use:\n");
>
> This wording is ugly.

I didn't like the double-dash either, but couldn't find anything
better.

> Maybe something to this effect would be better?
>
> 	Note: A ref outside the refs/remotes/ hierarchy was not removed:

Actually, that's even more accurate. The non-deleted branch is somehow
a remote-tracking since "fetch" feeds it, and the code detecting this
case is:

	/* don't delete non-remote-tracking refs */
	if (prefixcmp(refname, "refs/remotes")) {
		/* advise user how to delete local branches */
		if (!prefixcmp(refname, "refs/heads/"))
			string_list_append(branches->skipped,
					   abbrev_branch(refname));
		/* silently skip over other non-remote refs */
		return 0;
	}

hence, really what you wrote. I just disagree with the "ref", since
according to the code, only branches show this note, other are skept
silently.

So, I'll make this:

Note: A branch outside the refs/remotes/ hierarchy was not removed:

>> --- a/t/t5505-remote.sh
>> +++ b/t/t5505-remote.sh
>> @@ -107,16 +107,16 @@ test_expect_success 'remove remote' '
>>  )
>>  '
>>  
>> -test_expect_success 'remove remote protects non-remote branches' '
>> +test_expect_success 'remove remote protects non-remote-tracking branches' '
>
> Maybe:
>
> 	test_expect_success 'remove remote protects local branches' '
>
> since that is what is important in practice.

I buy that too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
