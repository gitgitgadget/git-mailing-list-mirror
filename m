From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed, 16 Dec 2015 14:36:46 -0800
Message-ID: <CAGZ79kb07Sv7LzDZUCxFk1Cmxxk2cga5sN-pT_R1e9_4wSJirA@mail.gmail.com>
References: <1449709654-30189-1-git-send-email-sbeller@google.com>
	<5669202C.2090100@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 23:36:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Kgm-0003u1-8A
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbbLPWgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:36:47 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35565 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbLPWgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:36:46 -0500
Received: by mail-ig0-f177.google.com with SMTP id to4so87304660igc.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 14:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PNy5XOWwIR4jPlVDbyYJcVlEXpwUWqMzfbaOBsTgtOk=;
        b=S6pdM36Ek5OnLULLaJpbtxNb7/ypA9AcYgs12YzlNlM1ZBEKbMBd46Z1y9X+C/eHbY
         7ds3BCL5IaDcFu/XQZbjEda+j7SOzSuBTQLbIeDugFeKeWCjcEORUoYhuBUcUculHiof
         vMiPVfMCZ1ymwQUJQ1ULpIbZj65hTPsjuceLl36X+/aOx1pk7u4F0DTyu5DW9SktJtpP
         OZk73IUwBo5A9JTXdhzXW0FMkqz/3QwAINaikQ8Fwgh3tcBCKmjHDMHMJELQQvYo7Eiq
         PAswC5klEA4tyjH0Y/e4gX61PzgJCKLO3v+TBjW/aLHKWBzFPIS6k8kGcDWuSS4ByGd+
         Ej+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PNy5XOWwIR4jPlVDbyYJcVlEXpwUWqMzfbaOBsTgtOk=;
        b=MEmLL08zLFcpR76sxFYA46RJW4zz7fVgIFXC6UmEhpNq4sPTf783u2VGFOPhRAKhMB
         u8qXjrtjyptvreVffLnpMUQWVfgkjfzyuJGZuGl6MhSZE9EwAD4jBq4keP2tBpn/gJgd
         Bo5aKot+K9wAfgFmO2rc0NmEaIhImdtij6CRjJRXSX4zgrpg8TV68dNODQbbSQMXtSi1
         XFL7lxv/6BO1OFVukmLB/wJjjyoSL1xQAzJZS8RhZ0JnFaZnSk0ChJnryI3SOmjQaXSC
         nrdkWEErpUr/vsL9uysKpIWBmGJktDIbBb7/5Qug1UkGAJksPfa4qW2iXoMvOkbADwxB
         YOdw==
X-Gm-Message-State: ALoCoQn5hOxpCEVrBRFbI2jrVXNtKZnCbKePtUMJ7S3yp4gZcPlkA7w7a6XpFIaCrnTc4150/rbZR9IH+pXdx3E8X00ZIyW8eiz+P1/NrZQVy05G9M5NmVE=
X-Received: by 10.107.168.203 with SMTP id e72mr3816376ioj.96.1450305406137;
 Wed, 16 Dec 2015 14:36:46 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 16 Dec 2015 14:36:46 -0800 (PST)
In-Reply-To: <5669202C.2090100@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282616>

On Wed, Dec 9, 2015 at 10:48 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 10.12.2015 um 02:07 schrieb Stefan Beller:
>>
>> This reimplements the helper function `resolve_relative_url` in shell
>> in C. This functionality is needed in C for introducing the groups
>> feature later on. When using groups, the user should not need to run
>> `git submodule init`, but it should be implicit at all appropriate places,
>> which are all in C code. As the we would not just call out to `git
>> submodule init`, but do a more fine grained structure there, we actually
>> need all the init functionality in C before attempting the groups
>> feature. To get the init functionality in C, rewriting the
>> resolve_relative_url subfunction is a major step.
>
>
> I see lots of '/', but no is_dir_sep() in the C version. Did you consider
> that local URLs can use a backslash as path separator on Windows? In the
> shell version, this did not matter because bash converts the backslashes to
> forward slashes for us. But when rewritten in C, this does not happen.

