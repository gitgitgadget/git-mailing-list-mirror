From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH]  Test and fix handling of quotes in ~/.ssh/config
Date: Thu, 25 Sep 2008 01:25:19 +0200
Message-ID: <20080924232519.GA15318@diku.dk>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com> <20080921112519.GA24200@diku.dk> <200809222242.29165.robin.rosenberg.lists@dewire.com> <20080922210734.GE3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	sverre@rabbelier.nl, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 01:26:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kidkd-0005y1-0Q
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 01:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbYIXXZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 19:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYIXXZY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:25:24 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:60709 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbYIXXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:25:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id C889152C376;
	Thu, 25 Sep 2008 01:25:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bAi9G21yx+X; Thu, 25 Sep 2008 01:25:19 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C817952C32D;
	Thu, 25 Sep 2008 01:25:19 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E76F26DF845; Thu, 25 Sep 2008 01:24:46 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A48204F9FA1; Thu, 25 Sep 2008 01:25:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080922210734.GE3669@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96712>

Shawn O. Pearce <spearce@spearce.org> wrote Mon, Sep 22, 2008:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > s=F6ndagen den 21 september 2008 13.25.19 skrev Jonas Fonseca:
> > > +		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
> > This one is really (as you noted) bad so we shouldn't allow it at a=
ll. A new=20
> > subclass of TransportExcpeption should be thrown to indicate a seri=
ous
> > configuration problem when attempting to use the option.
>
> Probably so.
>=20
> But then we need to mark that the Host is invalid, because we
> are serving requests from a cache, not from the file itself.
> And TransportException isn't something that the SshSessionFactory
> knows about.  Probably better to use a a subclass of IOException.

Sorry, for not following up on this. I was trying to cook up a patch fo=
r
this today. Now, it is somehow sad that testing "forces" us to waste
time on these stupid corner cases. ;-) On the other hand, this problem
might exist (.git/config) or turn up again, so it would be good to have
a design principle.

Using exceptions seems a bit harsh, since the quote is not really fatal
in anyway. Also, for badly formatted Port values the value is simply
ignored. So for bad quoting encountered during non-Host values, I think
it is fair to just ignore the value. For Host values it is a bit more
non-obvious to me. In terms of invalidating hosts, the API ensures that
a lookup will always return a host, so invalid hosts should not return
null. I propose to simply remove these hosts from the host map and clea=
r
the current host list so that no values will be saved, effectively
causing invalid hosts to result in the same as unknown hosts.

--=20
Jonas Fonseca
