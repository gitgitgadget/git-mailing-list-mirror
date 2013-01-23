From: Barry Wardell <barry.wardell@gmail.com>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Wed, 23 Jan 2013 12:08:37 +0000
Message-ID: <CAHrK+Z8kc_O1CE4Le=XpiXWJ2Fadh906nbfgf0rqmvL0e6=P6A@mail.gmail.com>
References: <20120308005103.GA27398@dcvr.yhbt.net> <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 <20130123023235.GA24135@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txz8u-0000k1-MS
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 13:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab3AWMJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 07:09:00 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:46802 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3AWMJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 07:09:00 -0500
Received: by mail-la0-f49.google.com with SMTP id fs13so2354323lab.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 04:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=wuKzpRl3He3Ni9m9bUSip9DVMMyh5JILvky5nO/3l4E=;
        b=uaZXSxGLq3SksrbLeZFxIGfzYiE8ubRp49SNiiO+94AFfRyrc3YrdaHJuKwTafeH9t
         kcvwcU/gmvA0K9KoN9WCtrjSoTcn5/zeR2x2GCTiJAJyTi5c8gym2zXc82hmf5PcrMw5
         82XXoUkACInyy9njv99UNvzEJhjUyp1sAoBoKjIAxExlM2YwGFKBSFQNgLBaGbuD9u2p
         STgSmwxhgZs8Lcs1ghTTMAzsWRuF+Vj/d/s5D1ZLaCOUDjGdxgfPpuT+/uqUS9iCJGo+
         rjsKFeOJbI8vRg0GFuOT0bfiO2iUlzNyzDtaKTZKxWVRiAAeqgTC6cln9yH14WDa0Q6R
         i8wQ==
X-Received: by 10.112.40.228 with SMTP id a4mr649158lbl.26.1358942938212; Wed,
 23 Jan 2013 04:08:58 -0800 (PST)
Received: by 10.112.104.34 with HTTP; Wed, 23 Jan 2013 04:08:37 -0800 (PST)
In-Reply-To: <20130123023235.GA24135@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214314>

On Wed, Jan 23, 2013 at 2:32 AM, Eric Wong <normalperson@yhbt.net> wrote:
>
> Barry Wardell <barry.wardell@gmail.com> wrote:
> > These patches fix a bug which prevented git-svn from working with repositories
> > which use gitdir links.
> >
> > Changes since v2:
> >  - Rebased onto latest master.
> >  - Added test case which verifies that the problem has been fixed.
> >  - Fixed problems with git svn (init|clone|multi-init).
> >  - All git-svn test cases now pass (except two in t9101 which also failed
> >    before these patches).
>
> t9101 did not fail for me before your patches.  However I have a
> patch on top of your 2/2 which should fix things.
>
> `git rev-parse --show-cdup` outputs nothing if GIT_DIR is set,
> so I unset GIT_DIR temporarily.
>
> I'm not sure why --show-cdup behaves like this, though..
>
> Does squashing this on top of your changes fix all your failures?
> I plan on squashing both your changes together with the below:
>
> diff --git a/git-svn.perl b/git-svn.perl
> index c232798..e5bd292 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -332,11 +332,13 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>                 $ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
>         } "Unable to find .git directory\n";
>         my $cdup = undef;
> +       my $git_dir = delete $ENV{GIT_DIR};
>         git_cmd_try {
>                 $cdup = command_oneline(qw/rev-parse --show-cdup/);
>                 chomp $cdup if ($cdup);
>                 $cdup = "." unless ($cdup && length $cdup);
> -       } "Already at toplevel, but $ENV{GIT_DIR} not found\n";
> +       } "Already at toplevel, but $git_dir not found\n";
> +       $ENV{GIT_DIR} = $git_dir;
>         chdir $cdup or die "Unable to chdir up to '$cdup'\n";
>         $_repository = Git->repository(Repository => $ENV{GIT_DIR});
>  }


Yes, I can confirm that applying this patch on top of mine makes all
git-svn tests pass again. I have also re-run the tests without my
patch applied and found that they do all indeed pass, so I apologize
for my previous incorrect comment.
