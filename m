From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-receive-pack --stateless-rpc
Date: Thu, 17 Jun 2010 08:25:27 -0700
Message-ID: <20100617152527.GA14847@spearce.org>
References: <AANLkTikwu4iKnG-DzclRPFNF7djNKZ31xR82aO0ryVJ3@mail.gmail.com> <AANLkTikbUp7_22alAbgNFO30R7vkPUAOr7qvJ6a86Zc7@mail.gmail.com> <AANLkTimZxcljR4soYWVeExr27Md7jmsE1Mfx3Vcbf9SI@mail.gmail.com> <AANLkTinJadUb48CBKMy1cMlXb2yUvm9uY0nUAQuslrfo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Yiyi Sun <yiyisun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 17:25:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPGyG-0000Wk-6h
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 17:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760244Ab0FQPZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 11:25:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49431 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760160Ab0FQPZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 11:25:30 -0400
Received: by pwi1 with SMTP id 1so16490pwi.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 08:25:30 -0700 (PDT)
Received: by 10.115.113.18 with SMTP id q18mr8385142wam.220.1276788330001;
        Thu, 17 Jun 2010 08:25:30 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 33sm96470741wad.8.2010.06.17.08.25.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jun 2010 08:25:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinJadUb48CBKMy1cMlXb2yUvm9uY0nUAQuslrfo@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149314>

Yiyi Sun <yiyisun@gmail.com> wrote:
> Thanks Shawn for you quick reply. Now I have the answer to question #=
1.
>=20
> You are so good that spotted the space between 0030 and 000e. It is a
> byte of value 0x1. I can reproduce the issue using the attached file
> w/o goimg through my program:
>=20
> --save the file (named input) to and goto the directory
> git init --bare test
> cd test
> cat ../input | git receive-pack .
>=20
> It returns message below, where you can see a funny char there.
>=20
> 00700000000000000000000000000000000000000000 capabilities^{}  report-=
status dele
> te-refs side-band-64k ofs-delta
> Unpacking objects: 100% (6/6), done.
> 0030=E2=98=BA000eunpack ok
> 0019ok refs/heads/master
> 00000000
>=20
>=20
> For the "003" error. I tired to grab the HTTP output w/o using msysGi=
t. It is
>=20
> HTTP/1.1 200 OK
> Server: ASP.NET Development Server/10.0.0.0
> Date: Thu, 17 Jun 2010 13:18:44 GMT
> X-AspNet-Version: 4.0.30319
> Cache-Control: private
> Content-Type: application/x-git-receive-pack-result
> Content-Length: 52
> Connection: Close
>=20
> 0030=01000eunpack ok
> 0019ok refs/heads/master
> 00000000
>=20
> It looks normal. Besides msysGit can candle the output of 'git
> receive-pack --stateless-rpc
> --advertise-refs' via HTTP GET the same way my program returns the re=
sult.
>=20
> Regards,
>=20
> yysun
>=20
> On Thu, Jun 17, 2010 at 10:00 AM, Shawn Pearce <spearce@spearce.org> =
wrote:
> >
> > On Thu, Jun 17, 2010 at 6:45 AM, Yiyi Sun <yiyisun@gmail.com> wrote=
:
> > > I am creating a Git smart HTTP protocol wrapper and run into two
> > > problem. I tried the msysGit mailing list and was told to ask the=
m to
> > > the main git mailing list.
> > >
> > > Here is the story. During 'git push',=C2=A0 I successfully proces=
sed the
> > > initial GET request of '/info/refs?service=3Dgit-receive-pack' by
> > > sending back the output of 'git receive-pack --stateless-rpc
> > > --advertise-refs'. Then msysGit did a the POST request. I
> > > invoked 'git receive-pack --stateless-rpc', which returned:
> > >
> > > 0030 000eunpack ok
> > > 0019ok refs/heads/master
> > > 00000000
> >
> > That doesn't look right to me. =C2=A0There appears to be a space at=
 the
> > start of the packet (between 0030 and 000e), which would confuse th=
e
> > protocol. =C2=A0Otherwise, that appears to be a valid response from
> > receive-pack assuming the client asked for side-band-64k in the
> > request, and it pushed only refs/heads/master.
> >
> > > Question #1,=C2=A0Is the result supposed to be something below in=
stead?
> > >
> > > 000eunpack ok
> > > 0019ok refs/heads/master
> > > 0000
> >
> > Depends on whether or not the client asked for side-band-64k. =C2=A0=
If it
> > did, we wrap it up in a another pkt-line framing like above, and en=
d
> > with another flush-pkt. =C2=A0If the client didn't ask for side-ban=
d-64k,
> > then the above would be the correct response.
> >
> > > Question #2, msysGit cannot parse the result, it displays error m=
essage:
> > >
> > > fatal: protocol error: bad line length character:
> > > 003
> > > fatal: The remote end hung up unexpectedly
> >
> > This is weird. =C2=A0"003" isn't valid, its not 4 bytes long. =C2=A0=
What was
> > that trailing final 4th byte right there? =C2=A0If its a space like=
 it is
> > above (though then its really in the wrong spot, isn't it?) that wo=
uld
> > throw it all off.
> >
> > It sounds to me like your wrapper is mangling the data that is pass=
ing
> > through it on the way back to the client.

Oh, yea.  That byte 0x01 is the sideband stream number.  I forgot
about that needing to be there. :-)

I think your wrapper program is dropping the data there or isn't
being 8 bit clean and is mangling the value.  That's part of
the stream.

--=20
Shawn.
