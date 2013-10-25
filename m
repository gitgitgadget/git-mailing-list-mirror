From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Re* Bug report: reset -p HEAD
Date: Thu, 24 Oct 2013 22:42:52 -0700
Message-ID: <CANiSa6iYLp-iNdcv_qbFTitrfFxaDBVUy9YyUAF4QKM+-35P4A@mail.gmail.com>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
	<CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
	<CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
	<CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
	<xmqqvc0mj9wi.fsf_-_@gitster.dls.corp.google.com>
	<20131025042421.GB11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Maarten de Vries <maarten@de-vri.es>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 07:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaB0-0006gR-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 07:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab3JYFmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 01:42:54 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:56671 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3JYFmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 01:42:53 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so3247220wgh.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NmtzTAoRX0Ov8GLL6DbcssI2g+R2pXg+dbKgfxIL4M4=;
        b=pUmoGzfwnJXxpvrsXouqcaOw3lEzgTPphYaRQUHhX+MIzJJtUSp0Ub+TM9WZoevdzN
         JyyZLFbKig24dbCcYadPhgClKheYJumucpt/bZ3o51J/aXCxtgpp2h2pLU/nTQAfWIVB
         dGyoZ/SHi89hmi+q7qMHCS9NUxLNcjKA+CQafBEc7rmA5AboFivhh2lhWRUFIavI4Cgz
         GAnKs3tWmqeY5TFbQo9Ued6Na5bAmAHLQjbWrujKWsnK9irZNGTco/eEw5PPBPyWhxKp
         4z8miEY1hd0eLvFNFzwPW4zfe9Sf7ZypcUP9S3dq0qO6/B7zzmsBzoWyqEDqrvd/3WBG
         0z6Q==
X-Received: by 10.180.36.242 with SMTP id t18mr898999wij.28.1382679772116;
 Thu, 24 Oct 2013 22:42:52 -0700 (PDT)
Received: by 10.180.80.67 with HTTP; Thu, 24 Oct 2013 22:42:52 -0700 (PDT)
In-Reply-To: <20131025042421.GB11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236660>

Sorry about the regression and thanks for report and fixes.

On Thu, Oct 24, 2013 at 9:24 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 24, 2013 at 08:40:13PM -0700, Junio C Hamano wrote:
>
>> Maarten de Vries <maarten@de-vri.es> writes:
>>
>> > Some more info: It used to work as intended. Using a bisect shows it
>> > has been broken by commit 166ec2e9.
>>
>> Thanks.
>>
>> A knee-jerk change without thinking what side-effect it has for you
>> to try out.
>>
>>  builtin/reset.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index f2f9d55..a3088d9 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -304,7 +304,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>       if (patch_mode) {
>>               if (reset_type != NONE)
>>                       die(_("--patch is incompatible with --{hard,mixed,soft}"));
>> -             return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
>> +             return run_add_interactive(
>> +                     (unborn || strcmp(rev, "HEAD"))
>> +                     ? sha1_to_hex(sha1)
>> +                     : "HEAD", "--patch=reset", &pathspec);
>>       }
>
> I think that's the correct fix for the regression.  You are restoring
> the original, pre-166ec2e9 behavior for just the HEAD case. I do not
> think add--interactive does any other magic between a symbolic rev and
> its sha1, except for recognizing HEAD specially. However, if you wanted
> to minimize the potential impact of 166ec2e9, you could pass the sha1
> _only_ in the unborn case, like this:

Plus, the end result is more readable, IMHO.

> diff --git a/builtin/reset.c b/builtin/reset.c
> index f2f9d55..bfdd8d3 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -283,6 +283,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>         if (unborn) {
>                 /* reset on unborn branch: treat as reset to empty tree */
>                 hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
> +               rev = EMPTY_TREE_SHA1_HEX;
>         } else if (!pathspec.nr) {
>                 struct commit *commit;
>                 if (get_sha1_committish(rev, sha1))
> @@ -304,7 +305,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>         if (patch_mode) {
>                 if (reset_type != NONE)
>                         die(_("--patch is incompatible with --{hard,mixed,soft}"));
> -               return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
> +               return run_add_interactive(rev, "--patch=reset", &pathspec);
>         }
>
>         /* git reset tree [--] paths... can be used to
>
> That fixes any possible regression from add--interactive treating the
> two cases differently. On an unborn branch, we will still say "apply
> this hunk" rather than "unstage this hunk". That's not a regression,
> because it simply didn't work before, but it's not ideal. To fix that,
> we need to somehow tell add--interactive "this is HEAD, but use the
> empty tree because it's unborn". I can think of a few simple-ish ways:
>
>   1. Pass the head/not-head flag as a separate option.
>
>   2. Pass HEAD even in the unborn case; teach add--interactive to
>      convert an unborn HEAD to the empty tree.
>
>   3. Teach add--interactive to recognize the empty tree sha1 as an
>      "unstage" path.
>
> I kind of like (3). At first glance, it is wrong; we will also treat
> "git reset -p $(git hash-object -t tree /dev/null)" as if "HEAD" had
> been passed. But if you are explicitly passing the empty tree like that,
> I think saying "unstage" makes a lot of sense.

Makes sense to me. I'm sure others can implement that much faster than
I can, but I feel a little guilty, so I'm happy to do it if no one
else wants to, as long as we agree this is the way we want to go.
