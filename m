From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] revert: report fine-grained error messages from insn parser
Date: Mon, 9 Jan 2012 01:46:07 +0530
Message-ID: <CALkWK0mStgcb4EBB+ni9fisDJY=13cJZWCTEcgfyOUyAXbc=tA@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-6-git-send-email-artagnon@gmail.com> <20120108200748.GJ1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzAW-0004mw-V6
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab2AHUQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:16:30 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55776 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2AHUQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:16:29 -0500
Received: by wibhm6 with SMTP id hm6so2135970wib.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KzkPuTSJFOWua8Db7B/JOmmz7GQgifrjBmiejM8GGGg=;
        b=kUl7F6GGtel05ZB7cYDIH29R/1cvmxBIyS57EsKHnlC4l4PVxjO+RZo3EXSnzL+dKU
         UE+krsQSD23R/9QM8856AYl0I5iNe45SlKCdk+ZRbrn2H96xsYruV3ccZU1cJnGsKqPq
         CCBrrBOiV2cm75Iy0eix0A16tZCSxe1+4AiYI=
Received: by 10.180.77.200 with SMTP id u8mr427571wiw.18.1326053788193; Sun,
 08 Jan 2012 12:16:28 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 12:16:07 -0800 (PST)
In-Reply-To: <20120108200748.GJ1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188126>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Three kinds of errors can arise from parsing '.git/sequencer/todo':
>> 1. Unrecognized action
>> 2. Malformed object name
>> 3. Object name does not refer to a valid commit
>>
>> Since we would like to make the instruction sheet user-editable in t=
he
>> future (much like the 'rebase -i' sheet), report more fine-grained
>> parse errors prefixed with the filename and line number.
>
> Seems like a sensible idea. =C2=A0In other words,
> [...]

Thanks for the new wording.

> [...]
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -714,26 +714,29 @@ static int format_todo(struct strbuf *buf, str=
uct replay_insn_list *todo_list)
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> -static int parse_insn_line(char *bol, char *eol, struct replay_insn=
_list *item)
>> +static int parse_insn_line(char *bol, char *eol,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct replay_insn_list *item, int lineno)
>> =C2=A0{
>> + =C2=A0 =C2=A0 const char *todo_file =3D git_path(SEQ_TODO_FILE);
>
> This idiom is _still_ scary. =C2=A0I don't want to have to shout abou=
t
> this, but why didn't the commit message at least acknowledge it to pu=
t
> the reader's mind at ease when this has come up again and again?

Carried over from the previous re-roll; sorry I didn't pay enough atten=
tion.

> [...]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bol +=3D strlen("revert =
");
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_len =3D eol - bol =
> 255 ? 255 : eol - bol;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("%s:%d: U=
nrecognized action: %.*s"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 todo_file, lineno, (int)error_len, bol);
>
> Ah, so my example above was wrong: the actual message is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: .git/sequencer/todo:5: Unrecognized=
 action: the quick bro
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wn fox jumps over the lazy dog
>
> I guess that's fine. =C2=A0Is it intended?
>
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Eat up extra spaces/ tabs before object name=
 */
>> - =C2=A0 =C2=A0 padding =3D strspn(bol, " \t");
>> - =C2=A0 =C2=A0 if (!padding)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> - =C2=A0 =C2=A0 bol +=3D padding;
>> + =C2=A0 =C2=A0 bol +=3D strspn(bol, " \t");
>
> What does this have to do with the stated goal of the patch? =C2=A0It=
 seems
> to me that an unrelated and unadvertised bugfix snuck in.

Not a bugfix: since I have to report sensible error messages now, I
changed the "pick" and "revert" checks to "pick " || "pick\t" and
"revert " || "revert\t" -- then, I can report "invalid action" if it
doesn't match instead of a useless "missing space after action".

> [...]
> By the way, this is gross. =C2=A0Probably get_sha1 should grow a vari=
ant
> that takes a buffer and a length.

Yes; will do.

> [...]
>> =C2=A0 =C2=A0 =C2=A0 item->operand =3D lookup_commit_reference(commi=
t_sha1);
>> - =C2=A0 =C2=A0 if (!item->operand)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> + =C2=A0 =C2=A0 if (!item->operand) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_len =3D eol - bol =
> 255 ? 255 : eol - bol;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("%s:%d: N=
ot a valid commit: %.*s"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 todo_file, lineno, (int)error_len, bol);
>> + =C2=A0 =C2=A0 }
>
> Hmm, this one can be emitted even when there was no corruption or
> internal error, because the user removed a commit she was
> cherry-picking and the gc-ed before a "git cherry-pick --continue".
> Alternatively, it can happen because the repository has grown very
> crowded and what used to be an unambiguous commit name no longer is
> one (not enough digits). =C2=A0Will the error message be intuitive in=
 these
> situations?

Something like "Unable to look up commit: %s" perhaps?

> [...]
>> @@ -761,8 +770,8 @@ static int parse_insn_buffer(char *buf, struct r=
eplay_insn_list **todo_list)
>>
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 1; *p; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *eol =3D strch=
rnul(p, '\n');
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parse_insn_line(p, e=
ol, &item) < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return error(_("Could not parse line %d."), i);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parse_insn_line(p, e=
ol, &item, i) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>
> Not related to this patch, but why the "< 0" test? =C2=A0It makes thi=
s
> reader worry that there is some unusual return value convention that
> he should be taking into account.

Right.  Will fix.

Thanks.

-- Ram
