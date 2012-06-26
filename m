From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH v2] log: Handle new repository case.
Date: Mon, 25 Jun 2012 22:42:11 -0400
Message-ID: <CAA3EhHK25rLU-gQNUG0cmJ4E1g+Ce6AHcMF6jzcco5QaTJE+jA@mail.gmail.com>
References: <1340664813-96891-1-git-send-email-muhtasib@gmail.com> <7vobo7dlyl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:48:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjLoy-0007Gd-2N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 04:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab2FZCmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 22:42:33 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56289 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab2FZCmc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 22:42:32 -0400
Received: by vbbff1 with SMTP id ff1so2386092vbb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aJXJAAnaFSnwLjCmFkd5qCzW9aKSjNKyXCReJSHCabw=;
        b=dTzS7E/MZRVRfVJvH8yKRXE9M5IIjr2mIjFPgUTBIs6+3cUM7oedPYY+2/j8c+izli
         tUNWBZZDYeRjslPDktu+3Y+mqKAm19tmuR194jLHtganmSti5+WjCD5ffXQqJTgfws7A
         msQW/9ZxT2D9t3f5sukn/OepnQBD0CraxavUrjiLhGdx/s8ORUYWLch6qV1JuADmZ+e5
         ZClYGg5DFoCDOWTvS4rLHn5648Xjr5ZDHKVbPjD35fO7do4thHVOlbpUPFEA11sLhCcI
         XeHoc+fYjBs5DF7eb1Cy53R7MIU4omf8Jt/kMRutl4lDrKcAAxYapbGriz4NS25hbMIp
         Aopw==
Received: by 10.52.143.73 with SMTP id sc9mr7897884vdb.46.1340678551679; Mon,
 25 Jun 2012 19:42:31 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 25 Jun 2012 19:42:11 -0700 (PDT)
In-Reply-To: <7vobo7dlyl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200620>

On Mon, Jun 25, 2012 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Leila Muhtasib <muhtasib@gmail.com> writes:
>
>> @@ -553,8 +562,13 @@ int cmd_log(int argc, const char **argv, const =
char *prefix)
>> =A0 =A0 =A0 init_revisions(&rev, prefix);
>> =A0 =A0 =A0 rev.always_show_header =3D 1;
>> =A0 =A0 =A0 memset(&opt, 0, sizeof(opt));
>> - =A0 =A0 opt.def =3D "HEAD";
>> + =A0 =A0 opt.def =3D default_to_head_if_exists();
>> +
>> =A0 =A0 =A0 cmd_log_init(argc, argv, prefix, &rev, &opt);
>> +
>> + =A0 =A0 if (!opt.def && !rev.cmdline.nr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> =A0 =A0 =A0 return cmd_log_walk(&rev);
>
> Do you even need these four new lines if you do not error out?
> Doesn't log_walk() return successfully if there is nothing in the
> queue anyway?

Actually, yes. This was left behind because I was printing a success
message "No commit(s) to display". Thanks for catching this.

>
>> @@ -1128,7 +1142,7 @@ int cmd_format_patch(int argc, const char **ar=
gv, const char *prefix)
>> =A0 =A0 =A0 DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
>> =A0 =A0 =A0 rev.subject_prefix =3D fmt_patch_subject_prefix;
>> =A0 =A0 =A0 memset(&s_r_opt, 0, sizeof(s_r_opt));
>> - =A0 =A0 s_r_opt.def =3D "HEAD";
>> + =A0 =A0 s_r_opt.def =3D default_to_head_if_exists();
>
> I didn't think about other commands, but I do not think format-patch
> wants to silently succeed without doing anything---it is definitely
> a user error, no?
>

The other changed commands are git show, git whatchanged, git reflog.
And I think for the initial repo case, they can just silently succeed
vs display that error message.

'git format-patch' on a regular repo with commits, did nothing for me.
That's why I had originally included it. Though I think I'm changing
my mind about this because it's about generating a patch -- not just
displaying info.
