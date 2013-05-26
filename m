From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v13 02/15] path.c: refactor relative_path(), not only
 strip prefix
Date: Sun, 26 May 2013 08:21:14 +0800
Message-ID: <CANYiYbGiAdMtOwdAf1cgV74cJjaM1dABTE6LEe+LAWoEaUBSXw@mail.gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
	<d730f00edb09449bf299be8d2083c895a1028c18.1369186574.git.worldhello.net@gmail.com>
	<519C7CA1.2060402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 26 02:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgOiG-0006Ji-2x
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 02:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359Ab3EZAVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 20:21:17 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:59543 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758295Ab3EZAVQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 20:21:16 -0400
Received: by mail-we0-f172.google.com with SMTP id w62so3598194wes.3
        for <git@vger.kernel.org>; Sat, 25 May 2013 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0YaLgA9mOJqeYRziJDLhx/Bdqbw6ICEFw3zDGtk+a6c=;
        b=S7TROEkbHTA6F1o3hyvFQc38OlUFrQVxdKF3FXCOVvPjUromYOmGuml/BueYRzSI0V
         HQ8AmeY1qFjfb05+6Xnaffw6vtQ3BJTOvARdb3zeyJrE+AM28YckixWdyJpze6yoC241
         btsN4qcFIoECBmhy8AQSXazm6TPDO1L/TPsDYn9n7fu7EAgLh7h/8G4poYoTvDcGZ0Ff
         EJB5AI2i/zrf2xyMXezhjwcN2ZwyKROsDYi/kzyTTihL++S1P6fDOtj3VGFMAPJt2hoa
         DAeiCaSLs+LRwYL69dnOeGhRJreUQiKPQiZwELAItY1nbJWd2x4es3/HMqOYOTD7ExGP
         /vUA==
X-Received: by 10.194.77.15 with SMTP id o15mr3851837wjw.27.1369527674557;
 Sat, 25 May 2013 17:21:14 -0700 (PDT)
Received: by 10.194.179.37 with HTTP; Sat, 25 May 2013 17:21:14 -0700 (PDT)
In-Reply-To: <519C7CA1.2060402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225535>

2013/5/22 Michael Haggerty <mhagger@alum.mit.edu>:
> Sorry for coming late to the party.

I am on a business travel, and respond late also. ;-)

>
> On 05/22/2013 03:40 AM, Jiang Xin wrote:
>> Different results for relative_path() before and after this refactor=
:
>>
>>     abs path  base path  relative (original)  relative (refactor)
>>     =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     /a/b/c/   /a/b       c/                   c/
>>     /a/b//c/  //a///b/   c/                   c/
>>     /a/b      /a/b       .                    ./
>>     /a/b/     /a/b       .                    ./
>>     /a        /a/b/      /a                   ../
>>     /         /a/b/      /                    ../../
>>     /a/c      /a/b/      /a/c                 ../c
>>     /a/b      (empty)    /a/b                 /a/b
>>     /a/b      (null)     /a/b                 /a/b
>>     (empty)   /a/b       (empty)              ./
>>     (null)    (empty)    (null)               ./
>>     (null)    /a/b       (segfault)           ./
>
> The old and new versions both seem to be (differently) inconsistent
> about when the output has a trailing slash.  What is the rule?

The reason for introducing patch 02/15 is that we don't want to reinven=
t
the wheel. Patch 06/15 (git-clean: refactor git-clean into two phases)
needs to save relative_path of each git-clean candidate file/directory =
in
del_list, but the public method in path.c (i.e. relative_path) is not
powerful, and static method in quote.c (i.e. path_relative) can note be
used directly. One way is to enhanced relative_path in path.c, like thi=
s
patch.

Since we combine the two methods (relative_path in path.c and
path_relative in quote.c), the new relative_path must be compatible
with the original two methods.

relative_path in path.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

relative_path is called in one place:

        if (getenv(GIT_WORK_TREE_ENVIRONMENT))
                setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);

        set_git_dir(relative_path(git_dir, work_tree));
        initialized =3D 1;

and set_git_dir only set the environment GIT_DIR_ENVIRONMENT
like this:

        int set_git_dir(const char *path)
        {
                if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
                        return error("Could not set GIT_DIR to '%s'", p=
ath);
                setup_git_env();
                return 0;
        }

So the only restraint for relative_path is that the return value can
not be blank. If the abs and base arguments for relative_path are
the same, the return value should be "." ("./" is also OK), then
set the envionment GIT_DIR_ENVIRONMENT to "." (or "./").

path_relative in quote.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We can not simply move "path_relative" in quote.c to "relative_path"
in path.c directly. It is because:

* The arguments for "relative_path" are from user input. So must
   validate (remove duplicate slash) before use. But "path_relative"
   does not check duplicate slash in arguments.

* "path_relative" will return blank string, if abs and base are the sam=
e.

Also I noticed that "quote_path_relative" of quote.c (which calls
path_relative) will transform the blank string from path_relative to
"./" (not ".")

        char *quote_path_relative(const char *in, int len,
        ...
                const char *rel =3D path_relative(in, len, &sb, prefix,=
 -1);
                ...
                if (!out->len)
                        strbuf_addstr(out, "./");

That's why the "path_relative" in path.c refactor the output of "." int=
o "./".

>
>> diff --git a/path.c b/path.c
>> index 04ff..0174d 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -441,42 +441,104 @@ int adjust_shared_perm(const char *path)
>>       return 0;
>>  }
>>
>> -const char *relative_path(const char *abs, const char *base)
>> +/*
>> + * Give path as relative to prefix.
>> + *
>> + * The strbuf may or may not be used, so do not assume it contains =
the
>> + * returned path.
>> + */
>> +const char *relative_path(const char *abs, const char *base,
>> +                       struct strbuf *sb)
>
> Thanks for adding documentation.  But I think it could be improved:
>
> * The comment refers to "path" and "prefix" but the function paramete=
rs
> are "abs" and "base".  I suggest making them agree.

Yes, it will be nice to update the comments.

> * Who owns the memory pointed to by the return value?
>
> * The comment says that "the strbuf may or may not be used".  So why =
is
> it part of the interface?  (I suppose it is because the strbuf might =
be
> given ownership of the returned memory if it has to be allocated.)
> Would it be more straightforward to *always* return the result in the
> strbuf?
>
> * Please document when the return value contains a trailing slash and
> also that superfluous internal slashes are (apparently) normalized aw=
ay.
>
> * Leading double-slashes have a special meaning on some operating
> systems.  The old and new versions of this function both seem to igno=
re
> differences between initial slashes.  Perhaps somebody who knows the
> rules better could say whether this is an issue but I guess the probl=
em
> would rarely be encountered in practice.

See Junio's reply.

>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/



--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
