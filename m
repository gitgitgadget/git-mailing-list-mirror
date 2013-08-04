From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 09:00:35 -0500
Message-ID: <CAMP44s2ea_fpzFzH6XRX0zydRLf_10RUfj-xfG0kzQFgKfvtMQ@mail.gmail.com>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
	<1375612683-9104-1-git-send-email-apelisse@gmail.com>
	<478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de>
	<CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
	<668358E0-3483-4DA0-92DD-D72B02C9FBE8@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Sun Aug 04 16:00:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5yrT-0001vR-5s
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 16:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab3HDOAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 10:00:39 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:63005 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3HDOAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 10:00:38 -0400
Received: by mail-la0-f45.google.com with SMTP id fj20so1456773lab.18
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=z73AlFPDDz5B4wTQ5ms0mvkg9zdHBpokk2cnb9aXAMQ=;
        b=io7rjBcHskXwAYb3LzYN8GvM/9J/+51KYOmJMIWNxXSgCRM3ZMPuZPIlfLBuv2u5ou
         EQgNDGxglP5/GoCvP1O48/rywMvrvcFhN43uQN9HySCZX5sOuQcnA+X1184B1h4WdSn1
         RMP5D2CB+WZEYOPl3+GSTFWg3aVeFABu0X0G8n+aGUWgZbHrEiqG/2vUbv+WYo86lAHL
         Nm3pjXB4Pled6KQd3CVBBaQL7mYHUgcR9vH+bqbxQ4PyMSJFhd8n22MroAf7O3lwuVGm
         BDC+sPBof+ZxJOsrj45onPNgVyy25wZ2JG/dz+FzAI14BUquRW2YtEgvMf3Jtw0H2elz
         58XA==
X-Received: by 10.112.150.4 with SMTP id ue4mr6967043lbb.8.1375624835571; Sun,
 04 Aug 2013 07:00:35 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 4 Aug 2013 07:00:35 -0700 (PDT)
In-Reply-To: <668358E0-3483-4DA0-92DD-D72B02C9FBE8@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231630>

On Sun, Aug 4, 2013 at 8:51 AM, J=C3=B6rn Hees <dev@joernhees.de> wrote=
:
> On 4 Aug 2013, at 15:31, Felipe Contreras <felipe.contreras@gmail.com=
> wrote:

>> This is my solution:
>>
>> --- a/contrib/remote-helpers/git-remote-hg.py
>> +++ b/contrib/remote-helpers/git-remote-hg.py
>> @@ -391,11 +391,22 @@ def get_repo(url, alias):
>>             os.makedirs(dirname)
>>     else:
>>         shared_path =3D os.path.join(gitdir, 'hg')
>> -        if not os.path.exists(shared_path):
>> -            try:
>> -                hg.clone(myui, {}, url, shared_path, update=3DFalse=
, pull=3DTrue)
>> -            except:
>> -                die('Repository error')
>> +
>> +        # check and upgrade old organization
>> +        hg_path =3D os.path.join(shared_path, '.hg')
>> +        if os.path.exists(shared_path) and not os.path.exists(hg_pa=
th):
>> +            repos =3D os.listdir(shared_path)
>> +            for x in repos:
>> +                local_hg =3D os.path.join(shared_path, x, 'clone', =
'.hg')
>> +                if not os.path.exists(local_hg):
>> +                    continue
>> +                shutil.copytree(local_hg, hg_path)
>> +
>> +        # setup shared repo (if not there)
>> +        try:
>> +            hg.peer(myui, {}, shared_path, create=3DTrue)
>
> Didn't look this up, this will raise the error below when it exists a=
lready?

Exactly.

--=20
=46elipe Contreras
