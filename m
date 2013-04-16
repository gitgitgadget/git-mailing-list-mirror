From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 03/14] dir.c: git-status --ignored: don't list empty
 ignored directories
Date: Tue, 16 Apr 2013 23:18:06 +0530
Message-ID: <CALkWK0mG6bzWu7dqdP1mBe+AZfUDK=Mx4+ZkDOc2saXr3gBsUQ@mail.gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <516C4FE4.9090806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USA0B-0002AJ-VS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153Ab3DPRtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:49:00 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58745 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097Ab3DPRsr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:48:47 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so884702ieb.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vc/ZciS4WM71L8OgqqClRge5BH96aRnYUrT9dfe0ECk=;
        b=y5DK9KmHbxklBLLFMoNJdUlYGvX0Fbs+UQ4QFD8aVyatOO6rwZY7TTnWlVmLKMU+jo
         J6jZWTAkO3fo+Ksl0uFXE1Tv9jHY3HaX2EbAW988zA93h2Lsvfl7iKq9lWQM64VlgXXC
         +GJ8LMO3On/ljrGMGk751R2h0OxQFZ8stZrx2XAZyQ+2gPNi+DOHR54CAQ00oEN3gIcm
         /OxtjHkz5SVAEo84So0Yv/+/GQCRUOVMHU5JUozyubhK4Tyo+S6XEkB0f8aAwkgypCbv
         qtT8KiA9SynMocGU8xJ77XL4t2IlrbTbVmRiL9U7LysgXA3rPy7/QcxrT1bfCWeh902P
         TM9A==
X-Received: by 10.50.17.166 with SMTP id p6mr8527518igd.12.1366134526343; Tue,
 16 Apr 2013 10:48:46 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 10:48:06 -0700 (PDT)
In-Reply-To: <516C4FE4.9090806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221436>

Karsten Blees wrote:
> 'git-status --ignored' lists ignored tracked directories without any
> ignored files if a tracked file happens to match an exclude pattern.

Here, I have:

    quux/
        bar
        baz/
            foo

So, quux is an ignored tracked directory.  bar is tracked, but matches
an ignore pattern.  Currently, git status --ignored lists quux/.  I'm
confused.

> Always exclude tracked files.

"exclude" it from the 'git status --ignored' output, I presume?
There's already an _exclude_ pattern in your previous sentence, so you
can see why the reader might be confused about what you're talking
about.

> diff --git a/dir.c b/dir.c
> index 7c9bc9c..fd1f088 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1109,16 +1109,13 @@ static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude,
>         struct path_exclude_check check;
>         int exclude_file = 0;
>
> +       /* Always exclude indexed files */
> +       if (index_name_exists(&the_index, path->buf, path->len, ignore_case))
> +               return 1;
> +
>         if (exclude)
>                 exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
>         else if (dir->flags & DIR_SHOW_IGNORED) {
> -               /* Always exclude indexed files */
> -               struct cache_entry *ce = index_name_exists(&the_index,
> -                   path->buf, path->len, ignore_case);
> -
> -               if (ce)
> -                       return 1;
> -

Okay, so you just moved this segment outside the else if()
conditional.  Can you explain what the old logic was doing, and what
the rationale for it was?

> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 4ece129..28b7d95 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -122,10 +122,34 @@ cat >expected <<\EOF
>  ?? .gitignore
>  ?? actual
>  ?? expected
> +EOF
> +
> +test_expect_success 'status ignored tracked directory and ignored file with --ignore' '
> +       echo "committed" >>.gitignore &&
> +       git status --porcelain --ignored >actual &&
> +       test_cmp expected actual
> +'

Um, didn't really get this one.  You have three untracked files, and
git status seems to be showing them fine.  What am I missing?

> +cat >expected <<\EOF
> +?? .gitignore
> +?? actual
> +?? expected
> +EOF
> +
> +test_expect_success 'status ignored tracked directory and ignored file with --ignore -u' '
> +       git status --porcelain --ignored -u >actual &&
> +       test_cmp expected actual
> +'

I didn't understand why you're invoking -u here (doesn't it imply
"all", as opposed to "normal" when unspecified?).  There are really no
directories, so I don't know what I'm expected to see.

> +cat >expected <<\EOF
> +?? .gitignore
> +?? actual
> +?? expected
>  !! tracked/
>  EOF
>
>  test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
> +       echo "tracked" >.gitignore &&
>         : >tracked/uncommitted &&
>         git status --porcelain --ignored >actual &&
>         test_cmp expected actual

Didn't we test this in the last patch?  Okay, I'm completely confused now.

Once again, apologies for my inexperienced comments:  I'm contributing
whatever little I can to the review process.
