From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 10:38:39 -0400
Message-ID: <20100831143839.GC16034@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 16:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqRzD-00007n-JS
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab0HaOiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 10:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757522Ab0HaOit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 10:38:49 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7VEcg2S001257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 31 Aug 2010 10:38:42 -0400
Received: from foucault.redhat.com (vpn-11-196.rdu.redhat.com [10.11.11.196])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7VEcdV6025543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 Aug 2010 10:38:41 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154902>

On Tue, Aug 31, 2010 at 11:29:02AM +1000, Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 31, 2010 at 7:17 AM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
> > On Mon, Aug 30, 2010 at 8:59 PM, =A0<cdahlin@redhat.com> wrote:
> >> From: Casey Dahlin <cdahlin@redhat.com>
> >>
> >> This isn't really what I'd normally call ready for public consumpt=
ion, but
> >> since there's been some minimal list chatter on a similar subject =
I figured I'd
> >> put this out there early.
> >>
> >> git-hive is a peer to peer service for exchanging branches. When s=
tarted it
> >> runs a small daemon to publish your repository on a random (or spe=
cified) port.
> >> Two hive daemons connected to oneanother can exchange branch lists=
 and
> >> introduce eachother to more hive daemons to widen the network.
> >
> > =A0p.s. is there any location where, in diagrammatic form, the
> > protocol's described?
>=20
> Also a short tutorial how to use it would be nice.
>=20
> I take it I can put different repositories (say wine.git and git.git)
> in the hive. When I fetch git.git from the hive, it won't fetch
> wine.git?

=46irst step to using hive is to set the project uri for your repo (may=
 change
this to a different mechanism later).

	casey@host_a$ git config --add hive.uri http://myproject.org

This is what prevents the scenario you describe; repos with the same pr=
oject
URI are assumed to be compatible. It can be given as a command line arg=
ument to
'git hive start', but this way is much more usable.

Next we start the service for our repo.

	casey@host_a$ git hive start --listen-port 21121

Normally the listen port is selected randomly. We specify it here so th=
at other
hive users can explicitly connect to us and "bootstrap" themselves into=
 the
hive network.

Now to have someone join.

	nguyen@host_b$ git config --add hive.uri http://myproject.org
	nguyen@host_b$ git hive start host_a.com:21121

So from host_b we specify host_a's address and listen port, and we join=
 the
network. From here on out anyone who also connects to host_a will get h=
ost_b's
(randomly selected) listen port automatically and be able to connect to=
 it as
well.

So now our two peers can see each other.

	casey@host_a$ git hive show --branches
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
		master
		for_casey
=09
	---

	nguyen@host_b$ git hive show --branches
	Casey Dahlin <cdahlin@redhat.com>
		master
		stable
		v2.1

And we can exchange them

	casey@host_a$ git hive fetch nguyen for_casey
	casey@host_a$ git branch
	* master
	  stable
	  for_casey

Note that the two arguments in fetch are a regex which searches through=
 user
IDs and a branch name, which is why I can abbreviate to just "nguyen" i=
n all
lower case.

--CJD
