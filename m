From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with EACCES
Date: Wed, 7 Dec 2011 09:31:24 +0100
Message-ID: <CAH6sp9NsRDWoMtnBUXOP-OMFwjjUm-OuRLpNvcS4pC1S=C93EQ@mail.gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
	<1323207503-26581-1-git-send-email-fransklaver@gmail.com>
	<1323207503-26581-2-git-send-email-fransklaver@gmail.com>
	<7vpqg1e3au.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:31:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCub-0006MK-FF
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab1LGIb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 03:31:26 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:62203 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1LGIbZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 03:31:25 -0500
Received: by qadb15 with SMTP id b15so245495qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=O3nRW4r9u0ROZvYs9p0IQ5nArXlua7x5L/9MCSwkSgs=;
        b=RSngaAhq3vTeQhsQ+mQeklqlAIeHRX4wwc0sIIICg76DtvhECTW6kkyz7lMNDWfG/w
         Ql19p9WrJmyxOwV/gBFNhs7Ww3ArwcwRovvXH7nZ/ugCKSOfAuM+5vxCLxXkCZ38UPZ8
         hWFjPC6QW5BU72BHgceQ9p9WNPnmETrHbwMX4=
Received: by 10.224.217.66 with SMTP id hl2mr15455876qab.84.1323246684728;
 Wed, 07 Dec 2011 00:31:24 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Wed, 7 Dec 2011 00:31:24 -0800 (PST)
In-Reply-To: <7vpqg1e3au.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186447>

Thanks for the review. There's a lot of things you mention that I
either didn't see (staring blind, you know) or that I didn't know of.

On Tue, Dec 6, 2011 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Frans Klaver <fransklaver@gmail.com> writes:
>
>> +#ifndef WIN32
>> +static int is_in_group(gid_t gid)
>> ...
>> +static int have_read_execute_permissions(const char *path)
>> +{
>> + =C2=A0 =C2=A0 struct stat s;
>> + =C2=A0 =C2=A0 trace_printf("checking '%s'\n", path);
>> +
>> + =C2=A0 =C2=A0 if (stat(path, &s) < 0) {
>> + ...
>> + =C2=A0 =C2=A0 /* check world permissions */
>> + =C2=A0 =C2=A0 if ((s.st_mode&(S_IXOTH|S_IROTH)) =3D=3D (S_IXOTH|S_=
IROTH))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>
> Hmm, do you need to do this with stat(2)?
>
> Wouldn't access(2) with R_OK|X_OK give you exactly what you want with=
out
> this much trouble?

Probably. I'll use access instead in a reroll.


> I also think that your permission check is incorrectly implemented.
>
> =C2=A0 =C2=A0$ cd /var/tmp && date >j && chmod 044 j && ls -l j
> =C2=A0 =C2=A0----r--r-- 1 junio junio 29 Dec =C2=A06 14:32 j
> =C2=A0 =C2=A0$ cat j
> =C2=A0 =C2=A0cat: j: Permission denied
> =C2=A0 =C2=A0$ su pogo
> =C2=A0 =C2=A0Password:
> =C2=A0 =C2=A0$ cat j
> =C2=A0 =C2=A0Tue Dec =C2=A06 14:32:23 PST 2011
>
> That's a world-readable but unreadable-only-to-me file.

Hmm, this is a case that didn't fit my expectations. Thanks for catchin=
g.



>> +static void diagnose_execvp_eacces(const char *cmd, const char **ar=
gv)
>> +{
>> + =C2=A0 =C2=A0 /* man 2 execve states that EACCES is returned for:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Just a style, but we tend to write mult=
i-line comment like
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * this, without anything else on opening =
and closing lines of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the comment block.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
>> + =C2=A0 =C2=A0 =C2=A0* - The file system is mounted noexec
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 struct strbuf sb =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 char *path =3D getenv("PATH");
>> + =C2=A0 =C2=A0 char *next;
>> +
>> + =C2=A0 =C2=A0 if (strchr(cmd, '/')) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!have_read_execute_p=
ermissions(cmd))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 error("no read/execute permissions on '%s'\n", cmd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>
> Ok, execvp() failed and "cmd" has at least one slash, so we know we d=
id
> not look for it in $PATH. =C2=A0We check only one and return (did you=
 need
> getenv() in that case?).

Obviously not. Missed that.

>
>> + =C2=A0 =C2=A0 for (;;) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next =3D strchrnul(path,=
 ':');
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (path < next)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_add(&sb, path, next - path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_addch(&sb, '.');
>
> Nice touch that you did not forget an empty component on $PATH.

Yes, that's a relic from me starting work based on one of your
proposed patches[1]. So that one goes to you.

[1] http://article.gmane.org/gmane.comp.version-control.git/171838


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!have_read_execute_p=
ermissions(sb.buf))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 error("no read/execute permissions on '%s'\n", sb.buf);
>
> Don't you want to continue here upon error, after resetting sb? You j=
ust
> saw the directory is unreadble, so you know next file_exists() will f=
ail
> before you try it.

Yes. I thought about that. I didn't do that because of the fact that I
had to do more than just resetting sb. The path variable has to be
updated as well. I had the choice of adding a level of indentation {},
duplicating the code, or just do a check I know before will fail.
There's probably something to say for each one of them. I'll probably
refactor that a bit more.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sb.len && sb.buf[sb.=
len - 1] !=3D '/')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_addch(&sb, '/');
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&sb, cmd);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (file_exists(sb.buf))=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!have_read_execute_permissions(sb.buf))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("no read/execute permissions on '=
%s'\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sb.buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn("file '%s' exists and permissions =
"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "seem OK.\nIf this is a script, see if =
you "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "have sufficient privileges to run the =
"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "interpreter", sb.buf);
>
> Does "warn()" do the right thing for multi-line strings like this?

I don't know/remember. It seemed like a natural thing to do, but I'll f=
ind out.