I see. That's a pity. :(

>
> Valid URLs are
>
>   D:\foo\bar.git
>   \\server\share\foo\bar
>   ..\..\foo\bar

I am staring at the code in desperation as backslashes
in Linux are valid for file names, i.e.:
"/tmp/testfile\" is a valid filename

Now look at the code where the first slash occurs, it's

    if (strip_suffix(remoteurl, "/", &len))
        remoteurl[len] = '\0';

The intention is to strip off the last character if it is a directory separator.
So in the unix world we want to keep "/tmp/testfile\" as it is,
whereas in Windows
we want to chop off the backslash (because there is no file with a
backslash allowed,
it is the directory separator?)

So what I think I am going to do for next round is something like

    static int has_same_dir_prefix(const char *str, const char **out)
    {
    #ifdef GIT_WINDOWS_NATIVE
        return skip_prefix(str, "./", out)
           || skip_prefix(str, ".\\", out);
    #else
        return skip_prefix(str, "./", out);
    #endif
    }

    static int has_upper_dir_prefix(const char *str, const char **out)
    {
    #ifdef GIT_WINDOWS_NATIVE
        return skip_prefix(str, "../", out)
           || skip_prefix(str, "..\\", out);
    #else
        return skip_prefix(str, "../", out);
    #endif
    }

in the submodule helper function, or alternatively in the wrapper.c ?
and then rely on these functions being accurate.

Would that approach make sense?

Thanks,
Stefan


