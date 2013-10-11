From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Fri, 11 Oct 2013 22:31:52 +0000
Message-ID: <20131011223151.GC79408@vauxhall.crustytoothpaste.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
 <20131009193054.GA3767@sigill.intra.peff.net>
 <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
 <20131009213742.GA8362@sigill.intra.peff.net>
 <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
 <CAJo=hJtBapzmF7BEawwRGJ0NKH1W0J5P4c4iGK6G_==gZahhgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 12 00:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUlFg-0000bG-0G
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 00:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab3JKWcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 18:32:03 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32951 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752612Ab3JKWcA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 18:32:00 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D365A2807A;
	Fri, 11 Oct 2013 22:31:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJo=hJtBapzmF7BEawwRGJ0NKH1W0J5P4c4iGK6G_==gZahhgg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235922>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2013 at 01:14:28AM -0700, Shawn Pearce wrote:
> If a large enough percentage of users are stuck behind a proxy that
> doesn't support 100-continue, it is hard to rely on that part of HTTP
> 1.1. You need to build the work-around for them anyway, so you might
> as well just make everyone use the work-around and assume 100-continue
> does not exist.

Well, the issue is that 100-continue is needed for functionality in some
cases, unless we want to restart the git-upload-pack command again or
force people to use outrageous sizes for http.postBuffer.  My preference
is generally to optimize for sane, standards-compliant behavior first,
and let the people with broken infrastructure turn on options to work
around that breakage.  I realize that git as a project is a little more
tolerant of people's myriad forms of breakage than I am personally.

Regardless, I have a reroll that leaves it disabled by default that I'll
send in a few minutes.

> 100-continue is frequently used when there is a large POST body, but
> those suck for users on slow or unstable connections. Typically the
> POST cannot be resumed where the connection was broken. To be friendly
> to users on less reliable connections than your gigabit office
> ethernet, you need to design the client side with some sort of
> chunking and gracefully retrying. So Git is really doing it all wrong.
> :-)

Yeah, there's been requests for resumable pull/push before.  The proper
way to do it would probably to send lots of little mini-packs that each
depend on the previous pack sent; if the connection gets reset, then at
least some of the data has been transferred, and negotiation would
restart the next time.  The number of SHA-1s sent during negotiation
would have to increase though, because you couldn't be guaranteed that
an entire ref would be able to be transferred each time.  Large blobs
would still be a problem, though, and efficiency would plummet.

> Even if you want to live in the fairy land where all servers support
> 100-continue, I'm not sure clients should pay that 100-160ms latency
> penalty during ancestor negotiation. Do 5 rounds of negotiation and
> its suddenly an extra half second for `git fetch`, and that is a
> fairly well connected client. Let me know how it works from India to a
> server on the west coast of the US, latency might be more like 200ms,
> and 5 rounds is now 1 full second of additional lag.

There shouldn't be that many rounds of negotiation.  HTTP retrieves the
list of refs over one connection, and then performs the POST over
another two.  Regardless, you should be using SSL over that connection,
and the number of round trips required for SSL negotiation in that case
completely dwarfs the overhead for the 100 continue, especially since
you'll do it thrice (even though the session is usually reused).  The
efficient way to do push is SSH, where you can avoid making multiple
connections and reuse the same encrypted connection at every stage.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSWHxXAAoJEL9TXYEfUvaLZ80QAKUwT8nnX1LaV25lVyPvIIPR
s6lNrdMi33a6Ltxx1ybqulVPBGxZma1a5DxgUxh+bQji/HVUDJJkr6MYCWhvWJ2D
H6CSaB/lhHej/0ng2U06mycWh9wYhRIY3SdXZ/mTEI6fWJhc7uwwpPkQF6vaW/WX
/pyU91t/JJETx9HmNgOEplmAomcubtOunbCGpEqJsDJTEwP8AFIsOpEc8Ff81Urj
brhiPgRjoJzuHApR9ZxmrL/NZuYH/fOR2aSoTKLeHOdwIWHiE1P19jyNPfCFCkg4
LpFXz/NfqJxapnszll5orAsdV7Ql16oJ/df3h6HBncIqofYoEEq6jCLGdh7fgbl1
Vs1AHwwHeyzIPB/1POkpEsBujvIF34cvNMO4YJ8nTailAOhZdvVmPpp5JlEaVQP3
HNmbPaHrFES5OMqc8swIoBqHFW8g8vEYVHCgWqAuAwBba+8LesUr8OkamhS5O2il
TqL7/5zI95y/RlZ48s1SGRTwiJPesXdmhAfi5fccjD6rtmYE0q1uq488+4/WzTRS
VJR+EC5jdmHhLKocOqGSjyy7/f0Hhtvcl2wyQvr117A5hfwCHdqCM3H95faDAtho
PMyY3Hb2pG3XZMQOGLBDB35rKpthRff4CBEcJjUeEC9KEJGeNtzZirA7hhazCqnm
30Md2Zhtx11pL4lHhB8N
=kyZf
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
