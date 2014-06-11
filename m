From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Fix "t0001: test git init when run via an alias"
Date: Wed, 11 Jun 2014 17:57:50 +0700
Message-ID: <CACsJy8Dh9miVOGM0JLWXs6kzzEnum1ggnc2qm0gKaCwX+9iZYQ@mail.gmail.com>
References: <20140606110935.GA14446@lanh> <1402220230-799-1-git-send-email-pclouds@gmail.com>
 <xmqq4mzsa9ej.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 12:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WugEd-0002GM-0i
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 12:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbaFKK6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2014 06:58:23 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:40829 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbaFKK6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 06:58:21 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so4108274qcz.37
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sm4cYirPnZVIMt05hlViuBVrrUfQGx7aFdakewyrTYk=;
        b=DzprbzGg2dPBb32udvcbI8q79nxm0l6l+2aSKhoaQwu5lww7AuGkVkWr5Dz11UvtVk
         j8q4E/+AINf7FGJuGhomyS8Sj/mPuR06dpA5y13MD6P71ut0fPd31/zhXQbeMlkK0wqh
         vLX4eeXZkrm/AsMTF4rWqqW3tdv6CQAwVCvcj1D7zYYWpuOucmKWF70FxAMZIb+7eskT
         SJdKFmDSz0fmGx/D0OeaeEo9tboaIJYaYb+opc0TdGBJo80Kd+V6dnJY8IZJ7acTjWVJ
         FauaVTUZHH5TeKmaeNNRrh7uX3iWKzewzBAI1bfBPXd4M4XKl3znjhfAFvTKP1ApeJWy
         DdAg==
X-Received: by 10.224.160.202 with SMTP id o10mr51020578qax.8.1402484300947;
 Wed, 11 Jun 2014 03:58:20 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 11 Jun 2014 03:57:50 -0700 (PDT)
In-Reply-To: <xmqq4mzsa9ej.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251361>

On Wed, Jun 11, 2014 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Commit 4ad8332 (t0001: test git init when run via an alias -
>> 2010-11-26) noted breakages when running init via alias. The problem
>> is for alias to be used, $GIT_DIR must be searched, but 'init' and
>> 'clone' are not happy with that. So we start a new process like an
>> external command, with clean environment in this case. Env variables
>> that are set by command line (e.g. "git --git-dir=3D.. ") are kept.
>>
>> This should also fix autocorrecting a command typo to "init" because
>> it's the same problem: aliases are read, then "init" is unhappy with
>> $GIT_DIR already set up because of that.
>>
>> Reminded-by: David Turner <dturner@twopensource.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  git.c           | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
++----
>
> This goes far deeper than "Fix t0001", doesn't it?

I followed the way git-revert creates the subject line, thinking that
this fixes an old commit so do similarly. Probably better rephrase it.

>
>>  t/t0001-init.sh |  4 ++--
>>  2 files changed, 50 insertions(+), 6 deletions(-)
>>
>> diff --git a/git.c b/git.c
>> index 7780572..d1e49da 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -484,6 +521,10 @@ static void handle_builtin(int argc, const char=
 **argv)
>>               struct cmd_struct *p =3D commands+i;
>>               if (strcmp(p->cmd, cmd))
>>                       continue;
>> +             if (saved_environment && (p->option & NO_SETUP)) {
>> +                     restore_env();
>> +                     break;
>> +             }
>>               exit(run_builtin(p, argc, argv));
>>       }
>>  }
>> @@ -539,7 +580,10 @@ static int run_argv(int *argcp, const char ***a=
rgv)
>>                * of overriding "git log" with "git show" by having
>>                * alias.log =3D show
>>                */
>> -             if (done_alias || !handle_alias(argcp, argv))
>> +             if (done_alias)
>> +                     break;
>> +             save_env();
>> +             if (!handle_alias(argcp, argv))
>>                       break;
>>               done_alias =3D 1;
>>       }
>
> So the save-env kicks in only after we tried the builtins and the
> externals and didn't find any, and before expanding the alias (which
> has to look at the config, which means we need to do discovery and
> may contaminate the environment and the globals), and then when we
> retry with the expanded alias, we restore when we know the command
> will misbehave if we didn't do so?
>
> That does not sound so bad.  Even though I wonder if that "save and
> then restore" sequence logically belongs around handle_alias(), you
> would not have sufficient clue to let you cheat by not restoring the
> environment for commands that you happen to know that they do not
> care, so that may be a reasonable optimization.

The save code definitely belongs to handle_alias(). I'm not so
confident about always restoring at the end of handle_alias(). The
restore procedure is just enough not to propagate wrong info to the
child process. For that purpose, guarding cwd and environm are enough.
If after we return from handle_alias() and we run the builtin command
anyway, that' may not be clean enough (e.g. static variables may be
already initialized..)

> Is it too brittle a solution to force people to mark problematic
> subcommands with NO_SETUP, though?  What kind of change to a
> subcommand that currently does not have to be marked with NO_SETUP
> would make it necessary to mark it with NO_SETUP?

If I had a clear answer here, I could have undone the setup effects
caused by handle_alias() and not resort to spawning a new process :)
So my answer is mostly trial and error. We have evidence that clone
and init do not work with contaminated environment. So we fix them and
wait for new bugs to show up.
--=20
Duy
