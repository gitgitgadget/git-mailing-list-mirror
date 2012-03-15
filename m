From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE;
 it may be the user's cwd
Date: Thu, 15 Mar 2012 08:39:30 +0100
Message-ID: <CALKQrgfpM-y=9O=h33jxirVoOO8dHHO8tWCR9RatxTottpRXFA@mail.gmail.com>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
	<1331769333-13890-1-git-send-email-johan@herland.net>
	<7vipi6l52w.fsf@alter.siamese.dyndns.org>
	<7v7gyml4g7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 08:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85Ho-0003aj-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 08:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab2COHjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 03:39:37 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:52851 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab2COHjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 03:39:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1S85Ha-0002m5-Hy
	for git@vger.kernel.org; Thu, 15 Mar 2012 08:39:34 +0100
Received: by iagz16 with SMTP id z16so3531616iag.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 00:39:30 -0700 (PDT)
Received: by 10.50.185.201 with SMTP id fe9mr8302996igc.47.1331797170909; Thu,
 15 Mar 2012 00:39:30 -0700 (PDT)
Received: by 10.43.52.6 with HTTP; Thu, 15 Mar 2012 00:39:30 -0700 (PDT)
In-Reply-To: <7v7gyml4g7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193192>

On Thu, Mar 15, 2012 at 08:16, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>> Johan Herland <johan@herland.net> writes:
>>> I'm torn about the new remove_everything_inside_dir(). Obviously it=
's a
>>> copy-paste-modify of dir.c:remove_dir_recursively(), and could inst=
ead be
>>> implemented by adding an extra flag to remove_dir_recursively(). Ho=
wever,
>>> adding a "#define REMOVE_DIR_CONTENTS_BUT_NOT_DIR_ITSELF 04" seemed=
 even
>>> uglier to me...
>>
>> Hmm, what ugliness am I missing when viewing the attached patch? =C2=
=A0It looks
>> simple and straightforward enough, at least to me.

Agreed, you found a much more palatable name than I did. The patch
below looks good to me, and should become patch #3 in this series,
with my "3/2" patch being adjusted accordingly and becoming patch #4.
Do you want me to send the whole series again, or is it easier for you
to simply fix it up yourself?

>> =C2=A0dir.c | =C2=A0 14 ++++++++++----
>> =C2=A0dir.h | =C2=A0 =C2=A01 +
>> =C2=A02 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 0a78d00..6432728 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1178,6 +1178,7 @@ int remove_dir_recursively(struct strbuf *path=
, int flag)
>> =C2=A0 =C2=A0 =C2=A0 struct dirent *e;
>> =C2=A0 =C2=A0 =C2=A0 int ret =3D 0, original_len =3D path->len, len;
>> =C2=A0 =C2=A0 =C2=A0 int only_empty =3D (flag & REMOVE_DIR_EMPTY_ONL=
Y);
>> + =C2=A0 =C2=A0 int keep_toplevel =3D (flag & REMOVE_DIR_KEEP_TOPLEV=
EL);
>> =C2=A0 =C2=A0 =C2=A0 unsigned char submodule_head[20];
>>
>> =C2=A0 =C2=A0 =C2=A0 if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
>> @@ -1185,9 +1186,14 @@ int remove_dir_recursively(struct strbuf *pat=
h, int flag)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Do not descend a=
nd nuke a nested git work tree. */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> + =C2=A0 =C2=A0 flag &=3D ~REMOVE_DIR_KEEP_TOPLEVEL;
>
> Nit. This needs to drop REMOVE_DIR_KEEP_NESTED_GIT as well in order t=
o
> preserve the current behaviour.
>
> I actually suspect that the passing of "only_empty" in the original m=
ay be
> a bug in a0f4afb (clean: require double -f options to nuke nested git
> repository and work tree, 2009-06-30), and this patch might be a fix =
to
> the bug, but I didn't think things through, and it is getting late, s=
o...

I noticed the same while looking at this function, and I think your
analysis is correct. As it stands, REMOVE_DIR_KEEP_NESTED_GIT only
applies to .git folders located directly in the toplevel dir, and not
inside a subdirectory. That strikes me as odd given the name of the
flag.


Have fun! :)

=2E..Johan

>> =C2=A0 =C2=A0 =C2=A0 dir =3D opendir(path->buf);
>> - =C2=A0 =C2=A0 if (!dir)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rmdir(path->buf);
>> + =C2=A0 =C2=A0 if (!dir) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!keep_toplevel)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return rmdir(path->buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>> + =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 if (path->buf[original_len - 1] !=3D '/')
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addch(path, =
'/');
>>
>> @@ -1202,7 +1208,7 @@ int remove_dir_recursively(struct strbuf *path=
, int flag)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lstat(path->buf=
, &st))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ; /* fall thru */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (S_ISDIR(st=
=2Est_mode)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!remove_dir_recursively(path, only_empty))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!remove_dir_recursively(path, flag))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue; /* happy */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!only_em=
pty && !unlink(path->buf))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue; /* happy, too */



--=20
Johan Herland, <johan@herland.net>
www.herland.net
