From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 03/14] dir.c: git-status --ignored: don't list empty
 ignored directories
Date: Wed, 17 Apr 2013 02:31:06 +0200
Message-ID: <516DED4A.5050800@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <516C4FE4.9090806@gmail.com> <CALkWK0mG6bzWu7dqdP1mBe+AZfUDK=Mx4+ZkDOc2saXr3gBsUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 02:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USGHV-0002kk-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 02:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab3DQAbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 20:31:11 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:51393 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab3DQAbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 20:31:08 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so478914eek.4
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3HxwbicAiovkqQlsiqfnVG7xDAqh+V8yIF5Ys1QTBJE=;
        b=k81hkNaw0M9HhLeXbFWzZPDzB4xYBHpK4ODClFJblhmhiDZj+GI1+h49HjS2LSO1mg
         PvqOAS+4W+wX2yAhaepg3UPy5iBeX+l1ZoJ/hhoIi0j1SIZKNjyjyQOJYk9o4DZjgDgQ
         iqaksQR02unHYPFqjWaIGBlEg5I19cV5zeZB+Mg6c7oI+OT3feoTGFdbcDkjG/t7zbE5
         3nvDk6XjwDOmcDSTI7PJ4ueS6kabZY6t4NNjIMKQTsUwxyP4GNjKWYVhLrunsrYj70/G
         YSEPbYi9L7R1JVyaSCQZoR16/r7OIwj8/xZpeppOK1/CWEvDCqF5OcNbzHj5TmOzj88u
         GeSg==
X-Received: by 10.15.111.202 with SMTP id cj50mr12052713eeb.6.1366158666699;
        Tue, 16 Apr 2013 17:31:06 -0700 (PDT)
Received: from [10.1.100.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id ch6sm5502916eeb.17.2013.04.16.17.31.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 17:31:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CALkWK0mG6bzWu7dqdP1mBe+AZfUDK=Mx4+ZkDOc2saXr3gBsUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221492>

Am 16.04.2013 19:48, schrieb Ramkumar Ramachandra:
> Karsten Blees wrote:
>> 'git-status --ignored' lists ignored tracked directories without any
>> ignored files if a tracked file happens to match an exclude pattern.
> 
> Here, I have:
> 
>     quux/
>         bar
>         baz/
>             foo
> 
> So, quux is an ignored tracked directory.  bar is tracked, but matches
> an ignore pattern.  Currently, git status --ignored lists quux/.  I'm
> confused.
> 

The crucial part is 'without any ignored files'. So if you 'rm quux/baz/foo' or 'git-add -f quux/baz/foo', you get this:

1) git-status --ignored -uall: <empty>
2) git-status --ignored -unormal: quux/

In case 2), quux/ is listed as ignored even though there are no ignored files and the DIR_HIDE_EMPTY_DIRECTORIES flag should kick in.

>> Always exclude tracked files.
> 
> "exclude" it from the 'git status --ignored' output, I presume?
> There's already an _exclude_ pattern in your previous sentence, so you
> can see why the reader might be confused about what you're talking
> about.
> 

I see, but "Always *ignore* tracked files" is also ambiguous. Suggestions?

>> diff --git a/dir.c b/dir.c
>> index 7c9bc9c..fd1f088 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1109,16 +1109,13 @@ static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude,
>>         struct path_exclude_check check;
>>         int exclude_file = 0;
>>
>> +       /* Always exclude indexed files */
>> +       if (index_name_exists(&the_index, path->buf, path->len, ignore_case))
>> +               return 1;
>> +
>>         if (exclude)
>>                 exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
>>         else if (dir->flags & DIR_SHOW_IGNORED) {
>> -               /* Always exclude indexed files */
>> -               struct cache_entry *ce = index_name_exists(&the_index,
>> -                   path->buf, path->len, ignore_case);
>> -
>> -               if (ce)
>> -                       return 1;
>> -
> 
> Okay, so you just moved this segment outside the else if()
> conditional.  Can you explain what the old logic was doing, and what
> the rationale for it was?
> 

Quoting Antoine's patch from January:
+		/*
+		 * Optimization:
+		 * Don't spend time on indexed files, they won't be
+		 * added to the list anyway
+		 */

In other words: don't do the (expensive) recursive is_path_excluded check if the file will be dropped later anyway (see the additional 'cache_name_is_other' checks in wt_status.c::wt_status_collect_untracked and builtin/ls-files.c::show_other_files).

In the DIR_SHOW_OTHER_DIRECTORIES case, we use read_directory_recursive to just *check* for ignored / untracked files, all within dir.c. So the results must be correct *here*, we cannot rely on some other modules to fix up incorrect files later.

>> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
>> index 4ece129..28b7d95 100755
>> --- a/t/t7061-wtstatus-ignore.sh
>> +++ b/t/t7061-wtstatus-ignore.sh
>> @@ -122,10 +122,34 @@ cat >expected <<\EOF
>>  ?? .gitignore
>>  ?? actual
>>  ?? expected
>> +EOF
>> +
>> +test_expect_success 'status ignored tracked directory and ignored file with --ignore' '
>> +       echo "committed" >>.gitignore &&
>> +       git status --porcelain --ignored >actual &&
>> +       test_cmp expected actual
>> +'
> 
> Um, didn't really get this one.  You have three untracked files, and
> git status seems to be showing them fine.  What am I missing?
> 

We have this:

	tracked/
		committed

.gitignore:
tracked
committed

Both the directory and tracked file match an exclude pattern. There are no untracked ignored files, yet before this patch, git-status --ignored would list tracked/ as ignored directory.

>> +cat >expected <<\EOF
>> +?? .gitignore
>> +?? actual
>> +?? expected
>> +EOF
>> +
>> +test_expect_success 'status ignored tracked directory and ignored file with --ignore -u' '
>> +       git status --porcelain --ignored -u >actual &&
>> +       test_cmp expected actual
>> +'
> 
> I didn't understand why you're invoking -u here (doesn't it imply
> "all", as opposed to "normal" when unspecified?).  There are really no
> directories, so I don't know what I'm expected to see.
> 
>> +cat >expected <<\EOF
>> +?? .gitignore
>> +?? actual
>> +?? expected
>>  !! tracked/
>>  EOF
>>
>>  test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
>> +       echo "tracked" >.gitignore &&
>>         : >tracked/uncommitted &&
>>         git status --porcelain --ignored >actual &&
>>         test_cmp expected actual
> 
> Didn't we test this in the last patch?  Okay, I'm completely confused now.
> 

'echo "tracked" >.gitignore' reverts the 'echo "committed" >>.gitignore' from above.
