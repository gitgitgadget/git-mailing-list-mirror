From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 26/48] merge-recursive: Allow make_room_for_path() to
 remove D/F entries
Date: Mon, 8 Aug 2011 14:56:19 -0600
Message-ID: <CABPp-BEBJnMCwKKL67=LkB8pea+7QkpoXih3P7rfF5AiDRQYZQ@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-27-git-send-email-newren@gmail.com>
	<4E1D46A5.6050904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 08 22:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqWs5-0004RK-OV
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 22:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab1HHU4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 16:56:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61199 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab1HHU4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 16:56:20 -0400
Received: by fxh19 with SMTP id 19so5746692fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jmZw0gSYKXPB1ofNOfxHUxHbL5xRYwvj6hVcgGumutk=;
        b=BpuqXfvmnMjztxl+nD+/9NOykjX1aAmi6PWBwrnDvP6pcq29b73oSjfGc1DEjgG/yH
         3b/SH1+xgsK1PKpakZIUeLGv1fZuzdI2NZtCI9sjGMIiFL3Qa5Ir0l4OGO/uXtkiaCAv
         ioaoHODB8BIwPs3fGNnhIjTks09MximyC/p+g=
Received: by 10.223.58.73 with SMTP id f9mr8115204fah.149.1312836979319; Mon,
 08 Aug 2011 13:56:19 -0700 (PDT)
Received: by 10.223.123.13 with HTTP; Mon, 8 Aug 2011 13:56:19 -0700 (PDT)
In-Reply-To: <4E1D46A5.6050904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178982>

Hi,

On Wed, Jul 13, 2011 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 6/8/2011 9:30, schrieb Elijah Newren:
>> +static int make_room_for_path(const struct merge_options *o, const =
char *path)
>> =C2=A0{
>> - =C2=A0 =C2=A0 int status;
>> + =C2=A0 =C2=A0 int status, i;
>> =C2=A0 =C2=A0 =C2=A0 const char *msg =3D "failed to create path '%s'=
%s";
>>
>> + =C2=A0 =C2=A0 /* Unlink any D/F conflict files that are in the way=
 */
>> + =C2=A0 =C2=A0 for (i =3D 0; i < o->df_conflict_file_set.nr; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *df_path =3D =
o->df_conflict_file_set.items[i].string;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t pathlen =3D strle=
n(path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t df_pathlen =3D st=
rlen(df_path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (df_pathlen < pathlen=
 && strncmp(path, df_path, df_pathlen) =3D=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unlink(df_path);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>
> Each time this loop is entered it tries to remove the same path again=
,
> even if it does not exist anymore or was morphed into a directory in =
the
> meantime. I suggest to remove a path from o->df_conflict_file_set aft=
er it
> was unlinked. Or even better: have a separate "make room" phase somew=
here
> in the merge process.

Removing it from o->df_conflict_file_set makes sense.  However, there
appears to be no API in string_list.h for deleting entries.  Are such
operations discouraged?  I'm not sure whether to add such API, just
hack it directly, or wait for someone else to come along and change
this to a better data structure (such as a hash)...

I don't think it's possible to move this "make room" phase anywhere
earlier in the merge process.  When we have D/F conflicts, the files
of those D/F conflicts should only be removed if at least one of the
paths under the corresponding directory are not removed by the merge
process.  We don't know whether those paths will need to be removed
until we call process_entry() on each of them, and from there we go
right to this function when we find one that needs to stick around.
So I simply don't see how to move it any earlier.


However, there is clearly a bug in this code.  If there is a D/F
conflict at 'd' (e.g. paths 'd' and 'd/foo' are present), and there is
a file named 'd_bla', then the need to merge 'd_bla' can cause 'd' to
be deleted.  Oops.  (Granted, it's a bug that would be masked by the
later call to process_entry() on 'd', which would reinstate that file
if necessary, but that doesn't mean this code is right.)  I'll fix
that up.

However, I don't see how any of this would address any failure you're
seeing on windows.  Maybe one of my other changes, including one or
two other bugfixes I've found will help?  I'll have to ping you when I
submit the re-roll.