>
> and all of them with some or all backslashes replaced by forward slashes.
>
> See also connect.c:url_is_local_not_ssh, which ensures that the first
> example above is considered a local path with a drive letter, not a remote
> ssh path.
>
>
>>
>> This also improves the performance:
>> (Best out of 3) time ./t7400-submodule-basic.sh
>> Before:
>> real    0m9.575s
>> user    0m2.683s
>> sys     0m6.773s
>> After:
>> real    0m9.293s
>> user    0m2.691s
>> sys     0m6.549s
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>   This applies on origin/master, and I'd carry as its own feature branch
>>   as I am nowhere near done with the groups feature after reading Jens
>> feedback.
>>   (It took me a while to identify this as a next best step.)
>>
>>   Thanks,
>>   Stefan
>>
>>   builtin/submodule--helper.c | 120
>> ++++++++++++++++++++++++++++++++++++++++++++
>>   git-submodule.sh            |  81 ++----------------------------
>>   2 files changed, 124 insertions(+), 77 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index f4c3eff..f48b5b5 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -9,6 +9,125 @@
>>   #include "submodule-config.h"
>>   #include "string-list.h"
>>   #include "run-command.h"
>> +#include "remote.h"
>> +#include "refs.h"
>> +
>> +static const char *get_default_remote(void)
>> +{
>> +       char *dest = NULL;
>> +       unsigned char sha1[20];
>> +       int flag;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
>> +
>> +       if (!refname)
>> +               die("No such ref: HEAD");
>> +
>> +       refname = shorten_unambiguous_ref(refname, 0);
>> +       strbuf_addf(&sb, "branch.%s.remote", refname);
>> +       if (git_config_get_string(sb.buf, &dest))
>> +               return "origin";
>> +       else
>> +               return xstrdup(dest);
>> +}
>> +
>> +/*
>> + * The function takes at most 2 arguments. The first argument is the
>> + * URL that navigates to the submodule origin repo. When relative, this
>> URL
>> + * is relative to the superproject origin URL repo. The second up_path
>> + * argument, if specified, is the relative path that navigates
>> + * from the submodule working tree to the superproject working tree.
>> + *
>> + * The output of the function is the origin URL of the submodule.
>> + *
>> + * The output will either be an absolute URL or filesystem path (if the
>> + * superproject origin URL is an absolute URL or filesystem path,
>> + * respectively) or a relative file system path (if the superproject
>> + * origin URL is a relative file system path).
>> + *
>> + * When the output is a relative file system path, the path is either
>> + * relative to the submodule working tree, if up_path is specified, or to
>> + * the superproject working tree otherwise.
>> + */
>> +static const char *relative_url(const char *url, const char *up_path)
>> +{
>> +       int is_relative = 0;
>> +       size_t len;
>> +       char *remoteurl = NULL;
>> +       char *sep = "/";
>> +       const char *out;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       const char *remote = get_default_remote();
>> +       strbuf_addf(&sb, "remote.%s.url", remote);
>> +
>> +       if (git_config_get_string(sb.buf, &remoteurl))
>> +               /* the repository is its own authoritative upstream */
>> +               remoteurl = xgetcwd();
>> +
>> +       if (strip_suffix(remoteurl, "/", &len))
>> +               remoteurl[len] = '\0';
>> +
>> +       if (strchr(remoteurl, ':') || skip_prefix(remoteurl, "/", &out))
>> +               is_relative = 0;
>> +       else if (skip_prefix(remoteurl, "./", &out) ||
>> +                   skip_prefix(remoteurl, "../", &out))
>> +               is_relative = 1;
>> +       else {
>> +               is_relative = 1;
>> +               strbuf_reset(&sb);
>> +               strbuf_addf(&sb, "./%s", remoteurl);
>> +               remoteurl = strbuf_detach(&sb, NULL);
>> +       }
>> +
>> +       while (url) {
>> +               if (skip_prefix(url, "../", &out)) {
>> +                       char *rfind;
>> +                       url = out;
>> +
>> +                       rfind = strrchr(remoteurl, '/');
>> +                       if (rfind)
>> +                               *rfind = '\0';
>> +                       else {
>> +                               rfind = strrchr(remoteurl, ':');
>> +                               if (rfind) {
>> +                                       *rfind = '\0';
>> +                                       sep = ":";
>> +                               } else {
>> +                                       if (is_relative || !strcmp(".",
>> remoteurl))
>> +                                               die(N_("cannot strip one
>> component off url '%s'"), remoteurl);
>> +                                       else
>> +                                               remoteurl = ".";
>> +                               }
>> +                       }
>> +               } else if (skip_prefix(url, "./", &out))
>> +                       url = out;
>> +               else
>> +                       break;
>> +       }
>> +       strbuf_reset(&sb);
>> +       strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
>> +
>> +       if (!skip_prefix(sb.buf, "./", &out))
>> +               out = sb.buf;
>> +       out = xstrdup(out);
>> +
>> +       strbuf_reset(&sb);
>> +       strbuf_addf(&sb, "%s%s", is_relative && up_path ? up_path : "",
>> out);
>> +
>> +       free((char*)out);
>> +       return strbuf_detach(&sb, NULL);
>> +}
>> +
>> +static int resolve_relative_url(int argc, const char **argv, const char
>> *prefix)
>> +{
>> +       if (argc == 2)
>> +               printf("%s\n", relative_url(argv[1], NULL));
>> +       else if (argc == 3)
>> +               printf("%s\n", relative_url(argv[1], argv[2]));
>> +       else
>> +               die("BUG: resolve_relative_url only accepts one or two
>> arguments");
>> +       return 0;
>> +}
>>
>>   struct module_list {
>>         const struct cache_entry **entries;
>> @@ -264,6 +383,7 @@ static struct cmd_struct commands[] = {
>>         {"list", module_list},
>>         {"name", module_name},
>>         {"clone", module_clone},
>> +       {"resolve_relative_url", resolve_relative_url},
>>   };
>>
>>   int cmd_submodule__helper(int argc, const char **argv, const char
>> *prefix)
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 9bc5c5f..6a7a3e4 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -46,79 +46,6 @@ prefix=
>>   custom_name=
>>   depth=
>>
>> -# The function takes at most 2 arguments. The first argument is the
>> -# URL that navigates to the submodule origin repo. When relative, this
>> URL
>> -# is relative to the superproject origin URL repo. The second up_path
>> -# argument, if specified, is the relative path that navigates
>> -# from the submodule working tree to the superproject working tree.
>> -#
>> -# The output of the function is the origin URL of the submodule.
>> -#
>> -# The output will either be an absolute URL or filesystem path (if the
>> -# superproject origin URL is an absolute URL or filesystem path,
>> -# respectively) or a relative file system path (if the superproject
>> -# origin URL is a relative file system path).
>> -#
>> -# When the output is a relative file system path, the path is either
>> -# relative to the submodule working tree, if up_path is specified, or to
>> -# the superproject working tree otherwise.
>> -resolve_relative_url ()
>> -{
>> -       remote=$(get_default_remote)
>> -       remoteurl=$(git config "remote.$remote.url") ||
>> -               remoteurl=$(pwd) # the repository is its own authoritative
>> upstream
>> -       url="$1"
>> -       remoteurl=${remoteurl%/}
>> -       sep=/
>> -       up_path="$2"
>> -
>> -       case "$remoteurl" in
>> -       *:*|/*)
>> -               is_relative=
>> -               ;;
>> -       ./*|../*)
>> -               is_relative=t
>> -               ;;
>> -       *)
>> -               is_relative=t
>> -               remoteurl="./$remoteurl"
>> -               ;;
>> -       esac
>> -
>> -       while test -n "$url"
>> -       do
>> -               case "$url" in
>> -               ../*)
>> -                       url="${url#../}"
>> -                       case "$remoteurl" in
>> -                       */*)
>> -                               remoteurl="${remoteurl%/*}"
>> -                               ;;
>> -                       *:*)
>> -                               remoteurl="${remoteurl%:*}"
>> -                               sep=:
>> -                               ;;
>> -                       *)
>> -                               if test -z "$is_relative" || test "." =
>> "$remoteurl"
>> -                               then
>> -                                       die "$(eval_gettext "cannot strip
>> one component off url '\$remoteurl'")"
>> -                               else
>> -                                       remoteurl=.
>> -                               fi
>> -                               ;;
>> -                       esac
>> -                       ;;
>> -               ./*)
>> -                       url="${url#./}"
>> -                       ;;
>> -               *)
>> -                       break;;
>> -               esac
>> -       done
>> -       remoteurl="$remoteurl$sep${url%/}"
>> -       echo "${is_relative:+${up_path}}${remoteurl#./}"
>> -}
>> -
>>   # Resolve a path to be relative to another path.  This is intended for
>>   # converting submodule paths when git-submodule is run in a subdirectory
>>   # and only handles paths where the directory separator is '/'.
>> @@ -281,7 +208,7 @@ cmd_add()
>>                 die "$(gettext "Relative path can only be used from the
>> toplevel of the working tree")"
>>
>>                 # dereference source url relative to parent's url
>> -               realrepo=$(resolve_relative_url "$repo") || exit
>> +               realrepo=$(git submodule--helper resolve_relative_url
>> "$repo") || exit
>>                 ;;
>>         *:*|/*)
>>                 # absolute url
>> @@ -485,7 +412,7 @@ cmd_init()
>>                         # Possibly a url relative to parent
>>                         case "$url" in
>>                         ./*|../*)
>> -                               url=$(resolve_relative_url "$url") || exit
>> +                               url=$(git submodule--helper
>> resolve_relative_url "$url") || exit
>>                                 ;;
>>                         esac
>>                         git config submodule."$name".url "$url" ||
>> @@ -1190,9 +1117,9 @@ cmd_sync()
>>                         # guarantee a trailing /
>>                         up_path=${up_path%/}/ &&
>>                         # path from submodule work tree to submodule
>> origin repo
>> -                       sub_origin_url=$(resolve_relative_url "$url"
>> "$up_path") &&
>> +                       sub_origin_url=$(git submodule--helper
>> resolve_relative_url "$url" "$up_path") &&
>>                         # path from superproject work tree to submodule
>> origin repo
>> -                       super_config_url=$(resolve_relative_url "$url") ||
>> exit
>> +                       super_config_url=$(git submodule--helper
>> resolve_relative_url "$url") || exit
>>                         ;;
>>                 *)
>>                         sub_origin_url="$url"
>>
>
