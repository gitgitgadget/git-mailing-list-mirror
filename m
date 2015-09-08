From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv5 3/3] submodule: Reimplement `module_clone` shell
 function in C
Date: Tue, 8 Sep 2015 11:31:17 -0700
Message-ID: <CAGZ79kYAsNZ1huLrYOvyPtYHKoN4paBGXbY3OMX3SQNMwqCiKA@mail.gmail.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
	<1441230146-26921-4-git-send-email-sbeller@google.com>
	<xmqq8u8ni2bv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:31:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNfx-0002xD-Kw
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbbIHSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:31:22 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33925 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbbIHSbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:31:18 -0400
Received: by ykdg206 with SMTP id g206so132161018ykd.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yiA0eTpohYXaEmo7gceGzAMrQESSoDZlGg2g3UTmxKw=;
        b=UrVA77DsoMrUL9F4prXagx3On5jC2nXmY6hDwJB9otjqZdBTgZM49h+llA4JKtM/6E
         1a2H5i47paFE0LHy+ZajW0w0Jit0dOcvmaFORuu/U1cckMPykZecSmgJfu1o++mJlJ+b
         AsL/M9o3Om9bLlUJZdOs4rmlm8+pnacylfzfFfJX0OT4cZ9GQJTp+yvFqAB9dtoKxj6y
         oKOwYNwubcQe/TohzR2fVhycYi6hsMPeV5tiTUgN26wqsb576S6stL5bYpTMY1x1dcuk
         Nnylyp7sNfw9jroSXc+7/IDyM3AinNusd5zSUhmlh7/13sZ1zBLWh5zn0MW245QKFbFb
         N4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yiA0eTpohYXaEmo7gceGzAMrQESSoDZlGg2g3UTmxKw=;
        b=m+BOHzg2TCzf/4VQL5WM2m3z3Nd9YxN6iXTWUreaFMXXrSHZDOQnPht19vM7rkyi1m
         M0XzpUqFOaxrK437QBXClx8t+4lRtF+LJKEBrSRhUPgnUUPB93876saQrcVph+bRpxjM
         F7fBiv08rHZuDewKTtww7dzjMGkWrZhuKNhcdddNDYAVq6g1xdv09Tp88+1E8fUYiQJd
         R4Mh8x1Ie/yjGnQLm/sf+SA3bookEa3aJTIo07iBKmzPGNnOgjLdu184Cp7gKxI8Cs1o
         TTnUjz62KSw6308kjmF3dEJ1fxsUIjdjjrO/R4FM5VfVCt1pw8XKRfrPcCe7w+cQLWW9
         FsBQ==
X-Gm-Message-State: ALoCoQlAVA/zzoMD9Ef1CDCrzSbiRzx9nsD5JfDXlKDXjmQGurdgpwy2Wk3Pa2A+jmBe8Rn9Zovs
X-Received: by 10.13.218.131 with SMTP id c125mr31499007ywe.129.1441737077419;
 Tue, 08 Sep 2015 11:31:17 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 8 Sep 2015 11:31:17 -0700 (PDT)
In-Reply-To: <xmqq8u8ni2bv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277516>

On Thu, Sep 3, 2015 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +
>> +     cp.no_stdin = 1;
>> +     cp.no_stdout = 1;
>> +     cp.no_stderr = 1;
>
> Output from "git clone" is not shown, regardless of --quiet option?

Removed that.

>> +     argc = parse_options(argc, argv, prefix, module_clone_options,
>> +                          git_submodule_helper_usage, 0);
>> +
>> +     strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
>
> The original says
>
>         base_name=$(dirname "$name")
>
> before doing this %s/modules/%s concatenation.  I do not think we
> intended to allow a slash in submodule name, so this difference may
> be showing that the original was doing an unnecessary thing.

The way I understood the code, this was a workaround of now having
safe_create_leading_directories, which takes the base directory of
a given path and creates that directory. (base_name is only used as an
argument for mkdir -p).

Slashes are already in use for submodule names as the name defaults
to the path if no explicit name is given. And the path may contain slashes
as it may be nested. In Gerrit we have a .gitmodules:
[submodule "plugins/commit-message-length-validator"]
    path = plugins/commit-message-length-validator
    url = ../plugins/commit-message-length-validator
[...

>
>> +     sm_gitdir = strbuf_detach(&sb, NULL);
>> +
>> +     if (!file_exists(sm_gitdir)) {
>> +             if (safe_create_leading_directories_const(sm_gitdir) < 0)
>> +                     die(_("could not create directory '%s'"), sm_gitdir);
>> +             if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
>> +                     die(_("clone of '%s' into submodule path '%s' failed"),
>> +                         url, path);
>> +     } else {
>> +             if (safe_create_leading_directories_const(path) < 0)
>> +                     die(_("could not create directory '%s'"), path);
>> +             strbuf_addf(&sb, "%s/index", sm_gitdir);
>> +             if (unlink(sb.buf) < 0)
>> +                     die_errno(_("failed to delete '%s'"), sm_gitdir);
>
> The original says "we do not care if it failed" with
>
>         rm -f "$gitdir/index"
>
> I think the intention of the original is "we do not care if it
> failed because it did not exist." in which case unconditional
> die_errno() here may be something we do not want?

Right, this was a short-circuit reaction from me on Erics comment
to check for the return value of unlink. I think we can use
unlink_or_warn here as that only warns if we cannot remove
an existing file. non existent files are not warned about.

>
>> +             strbuf_reset(&sb);
>> +     }
>> +
>> +     /* Write a .git file in the submodule to redirect to the superproject. */
>> +     if (safe_create_leading_directories_const(path) < 0)
>> +             die(_("could not create directory '%s'"), path);
>> +
>> +     if (path && *path)
>> +             strbuf_addf(&sb, "%s/.git", path);
>> +     else
>> +             strbuf_addf(&sb, ".git");
>> +
>> +     if (safe_create_leading_directories_const(sb.buf) < 0)
>> +             die(_("could not create leading directories of '%s'"), sb.buf);
>> +     submodule_dot_git = fopen(sb.buf, "w");
>> +     if (!submodule_dot_git)
>> +             die_errno(_("cannot open file '%s'"), sb.buf);
>> +
>> +     fprintf(submodule_dot_git, "gitdir: %s\n",
>> +             relative_path(sm_gitdir, path, &rel_path));
>> +     if (fclose(submodule_dot_git))
>> +             die(_("could not close file %s"), sb.buf);
>> +     strbuf_reset(&sb);
>> +     strbuf_reset(&rel_path);
>
> The original seems to go quite a length to make sure symbolic links
> do not fool the comparison between $gitdir and $sm_path, and also it
> makes sure one is not a subpath of the other.  Do we need the same
> level of carefulness, or is textual relative_path() enough?

I think the original was doing an "optimized" version of relative_path()
as we know that they have an anchor at the superproject root directory.

relative_path() seems to deal with the symbolic links just fine, as all
tests pass. (6eafa6d096ce, "submodules: don't stumble over symbolic
links when cloning recursively" did add code as well as testing for symbolic
link problems, Thanks Jens!)

>>               --depth=*)
>> -                     depth=$1
>> +                     depth="$1"
>
> This seems to be an unrelated change.

A leftover from earlier, when I mucked around with --depth and
--reference in the shell scipt.


On Thu, Sep 3, 2015 at 4:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +       if (path && *path)
>> +               strbuf_addf(&sb, "%s/.git", path);
>> +       else
>> +               strbuf_addf(&sb, ".git");
>
> Minor: strbuf_addstr(...);

done
