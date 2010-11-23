From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC PATCH 1/6] msvc: opendir: use xmalloc
Date: Tue, 23 Nov 2010 18:45:07 +0100
Message-ID: <AANLkTiknTQp96PeiBd+MqCO6uEs1mCzFYDsW8NwYpBsm@mail.gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-2-git-send-email-kusmabite@gmail.com> <20101123174050.GB12113@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwwD-0003mm-4k
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab0KWRpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 12:45:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39402 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982Ab0KWRp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 12:45:29 -0500
Received: by pwj3 with SMTP id 3so138998pwj.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Ye/NQfD0xFBcx0GPpud5eV5NMRQjQAlZydWrFY56PMA=;
        b=Ivt90Cn8GYSPxbiY9v9HgM+tLU8ROrZDDRbAVNZXMsemz8ZDcYv6Yejp3A5LRGsWza
         KzQDBttacKIxtcKULouCMX3ylta5UXuZZn4LYgAOe7IPzXhFYUTi2lSVTiDLxZkcB07W
         fFkoQ/O/ejAhvWWot7OsWakIFGevjQKvZnJak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=o5KbU+OEg/rsR9nJP9De0umV4zxJeP4WxayiSEaYYLhxCvSMa0n/LJiGxvXsh4uG5w
         6twafP3o88YIsXjQqEGMdmsReuzIywVRcS8GT1NjCgeqdWSN0vF2Zu/hdeLlgDTvAp8a
         aVkVaeaV24COaJRuRg2Bp25/24wkBkPDtjruk=
Received: by 10.223.107.16 with SMTP id z16mr264273fao.7.1290534327950; Tue,
 23 Nov 2010 09:45:27 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 09:45:07 -0800 (PST)
In-Reply-To: <20101123174050.GB12113@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161995>

On Tue, Nov 23, 2010 at 6:40 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> --- a/compat/msvc.c
>> +++ b/compat/msvc.c
>> @@ -7,16 +7,13 @@ DIR *opendir(const char *name)
>> =A0{
>> =A0 =A0 =A0 int len;
>> =A0 =A0 =A0 DIR *p;
>> - =A0 =A0 p =3D (DIR*)malloc(sizeof(DIR));
>> + =A0 =A0 p =3D xmalloc(sizeof(DIR));
>> =A0 =A0 =A0 memset(p, 0, sizeof(DIR));
>> =A0 =A0 =A0 strncpy(p->dd_name, name, PATH_MAX);
>> =A0 =A0 =A0 len =3D strlen(p->dd_name);
>> =A0 =A0 =A0 p->dd_name[len] =3D '/';
>> =A0 =A0 =A0 p->dd_name[len+1] =3D '*';
>>
>> - =A0 =A0 if (p =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>
> A behavior change but maybe a good one. =A0For example, the
> prune_packed_objects() loop currently skips object dirs it can't open=
,
> even if that is due to memory exhaustion, but this changes it to erro=
r
> out.
>
> What is the motivation?
>

The motivation is just to avoid having to deal with the error, like we
do other places. It's not a big deal though. I could also set errno to
ENOMEM and return NULL if that's preferable. I just don't see how it
is.

I also slightly dislike setting an error not listed in POSIX'
documentation of opendir, even though it's probably allowed.
