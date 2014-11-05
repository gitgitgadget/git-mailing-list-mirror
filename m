From: Alexandre Garnier <zigarn+git@gmail.com>
Subject: Re: Bug in log for path in case of identical commit
Date: Wed, 5 Nov 2014 20:49:23 +0100
Message-ID: <CAFFOgCVvz8mog86pMynHtkssUj9GruC=58YLbEoRK_BVz+v-GA@mail.gmail.com>
References: <CAFFOgCUeqcEPdjUyri0bivCj-Ofzp_9GhH3mR7UTzD-8PY9tGw@mail.gmail.com>
	<CABURp0qZ5Ba3EFhqF0LfoEz7J4Vq2DiStqcDc_bpK62XT7s7eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 20:49:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm6a8-0003qV-EC
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 20:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbaKETtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 14:49:24 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:39881 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaKETtY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 14:49:24 -0500
Received: by mail-vc0-f169.google.com with SMTP id hy4so811908vcb.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IeTaL1k42muwtV9OpDSKueLJS628gUFTha/R067kv6c=;
        b=eg2LFvtiMj1QlbzPd2BhTR1398iL2stXbwvIMSUg6zZRoVC9Pjns5OexksuVUGxDye
         owEdU0OLLwEQSYXLnRy8j558uw9bT8rL/ZFjUfHfHQpir5Vzle132RdhlCzVS3U/YXtp
         xX4qWLUQ0ltbvjX0pOX89lTdxCpffNGzKXgH4MmIyA7z+09JPc/dZpA9/lXa0LZI6s3Q
         2TmSufi7fVUXE9FkURnteHpegqAUXSyKTDuwzaTndgz+Oi+miVWec1ukvr9GR4UTMBq7
         UsaPH/wM12pMNP7+3OstwZLimYW/qSIfGDUW5F8qXW+DG7qlrw8A7TIWPI75I5Dr1vKP
         yXlw==
X-Received: by 10.52.82.103 with SMTP id h7mr6232719vdy.27.1415216963175; Wed,
 05 Nov 2014 11:49:23 -0800 (PST)
Received: by 10.220.122.132 with HTTP; Wed, 5 Nov 2014 11:49:23 -0800 (PST)
In-Reply-To: <CABURp0qZ5Ba3EFhqF0LfoEz7J4Vq2DiStqcDc_bpK62XT7s7eQ@mail.gmail.com>
X-Google-Sender-Auth: qp0CFdzhY3Gl5Xg6CDioj2yyZu8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-11-04 17:21 GMT+01:00 Phil Hord <phil.hord@gmail.com>:
> On Fri, Oct 31, 2014 at 4:40 AM, Alexandre Garnier <zigarn+git@gmail.com> wrote:
>> When merging 2 branches with the same modifications on the both sides,
>> depending the merge side, one branch disappear from the file history.
>>
>> To be more clear, there is a script in attachment to reproduce, but
>> here is the result :
>> $ git log --graph --oneline --all --decorate --name-status
>> *   63c807f (HEAD, master) Merge branch 'branch' into 'master'
>> |\
>> | * 5dc8785 (branch) Change line 15 on branch
>> | | M   file
>> | * d9cd3ce Change line 25 on branch
>> | | M   file
>> * | 7220d52 Change line 15 on master
>> |/
>> |   M   file
>> * 7566672 Initial commit
>>   A     file
>>
>> $ git log --graph --oneline --all --decorate --name-status -- file
>> * 5dc8785 (branch) Change line 15 on branch
>> | M     file
>> * d9cd3ce Change line 25 on branch
>> | M     file
>> * 7566672 Initial commit
>>   A     file
>>
>> => The commit 7220d52 modified the file but is not shown in file
>> history anymore.
>> The expected result would be:
>> * 5dc8785 (branch) Change line 15 on branch
>> | M     file
>> * d9cd3ce Change line 25 on branch
>> | M     file
>> | * 7220d52 Change line 15 on master
>> |/
>> |   M   file
>> * 7566672 Initial commit
>>   A     file
>>
>> The order between the 2 commits on the branch is not important.
>> If you do a 'cherry-pick 7220d52' or a 'merge --squash master' instead
>> of applying the same modification for commit 5dc8785, you get the same
>> result (cherry-picking was my initial use-case).
>> If you do not create the commit d9cd3ce, then the file history show all commits.
>> If you merge 'master' into 'branch', then the file history show all commits.
>
> This last line was confusing to me.  But I think you've misinterpreted
> the results a bit.  There is no difference between "merge master into
> branch" and "merge branch into master" in this case.  The real reason
> the "extra" commit is shown in the former case is that you used
> '--all' (include all refs as commandline arguments) and the commit
> which was being omitted was directly referenced by a ref, 'master'.
>
> When I remove the "--all" from your test script, I get consistent logs
> for the two merges.
>
> Maybe this has misled your other tests as well.  Read the "History
> Simplification" section of "git help log".

Thanks for pointing me out the 'history simplification' [1]. Didn't
know about this and missed it in the large help of 'git log'.
I will now use the '--full-history' option more often as it has more
sense to me (but it's not available in EGit: bug #341028) [2])

[1] http://git-scm.com/docs/git-log#_history_simplification
[2] https://bugs.eclipse.org/bugs/show_bug.cgi?id=341028

-- 
Alex
