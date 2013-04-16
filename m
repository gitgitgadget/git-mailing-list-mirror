From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 01/14] dir.c: git-status --ignored: don't drop ignored directories
Date: Tue, 16 Apr 2013 23:03:40 +0530
Message-ID: <CALkWK0=0MbKnEWc+uLkbynJZXYYiRyfJ539HjtPTajHotB4q9A@mail.gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <516C4F6F.5020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:34:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9ly-0007bE-LF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936019Ab3DPReW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:34:22 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:49268 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935536Ab3DPReV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:34:21 -0400
Received: by mail-ia0-f182.google.com with SMTP id u20so653182iag.27
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=B/kKni51bg2bQPX1AXHgwwyDcpQrluaNXexeQLDUzgQ=;
        b=CnQtKSnz/OWM6FkQkTblzEsURQm/b2d8YcfQ5Ar4KIpzKPBrHjWONid5GO50JMG9qJ
         Bq1Q95mSPH9CXv9JY7W+qY1EZ3iGj62eV4Aix9tCVq89zsRf0yn3AVb0HREovzKaSbwV
         mbAG7wmR+GFo1vCZxSdfOStwpZA8rpuid8HA54XsAPSmHUit/m69diwbtX/sZpC6zEnk
         tr2gA1f42/mN6TNLz5l2swq67CnIwrHqv7ZZu3Jj9fmS1ve3LyKVUkz1QPyrtEEaKEKM
         KW3cP0AMpYaSs6k0nOYA0aKo8RbZzxmlOGHTt/aR2IW78LI9ZCGNy/ZoOb+/0Y1acXpW
         Ouog==
X-Received: by 10.50.119.102 with SMTP id kt6mr2046600igb.12.1366133660890;
 Tue, 16 Apr 2013 10:34:20 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 10:33:40 -0700 (PDT)
In-Reply-To: <516C4F6F.5020708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221433>

Firstly, great work on the series! I've just started looking into it,
so please don't take my comments too seriously: some of them may be
queries, and others may be minor suggestions, but I can't say I
understand the area you're patching.  I know Junio doesn't like me
mixing queries in reviews, but I don't fully agree with his policy.

Karsten Blees wrote:
> 'git-status --ignored' drops ignored directories if they contain untracked
> files in an untracked sub directory.

Wait, ignored directories will always contain untracked
subdirectories, unless you add -f them, right?  Why are you saying
untracked files in an _untracked_ subdirectory?  We don't track
directories anyway, and I would call a directory "tracked" if there's
atleast one file inside it is tracked.  So, my understanding of this
is:

    quux/
       bar
        baz/
             foo

In this example, if quux is ignored and untracked, git status
--ignored currently shows quux/.  If quux/bar is tracked (say with add
-f), but baz/ is untracked, git status --ignored doesn't show me
anything.  What exactly is the bug you're fixing?  I'll try to look at
the tests to infer this, but your commit message could probably be
clearer.

Nit: please s/git-status/git status/

> Fix it by getting exact (recursive) excluded status in treat_directory.

Okay, so you're patching treat_directory() in dir.c to do some
recursive exclude handling.  Let's see what this is.

> diff --git a/dir.c b/dir.c
> index 57394e4..ec4eebf 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1060,6 +1060,15 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
>
>         /* This is the "show_other_directories" case */
>
> +       /* might be a sub directory in an excluded directory */
> +       if (!exclude) {
> +               struct path_exclude_check check;
> +               int dt = DT_DIR;
> +               path_exclude_check_init(&check, dir);
> +               exclude = is_path_excluded(&check, dirname, len, &dt);
> +               path_exclude_check_clear(&check);
> +       }
> +

So, I'm guessing that DT_DIR refers to a value that a field in struct
dirent can take; that value could be one of DIR (directory), REG
(regular file?), LNK (symbolic link?).  I don't get much of this, but
what I do get is that you're setting exclude for the rest of the code
in this function.

Sorry that I'm not able to do a more thorough review.

> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 0da1214..0f1034e 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -143,4 +143,31 @@ test_expect_success 'status ignored tracked directory and uncommitted file with
>         test_cmp expected actual
>  '
>
> +cat >expected <<\EOF
> +?? .gitignore
> +?? actual
> +?? expected
> +!! tracked/
> +EOF

Please put these segments inside the test_expect_success block, so
it's easy to think about those blocks in isolation.  I know you're
just following the existing conventions existing in this test, but
those are not necessarily good conventions.

> +test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore' '
> +       rm -rf tracked/uncommitted &&
> +       mkdir tracked/ignored &&
> +       : >tracked/ignored/uncommitted &&
> +       git status --porcelain --ignored >actual &&
> +       test_cmp expected actual
> +'

This is very confusing.  How is tracked a tracked directory?  Oh,
right: some previous test git add'ed tracked/committed.  How do I know
about that in this test?

Yeah, changes to tracked ignored directories are not shown, but the
commit message didn't tell me this.

> +cat >expected <<\EOF
> +?? .gitignore
> +?? actual
> +?? expected
> +!! tracked/ignored/uncommitted
> +EOF
> +
> +test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore -u' '
> +       git status --porcelain --ignored -u >actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done

I suppose the commit message told me about this one vaguely, but I
think it could be much clearer overall.

Thanks.
