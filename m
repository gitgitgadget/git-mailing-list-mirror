From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Fri, 28 Jul 2006 09:57:07 -0400
Message-ID: <b8bf37780607280657x1c4c88d1ofd0734ddc4642d02@mail.gmail.com>
References: <b8bf37780607280258s421faf65o11c5dd241e7a27c6@mail.gmail.com>
	 <EA24FE8B11562848B4760FD5EB4D2E9401B3F3C2@SAO1016V.ww101.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 15:57:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Sq2-0008UL-Ix
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 15:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWG1N5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 28 Jul 2006 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWG1N5L
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 09:57:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:20508 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161153AbWG1N5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 09:57:09 -0400
Received: by py-out-1112.google.com with SMTP id s49so634930pyc
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 06:57:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i7F3zXKeLI14ydUVt411SZMcWQzPthhCmFijBGUtT3TjzTILr7uNHIjRMwd9bGk4nocuznQXhWiZMmhS+NrwCxZaKc1uBujd2FJ5UB1Ny8jGFNebEARX3kfAwjhEkKjN47v+zfF6zgoyosPKYv7SrMS8Eb9V2p6rq2+j+lGpIDs=
Received: by 10.35.26.14 with SMTP id d14mr14502324pyj;
        Fri, 28 Jul 2006 06:57:07 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Fri, 28 Jul 2006 06:57:07 -0700 (PDT)
To: "Ribeiro, Humberto Plinio" <humberto.ribeiro@siemens.com>
In-Reply-To: <EA24FE8B11562848B4760FD5EB4D2E9401B3F3C2@SAO1016V.ww101.siemens.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24385>

On 7/28/06, Ribeiro, Humberto Plinio <humberto.ribeiro@siemens.com> wro=
te:
> Hi, Andre.
>
> After a "ps -ef" I saw two instances of the script defined by
> GIT_PROXY_COMMAND. Strangely one of those instances was child
> of the other. A strace showed the scripts were blocked in a
>"waitpid(-1,". I've killed the child script and the git clone resumed =
the
>process.
>
> I didn't understand why this blocking on git happened though. The
> creation of these two instances (one child of the other) was also
> strange.

Yes,  it worked to me too, but I also don't know why.

Let me explain exactly what we had to do so someone perhaps can
explain why we had to do this:

I configured GIT_PROXY_COMMAND pointing to a script with this content:

(echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | nc 172.29.0.6 3128 |
(read a; read a; cat )

Later:

git clone git://source.mvista.com/git/linux-davinci-2.6.git

After some time (downloading 117 Mb) it stalled (git-fetch on a pipe
read) and we had to do this to resume and let it finish:

[root@mao2wx23 tmp]# ps -ef | grep git | grep -v grep
opb694    9975  1451  0 01:39 pts/11   00:00:00 /bin/sh
/usr/bin/git-clone git://source.mvista.com/git/linux-davinci-2.6.git
opb694    9985  9975  3 01:39 pts/11   00:01:56 git-fetch-pack --all
-k git //source.mvista.com git/linux-davinci-2.6.git
[root@mao2wx23 tmp]# ps -ef | grep proxy | grep -v grep
opb694    9986  9985  0 01:39 pts/11   00:00:00 /bin/sh
/home/opb694/proxy-cmd.sh source.mvista.com 9418
opb694    9987  9986  0 01:39 pts/11   00:00:00 /bin/sh
/home/opb694/proxy-cmd.sh source.mvista.com 9418
[root@mao2wx23 tmp]# kill 9987

Thanks again for the patience,
--=20
[]s,
Andr=E9 Goddard
