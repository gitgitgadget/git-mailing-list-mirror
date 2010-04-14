From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/9] builtin: check pager.<cmd> configuration if
 RUN_SETUP_GENTLY is used
Date: Tue, 13 Apr 2010 23:38:44 -0500
Message-ID: <20100414043844.GA28864@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413023003.GH4118@progeny.tock>
 <u2ufcaeb9bf1004122229l72de0e55i8dbd993d6cb16d2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 06:38:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1uNJ-0003bP-LE
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 06:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab0DNEis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 00:38:48 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:55498 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0DNEir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 00:38:47 -0400
Received: by yxe37 with SMTP id 37so3926961yxe.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 21:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yYv09Hz0bdsqABrqH9WwoP6yMVERK+gc+x43XwzdWOU=;
        b=wcf6d41txLWBcLruFTo9kDE+3jU++4vJWQgiIhbo1GGDPxNE7AQnT5O+k+Y45JzuL/
         9VIfGK5bIDT+PkeFWAX7PouH0I/mJdXVPouyzp5vNzKOSZhs9oLwfkNIj3Vn9BB43XYl
         Wet/mFHM7+7s58Yyi/iLsLo3Niigk9izMFzsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mfftOpJ4O32Mx0y4rbtNgQqy72siQ7DuDjPs0rkw+Lxs35G79u4YmJ2HGnH2iParPq
         alCIBEZF9nsnvILLdmVkQQyu0zz3GtN3QOOzC+WcG1vAI3AsFSXuFn4zxWwZVsETOjYo
         EBJux/bUL1xKnDhhGTvSfJdStbosnxknHNHVI=
Received: by 10.101.155.34 with SMTP id h34mr12482282ano.156.1271219926777;
        Tue, 13 Apr 2010 21:38:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5434023iwn.4.2010.04.13.21.38.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 21:38:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <u2ufcaeb9bf1004122229l72de0e55i8dbd993d6cb16d2b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144848>

Nguyen Thai Ngoc Duy wrote:
> 2010/4/13 Jonathan Nieder <jrnieder@gmail.com>:

>> @@ -251,7 +251,7 @@ static int run_builtin(struct cmd_struct *p, int=
 argc, const char **argv)
[...]
>> -		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
>> +		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GEN=
TLY))
>>			use_pager =3D check_pager_config(p->cmd);
>>		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
>>			use_pager =3D 1;
>
> This still leaves a chance of going wrong: when user explicitly gives
> "--paginate", use_pager will be 1, but commands like "git init" does
> not have RUN_SETUP*. So when setup_pager is called later on, it will
> mess things up.

I decided not to check_pager_config() unconditionally to avoid
breaking =E2=80=98git diff=E2=80=99 (especially =E2=80=98git diff --exi=
t-code=E2=80=99).  Maybe that
is too conservative; not sure.  The commit message should be more
explicit, something like:

   Eventually, all git commands should check their configuration at
   start-up.  For now, reading configuration before repository discover=
y
   is dangerous because it could cause a pager.<cmd> setting from the
   current repository to be neglected.

   But for commands with RUN_SETUP or RUN_SETUP_GENTLY set, it is safe.

   This will not affect commands like "git init" that cannot have
   RUN_SETUP* set; they will have to be helped separately later.  In
   particular, commands such as "git diff" that use command-specific
   options to decide whether to search for a repository and whether to
   paginate output are outside the scope of this change.

Guiding principle: better to leave some bugs for later than risk
regressions.

> This could be solved completely (indeed I have a patch
> under testing), but it would require unset_git_directory(), making
> this series a bit longer :(

I agree; that=E2=80=99s the right way to do it.  run_builtin() ought to=
 be
relatively sure about whether a repo is going to be searched for.  For
commands like diff and grep, I think it should be okay to search for a
repo unless --no-index is the first argument.

Thanks for your thoughtfulness.
Jonathan
