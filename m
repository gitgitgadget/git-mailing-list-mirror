From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 15:18:47 +0200
Message-ID: <81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com>
References: <87wsxpobf0.fsf@rho.meyering.net>
	 <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	 <87r6nxo8iq.fsf_-_@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 15:18:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3XQ3-0004y9-Bh
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760835AbXF0NSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761370AbXF0NSt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:18:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761466AbXF0NSs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:18:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so318895ugf
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 06:18:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ig7FlufiLFUxud5IxVYImSF+Xmo5Y+R+YHkmP7vJGR5U+T1wT5/8mh5Gi46ZDgiqfCXEVFIs8Py6b8en01IYRuxGirqMGbpLJwFGEl399E/yamTus3+fK1AuyW0AmZ0w22Fp3OPK6kQb3szOxChbgXg0z1dO1XwSMT8rcLt/Gs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZNwQOhNnlH0fDIF3Dgdrr4tk9/LshzEx+uMQYB9TtoV56MXYWJQEXm6tyKjJPQpotr3qqPe2UUXMGzcoajdm2aPGh/PJ8++r6F4a3oIj83k1pY1sGrNYgbz36GQk2Cqs56TfC4UdXiKdzP1P5+r7nF8RzmjOwI0FF5Y8jQLiwBk=
Received: by 10.78.130.6 with SMTP id c6mr257861hud.1182950327027;
        Wed, 27 Jun 2007 06:18:47 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 06:18:46 -0700 (PDT)
In-Reply-To: <87r6nxo8iq.fsf_-_@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51039>

On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
> I didn't see that fdopen could fail with ENOMEM.
> That'll teach me to trust the man page.  I see POSIX does mention it.

I wouldn't trust Linux man pages nor POSIX, if I were you.
Check if this works in some exotic but common
environments (like MacOSX, Cygwin or HP-UX).

(And yes, they probably are broken, and no, you can't fix them,
and no, people are not going to stop using them).

> +       if (!use_stdout) {
> +               int fd = dup(1);
> +               if (fd < 0 || (realstdout = fdopen(fd, "w")) == NULL)
> +                       die("failed to duplicate standard output: %s",
> +                           strerror(errno));
> +       }

Kinda stuffed in here. What's wrong with plain

  realstdout = fdopen(dup(1), "w");
  if (!realstdout)
    die("%s", strerror(errno));

(Yes, I do think that "duplicate standard output" is useless,
except for debugging. Exactly as strerror is, but that is shorter).
