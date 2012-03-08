From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 7/5] transport: optionally honor DNS SRV records
Date: Thu, 8 Mar 2012 17:18:49 +0100
Message-ID: <CABPQNSYpRGfu7Ew+KstCFsG4YDSx+i-jzHS1Bw0BA4S2hoz4SA@mail.gmail.com>
References: <20120308124857.GA7666@burratino> <20120308132155.GG9426@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5g41-0004gv-Q7
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 17:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494Ab2CHQTa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 11:19:30 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49319 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab2CHQT3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 11:19:29 -0500
Received: by dajr28 with SMTP id r28so590581daj.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 08:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Ox4clAwTWQKn5gqK3tUEpQGaLTBX0kqCT+RRKfZxIDY=;
        b=oWzPLVqTl6b6pgUbG4T5zV1Yjs5gt+P0NGHW79mdXPV+FRSnmsCL+BtEx7ASusF2a0
         mrRbm/QWdH0Ya1OzRbSWKLNRbpy7txuK0g36MKIaHnTwopRPCIqPv8xQ7T79HmUDzC/1
         SkPMP1XhsQCJ/gBOHKb4ZvdkKAsAiWPb5+KspdAWWlLxs1vCSiY+OHPQvF8voovfzlei
         P6YAcuxkZ+MNIPn2QJvB57vLNtfnB7lONc6cE2WQm6cM7hvxtaF80Fur3oOR7DAx99bK
         1xzY/B3qG3riTKiFgu9qPY7OA93PbdCa6SiMPnh4jevoacpNZJ/jdIhpd4Z8d2JuUOIx
         udWA==
Received: by 10.68.240.41 with SMTP id vx9mr10604063pbc.10.1331223569160; Thu,
 08 Mar 2012 08:19:29 -0800 (PST)
Received: by 10.68.1.135 with HTTP; Thu, 8 Mar 2012 08:18:49 -0800 (PST)
In-Reply-To: <20120308132155.GG9426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192614>

On Thu, Mar 8, 2012 at 2:21 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Date: Mon, 6 Jun 2011 04:46:20 -0500
>
> SRV records are an extra layer of indirection on top of A/AAAA record=
s
> mapping from domain names and service types to the hostnames of
> machines that offer that service. =A0That has a couple of nice effect=
s:
>
> =A0- a single domain can use different hosts for different services
> =A0- a single domain can use multiple hosts for one service
>
> Teach git to perform a SRV lookup whenever resolving a git:// URL.
> This means:
>
> =A0- if your git server was previously the same machine as your wesno=
th
> =A0 server, you can move it to a separate machine without forcing
> =A0 everyone to update their links to the old URLs
>
> =A0- if you have a primary git server and a backup machine that shoul=
d
> =A0 be used when the primary server goes down, the client can
> =A0 automatically take care of it
>
> =A0- if you have multiple git servers and would like to spread load
> =A0 between them, the client can automatically take care of it
>
> That is, SRV records let us ask the client to carry out various tasks
> that would require a proxy on the server side with traditional DNS.
> The client performs a SRV query to _git._tcp.<domain name> to receive
> its instructions. =A0RFC 2782 has details.
>
> Ideally reaping these benefits would just involve passing a special
> flag to getaddrinfo(). =A0Since we don't live in such a world, this
> patch uses the BIND 8 API provided by libresolv to parse the response
> for ourselves.
>
> RFC 2782 requires some non-determinism in the order of hosts
> contacted; this patch uses drand48() for that. =A0To avoid causing
> trouble for platforms that lack the libbind ns_* functions or
> drand48(), the SRV support is only provided when requested by setting
> the USE_SRV_RR compile-time option.
>
> git servers must ensure that they can also be reached by a plain
> A/AAAA lookup to support git clients without SRV support, for example
> by proxying connections to an appropriate server:
>
> =A0 =A0 =A0 =A0# in inetd.conf
> =A0 =A0 =A0 =A0git stream tcp nowait.400 nobody /usr/sbin/tcpd \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/bin/nc -q0 gitserver.example.com git
>
> Regression: this uglifies error messages for connection errors a
> little. =A0It would probably be better to leave out the connection co=
unt
> when we are not trying more than one server.
>
> Based on a patch by Julien Cristau <jcristau@debian.org>.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> As I mentioned at the gittogether, I think this would be a valuable
> feature in git. =A0You can test it out (though this is only the simpl=
e
> case, no load balancing or failover) by doing
>
> =A0 =A0 =A0 =A0git clone git://git.debian.org/~jrnieder-guest/git.git
>
> and watching what happens with wireshark.
>
> The patch needs documentation. =A0Maybe a howto and an addendum to th=
e
> protocol docs would do. =A0Anyway, I hope it's at least entertaining =
in
> the current state.

It's an interesting feature, but I'm a little bit worried if this
promotes non-portable setups; won't these repos be unreachable (at
least without manually redirecting or also keeping a copy on the
advertised URL) on machines where libresolv is unavailable? I'm mainly
thinking about the "a single domain can use different hosts for
different services"-benefit you mentioned. Multiple hosts for one
service would probably be done by simply advertising one of the URLs,
and get some load-balancing from the clients that DOES have
libresolv...
