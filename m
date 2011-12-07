From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 2/2] run-command: Add interpreter permissions check
Date: Wed, 7 Dec 2011 09:37:48 +0100
Message-ID: <CAH6sp9MqwKppcrtP7YM8FZAs=odmUicTvsxiYyH0ENmJrPxqEA@mail.gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
	<1323207503-26581-1-git-send-email-fransklaver@gmail.com>
	<1323207503-26581-3-git-send-email-fransklaver@gmail.com>
	<7vk469e2rn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYD0k-0008Uw-PA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab1LGIhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 03:37:50 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38742 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab1LGIht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 03:37:49 -0500
Received: by qcqz2 with SMTP id z2so151080qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2/4k1ODUj/zUKel+I6LA8usZUj4S7kmllwsLnbTLeK4=;
        b=RsvxyKn6D5gi60h4ge0MlMPCv308bvPF89BrrpsBG9cnq+QPWIAXSAHnKqYprclZt5
         Zg3j8pjJ61kR/D+ZieNxqRSJ/6vFX+mP1GAARokUK5PkiVoOd4KH6OzFwj4ad2fPqUgU
         G7srdiWb3V1S9FLY+pe5d7Uc/UP1d6TUcRQac=
Received: by 10.229.61.65 with SMTP id s1mr3790930qch.253.1323247068709; Wed,
 07 Dec 2011 00:37:48 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Wed, 7 Dec 2011 00:37:48 -0800 (PST)
In-Reply-To: <7vk469e2rn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186448>

On Tue, Dec 6, 2011 at 11:47 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Frans Klaver <fransklaver@gmail.com> writes:
>
>> If a script is started and the interpreter of that script given in t=
he
>> shebang cannot be started due to permissions, we can get a rather
>> obscure situation. All permission checks pass for the script itself,
>> but we still get EACCES from execvp.
>>
>> Try to find out if the above is the case and warn the user about it.
>>
>> Signed-off-by: Frans Klaver <fransklaver@gmail.com>
>> ---
>> =C2=A0run-command.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 66 ++=
+++++++++++++++++++++++++++++++++++++++++----
>> =C2=A0t/t0061-run-command.sh | =C2=A0 22 ++++++++++++++++
>> =C2=A02 files changed, 82 insertions(+), 6 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 5e38c5a..b8cf8d4 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -194,6 +194,63 @@ static int have_read_execute_permissions(const =
char *path)
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> +static void check_interpreter(const char *cmd)
>> +{
>> + =C2=A0 =C2=A0 FILE *f;
>> + =C2=A0 =C2=A0 struct strbuf sb =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 /* bash reads an 80 character line when determining =
the interpreter.
>> + =C2=A0 =C2=A0 =C2=A0* BSD apparently only allows 32 characters, as=
 it is the size of
>> + =C2=A0 =C2=A0 =C2=A0* your average binary executable header.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 char firstline[80];
>> + =C2=A0 =C2=A0 char *interpreter =3D NULL;
>> + =C2=A0 =C2=A0 size_t s, i;
>> +
>> + =C2=A0 =C2=A0 f =3D fopen(cmd, "r");
>> + =C2=A0 =C2=A0 if (!f) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("cannot open file =
'%s': %s\n", cmd, strerror(errno));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 s =3D fread(firstline, 1, sizeof(firstline), f);
>> + =C2=A0 =C2=A0 if (s < 2) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_printf("cannot det=
ermine file type");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(f);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (firstline[0] !=3D '#' || firstline[1] !=3D '!') =
{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_printf("file '%s' =
is not a script or"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " is a script without '#!'", cmd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(f);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>
> Nice touches to silently pass scripts that do not begin with she-bang=
=2E
>
>> +
>> + =C2=A0 =C2=A0 /* see if the given path has the executable bit set =
*/
>> + =C2=A0 =C2=A0 for (i =3D 2; i < s; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!interpreter && firs=
tline[i] !=3D ' ' && firstline[i] !=3D '\t')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 interpreter =3D firstline + i;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (interpreter && (firs=
tline[i] =3D=3D ' ' ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firstline[i] =3D=3D '\n')) {
>
> Curious.
>
> "#!<TAB>/bin/bash<TAB><LF>" would cause you to check "/bin/bash<TAB>"=
?

Apparently so. Thanks for catching.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_add(&sb, interpreter,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (firstline =
+ i) - interpreter);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> Wouldn't strcspn() work better instead of this loop?

Probably. Will revise.


>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (!sb.len) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("could not determi=
ne interpreter");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&sb);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (!have_read_execute_permissions(sb.buf))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("bad interpreter: =
no read/execute permissions on '%s'\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sb.buf);
>> +
>> + =C2=A0 =C2=A0 strbuf_release(&sb);
>> +}
>> +
>> =C2=A0static void diagnose_execvp_eacces(const char *cmd, const char=
 **argv)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 /* man 2 execve states that EACCES is returned =
for:
>> @@ -209,8 +266,8 @@ static void diagnose_execvp_eacces(const char *c=
md, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 char *next;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (strchr(cmd, '/')) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!have_read_execute_p=
ermissions(cmd))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 error("no read/execute permissions on '%s'\n", cmd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (have_read_execute_pe=
rmissions(cmd))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 check_interpreter(cmd);
>
> I would have expected the overall logic to be more like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if we cannot read and execute it then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0that in itself=
 is an error (i.e. the error message from [1/2])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if we can read it then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let's see if t=
here is an error in the interpreter.
>
> It is unnatural to see "if we can read and execute, then see if there=
 is
> anything wrong with the interpreter" and _nothing else_ here. If you =
made
> the "have_read_execute_permissions()" to issue the error message you =
used
> to give in your [1/2] patch here, that is OK from the point of view o=
f the
> overall code structure, but then the function is no longer "do we hav=
e
> permissions" boolean check and needs to be renamed. And if you didn't=
,
> then I have to wonder why we do not need the error message you added =
in
> your [1/2].

Hm, yea makes sense. I'll rethink this a bit.

Again, thanks for the review.
