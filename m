From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Wed, 28 May 2014 08:45:09 -0700
Message-ID: <20140528154509.GA7076@hudson.localdomain>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
 <1401257655-6043-2-git-send-email-jmmahler@gmail.com>
 <5385994A.5040507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 17:45:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpg2b-0004Zj-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 17:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbaE1PpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 11:45:15 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:49257 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbaE1PpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 11:45:13 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so11181649pad.16
        for <git@vger.kernel.org>; Wed, 28 May 2014 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=r5NfeNwyFIVmCHZ2jrAtz0mFnmXzuqhA87W5Q6vE6c0=;
        b=piZ96cedVNkPxhOfpXxvfqCwB/7/7DcQKBaLuGNH3wdsxdQakDsDrQkkGvJ4QzKIy3
         0oI6K8I6izfTEHok8uaEZ/yJ8/xPmeKD/rihl2xKVoMbw5Tzh64VsZhTU8Kw7taH1yuH
         inlheXXuL0vFLZMXXT0FzrBobFXWCqS9Fi+9U5VkQkaVesJYiaAa+W6TbM6jiVvIvnh6
         UHpGXmEnikB2JBdfJcrRWOfMDxQcFK/s1Mt3i8tKEOvjeALtroLPGBCjiGxrJB6rtmAf
         7KzxOLB3aPw1MXT5NITpR3PFq5vHuI6huS04F7a6Gf7o6ZDssOv5TTluiDbfzK8OJ1JU
         9OjA==
X-Received: by 10.66.244.176 with SMTP id xh16mr706355pac.20.1401291913254;
        Wed, 28 May 2014 08:45:13 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id z3sm90476523pas.15.2014.05.28.08.45.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 08:45:11 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 28 May 2014 08:45:09 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5385994A.5040507@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250290>

On Wed, May 28, 2014 at 08:07:38PM +1200, Chris Packham wrote:
> On 28/05/14 18:14, Jeremiah Mahler wrote:
> > From signal(2)
> >=20
> >   The behavior of signal() varies across UNIX versions, and has als=
o var=E2=80=90
> >   ied historically across different versions of Linux.   Avoid  its=
  use:
> >   use sigaction(2) instead.  See Portability below.
>=20
> Minor nit. The last sentence applies to the man page you're quoting a=
nd
> doesn't really make sense when viewed in the context of this commit
> message. Same applies to other patches in this series.
>=20
Yes, that is confusing.

=2E..
> > @@ -66,8 +66,12 @@ static void set_progress_signal(void)
> >  static void clear_progress_signal(void)
> >  {
> >  	struct itimerval v =3D {{0,},};
> > +	struct sigaction sa;
> > +
> > +	memset(&sa, 0, sizeof(sa));
> > +	sa.sa_handler =3D SIG_IGN;
>=20
> A C99 initialiser here would save the call to memset. Unfortunately
> Documentation/CodingGuidelines is fairly clear on not using C99
> initialisers, given the fact we're now at git 2.0 maybe it's time to
> revisit this policy?
>=20

struct sigaction sa =3D { .sa_handler =3D SIG_IGN };

I do like that.

This brings up another issue.  memset(&sa, 0, sizeof(sa)); The sigactio=
n
examples I have seen always use memset.  The manpage for sigaction(2)
doesn't mention it.  Other code it Git uses memset with sigaction (see
fast-import.c line 530).

Is this struct guaranteed to be initialized to zero so I don't have to
use memset?

--=20
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
