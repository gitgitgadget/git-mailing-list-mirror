From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 11:52:00 -0400
Message-ID: <20100831155159.GD16034@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:52:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqT8G-0004pW-6f
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484Ab0HaPwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:52:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8622 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115Ab0HaPwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:52:06 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7VFq3Vg029072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 31 Aug 2010 11:52:03 -0400
Received: from foucault.redhat.com (vpn-11-196.rdu.redhat.com [10.11.11.196])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7VFq0ev016232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 Aug 2010 11:52:02 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154920>

On Tue, Aug 31, 2010 at 04:08:03PM +0100, Luke Kenneth Casson Leighton =
wrote:
> On Tue, Aug 31, 2010 at 3:38 PM, Casey Dahlin <cdahlin@redhat.com> wr=
ote:
>=20
> > =A0 =A0 =A0 =A0nguyen@host_b$ git config --add hive.uri http://mypr=
oject.org
> > =A0 =A0 =A0 =A0nguyen@host_b$ git hive start host_a.com:21121
> >
> > So from host_b we specify host_a's address and listen port, and we =
join the
> > network. From here on out anyone who also connects to host_a will g=
et host_b's
> > (randomly selected) listen port automatically and be able to connec=
t to it as
> > well.
> >
> > So now our two peers can see each other.
>=20
>  ok - this only works if the two peers can see each other's ip
> addresses.  i.e. if the two machines are either on a local subnet or
> if the two machines are directly on the public internet.  ( or if
> you've forced people to set up a firewall rule and/or UPnP rule, but
> even then UPnP doesn't solve the entire problem - only one part of it=
)
>=20
>  ... unless (and i haven't reviewed the code closely, i admit) you're
> using the following protocol:
>=20
>  * make tcp connection
>  * send dedicated specific message "please tell me my public IP and p=
ort"
>  * far end does sockaddr lookup of the incoming socket
>  * far end returns IP and port as response to requestor
>=20

Its a bit more primitive right now (a bit broken even) but that's the e=
ventual
plan.

Piece you missed though is that the port on the connect end isn't the s=
ame as
the listen port. Connecting back to it would do no good.

> in this way, requestors can determine what the "apparent" IP address
> is as far as having been NAT'd through half a ton of ISP layers
> performing NAT, local routers performing NAT, laptops such as mine
> doing NAT sharing of a 3G connection over a netgear router and so on.
>=20

You can't get back through all those anyway unless they've all been set=
 up to
allow it. I don't know what magic you've seen torrent clients do, but t=
he
procedure for the ones I always used was:

1) Check to see if it can receive connections on the port it wants.
2) Bitch at user if it can't.

Bittorrent has the luxury of being able to proxy for the poor firewall-=
bound
users since as long as there's one peer exposed to the internet you can=
 have
any two other peers connect to him and give him the data they want to e=
xchange,
to the benefit of all 3. Git won't work that way because not everyone i=
n the
swarm wants all chunks of data, so if you found a proxy node, you might=
 have to
make him carry data (possibly lots of data) that he has no personal int=
erest
in.

> so, answering the question you were asking earlier: i believe that yo=
u
> really do need to consider taking the closest c-based bittorrent
> library/application apart, and use it as the basis for git-hive.  if
> you don't, you will be here forever, reinventing everything that thes=
e
> fileshare-app-writers have spent nearly a decade perfecting.
>=20

The thing avahi was going to provide was bootstrapping. Bittorrent DHT =
handles
this by having a list of known-good peers stashed away somewhere
(bittorrent.org hosts one). Essentially a non-p2p solution to joining t=
he p2p
network. That's pretty much the only WAN solution. Local networks on th=
e same
subnet have the option of UDP multicast. Avahi can do that. I'd be will=
ing to
do it manually or with something else. But yes, for your WAN case its u=
seless.

--CJD
