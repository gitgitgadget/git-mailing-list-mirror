From: Rafal Rusin <rafal.rusin@gmail.com>
Subject: Re: 'error: unable to set permission to './objects/...'
Date: Mon, 23 Nov 2009 10:35:39 +0100
Message-ID: <9bbf67fa0911230135j7cfe5bcem991e750b6754f344@mail.gmail.com>
References: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
	 <7vd43acf7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 10:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCVKu-0002Kz-0W
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 10:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522AbZKWJfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 04:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756514AbZKWJfk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 04:35:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58695 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113AbZKWJfe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 04:35:34 -0500
Received: by bwz27 with SMTP id 27so4787075bwz.21
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 01:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P5R7MVowyeBkro1QL3Zb6X0qyTuVWhGkrjn3LhpDb+I=;
        b=tE/brCviXtnmYUpdY60p/bP1xpYBRhlvGt1uXKhUL0noBbmnwFdFwr5jhj5CBPhfZH
         IFAM+0Q2s6EyBgJ5NVoeeK1wFtKOvKUIm0amx8XsMe+zXVIq47MkxMOWh6HfpMMlrpxu
         OiUur1ZH3Jlm5yOkL11xzDfBHocg08jniBEv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LmwOalPKEgTsUbb4vN12ilFNCiRaco+/dvzcz+eDq+tN/K61jhlTC6Bus63UlgYkg/
         WjpLC+RVNC3WNaY++lok5ptqyjoNrs8ECtw0RddqEt6/VGkNSXswWD3Qf0ToR5EnhnOd
         HbwskKe8cnwvZin9/g9ROYj3E5Xt/gke26Q0s=
Received: by 10.204.156.28 with SMTP id u28mr4522540bkw.74.1258968939102; Mon, 
	23 Nov 2009 01:35:39 -0800 (PST)
In-Reply-To: <7vd43acf7y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133491>

2009/11/23 Junio C Hamano <gitster@pobox.com>:
> Rafal Rusin <rafal.rusin@gmail.com> writes:
>
>> I'm hosting git repository on filesystem with 'chmod <some-file>'
>> causing permission denied error (it's smbfs mounted directory),
>> When I was doing push to such repo using file:// protocol, I got
>> following error:
>> error: unable to set permission to './objects/...'
>>
>> I did a small fix to sha1_file.c (patch in attachment) and git now
>> warns when unable to chmod, and continues push. This resolved proble=
m.
>> What do you think about applying it?
>
> Suppose the user wanted to use this as a shared public repository and
> configured core.sharedrepository. =C2=A0If we try to set shared-perm =
and notice
> a failure but keep going, what happens to the resulting repository?
>
> For example, the umask of the user who is pushing objects, causing th=
is
> codepath to run, might be too tight to be usable for the purpose of m=
aking
> the file readable for other members of the group. =C2=A0And the chmod=
() fails
> in this codepath. =C2=A0Then what? =C2=A0Wouldn't it make the resulti=
ng repository
> unusable?
>
> I think a _fix_ needs to first know why chmod is failing for you and
> either
>
> =C2=A0(1) make it not to fail; or
>
> =C2=A0(2) Perhaps your filesystem is lying and the result of chmod ha=
ppens to
> =C2=A0 =C2=A0 be Ok (iow, the resulting file may be readable/writable=
 by people who
> =C2=A0 =C2=A0 are supposed to be able to, accoring to the core.shared=
repository
> =C2=A0 =C2=A0 settings), in which case make the code notice the situa=
tion and keep
> =C2=A0 =C2=A0 going _only when_ it is safe to do so.
>
> I do not think your change to _unconditionally_ keep going is a fix.

Thanks for reply. You are right about sharedrepository argument.
As for detecting this particular case, I think it's not possible.
I think the best solution is to add repository config switch like
'usefilepermissions' true by default. If set to false, git would skip
chmod during push.
Does that make sense to you?

Regards,
--=20
Rafa=C5=82 Rusin
http://rrusin.blogspot.com
http://www.touk.pl
http://top.touk.pl
