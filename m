From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 0/5] replace signal() with sigaction()
Date: Wed, 28 May 2014 20:11:48 +1200
Message-ID: <53859A44.7040806@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com> <53859307.8080506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Johannes Sixt <j.sixt@viscovery.net>,
	Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 10:11:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpYxq-0000i0-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 10:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbaE1ILy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 04:11:54 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:53261 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbaE1ILw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 04:11:52 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so10645527pbc.26
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=UXp6rdr/37wIYKXuv58CrIgMvPGewY8YK29BwKkFJN8=;
        b=EmgbYVH202QrwaUSutXCkJBGIEDi8H2CWk/6mwKT49pcIC+xX44pZLL26nSvxkxez1
         wfLiwr97ZQwr30gdV4dKnNMuqijiLtyNCKtwwsGO61Cmxd+nAndnfLMU7JEzsqjk02/t
         DmmoJMS0UIBgNk+BrF3i9R/nyXeWMPheJjkuBNYXGAvW7N9ZhyRcYkL9FPVjEvqW8tdz
         D/2dSl8E3Vy/wv2lA3NWRp9/ipqjmjzw1eSLOc7bJTFHr3drclOGFYcuD/k1sBTbQcbm
         Awryn4RjeNW9Y9Q0jZtsVy+KaHCfQcL1SBJzE85RzxDnYhZX9Xs6Oj6kxDIq7y65uEj5
         b71A==
X-Received: by 10.68.113.68 with SMTP id iw4mr42699600pbb.119.1401264711897;
        Wed, 28 May 2014 01:11:51 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id nh8sm27055472pbc.25.2014.05.28.01.11.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 28 May 2014 01:11:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53859307.8080506@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250271>

On 28/05/14 19:40, Johannes Sixt wrote:
> Am 5/28/2014 8:14, schrieb Jeremiah Mahler:
>> From signal(2)
>>
>>   The behavior of signal() varies across UNIX versions, and has also=
 var=E2=80=90
>>   ied historically across different versions of Linux.   Avoid  its =
 use:
>>   use sigaction(2) instead.  See Portability below.
>>
>> This patch set replaces calls to signal() with sigaction() in all fi=
les
>> except sigchain.c.  sigchain.c is a bit more complicated than the ot=
hers
>> and will be done in a separate patch.
>=20
> In compat/mingw.c we have:
>=20
> int sigaction(int sig, struct sigaction *in, struct sigaction *out)
> {
> 	if (sig !=3D SIGALRM)
> 		return errno =3D EINVAL,
> 			error("sigaction only implemented for SIGALRM");
> 	if (out !=3D NULL)
> 		return errno =3D EINVAL,
> 			error("sigaction: param 3 !=3D NULL not implemented");
>=20
> 	timer_fn =3D in->sa_handler;
> 	return 0;
> }
>=20
> Notice "only implemented for SIGALRM". Are adding the missing signals
> somewhere (here or in a later patch)?
>=20

* note: not a windows/mingw programmer *

Will the ones setting SIG_IGN be OK? Presumably we won't get these
signals on windows anyway so we're already getting what we want.

>> Jeremiah Mahler (5):
>>   progress.c: replace signal() with sigaction()
>>   daemon.c run_service(): replace signal() with sigaction()
>>   daemon.c child_handler(): replace signal() with sigaction()
>>   daemon.c service_loop(): replace signal() with sigaction()
>>   connect.c: replace signal() with sigaction()
>>
>>  connect.c  |  5 ++++-
>>  daemon.c   | 15 ++++++++++++---
>>  progress.c |  6 +++++-
>>  3 files changed, 21 insertions(+), 5 deletions(-)
>=20
> Isn't this a bit too much of code churn, given that there were no bug
> reports where signal handling is identified as the culprit despite
> the warning you cited above?
>=20
> -- Hannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
