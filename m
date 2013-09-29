From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 02/44] ruby: add support for internal ruby programs
Date: Sun, 29 Sep 2013 00:07:58 -0500
Message-ID: <CAMP44s186x7uWh8-0hHK+3ye=-7UsdJSUZbFODG+bgKkS1PZwA@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<1380405849-13000-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=XSxiz+MoU2H7Zxo4gSRvs+C5fGpnD2ioBvrXzdLpmww@mail.gmail.com>
	<CAMP44s28B+UX1ofQb_sZfaPG2htvQ=W_EvScVbFgmR9P4SnvPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:08:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ9Ek-0002Fy-2N
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab3I2FIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:08:01 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:58920 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2FIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:08:00 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so3425634lab.12
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6sHfxAdnYFcydBu8lJgkTDlXxC8sUhz0rhfCwoU+ijk=;
        b=yAQuBEhhobDwx40vH9nRmt4lnI2g9iWR3ad4HBKTXXnNahky7UigmtRV95beaJxNeL
         TaE38bVJtkMr0m1RtgdNY8T5i5U66/d9MPBkLDYKX6A+Bi46R5o5vDxg5TkfwZWABy48
         mO+at3ZUxZC3D6cAw0gbNd28P8FJPz/mriS/GNSkoePrNKpyAw18+M3OxSQiVXTnOiMx
         ncpSHrCUnfydWPtccJsgjBita/KjwBp0Ya7ECzrZOPaq6IPOmiYmQzaehM9lF8aMNE8l
         U2h/3/eTUs/BOpF06+89VCZ+/f6QSw2PwdbIIjyJZNyVb4X6AebqqR5Rja1J/nQPsKj0
         XRQg==
X-Received: by 10.112.168.3 with SMTP id zs3mr16413120lbb.2.1380431278351;
 Sat, 28 Sep 2013 22:07:58 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 22:07:58 -0700 (PDT)
In-Reply-To: <CAMP44s28B+UX1ofQb_sZfaPG2htvQ=W_EvScVbFgmR9P4SnvPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235588>

On Sat, Sep 28, 2013 at 11:56 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Sep 28, 2013 at 11:40 PM, Ramkumar Ramachandra

>>> diff --git a/ruby.c b/ruby.c
>>> index ee6a0e7..339e376 100644
>>> --- a/ruby.c
>>> +++ b/ruby.c
>>> @@ -52,5 +52,22 @@ static int run_ruby_command(const char *cmd, int argc, const char **argv)
>>>
>>>  int main(int argc, const char **argv)
>>>  {
>>> -       return run_ruby_command(argv[1], argc, argv);
>>> +       if (!strcmp(argv[0], "git-ruby")) {
>>> +               return run_ruby_command(argv[1], argc, argv);
>>> +       } else {
>>> +               const char *cmd = argv[0];
>>> +               static char buf[PATH_MAX + 1];
>>> +               const char *args[argc + 1];
>>> +               int i;
>>> +
>>> +               snprintf(buf, PATH_MAX, "%s/%s.rb",
>>> +                               git_exec_path(), basename((char *)cmd));
>>> +
>>> +               args[0] = "git";
>>> +               args[1] = buf;
>>> +               for (i = 0; i < argc - 1; i++)
>>> +                       args[i + 2] = (char *)argv[i + 1];
>>> +
>>> +               return run_ruby_command(cmd, argc + 1, args);
>>> +       }
>>>  }
>>
>> Can you explain this in greater detail in your commit message? When I
>> pass an argument,
>>
>>   $ git ruby foo
>>   git-ruby: No such file or directory -- foo (LoadError)
>>
>> I get this as before. How exactly will new ruby scripts be executed?
>> (I can only guess at this point)
>
> If you do:
>
> % git ruby foo
>
> It's the same as
>
> % ruby foo
>
> You need the script right there, as a file named "foo".
>
> However, this already works before this patch.
>
> What this patch does is enable:
>
> % git foo
>
> But for this you need two things:
>
> 1) A binary named git-foo in your path, that is a link to git-ruby,
> which is what the variable RUBY_PROGRAMS is for in the Makefile
>
> 2) A script named git-foo.rb in your exec-path.
>
> So basically "git-foo" is the same as "git ruby $GIT_EXEC_PATH/git-foo.rb".

Note that this is for _internal_ Ruby programs, if you want "git foo"
to run yours, or a third party script, you can do it like this:

cat > git-foo <<EOF
#!git ruby

#ruby code
EOF

chmod +x and put it on your PATH, done :)

-- 
Felipe Contreras
