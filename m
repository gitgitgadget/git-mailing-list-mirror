From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 4 Apr 2012 19:34:20 +0700
Message-ID: <CACsJy8A+cJtzKdqJSWbmjT1LgP10LB69-NHfOv8S6BusGcMeFw@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 14:35:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFPQQ-00037H-40
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 14:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382Ab2DDMex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 08:34:53 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56669 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358Ab2DDMex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 08:34:53 -0400
Received: by wejx9 with SMTP id x9so134762wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GA/L4Cawtswb3AiCEsEKErX7YY8ZPnNbXW0xp3bUTiM=;
        b=yI78fYMYwtzNTjRDtFygFXEHkRs+tZ0G7o4tmrX3Nq2dfUzU+jAxrKO6orB0OuZKQZ
         j6PrcRSX5Kfz9KrjvUYmmPbPmE2RwSaM/tBIqweAjfHR+jG7/sKJoa781kt5eh+YdybX
         PUFFQNODyaARJtqCZOXvnWCl5PM0qRLv8sIn8f0dMUz1orD+otmEz0tICOkvRkmT7aQq
         UkBj8Pt5pxX1GbX/9WplGXk4LSLXLEY0P7xMtvaM+cveHry/yu+WhRLPzW7tn8JSrSDT
         wGSOljdYIve5JzxmQX1Nra+4xBPlCheZm/NXha6SbSgIvAI1744XIZLs7OV/CriQt71A
         vPEg==
Received: by 10.180.102.101 with SMTP id fn5mr4958719wib.6.1333542891879; Wed,
 04 Apr 2012 05:34:51 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Wed, 4 Apr 2012 05:34:20 -0700 (PDT)
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194696>

On Wed, Apr 4, 2012 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> This is still rough,

but nice cleanups

> but with this patch I am getting:
>
> =C2=A0 =C2=A0$ ls -l .git/index*
> =C2=A0 =C2=A0-rw-r----- 1 jch eng 25586488 2012-04-03 15:27 .git/inde=
x
> =C2=A0 =C2=A0-rw-r----- 1 jch eng 14654328 2012-04-03 15:38 .git/inde=
x-4
>
> in a clone of WebKit repository that has 183175 paths.
>
> With hot-cache with no local modification:
>
> =C2=A0 =C2=A0$ time sh -c 'GIT_INDEX_FILE=3D.git/index-4 git diff'
> =C2=A0 =C2=A0real =C2=A00m0.469s
> =C2=A0 =C2=A0user =C2=A00m0.130s
> =C2=A0 =C2=A0sys =C2=A0 0m0.330s
>
> =C2=A0 =C2=A0$ time sh -c 'git diff'
> =C2=A0 =C2=A0real =C2=A00m0.677s
> =C2=A0 =C2=A0user =C2=A00m0.290s
> =C2=A0 =C2=A0sys =C2=A0 0m0.370s

I wonder what causes user time drop from .29s to .13s here. I think
the main patch should increase computation, even only slightly, not
less. Or is it noise?

> The updated format is not documented yet, as I didn't intend (and I s=
till
> am not committed) to declare a change along this line the official "v=
4"
> format; I was merely being curious to see how much improvements we ca=
n get
> from a trivial approach like this.

Anything else you have in mind for v4? Any chance we can adopt crc32
instead of sha-1? We could divide the index into many smaller parts
for checksum, for example one crc32 every 100 entries, and one (or
sha-1) for each extension. It should not complicate the code too much.
--=20
Duy
