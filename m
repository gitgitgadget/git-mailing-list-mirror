From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 02/44] ruby: add support for internal ruby programs
Date: Sat, 28 Sep 2013 23:56:18 -0500
Message-ID: <CAMP44s28B+UX1ofQb_sZfaPG2htvQ=W_EvScVbFgmR9P4SnvPg@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<1380405849-13000-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=XSxiz+MoU2H7Zxo4gSRvs+C5fGpnD2ioBvrXzdLpmww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ93c-0000WW-Ba
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab3I2E4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:56:21 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:34958 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2E4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:56:20 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so3361304lab.40
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XVeiORJ7BMyQxmalUcxwBhh4JC5tJnBCKW7ebk3obXI=;
        b=qK04EcsPz22QRGfqJwJ6fD2PrHdKmu6I4xTCfRP7MlvSXWwegok34oFV5PQCQWq6bq
         /vR5SlKEyFLjckfA+XkK7yK5Zrdg6pSzr+ncl70G1mzIcYJuTA2hzmjDuAkIw+IN6UCb
         cpAwYLCW+EADOX+Q0lXLX3VPJnXl1kOcsSew25Awf9xoXf71QZfumOMezgBSYiA1TN+U
         SMc2NpI9pOpb8fRa1tZr5vgHZalgLRDAdpitbC6T2KRkt7mnbv5lPMcwVUmWnpNmC4hf
         SrGQjPkrqkJWJ/zee4SjYMqqXnauzCXEEEd9JChujsJ5RAkQAeTNbq6KNs7Pwens/dl6
         +M5A==
X-Received: by 10.152.30.74 with SMTP id q10mr954977lah.27.1380430578495; Sat,
 28 Sep 2013 21:56:18 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 21:56:18 -0700 (PDT)
In-Reply-To: <CALkWK0=XSxiz+MoU2H7Zxo4gSRvs+C5fGpnD2ioBvrXzdLpmww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235585>

On Sat, Sep 28, 2013 at 11:40 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> +$(RUBY_PROGRAMS): git-ruby$X
>> +       $(QUIET_BUILT_IN)$(RM) $@ && \
>> +       ln >lt; $@ 2>/dev/null || \
>> +       ln -s >lt; $@ 2>/dev/null || \
>> +       cp >lt; $@
>
> Why so many fallbacks? Will the hard-link (the first ln) ever fail?

Because that's what the code right on top of this is doing. I presume
it would fail in file-systems that don't have hard-links.

>> diff --git a/ruby.c b/ruby.c
>> index ee6a0e7..339e376 100644
>> --- a/ruby.c
>> +++ b/ruby.c
>> @@ -52,5 +52,22 @@ static int run_ruby_command(const char *cmd, int argc, const char **argv)
>>
>>  int main(int argc, const char **argv)
>>  {
>> -       return run_ruby_command(argv[1], argc, argv);
>> +       if (!strcmp(argv[0], "git-ruby")) {
>> +               return run_ruby_command(argv[1], argc, argv);
>> +       } else {
>> +               const char *cmd = argv[0];
>> +               static char buf[PATH_MAX + 1];
>> +               const char *args[argc + 1];
>> +               int i;
>> +
>> +               snprintf(buf, PATH_MAX, "%s/%s.rb",
>> +                               git_exec_path(), basename((char *)cmd));
>> +
>> +               args[0] = "git";
>> +               args[1] = buf;
>> +               for (i = 0; i < argc - 1; i++)
>> +                       args[i + 2] = (char *)argv[i + 1];
>> +
>> +               return run_ruby_command(cmd, argc + 1, args);
>> +       }
>>  }
>
> Can you explain this in greater detail in your commit message? When I
> pass an argument,
>
>   $ git ruby foo
>   git-ruby: No such file or directory -- foo (LoadError)
>
> I get this as before. How exactly will new ruby scripts be executed?
> (I can only guess at this point)

If you do:

% git ruby foo

It's the same as

% ruby foo

You need the script right there, as a file named "foo".

However, this already works before this patch.

What this patch does is enable:

% git foo

But for this you need two things:

1) A binary named git-foo in your path, that is a link to git-ruby,
which is what the variable RUBY_PROGRAMS is for in the Makefile

2) A script named git-foo.rb in your exec-path.

So basically "git-foo" is the same as "git ruby $GIT_EXEC_PATH/git-foo.rb".

-- 
Felipe Contreras
