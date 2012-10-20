From: Herman van Rink <rink@initfour.nl>
Subject: Re: [PATCH] Add --unannotate option to git-subtree
Date: Sat, 20 Oct 2012 21:33:06 +0200
Organization: Initfour websolutions
Message-ID: <5082FC72.4000608@initfour.nl>
References: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com> <CABVa4NgdaiwfTvFe1CU+24QF-BA45tM2e3+9e2PJ_4ecuD0Cyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 21:42:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPewQ-0004y3-2m
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 21:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab2JTTm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 15:42:26 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:57041 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447Ab2JTTm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 15:42:26 -0400
Received: from [192.168.65.204] (hosted-by.initfour.nl [83.137.144.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 75DD39FC6D9;
	Sat, 20 Oct 2012 21:33:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CABVa4NgdaiwfTvFe1CU+24QF-BA45tM2e3+9e2PJ_4ecuD0Cyg@mail.gmail.com>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208094>

On 10/16/2012 02:47 PM, James Nylen wrote:
> On Tue, Oct 9, 2012 at 4:26 PM, James Nylen <jnylen@gmail.com> wrote:
>> This new option does the reverse of --annotate, which is more useful
>> when contributing back to a library which is also included in the
>> repository for a larger project, and perhaps in other situations as
>> well.
>>
>> Rather than adding a marker to each commit when splitting out the
>> commits back to the subproject, --unannotate removes the specified
>> string (or bash glob pattern) from the beginning of the first line of
>> the commit message.  This enables the following workflow:
>>
>>  - Commit to a library included in a large project, with message:
>>      Library: Make some amazing change
>>
>>  - Use `git-subtree split` to send this change to the library maintainer
>>
>>  - Pass ` --unannotate='Library: ' ` or ` --unannotate='*: ' `
>>
>>  - This will turn the commit message for the library project into:
>>      Make some amazing change
>>
>> This helps to keep the commit messages meaningful in both the large
>> project and the library project.
>>
>> Signed-off-by: James Nylen <jnylen@gmail.com>
>> ---
> Has anybody looked at this?
>
> It has been very useful for me.


The version of subtree in contrib is rather out-dated unfortunately.
Your patch looks interesting though. I can see how this could be useful.

I've collected a bunch of patches in
https://github.com/helmo/git/tree/subtree-updates

Apart from a line in git-subtree.txt ending in whitespace I think I can
merge it in there.

>
>> Let me know if gmail has munged this patch.  You can also get at it
>> like this:
>>
>> $ git remote add nylen git://github.com/nylen/git.git
>> $ git fetch nylen
>> $ git show nylen/subtree-unannotate
>> ---
>>  contrib/subtree/git-subtree.sh  | 11 +++++++++--
>>  contrib/subtree/git-subtree.txt | 15 +++++++++++++++
>>  2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 920c664..8d1ed05 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -21,6 +21,7 @@ P,prefix=     the name of the subdir to split out
>>  m,message=    use the given message as the commit message for the merge commit
>>   options for 'split'
>>  annotate=     add a prefix to commit message of new commits
>> +unannotate=   remove a prefix from new commit messages (supports bash globbing)
>>  b,branch=     create a new branch from the split subtree
>>  ignore-joins  ignore prior --rejoin commits
>>  onto=         try connecting new tree to an existing one
>> @@ -43,6 +44,7 @@ onto=
>>  rejoin=
>>  ignore_joins=
>>  annotate=
>> +unannotate=
>>  squash=
>>  message=
>>
>> @@ -80,6 +82,8 @@ while [ $# -gt 0 ]; do
>>                 -d) debug=1 ;;
>>                 --annotate) annotate="$1"; shift ;;
>>                 --no-annotate) annotate= ;;
>> +               --unannotate) unannotate="$1"; shift ;;
>> +               --no-unannotate) unannotate= ;;
>>                 -b) branch="$1"; shift ;;
>>                 -P) prefix="$1"; shift ;;
>>                 -m) message="$1"; shift ;;
>> @@ -310,8 +314,11 @@ copy_commit()
>>                         GIT_COMMITTER_NAME \
>>                         GIT_COMMITTER_EMAIL \
>>                         GIT_COMMITTER_DATE
>> -               (echo -n "$annotate"; cat ) |
>> -               git commit-tree "$2" $3  # reads the rest of stdin
>> +               (
>> +                       read FIRST_LINE
>> +                       echo "$annotate${FIRST_LINE#$unannotate}"
>> +                       cat  # reads the rest of stdin
>> +               ) | git commit-tree "$2" $3
>>         ) || die "Can't copy commit $1"
>>  }
>>
>> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
>> index 0c44fda..ae420aa 100644
>> --- a/contrib/subtree/git-subtree.txt
>> +++ b/contrib/subtree/git-subtree.txt
>> @@ -198,6 +198,21 @@ OPTIONS FOR split
>>         git subtree tries to make it work anyway, particularly
>>         if you use --rejoin, but it may not always be effective.
>>
>> +--unannotate=<annotation>::
>> +       This option is only valid for the split command.
>> +
>> +       When generating synthetic history, try to remove the prefix
>> +       <annotation> from each commit message (using bash's "strip
>> +       shortest match from beginning" command, which supports
>> +       globbing).  This makes sense if you format library commits
>> +       like "library: Change something or other" when you're working
>> +       in your project's repository, but you want to remove this
>> +       prefix when pushing back to the library's upstream repository.
>> +       (In this case --unannotate='*: ' would work well.)
>> +
>> +       Like --annotate,  you need to use the same <annotation>
>> +       whenever you split, or you may run into problems.
>> +
>>  -b <branch>::
>>  --branch=<branch>::
>>         This option is only valid for the split command.
>> --
>> 1.7.11.3
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
