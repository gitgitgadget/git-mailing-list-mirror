From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 2 Dec 2013 16:35:33 +0700
Message-ID: <CACsJy8AuSej7Pwm5Tbo5r_FNaND1-E62Btk=7dZ74YD8K6UJDg@mail.gmail.com>
References: <1385922611.3240.6.camel@localhost> <20131201190447.GA31367@kaarsemaker.net>
 <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
 <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
 <1385941093.3240.10.camel@localhost> <CACsJy8CSQ2RfZub6As9TJc2Vd-wmp75ZVnjQ4nr1QY4mZ4f_TA@mail.gmail.com>
 <1385971274.3240.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 10:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnPvG-0006f3-FI
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 10:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab3LBJgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 04:36:07 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:32969 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab3LBJgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 04:36:04 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so4119700qac.7
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 01:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nRr3noLtSBr3ZH2SI9hvtaRni4oSPa0tg+xdr71ddUA=;
        b=XbKCT/yHB20/NVZPrlPe+DwcPsc+YNL12HPpebEZ+Dryn17knOolwElQftmLKc0Xjl
         JCRtD0k5SBmovdQpGfmc1GUBGsfIU5c6tAEtwkEHmdm4IUW2N3l2EilL6+M6eMia/clf
         fSPZn4qeSIjri+1XA29MS0gPtLGuTGe5zjuS5+fLbj87dWk0qIAb+ec3tco/9989W5L0
         tf5iFoHNeBLQ6NpFMHQxJ08b7l3Jls0d3PhqiYPjDVRIPJfH9Lm4TGhcabfSzMIHYUVc
         rfDK/rv2/legUILE1pPOTsTGvIohfdT0/GHBpWM3iYOnhxtLC6ZjWEqC9ym+eXGyffb9
         NMJA==
X-Received: by 10.49.105.138 with SMTP id gm10mr81716033qeb.7.1385976963074;
 Mon, 02 Dec 2013 01:36:03 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Mon, 2 Dec 2013 01:35:33 -0800 (PST)
In-Reply-To: <1385971274.3240.14.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238620>

On Mon, Dec 2, 2013 at 3:01 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On ma, 2013-12-02 at 07:38 +0700, Duy Nguyen wrote:
>> On Mon, Dec 2, 2013 at 6:38 AM, Dennis Kaarsemaker
>> <dennis@kaarsemaker.net> wrote:
>> > On ma, 2013-12-02 at 00:08 +0100, Thomas Rast wrote:
>> >> Duy Nguyen <pclouds@gmail.com> writes:
>> >>
>> >> > On Mon, Dec 2, 2013 at 2:04 AM, Dennis Kaarsemaker
>> >> > <dennis@kaarsemaker.net> wrote:
>> >> >> We always ignore anything named .git, but we should also ignore the git
>> >> >> directory if the user overrides it by setting $GIT_DIR
>> >> [...]
>> >> >> +       if (simplify_away(path->buf, path->len, simplify) || is_git_directory(path->buf))
>> >> >>                 return path_none;
>> >> >
>> >> > this adds 2 access, 1 lstat, 1 open, 1 read, 1 close to _every_ path
>> >> > we check. Is it worth the cost?
>> >>
>> >> Moreover it is a much more inclusive check than what the commit message
>> >> claims: it will ignore anything that looks like a .git directory,
>> >> regardless of the name.  In particular GIT_DIR doesn't have anything to
>> >> do with it.
>> >
>> > Ah, yes thanks, that's rather incorrect indeed. How about the following
>> > instead? Passes all tests, including the new one.
>> >
>> > --- a/dir.c
>> > +++ b/dir.c
>> > @@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
>> >                 return path_none;
>> >         strbuf_setlen(path, baselen);
>> >         strbuf_addstr(path, de->d_name);
>> > -       if (simplify_away(path->buf, path->len, simplify))
>> > +       if (simplify_away(path->buf, path->len, simplify) || !strncmp(get_git_dir(), path->buf, path->len))
>> >                 return path_none;
>>
>> get_git_dir() may return a relative or absolute path, depending on
>> GIT_DIR/GIT_WORK_TREE. path->buf is always relative. You'll pass one
>> case with this (relative vs relative) and fail another. It might be
>> simpler to just add get_git_dir(), after converting to relative path
>> and check if it's in worktree, to the exclude list and let the current
>> exclude mechanism handle it.
>
> This type of invocation really only works from the root of the workdir
> anyway and both a relative and absolute path work just fine:
>
> dennis@lightning:~/code/git$ GIT_DIR=$(pwd)/.foo ./git status
> On branch master
> nothing to commit, working directory clean
> dennis@lightning:~/code/git$ GIT_DIR=./.foo ./git status
> On branch master
> nothing to commit, working directory clean
>
> Well, unless you set GIT_WORK_TREE as well, but then it still works:
>
> dennis@lightning:~/code/git/t$ GIT_DIR=$(pwd)/../.foo GIT_WORK_TREE=.. ../git status
> On branch master
> nothing to commit, working directory clean
> dennis@lightning:~/code/git/t$ GIT_DIR=../.foo GIT_WORK_TREE=.. ../git status
> On branch master
> nothing to commit, working directory clean
>
> So I'm wondering when you think this will fail. Because then I can add a
> test for that case too.

~/w/git $ cd t
~/w/git/t $ GIT_TRACE_SETUP=1 ../git --git-dir=../.git --work-tree=..
--no-pager status
setup: git_dir: /home/pclouds/w/git/.git
setup: worktree: /home/pclouds/w/git
setup: cwd: /home/pclouds/w/git
setup: prefix: t/
On branch exclude-pathspec
Your branch and 'origin/master' have diverged,
and have 2 and 5 different commits each, respectively.

I can't say this is the only case though. One has to audit to all
possible setup cases in setup_git_directory() to make that claim.
-- 
Duy
