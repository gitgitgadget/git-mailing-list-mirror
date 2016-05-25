From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Thu, 26 May 2016 08:34:03 +0900
Message-ID: <20160525233403.GA23405@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
 <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
 <20160522080316.GA19790@glandium.org>
 <574287B9.4090307@web.de>
 <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com>
 <5743DC2A.6030808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 26 01:34:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5iK1-00049i-NO
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcEYXeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 19:34:37 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:52032 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbcEYXef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:34:35 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b5iJP-0007PD-35; Thu, 26 May 2016 08:34:03 +0900
Content-Disposition: inline
In-Reply-To: <5743DC2A.6030808@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295619>

On Tue, May 24, 2016 at 06:44:26AM +0200, Torsten B=F6gershausen wrote:
> On 05/23/2016 11:30 PM, Junio C Hamano wrote:
> > Torsten B=F6gershausen <tboegi@web.de> writes:
> >=20
> > > > > >    			get_host_and_port(&ssh_host, &port);
> > > > > >    +			/* get_host_and_port may not return a port
> > > > > > even when
> > > > > > +			 * there is one: In the [host:port]:path case,
> > > > > > +			 * get_host_and_port is called with "[host:port]" and
> > > > > > +			 * returns "host:port" and NULL.
> > > > > > +			 * In that specific case, we still need to split the
> > > > > > +			 * port. */
> > > > > Is it worth to mention that this case is "still supported leg=
acy" ?
> > > > If it's worth mentioning anywhere, it seems to me it would star=
t with
> > > > urls.txt?
> > > >=20
> > > > Mike
> > > >=20
> > > I don't know.
> > > urls.txt is for Git users, and connect.c is for Git developers.
> > > urls.txt does not mention that Git follows any RFC when parsing t=
he
> > > URLS', it doesn't claim to be 100% compliant.
> > > Even if it makes sense to do so, as many user simply expect Git t=
o accept
> > > RFC compliant URL's, and it makes the development easier, if ther=
e is
> > > an already
> > > written specification, that describes all the details.
> > > The parser is not 100% RFC compliant, one example:
> > > - old-style usgage like "git clone [host:222]:~/path/to/repo are =
supported
> > Is it an option to fix get_host_and_port() so that it returns what
> > the caller expects even when it is given "[host:port]"?  When the
> > caller passes other forms like "host:port", it expects to get "host=
"
> > and "port" parsed out into two variables.  Why can't the caller
> > expect to see the same happen when feeding "[host:port]" to the
> > function?
> >=20
> This is somewhat out of my head:
> git clone   git://[example.com:123]:/test        #illegal, malformate=
d URL
> git clone   [example.com:123]:/test               #scp-like URL, lega=
cy
> git clone   ssh://[example.com:123]:/test       #illegal, but support=
ed as
> legacy, because
> git clone  ssh://[user@::1]/test                       # was the only=
 way to
> specify a user name at a literal IPv6 address
>=20
> May be we should have some  more test cases for malformated git:// UR=
Ls?

None of these malformed urls are rejected with or without my series
applied:

Without:
$ git fetch-pack --diag-url git://[example.com:123]:/test=20
Diag: url=3Dgit://[example.com:123]:/test
Diag: protocol=3Dgit
Diag: hostandport=3D[example.com:123]:
Diag: path=3D/test
$ git fetch-pack --diag-url
ssh://[example.com:123]:/test
Diag: url=3Dssh://[example.com:123]:/test
Diag: protocol=3Dssh
Diag: userandhost=3Dexample.com
Diag: port=3D123
Diag: path=3D/test

With:
$ git fetch-pack --diag-url git://[example.com:123]:/test=20
Diag: url=3Dgit://[example.com:123]:/test
Diag: protocol=3Dgit
Diag: user=3DNULL
Diag: host=3Dexample.com
Diag: port=3D123
Diag: path=3D/test
$ git fetch-pack --diag-url ssh://[example.com:123]:/test
Diag: url=3Dssh://[example.com:123]:/test
Diag: protocol=3Dssh
Diag: user=3DNULL
Diag: host=3Dexample.com
Diag: port=3D123
Diag: path=3D/test

Note in the first case, hostandport is "[example.com:123]:", and that
is treated as host=3Dexample.com:123 and port=3DNULL further down, so m=
y
series is changing something here, but arguably, it makes it less worse=
=2E
(note that both with and without my series,
"git://[example.com:123]:42/path" is treated the same, so only a corner
case changed)

Can we go forward with the current series (modulo the comment style
thing Eric noted, and maybe adding a note about the parser handling url=
s
as per urls.txt), and not bloat scope it? If anything, the state of the
code after the series should make further parser changes easier.

Cheers,

Mike
