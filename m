From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 10:56:35 -0400
Message-ID: <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com>
References: <482BE5F7.2050108@thorn.ws>
	 <alpine.DEB.1.00.0805161139530.30431@racer>
	 <alpine.DEB.1.00.0805161148010.30431@racer>
	 <alpine.DEB.1.00.0805161403130.30431@racer>
	 <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com>
	 <alpine.DEB.1.00.0805161529390.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tommy Thorn" <tommy-git@thorn.ws>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 17:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx1Po-00039z-PW
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 17:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760361AbYEPO4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759212AbYEPO4l
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:56:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:59899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbYEPO4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:56:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so736075fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xovktEA8etuB2dFknf0bqm0nuZC6sXM0XljH87p4Wms=;
        b=pQCkntqQP/lAYwXv5DMfOwtZx5/CWFE52LsWGZVBp5IKlEuQbYodMGicA1musgRjY5tXP2lzz0Y1ywbYu+WHfPCCioSwQ9rvZP3PV1YUUMqnZlQfo9UY1qF7lB0nGtIELgLlv5o5YImte3rQhGHbZsAMZlUFXg+9iYDKN93/6a8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jLRSrtYzJ3POgvJMb5cRjWurCncdxhUOWOV6tMW9hBrdiLAypL+BRfw1mdxSpkzbTU9vB2KokL0wdo0sQZap4a4Y4Va1Da2XsJpNAkKwYLfsWfvWOzw5DvshnWBVKOBsXyHERu/hZJkj1ttIXNKigq1R6Hv4INHIpyT24bwQFQk=
Received: by 10.82.175.7 with SMTP id x7mr526466bue.35.1210949795972;
        Fri, 16 May 2008 07:56:35 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 16 May 2008 07:56:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161529390.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82303>

On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hmpf.  I hoped to get more definitive information here.  Especially given
>  that fgetc() is nothing more than a glorified fread() into a buffer, and
>  then access the buffer.
>
>  Well, at least you kind of pointed me to the _unlocked() function family.

Point taken.

/tmp $ for d in test1 test2 test3 test3u; do echo -n "$d: ";
/usr/bin/time ./$d </dev/zero; done
test1: 0.09user 0.05system 0:00.14elapsed 94%CPU
test2: 2.50user 0.05system 0:02.54elapsed 100%CPU
test3: 2.48user 0.06system 0:02.53elapsed 100%CPU
test3u: 1.05user 0.05system 0:01.10elapsed 99%CPU

fread is about 18x faster than fgetc().  getc() is the same speed as
fgetc().  getc_unlocked() is definitely faster than getc, but still at
least 7x slower than fread().

And if you think *that* sucks, you should try "c << cin" in C++ :)

Source code below.

Have fun,

Avery


=== test1.c ===
#include <stdio.h>

int main()
{
    char buf[1024];
    int i;
    for (i = 0; i < 102400; i++)
        fread(buf, 1, sizeof(buf), stdin);
}

=== test2.c ===
#include <stdio.h>

int main()
{
    int i;
    for (i = 0; i < 1024*102400; i++)
        fgetc(stdin);
}

=== test3.c ===
#include <stdio.h>

int main()
{
    int i;
    for (i = 0; i < 1024*102400; i++)
        getc(stdin);
}

=== test3u.c ===
#include <stdio.h>

int main()
{
    int i;
    for (i = 0; i < 1024*102400; i++)
        getc_unlocked(stdin);
}
