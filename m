From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 2 Dec 2013 07:38:20 +0700
Message-ID: <CACsJy8CSQ2RfZub6As9TJc2Vd-wmp75ZVnjQ4nr1QY4mZ4f_TA@mail.gmail.com>
References: <1385922611.3240.6.camel@localhost> <20131201190447.GA31367@kaarsemaker.net>
 <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
 <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098> <1385941093.3240.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 01:39:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnHXQ-00016v-LU
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 01:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab3LBAix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 19:38:53 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:65461 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3LBAiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 19:38:52 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so10286225qee.24
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 16:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sy7Mz3k7KZrFMCldTr1x5zTEMFldqdK2Xgu0qfJw7vM=;
        b=0vYe2ON6P6x5hP48TmW3u1wn1egeqAxH3wQGzN3gJvnv6jTDMhqNpwcn8AXAnEU4c/
         oJL0FXDSWcmqsfG/ooiO6fAUV2AYwgCp3UtrmsKr5Xc+e700ZHnAqDw9hl40715XV/Ue
         Nu3hL0asef9sUIvKQGl+Lvfs1dgPXLOlIl1Z94Zh9asEMq6akxYkbyfApq+NQzVcbtv9
         nbukSxzEFKLioVGRi7Ntdgu8ago+4/IIV140h5e08I7U+HbwppHAQC7QMxkCcIFLv33F
         ky3CyQA7JC88SaLwAQdPSwy6fdj8VOUlEVW0Jq/sB+sccA47w+zyER9ziCierUisxeNL
         gpow==
X-Received: by 10.229.65.201 with SMTP id k9mr108325237qci.11.1385944730860;
 Sun, 01 Dec 2013 16:38:50 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sun, 1 Dec 2013 16:38:20 -0800 (PST)
In-Reply-To: <1385941093.3240.10.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238607>

On Mon, Dec 2, 2013 at 6:38 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On ma, 2013-12-02 at 00:08 +0100, Thomas Rast wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > On Mon, Dec 2, 2013 at 2:04 AM, Dennis Kaarsemaker
>> > <dennis@kaarsemaker.net> wrote:
>> >> We always ignore anything named .git, but we should also ignore the git
>> >> directory if the user overrides it by setting $GIT_DIR
>> [...]
>> >> +       if (simplify_away(path->buf, path->len, simplify) || is_git_directory(path->buf))
>> >>                 return path_none;
>> >
>> > this adds 2 access, 1 lstat, 1 open, 1 read, 1 close to _every_ path
>> > we check. Is it worth the cost?
>>
>> Moreover it is a much more inclusive check than what the commit message
>> claims: it will ignore anything that looks like a .git directory,
>> regardless of the name.  In particular GIT_DIR doesn't have anything to
>> do with it.
>
> Ah, yes thanks, that's rather incorrect indeed. How about the following
> instead? Passes all tests, including the new one.
>
> --- a/dir.c
> +++ b/dir.c
> @@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
>                 return path_none;
>         strbuf_setlen(path, baselen);
>         strbuf_addstr(path, de->d_name);
> -       if (simplify_away(path->buf, path->len, simplify))
> +       if (simplify_away(path->buf, path->len, simplify) || !strncmp(get_git_dir(), path->buf, path->len))
>                 return path_none;

get_git_dir() may return a relative or absolute path, depending on
GIT_DIR/GIT_WORK_TREE. path->buf is always relative. You'll pass one
case with this (relative vs relative) and fail another. It might be
simpler to just add get_git_dir(), after converting to relative path
and check if it's in worktree, to the exclude list and let the current
exclude mechanism handle it.
-- 
Duy
