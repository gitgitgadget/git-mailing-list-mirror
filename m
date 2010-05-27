From: Albert Dvornik <dvornik@gmail.com>
Subject: Re: [msysGit] Re: [PATCH] compat: Add another rudimentary poll() 
	emulation
Date: Thu, 27 May 2010 10:05:02 -0400
Message-ID: <AANLkTimyFxEYjQLefWvExBarhZAwoXNLDUum2lVj4Q3B@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 16:05:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdhy-0006pA-DQ
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0E0OFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 10:05:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab0E0OFD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 10:05:03 -0400
Received: by pvg3 with SMTP id 3so1658736pvg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sYyPKgzXnA1q5IRcodEyXRs0zKX9dtuF7AfBrQRdSpw=;
        b=wMsKvIrU4HECwYoDO6CkVf7LTMSBjJ62tXDdIXqGynhLoSQq/QTyf0Rkgd4Xyldyez
         7jfGw+U4V/3P/BoBpVvoWlkZ9S0eJ1wcIGq4wR72A1FRujjOWl32FuIM2fQM0VEK5h2j
         88CqH/tQ1OXDrHE7tdzEB9NP/OX2sKDg5Ag7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xhgwjlHLb7OQfWgmS9wUkDJ3ZKIRpHJyEoqtBvDNzUWyNLCE+ZNmrP65q2j6pGI3Rm
         SH9A06nCl0EO9a7chQhBFk74cDCKiniJfjQXwSk6OakQ6oliqjx2bVxu2F1I0uNxoCgB
         GCBXLnHTMxUy+JbinwqnbA8UVmERGPuEMfCJQ=
Received: by 10.229.186.139 with SMTP id cs11mr2284754qcb.19.1274969102222; 
	Thu, 27 May 2010 07:05:02 -0700 (PDT)
Received: by 10.229.74.193 with HTTP; Thu, 27 May 2010 07:05:02 -0700 (PDT)
In-Reply-To: <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147858>

On Thu, May 27, 2010 at 9:06 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
[...]
> But perhaps you should include a check along the lines of this:
>
> if (nfds > FD_SETSIZE)
> =A0 =A0 =A0 =A0return errno =3D EINVAL, error("poll: nfds must be bel=
ow %d", FD_SETSIZE);
>
> Just so we can know when the code fails :)

If you're checking against FD_SETSIZE (which is IMO a good idea), you
should consider that
(a) on the one system I'm aware of where fd_set doesn't use a bitmap
(Windows), FD_SETSIZE is a limit on the number of descriptors added to
the set, but
(b) on systems where fd_set uses a bitmap (i.e. Linux, perhaps all
UNIXes, etc), FD_SETSIZE is a limit on *each descriptor value*.  This
is also what POSIX says.

So on the latter systems, we want something like this before each FD_SE=
T:

if (ufds[i].fd >=3D FD_SETSIZE) {
    errno =3D EINVAL;
    return error("poll: each fd must be below %d", FD_SETSIZE);
}

(The reason to have it in the loop, rather than just check maxfd
afterwards, is that FD_SET with an argument that's too big can trash
the stack.)

Of course, on Windows this would impose a limitation that all
descriptors be < 64, which is probably crazy.  Which means that you'd
have to actually distinguish the two types.  Sigh.

--bert
