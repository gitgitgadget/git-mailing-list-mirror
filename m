From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC v2 PATCH] Teach rm to remove submodules unless they contain
 a git directory
Date: Tue, 28 Aug 2012 20:29:29 +0200
Message-ID: <503D0E09.8010605@web.de>
References: <503BCD91.6080107@web.de> <7v1uisqcef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:29:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6QXi-0003Fb-JU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab2H1S3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:29:32 -0400
Received: from mout.web.de ([212.227.15.3]:60508 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236Ab2H1S3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:29:31 -0400
Received: from [192.168.178.41] ([91.3.154.93]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LyUsk-1Tjj8J1rk6-015GKQ; Tue, 28 Aug 2012 20:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1uisqcef.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:BjQSfVxWmjo5FzbKc1P0pyIh8m294Ycp8CbP3roYdXw
 Zny3B+DP1+Gp3bsH2lp6d3K2t3ALEk7ArK4tGuuf6rgqXepRKB
 egk5Hztwmc8Noz88uXMuwu7hSznLCpwiMzVwETTQmNcyMh3U8X
 AxO3gXy8pR6incsSTnhoVugzpnhzIWpjQWltxjteG+sGYcER/u
 Y6/D/xz9OUNB7EzmpjnSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204446>

Am 27.08.2012 22:59, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> +{
>> +	int i;
>> +	int errs = 0;
>> +
>> +	for (i = 0; i < list.nr; i++) {
>> +		const char *name = list.entry[i].name;
>> +		int pos;
>> +		struct cache_entry *ce;
>> +		struct stat st;
>> +
>> +		pos = cache_name_pos(name, strlen(name));
>> +		if (pos < 0)
>> +			continue; /* ignore unmerged entry */
> 
> Would this cause "git rm -f path" for an unmerged submodule bypass
> the safety check?

Oops, thanks for spotting that. So replacing the "continue;" with
"pos = -pos-1;" should do the trick here, right? Will add some
tests for unmerged submodules ...

>> +		ce = active_cache[pos];
>> +
>> +		if (!S_ISGITLINK(ce->ce_mode) ||
>> +		    (lstat(ce->name, &st) < 0) ||
>> +		    is_empty_dir(name))
>> +			continue;
>> +
>> +		if (!submodule_uses_gitfile(name))
>> +			errs = error(_("submodule '%s' (or one of its nested "
>> +				     "submodules) uses a .git directory\n"
>> +				     "(use 'rm -rf' if you really want to remove "
>> +				     "it including all of its history)"), name);
>> +	}
>> +
>> +	return errs;
>> +}
> 
> The call to this function comes at the very end and gives us yes/no
> for the entire set of paths.  After getting this error for one
> submodule and bunch of other non-submodule paths, what is the
> procedure for the user to remove it that we want to recommend in our
> documentation?  Would it go like this?
> 
> 	$ git rm path1 path2 sub path3
> 	... get the above error ...
> 	$ git submodule --to-gitfile sub
>         $ rm -fr sub
>         $ git rm sub
>         ... then finally ...
>         $ git rm path1 path2 path3

With current git I'd recommend:

 	$ git rm path1 path2 sub path3
 	... get the above error ...
        $ rm -fr sub
 	... try again ...
        $ git rm path1 path2 sub path3

Maybe I should add the hint to repeat the git rm after removing the
submodule to the error output?

Once we implemented "git submodule --to-gitfile" it could be used
instead of "rm -fr sub" to preserve the submodule's repo if the user
wants to.

BTW: I added the same message twice, here for the forced case and in
check_local_mod() when not forced. Is there a recommended way to assign
a localized message to a static variable, so I could define it only once
and reuse it?

>> @@ -80,8 +116,11 @@ static int check_local_mod(unsigned char *head, int index_only)
>>
>>  		/*
>>  		 * Is the index different from the file in the work tree?
>> +		 * If it's a submodule, is its work tree modified?
>>  		 */
>> -		if (ce_match_stat(ce, &st, 0))
>> +		if (ce_match_stat(ce, &st, 0) ||
>> +		    (S_ISGITLINK(ce->ce_mode) &&
>> +		     !ok_to_remove_submodule(ce->name)))
>>  			local_changes = 1;
> 
> As noted before, because we also skip these "does it match the
> index?  does it match the HEAD?" checks for unmerged paths in this
> function, a submodule that has local changes or new files is
> eligible for removal during a conflicted merge.  I have a feeling
> that this should be tightened a bit; wouldn't we want to check at
> least in the checked out version (i.e. stage #2 in the index) if the
> path were a submodule, even if we are in the middle of a conflicted
> merge?  After all, the top level merge shouldn't have touched the
> submodule working tree, so the local modes and new files must have
> come from the end user action that was done _before_ the conflicted
> merge started, and not expendable, no?

Right, I'll change that.
