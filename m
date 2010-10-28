From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 06/10] Change incorrect "remote branch" to "remote tracking branch" in C code
Date: Fri, 29 Oct 2010 00:34:15 +0200
Message-ID: <vpqtyk6dk0o.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-7-git-send-email-Matthieu.Moy@imag.fr>
	<20101028191303.GE14212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBb3P-0003wo-T0
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0J1Wef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:34:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35274 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab0J1Wee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:34:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9SMJUFl029973
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 29 Oct 2010 00:19:30 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBb31-00060p-HE; Fri, 29 Oct 2010 00:34:15 +0200
In-Reply-To: <20101028191303.GE14212@burratino> (Jonathan Nieder's message of "Thu\, 28 Oct 2010 14\:13\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 Oct 2010 00:19:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SMJUFl029973
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288909170.6235@b3jfmYQw3YVjshLe1wSs5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160244>

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

> 	Configure local branch "local" as downstream to branch "remote"
> 	from remote "origin".  Used by git branch --set-upstream.

I buy this one.

>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -359,7 +359,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>  			what = rm->name + 10;
>>  		}
>>  		else if (!prefixcmp(rm->name, "refs/remotes/")) {
>> -			kind = "remote branch";
>> +			kind = "remote-tracking branch";
>>  			what = rm->name + 13;
>
> I didn't follow before --- what concrete effect does this have?

Almost none ;-).

>From reading the code and testing, it affects

$ git fetch
$ cat FETCH_HEAD
...
21d039[...]  not-for-merge  remote-tracking branch 'origin/branch' of /tmp/cloned
...

when ran in a repository obtained with "git clone --mirror" (i.e. when
you fetch remote-tracking branches from the remote repository).

and

$ git fetch origin refs/remotes/origin/some-branch
From /tmp/cloned
 * remote-tracking branch origin/oaue -> FETCH_HEAD

> Are scripts affected?

I don't think any script would parse the last part of FETCH_HEAD,
which seems really to be meant as a comment, nor the precise output of
git-fetch-in-a-mirror-with-refspec-given-explicitely.

But anyway, that's in a place where bare mortals wouldn't go, so I
don't mind much is anyone wants to revert this particular hunk. That's
not going to affect the learning curve of newcommers.

> Is fmt-merge-msg affected?

No (that's why it's a separate patch. In case you missed my earlier
message: yes, the testsuite passes between the two).

> Maybe the commit message should explain the reasoning, something like:
>
>  The non-deleted branch is somehow remote-tracking since "fetch" feeds
>  it, and the code detecting this case is:

I've tried a shorter version :

  In the process, we change "non-remote branch" to "branch outside
  the refs/remotes/ hierarchy" to avoid the ugly "non-remote-tracking
  branch". The new formulation actually corresponds to how the code
  detects this case (i.e. prefixcmp(refname, "refs/remotes")).

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
