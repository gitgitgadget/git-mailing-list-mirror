From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Sat, 8 Oct 2011 14:11:16 -0400
Message-ID: <CAG+J_Dzrk5x0+JRC8EbrAxjZE+hD+-5mp+H=F=M8Su2WosPfmg@mail.gmail.com>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
	<1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
	<7vfwj4tplw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:11:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCbMo-0008SA-TR
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1JHSLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 14:11:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50804 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1JHSLR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2011 14:11:17 -0400
Received: by gyg10 with SMTP id 10so4426993gyg.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oOPzlZjPkp/PYgh8WApafUPXnD19vXRgm9LPSA3lJ7g=;
        b=bAK9EY8ewjtJlZ4WDIO6338JcgP89GSQIadv/ol4HvjWkhYCGX0DKgvIALdERLe4DO
         4HbEPneTGX9cnB4ftm+JQ41aQ7FAPt6aMYeTg61xQbX+KSPLCnINCwMEYi6PSCRZsFwv
         2mIUGyv8QaVyQcI3+mpzRsX4eMjgHwMJ9mnQk=
Received: by 10.147.154.12 with SMTP id g12mr2478806yao.36.1318097477198; Sat,
 08 Oct 2011 11:11:17 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Sat, 8 Oct 2011 11:11:16 -0700 (PDT)
In-Reply-To: <7vfwj4tplw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183165>

On Fri, Oct 7, 2011 at 6:15 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Think and look forward.
>
> You are complaining that the "commit" does not know enough to behave =
as if
> it were a part of the merge command workflow if you split a usual mer=
ge
> into two steps "merge --no-commit; commit".

No Junio, you have my argument completely reversed.

I am complaining that git-merge implements commits internally, which
gives it unique behavior from git-{commit/cherry-pick/revert} (the
latter two of which just run external git-commit). I'm saying merge is
fundamentally broken to do it this way. And maybe that's something
that should be fixed in 2.0 -- that git-merge should just call out to
git-commit, just like cherry-pick/revert do.

In case that's not clear: I think that git-merge should eventually
behave identically to "merge --no-commit; commit".

> How would you make it better? Would you strip all the things usual "m=
erge"
> does, so that it would work identically to the split one,

Yes.

> losing some hook support and such.

Yes, I would lose the post-merge hook and such.

>, or would you rather make the split case work similar to the usual me=
rge?

No, I would not do that.

BTW, the same arguments apply to git-am, which uses git-commit-tree,
and so implements its own set of hooks.

> I'd say between "merge" and "merge --no-commit ; commit", the latter =
is
> what needs to be fixed. Viewed that way, why would you even consider
> making the new option behave similar to the _wrong_ one?

Strongly disagree. I think it would make much more sense for all
commits to flow through git-commit, which would ensure consistent
behavior. I think we've got a mishmash of hooks which evolved over
time.

>> I didn't bother with the commit status, it's more code than I wanted
>> to deal with duplicating/refactoring from commit.c.
>
> What do you mean by "commit status"? If you mean this patch is incomp=
lete,
> it would have been nicer if it were labeled with [PATCH/RFC].

No, I meant that git-commit includes status information about the
commit itself as comments in the commit message (git config
commit.status), and I didn't implement that. I don't think that makes
this patch incomplete however, that could be added by a later patch.

I'll send another iteration with your comments below addressed.

j.

>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index ee56974371..0dee53b7e4 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -46,6 +46,7 @@ static const char * const builtin_merge_usage[] =3D=
 {
>>
>> =C2=A0static int show_diffstat =3D 1, shortlog_len, squash;
>> =C2=A0static int option_commit =3D 1, allow_fast_forward =3D 1;
>> +static int option_edit =3D 0;
>
> No need to move this into .data segment when it can be in .bss
> segment. Drop the unnecessary " =3D 0" before ";".
>
>> @@ -842,30 +845,54 @@ static void add_strategies(const char *string,=
 unsigned attr)
>>
>> =C2=A0}
>>
>> -static void write_merge_msg(void)
>> +static void write_merge_msg(struct strbuf *msg)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int fd =3D open(git_path("MERGE_MSG"), O_WRONLY=
 | O_CREAT, 0666);
>> =C2=A0 =C2=A0 =C2=A0 if (fd < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could =
not open '%s' for writing"),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 git_path("MERGE_MSG"));
>> - =C2=A0 =C2=A0 if (write_in_full(fd, merge_msg.buf, merge_msg.len) =
!=3D merge_msg.len)
>> + =C2=A0 =C2=A0 if (write_in_full(fd, msg->buf, msg->len) !=3D msg->=
len)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could =
not write to '%s'"), git_path("MERGE_MSG"));
>> =C2=A0 =C2=A0 =C2=A0 close(fd);
>> =C2=A0}
>>
>> -static void read_merge_msg(void)
>> +static void read_merge_msg(struct strbuf *msg)
>> =C2=A0{
>> - =C2=A0 =C2=A0 strbuf_reset(&merge_msg);
>> - =C2=A0 =C2=A0 if (strbuf_read_file(&merge_msg, git_path("MERGE_MSG=
"), 0) < 0)
>> + =C2=A0 =C2=A0 strbuf_reset(msg);
>> + =C2=A0 =C2=A0 if (strbuf_read_file(msg, git_path("MERGE_MSG"), 0) =
< 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could =
not read from '%s'"), git_path("MERGE_MSG"));
>> =C2=A0}
>>
>> -static void run_prepare_commit_msg(void)
>> +static void write_merge_state();
>
> s/()/(void)/;
>
> Thanks.
>
>
