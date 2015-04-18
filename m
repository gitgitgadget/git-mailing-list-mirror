From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 1/7] path.c: implement xdg_config_home()
Date: Sat, 18 Apr 2015 15:51:48 +0800
Message-ID: <CACRoPnR7MQsP_dAE0RV_80JDbU9h6tfu30yL2OOK+JGYLzVLNQ@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<20150414172854.GA27623@yoshi.chippynet.com>
	<CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 09:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjNXh-000566-4Y
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 09:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbbDRHvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 03:51:51 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:35726 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbbDRHvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 03:51:50 -0400
Received: by labbd9 with SMTP id bd9so95336832lab.2
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kNApDWbu9ZE1UDZOkl2Eih4+lHk4Yv24z9S2VYbGitI=;
        b=XYKY0npxtnfXE/TdUQLcm5ZU9uDCSH9tL9DgcMThiskfOZJsQMOJ3RtfcikCQvgCv8
         VJ5QYlUzx9AHV4Eyad9vcQmllA4SDVupfaBWEXSoXVas2HvJqewJwYSQ4TSxsCX69mhz
         LeLMVsztHlOuR2WzdnEAgiezeDN/hJ5MDsnzWggr1SHKt4hM1dWCIXLl5GQ2WGAngxxi
         KrrezzrBqKWlDEyUrgTdjmomM39g2klvc3wwBIRr/PzLJRm6m2WQMCMQ2XAWI+kMOJ2G
         ojiGEam2g9v5p+0tsqDN8ATjtNIs80FfKSmYzq9seqIo0+9zmWDOVgj31dpMXAAdccrt
         CjiA==
X-Received: by 10.152.2.38 with SMTP id 6mr7575944lar.80.1429343508865; Sat,
 18 Apr 2015 00:51:48 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 18 Apr 2015 00:51:48 -0700 (PDT)
In-Reply-To: <CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267408>

Hi,

On Fri, Apr 17, 2015 at 5:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 14, 2015 at 1:28 PM, Paul Tan <pyokagan@gmail.com> wrote:
>> Below is the fixed patch. I also decided to return NULL if `filename` is
>> NULL because such an input usually indicated an uncaught error.
>
> Unfortunately, this blurs the line between programmer error (passing
> NULL for filename) and a user/configuration error (XDG_CONFIG_HOME and
> HOME being undefined). If there is indeed no valid interpretation for
> filename==NULL, then it may be better to die() or assert() here to
> flag the programmer error as early as possible, rather than returning
> NULL.
>
> More below.
>
>> ---
>> diff --git a/cache.h b/cache.h
>> index 3d3244b..2db10b8 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -836,6 +836,14 @@ char *strip_path_suffix(const char *path, const char *suffix);
>>  int daemon_avoid_alias(const char *path);
>>  extern int is_ntfs_dotgit(const char *name);
>>
>> +/**
>> + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/{filename}".  If
>> + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
>> + * "$HOME/.config/git/{filename}". Returns NULL if filename is NULL or an error
>> + * occurred.
>> + */
>
> This is better than the original which said "$XDG_CONFIG_HOME/git/%s",
> but is still potentially confusing. When I read the earlier iteration,
> I was left with the impression that it was returning that literal
> string, with '$' and '%s' embedded, and that the caller would have to
> process it further to have '$' and '%s' expanded. Perhaps rephrasing
> it something like this will help?
>
>     Return a newly allocated string with value xdg+"/git/"+filename
>     where xdg is the interpolated value of $XDG_CONFIG_HOME if
>     defined and non-empty, otherwise "$HOME/.config". Return NULL
>     upon error.
>

Personally I think interpolated strings are easier to read than
concatenated strings. $VARIABLE (all upper case) in shell scripting is
understood to be an environment variable, and $variable (all lower
case) to be a local variable.

Thinking about it again, I should not be using python-style format
strings either ;-). So I would write it as
"$XDG_CONFIG_HOME/git/$filename".

But anyway, I don't have strong opinions on documentation, so I will
leave this to majority opinion. I will change it if you strongly
disagree :-).

> Also, for consistency with other API documentation, say "Return"
> rather than "Returns".

Okay, will fix.

>
> More below.
>
>> +extern char *xdg_config_home(const char *filename);
>> +
>>  /* object replacement */
>>  #define LOOKUP_REPLACE_OBJECT 1
>>  extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
>> diff --git a/path.c b/path.c
>> index e608993..8ee7191 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -856,3 +856,19 @@ int is_ntfs_dotgit(const char *name)
>>                         len = -1;
>>                 }
>>  }
>> +
>> +char *xdg_config_home(const char *filename)
>> +{
>> +       const char *config_home = getenv("XDG_CONFIG_HOME");
>> +
>> +       if (!filename)
>> +               return NULL;
>
> See above regarding conflation of programmer error and user/configuration error.
>
>> +       if (!config_home || !config_home[0]) {
>
> On this project, *config_home is usually favored over config_home[0].
>
>> +               const char *home = getenv("HOME");
>> +
>> +               if (!home)
>> +                       return NULL;
>> +               return mkpathdup("%s/.config/git/%s", home, filename);
>> +       } else
>> +               return mkpathdup("%s/git/%s", config_home, filename);
>
> This logic is more difficult to follow than it ought to be due to the
> use of 'config_home' so distant from the 'if' which checked it, and
> due to the nested 'if'. It could be expressed more straight-forwardly
> as:
>
>     if (config_home && *config_home)
>         return mkpathdup("%s/git/%s", config_home, filename);
>
>     home = getenv("HOME");
>     if (home)
>         return mkpathdup("%s/.config/git/%s", home, filename);
>
>     return NULL;
>

Ah, flipping the conditionals definitely makes it look nicer. I guess
I will need your sign off to use your code? Thanks!

Regards,
Paul
